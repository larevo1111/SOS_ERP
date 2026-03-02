<?php
// erp/modulos/comercial/casos_de_uso/SubirMultimedia.php
//
// Caso de uso: recibir un archivo desde el frontend, subirlo a
// Cloudflare R2 vía API S3-compatible, y registrar el resultado
// en com_productos_multimedia.
//
// Variables requeridas en erp/.env:
//   R2_ACCOUNT_ID   → ID de cuenta de Cloudflare
//   R2_ACCESS_KEY   → Clave de acceso (Access Key ID)
//   R2_SECRET_KEY   → Clave secreta (Secret Access Key)
//   R2_BUCKET       → Nombre del bucket
//   R2_URL_PUBLICA  → URL base pública del bucket (ej: https://archivos.oscomunidad.com)

class SubirMultimedia
{
    private PDO $pdo;

    // Tipos MIME permitidos y su extensión esperada
    private const TIPOS_PERMITIDOS = [
        'image/jpeg' => 'jpg',
        'image/png' => 'png',
        'image/webp' => 'webp',
        'image/gif' => 'gif',
        'video/mp4' => 'mp4',
        'video/webm' => 'webm',
    ];

    // Tamaño máximo: 20 MB
    private const TAMANO_MAXIMO = 20 * 1024 * 1024;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    // $datos  → campos del formulario: uid_producto, empresa, usuario_creador, orden
    // $archivo → entrada de $_FILES['archivo']
    public function ejecutar(array $datos, ?array $archivo): array
    {
        // ── Validar que llegó un archivo ──────────────────────────
        if (!$archivo || $archivo['error'] !== UPLOAD_ERR_OK) {
            $error = $this->mensajeErrorSubida($archivo['error'] ?? -1);
            return $this->respuesta(false, null, $error, ['error_subida']);
        }

        // ── Validar datos mínimos ─────────────────────────────────
        $uidProducto = trim($datos['uid_producto'] ?? '');
        $empresa = strtolower(trim($datos['empresa'] ?? ''));
        $usuario = trim($datos['usuario_creador'] ?? 'sistema');

        if ($uidProducto === '') {
            return $this->respuesta(false, null, 'El uid_producto es obligatorio.', ['uid_producto_requerido']);
        }
        if ($empresa === '') {
            return $this->respuesta(false, null, 'La empresa es obligatoria.', ['empresa_requerida']);
        }

        // ── Verificar que el producto existe ──────────────────────
        if (!$this->productoExiste($uidProducto)) {
            return $this->respuesta(false, null, 'Producto no encontrado.', ['producto_no_existe']);
        }

        // ── Validar tipo y tamaño del archivo ─────────────────────
        $mimeType = mime_content_type($archivo['tmp_name']);
        if (!array_key_exists($mimeType, self::TIPOS_PERMITIDOS)) {
            return $this->respuesta(false, null, "Tipo de archivo no permitido: {$mimeType}.", ['tipo_no_permitido']);
        }
        if ($archivo['size'] > self::TAMANO_MAXIMO) {
            $mb = round(self::TAMANO_MAXIMO / 1024 / 1024);
            return $this->respuesta(false, null, "El archivo supera el límite de {$mb} MB.", ['tamano_excedido']);
        }

        // ── Determinar tipo de archivo (imagen o video) ───────────
        $tipoArchivo = str_starts_with($mimeType, 'video/') ? 'video' : 'imagen';

        // ── Generar nombre y ruta dentro del bucket ───────────────
        // Ruta: empresas/{empresa}/productos/{uid_producto}/{timestamp}-{random}.{ext}
        $ext = self::TIPOS_PERMITIDOS[$mimeType];
        $nombreUnico = date('YmdHis') . '-' . bin2hex(random_bytes(4)) . '.' . $ext;
        $rutaEnBucket = "empresas/{$empresa}/productos/{$uidProducto}/{$nombreUnico}";

        // ── Subir a Cloudflare R2 ─────────────────────────────────
        try {
            $urlPublica = $this->subirAR2($archivo['tmp_name'], $mimeType, $rutaEnBucket);
        }
        catch (Exception $e) {
            return $this->respuesta(false, null, 'Error al subir el archivo: ' . $e->getMessage(), ['error_r2']);
        }

        // ── Registrar en com_productos_multimedia ─────────────────
        $uid = $this->generarUid($empresa);
        $orden = (int)($datos['orden'] ?? 0);

        $sql = '
            INSERT INTO com_productos_multimedia (
                uid, empresa, uid_producto, tipo_archivo,
                archivo_local, archivo_woocommerce,
                uso, orden, estado,
                usuario_creador, usuario_ult_modificacion
            ) VALUES (
                :uid, :empresa, :uid_producto, :tipo_archivo,
                :archivo_local, :archivo_woocommerce,
                :uso, :orden, :estado,
                :usuario_creador, :usuario_ult_modificacion
            )
        ';

        $stmt = $this->pdo->prepare($sql);
        $stmt->execute([
            ':uid' => $uid,
            ':empresa' => $empresa,
            ':uid_producto' => $uidProducto,
            ':tipo_archivo' => $tipoArchivo,
            // archivo_local = ruta relativa dentro del bucket (SIN la URL base del proveedor).
            // La URL completa se reconstruye en tiempo de ejecución: R2_URL_PUBLICA . '/' . archivo_local
            // Esto permite cambiar de proveedor de almacenamiento sin tocar la BD.
            ':archivo_local' => $rutaEnBucket,
            // archivo_woocommerce = ID de WooCommerce, se llena al sincronizar. Vacío mientras tanto.
            ':archivo_woocommerce' => '',
            ':uso' => $datos['uso'] ?? 'Galeria',
            ':orden' => $orden,
            ':estado' => 'Activo',
            ':usuario_creador' => $usuario,
            ':usuario_ult_modificacion' => $usuario,
        ]);

        $registro = $this->buscarPorUid($uid);

        // Enriquecer el registro con la URL pública calculada para que el frontend la pueda mostrar
        if ($registro && !empty($registro['archivo_local'])) {
            $r2BaseUrl = rtrim(getenv('R2_URL_PUBLICA') ?: '', '/');
            $registro['url_publica_calculada'] = $r2BaseUrl . '/' . $registro['archivo_local'];
        }

        return $this->respuesta(true, $registro, 'Archivo subido correctamente.');
    }

