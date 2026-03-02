<?php
// erp/modulos/comercial/casos_de_uso/ObtenerProducto.php
//
// Caso de uso: Recupera un producto y su multimedia por UID.

class ObtenerProducto
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

        if ($uid === '') {
            return $this->respuesta(false, null, 'UID de producto no proporcionado.', ['uid_requerido']);
        }
        if ($empresa === '') {
            return $this->respuesta(false, null, 'Fallo de seguridad: Empresa no especificada.', ['empresa_requerida']);
        }

        // 1. Obtener datos básicos del producto (¡FILTRADO POR EMPRESA!)
        $stmt = $this->pdo->prepare("SELECT * FROM com_productos WHERE uid = :uid AND empresa = :empresa LIMIT 1");
        $stmt->execute([':uid' => $uid, ':empresa' => $empresa]);
        $producto = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$producto) {
            return $this->respuesta(false, null, 'Producto no encontrado o no pertenece a tu entorno.', ['producto_no_existe']);
        }

        // 2. Obtener multimedia asociada
        $stmtM = $this->pdo->prepare("
            SELECT * FROM com_productos_multimedia 
            WHERE uid_producto = :uid 
            ORDER BY orden ASC
        ");
        $stmtM->execute([':uid' => $uid]);
        $multimedia = $stmtM->fetchAll(PDO::FETCH_ASSOC);

        // 3. Obtener variaciones si es un producto maestro
        $variaciones = [];
        if (!$producto['producto_principal_variacion']) {
            $stmtV = $this->pdo->prepare("
                SELECT uid, nombre, estado, nombre_atributo_variacion, valor_atributo_variacion, precio_regular 
                FROM com_productos 
                WHERE uid_producto_padre = :uid AND empresa = :empresa
            ");
            $stmtV->execute([':uid' => $uid, ':empresa' => $empresa]);
            $variaciones = $stmtV->fetchAll(PDO::FETCH_ASSOC);
        }

        return $this->respuesta(true, [
            'producto' => $producto,
            'multimedia' => $multimedia,
            'variaciones' => $variaciones
        ], 'Producto recuperado con éxito.');
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