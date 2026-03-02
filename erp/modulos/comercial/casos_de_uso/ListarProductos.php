<?php
// erp/modulos/comercial/casos_de_uso/ListarProductos.php
//
// Caso de uso: Listado de productos con filtros y búsqueda.
// Siguiendo el estándar 5S de eficiencia y orden.

class ListarProductos
{
    private PDO $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function ejecutar(array $datos): array
    {
        $empresa = strtolower(trim($datos['empresa'] ?? ''));
        if ($empresa === '') {
            return $this->respuesta(false, [], 'La empresa es obligatoria para listar.', ['empresa_requerida']);
        }

        $busqueda = trim($datos['busqueda'] ?? '');
        $categoria = trim($datos['categoria'] ?? '');
        $marca = trim($datos['marca'] ?? '');
        $estado = trim($datos['estado'] ?? '');
        $soloMaestros = isset($datos['solo_maestros']) ? (bool)$datos['solo_maestros'] : true;

        $sql = "SELECT p.uid, p.nombre, p.categoria, p.marca, p.precio_regular,
                p.estado, p.estado_publicacion, p.producto_principal_variacion,
                p.empresa, p.fecha_creacion,
                (SELECT archivo_local FROM com_productos_multimedia
                 WHERE uid_producto = p.uid AND uso = 'Principal' AND estado = 'Activo'
                 LIMIT 1) AS foto_principal_local
                FROM com_productos p
                WHERE p.empresa = :empresa";

        $params = [':empresa' => $empresa];

        if ($busqueda !== '') {
            $sql .= " AND (p.nombre LIKE :busqueda OR p.uid LIKE :busqueda)";
            $params[':busqueda'] = "%$busqueda%";
        }

        if ($categoria !== '') {
            $sql .= " AND p.categoria = :categoria";
            $params[':categoria'] = $categoria;
        }

        if ($marca !== '') {
            $sql .= " AND p.marca = :marca";
            $params[':marca'] = $marca;
        }

        if ($estado !== '') {
            $sql .= " AND p.estado = :estado";
            $params[':estado'] = $estado;
        }

        if ($soloMaestros) {
            $sql .= " AND p.producto_principal_variacion IS NULL";
        }

        $sql .= " ORDER BY p.fecha_creacion DESC";

        // Paginación (opcional, por ahora simple)
        $limite = isset($datos['limite']) ? (int)$datos['limite'] : 50;
        $sql .= " LIMIT $limite";

        error_log("[DEBUG LISTAR_PROD] SQL: " . $sql);
        error_log("[DEBUG LISTAR_PROD] Params: " . print_r($params, true));

        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($params);
        $items = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Construir URL pública de la foto principal (ruta relativa → URL completa)
        $r2BaseUrl = rtrim(getenv('R2_URL_PUBLICA') ?: '', '/');
        foreach ($items as &$item) {
            $item['foto_principal'] = !empty($item['foto_principal_local'])
                ? $r2BaseUrl . '/' . $item['foto_principal_local']
                : null;
            unset($item['foto_principal_local']);
        }
        unset($item);

        return $this->respuesta(true, $items, 'Listado generado correctamente.');
    }
    private function respuesta(bool $exito, $datos, string $mensaje, array $errores = []): array
    {
        return [
            'exito' => $exito,
            'datos' => $datos ?? [],
            'mensaje' => $mensaje,
            'errores' => $errores,
        ];
    }
}