<?php
// erp/modulos/comercial/casos_de_uso/EliminarMultimedia.php

class EliminarMultimedia
{
    private PDO $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function ejecutar(array $datos): array
    {
        $uid = trim($datos['uid'] ?? '');
        $empresa = trim($datos['empresa'] ?? '');

        if ($uid === '' || $empresa === '') {
            return $this->respuesta(false, null, 'UID y empresa son obligatorios.', ['parametros_invalidos']);
        }

        // 1. Obtener registro de multimedia para confirmar que pertenece a la empresa y extraer ruta_local
        $stmtGET = $this->pdo->prepare("SELECT archivo_local FROM com_productos_multimedia WHERE uid = :uid AND empresa = :empresa LIMIT 1");
        $stmtGET->execute([':uid' => $uid, ':empresa' => $empresa]);
        $registro = $stmtGET->fetch(PDO::FETCH_ASSOC);

        if (!$registro) {
            return $this->respuesta(false, null, 'Archivo no encontrado o no autorizado.', ['no_encontrado']);
        }

        $archivoLocal = $registro['archivo_local'] ?? '';

        // 2. Intentar borrar en Cloudflare R2 si existe la ruta
        if ($archivoLocal !== '') {
            try {
                // Leer secretos de sys_empresa
                $stmtStorage = $this->pdo->prepare("SELECT storage_endpoint, storage_bucket, storage_access_key, storage_secret_key FROM sys_empresa WHERE uid = :empresa LIMIT 1");
                $stmtStorage->execute([':empresa' => $empresa]);
                $storageInfo = $stmtStorage->fetch(PDO::FETCH_ASSOC);

                if ($storageInfo && !empty($storageInfo['storage_endpoint'])) {
                    $this->borrarDelStorage($archivoLocal, $storageInfo);
                }
            }
            catch (Exception $e) {
                // Loguear el error de R2, pero continuar para borrar de la BD y no dejarlo huérfano funcionalmente
                error_log("[EliminarMultimedia R2 Error]: " . $e->getMessage());
            }
        }

        // 3. Borrar de la base de datos
        $stmtDEL = $this->pdo->prepare("DELETE FROM com_productos_multimedia WHERE uid = :uid AND empresa = :empresa");
        $exito = $stmtDEL->execute([':uid' => $uid, ':empresa' => $empresa]);

        return $this->respuesta($exito, null, 'Archivo eliminado correctamente.');
    }

    private function borrarDelStorage(string $clave, array $storageInfo): void
    {
        $accessKey = $storageInfo['storage_access_key'];
        $secretKey = $storageInfo['storage_secret_key'];
        $bucket = $storageInfo['storage_bucket'];

        $parsedUrl = parse_url($storageInfo['storage_endpoint']);
        $host = $parsedUrl['host'] ?? '';

        if (!$host || !$accessKey || !$secretKey || !$bucket) {
            throw new \RuntimeException('Configuración de almacenamiento incompleta.');
        }

        $claveUri = rawurlencode($clave);
        $claveUri = str_replace('%2F', '/', $claveUri);
        $uri = "/{$bucket}/{$claveUri}";

        $ahora = new \DateTime('now', new \DateTimeZone('UTC'));
        $fechaHora = $ahora->format('Ymd\THis\Z');
        $fecha = $ahora->format('Ymd');
        $region = 'auto';
        $servicio = 's3';

        $cabecerasOrdenadas = [
            'host' => $host,
            'x-amz-content-sha256' => 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855', // hash de string vacío para DELETE
            'x-amz-date' => $fechaHora,
        ];

        $cabecerasCanonicas = '';
        $cabecerasFirmadas = '';
        foreach ($cabecerasOrdenadas as $nombre => $valor) {
            $cabecerasCanonicas .= "{$nombre}:{$valor}\n";
            $cabecerasFirmadas .= "{$nombre};";
        }
        $cabecerasFirmadas = rtrim($cabecerasFirmadas, ';');

        $peticionCanonica = implode("\n", [
            'DELETE',
            $uri,
            '',
            $cabecerasCanonicas,
            $cabecerasFirmadas,
            $cabecerasOrdenadas['x-amz-content-sha256'],
        ]);

        $alcance = "{$fecha}/{$region}/{$servicio}/aws4_request";
        $cadenaParaFirmar = implode("\n", [
            'AWS4-HMAC-SHA256',
            $fechaHora,
            $alcance,
            hash('sha256', $peticionCanonica),
        ]);

        $claveF = hash_hmac('sha256', $fecha, 'AWS4' . $secretKey, true);
        $claveF = hash_hmac('sha256', $region, $claveF, true);
        $claveF = hash_hmac('sha256', $servicio, $claveF, true);
        $claveF = hash_hmac('sha256', 'aws4_request', $claveF, true);
        $firma = hash_hmac('sha256', $cadenaParaFirmar, $claveF);

        $autorizacion = "AWS4-HMAC-SHA256 Credential={$accessKey}/{$alcance}, SignedHeaders={$cabecerasFirmadas}, Signature={$firma}";

        $ch = curl_init("https://{$host}{$uri}");
        curl_setopt_array($ch, [
            CURLOPT_CUSTOMREQUEST => 'DELETE',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_HTTPHEADER => [
                "Authorization: {$autorizacion}",
                "Host: {$host}",
                "x-amz-content-sha256: {$cabecerasOrdenadas['x-amz-content-sha256']}",
                "x-amz-date: {$fechaHora}"
            ],
        ]);

        $respuesta = curl_exec($ch);
        $codigo = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        if ($codigo !== 204 && $codigo !== 200) {
            throw new \RuntimeException("R2 respondió HTTP {$codigo}: {$respuesta}");
        }
    }

    private function respuesta(bool $exito, $datos, string $mensaje, array $errores = []): array
    {
        return [
            'exito' => $exito,
            'datos' => $datos ?? (object)[],
            'mensaje' => $mensaje,
            'errores' => $errores,
        ];
    }
}