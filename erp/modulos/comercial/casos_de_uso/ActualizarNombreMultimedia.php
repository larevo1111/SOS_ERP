<?php
// erp/modulos/comercial/casos_de_uso/ActualizarNombreMultimedia.php
//
// Caso de uso: actualizar el campo nombre_archivo de una imagen/video.
// Parte del estándar 5S para permitir textos SEO amigables debajo de la galería.

class ActualizarNombreMultimedia
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
        $nombreArchivo = trim($datos['nombre_archivo'] ?? '');
        $usuario = trim($datos['usuario_ult_modificacion'] ?? 'sistema');

        if ($uid === '') {
            return $this->respuesta(false, null, 'El uid del archivo es obligatorio.', ['uid_requerido']);
        }
        if ($empresa === '') {
            return $this->respuesta(false, null, 'Cruce de seguridad fallido: falta empresa.', ['empresa_requerida']);
        }

        $stmt = $this->pdo->prepare("
            UPDATE com_productos_multimedia 
            SET nombre_archivo = :nombre_archivo, 
                usuario_ult_modificacion = :usuario, 
                fecha_ult_modificacion = NOW() 
            WHERE uid = :uid AND empresa = :empresa
        ");
        $stmt->execute([
            ':nombre_archivo' => $nombreArchivo,
            ':usuario' => $usuario,
            ':uid' => $uid,
            ':empresa' => $empresa
        ]);

        if ($stmt->rowCount() === 0) {
            // Verificar si el archivo existe pero de otra empresa (falla de seguridad) o si no cambió el valor
            $check = $this->pdo->prepare("SELECT id FROM com_productos_multimedia WHERE uid = :uid");
            $check->execute([':uid' => $uid]);
            if (!$check->fetch()) {
                return $this->respuesta(false, null, 'El archivo no existe.', ['archivo_no_existe']);
            }
        }

        return $this->respuesta(true, ['uid' => $uid, 'nombre_archivo' => $nombreArchivo], 'Nombre de archivo actualizado.');
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