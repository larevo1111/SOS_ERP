<?php
// erp/modulos/comercial/casos_de_uso/GuardarVariacionExpress.php
//
// Caso de uso: guardar una variación de producto desde el Popup Variación.
// Siempre crea un registro NUEVO en com_productos con el vínculo al maestro.
//
// Datos requeridos:
//   datos['uid_maestro']            → UID del producto padre (producto_principal_variacion)
//   datos['nombre']                 → Nombre de la variación (Ej: "Miel 500g")
//   datos['uid_producto_padre']     → UID del producto en costos (AppSheet)
//   datos['nombre_atributo_variacion'] → Ej: "Peso"
//   datos['valor_atributo_variacion']  → Ej: "500g"
//   datos['empresa']                → Código de empresa
//   datos['usuario_creador']        → Usuario que crea
//
// Datos opcionales:
//   datos['precio_regular'], datos['precio_oferta']
//   datos['fecha_oferta_desde'], datos['fecha_oferta_hasta']

class GuardarVariacionExpress
{
    private PDO $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function ejecutar(array $datos): array
    {
        $errores = $this->validar($datos);
        if (!empty($errores)) {
            return $this->respuesta(false, null, 'Datos inválidos.', $errores);
        }

        $empresa        = strtolower(trim($datos['empresa']));
        $uid            = $this->generarUid($empresa);
        $usuarioCreador = trim($datos['usuario_creador'] ?? 'sistema');

        $sql = '
            INSERT INTO com_productos (
                uid, empresa,
                nombre,
                estado, estado_publicacion,
                uid_producto_padre,
                producto_principal_variacion,
                nombre_atributo_variacion,
                valor_atributo_variacion,
                precio_regular,
                precio_oferta,
                fecha_oferta_desde,
                fecha_oferta_hasta,
                url_producto,
                usuario_creador,
                usuario_ult_modificacion
            ) VALUES (
                :uid, :empresa,
                :nombre,
                :estado, :estado_publicacion,
                :uid_producto_padre,
                :producto_principal_variacion,
                :nombre_atributo_variacion,
                :valor_atributo_variacion,
                :precio_regular,
                :precio_oferta,
                :fecha_oferta_desde,
                :fecha_oferta_hasta,
                :url_producto,
                :usuario_creador,
                :usuario_ult_modificacion
            )
        ';

        $stmt = $this->pdo->prepare($sql);
        $stmt->execute([
            'uid'                          => $uid,
            'empresa'                      => $empresa,
            'nombre'                       => trim($datos['nombre']),
            'estado'                       => $datos['estado']                    ?? 'Activo',
            'estado_publicacion'           => $datos['estado_publicacion']        ?? 'borrador',
            'uid_producto_padre'           => $datos['uid_producto_padre']        ?? '',
            'producto_principal_variacion' => trim($datos['uid_maestro']),
            'nombre_atributo_variacion'    => $datos['nombre_atributo_variacion'] ?? null,
            'valor_atributo_variacion'     => $datos['valor_atributo_variacion']  ?? null,
            'precio_regular'               => $datos['precio_regular']            ?? null,
            'precio_oferta'                => $datos['precio_oferta']             ?? null,
            'fecha_oferta_desde'           => $datos['fecha_oferta_desde']        ?? null,
            'fecha_oferta_hasta'           => $datos['fecha_oferta_hasta']        ?? null,
            'url_producto'                 => $datos['url_producto']              ?? '',
            'usuario_creador'              => $usuarioCreador,
            'usuario_ult_modificacion'     => $usuarioCreador,
        ]);

        $stmt = $this->pdo->prepare(
            'SELECT id, uid, nombre, estado, precio_regular,
                    nombre_atributo_variacion, valor_atributo_variacion
             FROM com_productos WHERE uid = :uid LIMIT 1'
        );
        $stmt->execute([':uid' => $uid]);
        $variacion = $stmt->fetch();

        return $this->respuesta(true, $variacion ?: (object)[], 'Variación guardada correctamente.');
    }

    private function validar(array $datos): array
    {
        $errores = [];
        if (trim($datos['uid_maestro'] ?? '') === '') {
            $errores[] = 'El campo uid_maestro es obligatorio.';
        }
        if (trim($datos['nombre'] ?? '') === '') {
            $errores[] = 'El campo nombre es obligatorio.';
        }
        if (trim($datos['empresa'] ?? '') === '') {
            $errores[] = 'El campo empresa es obligatorio.';
        }
        return $errores;
    }

    // Genera UID: {EMPRESA}-{YYYYMMDDHHMMSS}-{6hex}
    private function generarUid(string $empresa): string
    {
        $ts  = date('YmdHis');
        $hex = bin2hex(random_bytes(3));
        return strtoupper($empresa) . '-' . $ts . '-' . $hex;
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
