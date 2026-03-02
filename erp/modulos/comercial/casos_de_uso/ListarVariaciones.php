<?php
// erp/modulos/comercial/casos_de_uso/ListarVariaciones.php
//
// Caso de uso: obtener las variaciones de un producto maestro.
// Una variación es cualquier registro de com_productos cuyo campo
// producto_principal_variacion apunta al uid_maestro recibido.
//
// Datos requeridos:
//   datos['uid_maestro'] → UID del producto padre/maestro

class ListarVariaciones
{
    private PDO $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function ejecutar(array $datos): array
    {
        $uidMaestro = trim($datos['uid_maestro'] ?? '');
        $empresa = trim($datos['empresa'] ?? '');

        if ($uidMaestro === '') {
            return $this->respuesta(false, null, 'El campo uid_maestro es obligatorio.', ['uid_maestro_vacio']);
        }
        if ($empresa === '') {
            return $this->respuesta(false, null, 'Fallo de seguridad: Empresa no especificada.', ['empresa_requerida']);
        }

        $stmt = $this->pdo->prepare(
            'SELECT id, uid, nombre, estado, precio_regular,
                    nombre_atributo_variacion, valor_atributo_variacion
             FROM com_productos
             WHERE producto_principal_variacion = :uid_maestro AND empresa = :empresa
             ORDER BY id ASC'
        );
        $stmt->execute([':uid_maestro' => $uidMaestro, ':empresa' => $empresa]);
        $variaciones = $stmt->fetchAll();

        return $this->respuesta(true, ['variaciones' => $variaciones], 'Variaciones obtenidas correctamente.');
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