<?php
// erp/modulos/comercial/casos_de_uso/ListarMaestrosCosto.php
//
// Caso de uso: listar maestros de costo desde costos_encabezados_productos.
// Esta tabla es PROTEGIDA (AppSheet) — solo lectura, Manifiesto § 6.3.
//
// Columnas a leer (nombres originales de AppSheet, con mayúsculas):
//   Id       → clave interna
//   uid      → identificador único (se usa como uid_producto_padre)
//   Producto → nombre a mostrar en el selector del FormularioProducto

class ListarMaestrosCosto
{
    private PDO $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function ejecutar(array $datos): array
    {
        // Filtro opcional por texto (para búsqueda en el q-select del frontend)
        $busqueda = trim($datos['busqueda'] ?? '');

        try {
            if ($busqueda !== '') {
                $stmt = $this->pdo->prepare(
                    'SELECT `Id`, `uid`, `Producto`
                     FROM `costos_encabezados_productos`
                     WHERE `Producto` LIKE :busqueda
                     ORDER BY `Producto` ASC
                     LIMIT 100'
                );
                $stmt->execute([':busqueda' => '%' . $busqueda . '%']);
            } else {
                $stmt = $this->pdo->prepare(
                    'SELECT `Id`, `uid`, `Producto`
                     FROM `costos_encabezados_productos`
                     ORDER BY `Producto` ASC
                     LIMIT 200'
                );
                $stmt->execute();
            }

            $maestros = $stmt->fetchAll();

            // Normalizar a camelCase consistente para el frontend
            $resultado = array_map(fn($fila) => [
                'id'       => $fila['Id'],
                'uid'      => $fila['uid'],
                'producto' => $fila['Producto'],
            ], $maestros);

            return $this->respuesta(true, ['maestros' => $resultado],
                count($resultado) . ' maestros encontrados.');

        } catch (Exception $e) {
            return $this->respuesta(false, null, 'Error al consultar maestros de costo.', [$e->getMessage()]);
        }
    }

    private function respuesta(bool $exito, $datos, string $mensaje, array $errores = []): array
    {
        return [
            'exito'   => $exito,
            'datos'   => $datos ?? (object)[],
            'mensaje' => $mensaje,
            'errores' => $errores,
        ];
    }
}
