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

        // Inyectar URL pública calculada a la multimedia (Filosofía Multi-Tenant S3)
        $r2BaseUrl = rtrim($datos['storage_url_publica'] ?? '', '/');
        foreach ($multimedia as &$m) {
            if (!empty($m['archivo_local'])) {
                $m['url_publica_calculada'] = $r2BaseUrl . '/' . $m['archivo_local'];
            }
        }
        unset($m);

        // 3. Obtener variaciones si es un producto maestro
        // NOTA TÉCNICA: Se usa subquery correlacionado en el SELECT (NO LEFT JOIN LATERAL),
        // porque LATERAL no está disponible en todas las configuraciones de MariaDB local.
        // El subquery correlacionado es 100% compatible y produce el mismo resultado.
        $variaciones = [];
        if (!$producto['producto_principal_variacion']) {
            $stmtV = $this->pdo->prepare("
                SELECT v.uid, v.nombre, v.estado, v.nombre_atributo_variacion, v.valor_atributo_variacion, v.precio_regular,
                       (SELECT archivo_local
                        FROM com_productos_multimedia
                        WHERE uid_producto = v.uid
                          AND uso = 'Variacion'
                          AND estado = 'Activo'
                        ORDER BY orden ASC
                        LIMIT 1) AS miniatura_local
                FROM com_productos v
                WHERE v.producto_principal_variacion = :uid
                  AND v.empresa = :empresa
                ORDER BY v.id ASC
            ");
            $stmtV->execute([':uid' => $uid, ':empresa' => $empresa]);
            $variaciones = $stmtV->fetchAll(PDO::FETCH_ASSOC);

            // Inyectar URL pública para las miniaturas de variaciones
            foreach ($variaciones as &$v) {
                $v['miniatura_url'] = !empty($v['miniatura_local'])
                    ? $r2BaseUrl . '/' . $v['miniatura_local']
                    : null;
                unset($v['miniatura_local']);
            }
            unset($v);
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