    // ── Subida a Cloudflare R2 via API S3-compatible ──────────────
    // Implementa AWS Signature V4 con PHP nativo (sin SDK externo).
    private function subirAR2(string $rutaTmp, string $mimeType, string $clave): string
    {
        $accountId = getenv('R2_ACCOUNT_ID');
        $accessKey = getenv('R2_ACCESS_KEY');
        $secretKey = getenv('R2_SECRET_KEY');
        $bucket = getenv('R2_BUCKET');
        $urlPublica = rtrim(getenv('R2_URL_PUBLICA') ?: '', '/');

        if (!$accountId || !$accessKey || !$secretKey || !$bucket) {
            throw new \RuntimeException('Faltan variables R2 en el archivo .env.');
        }

        $contenido = file_get_contents($rutaTmp);
        $hashContenido = hash('sha256', $contenido);

        // Fecha y hora en formato requerido por AWS Sig V4
        $ahora = new \DateTime('now', new \DateTimeZone('UTC'));
        $fechaHora = $ahora->format('Ymd\THis\Z'); // 20260227T143055Z
        $fecha = $ahora->format('Ymd'); // 20260227

        $host = "{$accountId}.r2.cloudflarestorage.com";
        $claveUri = rawurlencode($clave);
        // Preservar las barras del path sin codificarlas
        $claveUri = str_replace('%2F', '/', $claveUri);
        $uri = "/{$bucket}/{$claveUri}";

        // Cabeceras ordenadas alfabéticamente (requisito del algoritmo)
        $region = 'auto';
        $servicio = 's3';

        $cabecerasOrdenadas = [
            'content-type' => $mimeType,
            'host' => $host,
            'x-amz-content-sha256' => $hashContenido,
            'x-amz-date' => $fechaHora,
        ];

        $cabecerasCanonicas = '';
        $cabecerasFirmadas = '';
        foreach ($cabecerasOrdenadas as $nombre => $valor) {
            $cabecerasCanonicas .= "{$nombre}:{$valor}\n";
            $cabecerasFirmadas .= "{$nombre};";
        }
        $cabecerasFirmadas = rtrim($cabecerasFirmadas, ';');

        // Petición canónica
        $peticionCanonica = implode("\n", [
            'PUT',
            $uri,
            '', // query string vacío
            $cabecerasCanonicas,
            $cabecerasFirmadas,
            $hashContenido,
        ]);

        // Cadena para firmar
        $alcance = "{$fecha}/{$region}/{$servicio}/aws4_request";
        $cadenaParaFirmar = implode("\n", [
            'AWS4-HMAC-SHA256',
            $fechaHora,
            $alcance,
            hash('sha256', $peticionCanonica),
        ]);

        // Derivar clave de firma (HMAC en cadena)
        $claveF = hash_hmac('sha256', $fecha, 'AWS4' . $secretKey, true);
        $claveF = hash_hmac('sha256', $region, $claveF, true);
        $claveF = hash_hmac('sha256', $servicio, $claveF, true);
        $claveF = hash_hmac('sha256', 'aws4_request', $claveF, true);
        $firma = hash_hmac('sha256', $cadenaParaFirmar, $claveF);

        // Cabecera Authorization final
        $autorizacion = "AWS4-HMAC-SHA256 Credential={$accessKey}/{$alcance}, SignedHeaders={$cabecerasFirmadas}, Signature={$firma}";

        // Subir vía cURL
        $endpoint = "https://{$host}{$uri}";
        $ch = curl_init($endpoint);
        curl_setopt_array($ch, [
            CURLOPT_CUSTOMREQUEST => 'PUT',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_POSTFIELDS => $contenido,
            CURLOPT_HTTPHEADER => [
                "Authorization: {$autorizacion}",
                "Content-Type: {$mimeType}",
                "Host: {$host}",
                "x-amz-content-sha256: {$hashContenido}",
                "x-amz-date: {$fechaHora}",
                'Content-Length: ' . strlen($contenido),
            ],
        ]);

        $respuesta = curl_exec($ch);
        $codigo = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $curlError = curl_error($ch);
        curl_close($ch);

        if ($curlError) {
            throw new \RuntimeException("cURL falló: {$curlError}");
        }
        if ($codigo !== 200) {
            throw new \RuntimeException("R2 respondió HTTP {$codigo}: {$respuesta}");
        }

        // La URL pública se construye desde R2_URL_PUBLICA + ruta del objeto
        return $urlPublica . '/' . $clave;
    }

    // ── Verifica que el producto existe en com_productos ──────────
    private function productoExiste(string $uid): bool
    {
        $stmt = $this->pdo->prepare('SELECT id FROM com_productos WHERE uid = :uid LIMIT 1');
        $stmt->execute([':uid' => $uid]);
        return $stmt->fetch() !== false;
    }

    // ── Busca un registro multimedia por UID ──────────────────────
    private function buscarPorUid(string $uid): ?array
    {
        $stmt = $this->pdo->prepare('SELECT * FROM com_productos_multimedia WHERE uid = :uid LIMIT 1');
        $stmt->execute([':uid' => $uid]);
        $fila = $stmt->fetch();
        return $fila ?: null;
    }

    // ── UID único: {EMPRESA}-M-{YYYYMMDDHHMMSS}-{6hex} ───────────
    // La "M" distingue los UIDs de multimedia de los de producto.
    private function generarUid(string $empresa): string
    {
        $ts = date('YmdHis');
        $hex = bin2hex(random_bytes(3));
        return strtoupper($empresa) . '-M-' . $ts . '-' . $hex;
    }

    // ── Mensaje amigable para errores de PHP en subida ────────────
    private function mensajeErrorSubida(int $codigo): string
    {
        return match ($codigo) {
                UPLOAD_ERR_INI_SIZE, UPLOAD_ERR_FORM_SIZE => 'El archivo supera el tamaño máximo permitido.',
                UPLOAD_ERR_PARTIAL => 'El archivo se subió parcialmente. Intenta de nuevo.',
                UPLOAD_ERR_NO_FILE => 'No se recibió ningún archivo.',
                UPLOAD_ERR_NO_TMP_DIR => 'Error del servidor: carpeta temporal no disponible.',
                UPLOAD_ERR_CANT_WRITE => 'Error del servidor: sin permiso de escritura.',
                default => 'Error desconocido al subir el archivo.',
            };
    }

    // ── Estructura estándar de respuesta (Manifiesto § 5.3) ───────
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