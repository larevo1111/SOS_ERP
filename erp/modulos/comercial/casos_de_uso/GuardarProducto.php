<?php
// erp/modulos/comercial/casos_de_uso/GuardarProducto.php
//
// Caso de uso: crear o actualizar un producto en com_productos.
// Si datos['uid'] está vacío → INSERT (producto nuevo).
// Si datos['uid'] tiene valor → UPDATE (actualizar existente).
//
// Campos que maneja según la estructura real de com_productos.
// Los campos de auditoría de sistema se manejan aquí, no en el frontend.

class GuardarProducto
{
    private PDO $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function ejecutar(array $datos): array
    {
        // ── Validaciones básicas ──────────────────────────────────
        $errores = $this->validar($datos);
        if (!empty($errores)) {
            return $this->respuesta(false, null, 'Datos inválidos.', $errores);
        }

        $uid = trim($datos['uid'] ?? '');

        if ($uid === '') {
            return $this->insertar($datos);
        } else {
            return $this->actualizar($uid, $datos);
        }
    }

    // ── INSERT: producto nuevo ────────────────────────────────────
    private function insertar(array $datos): array
    {
        $empresa  = strtolower(trim($datos['empresa'] ?? ''));
        $uid      = $this->generarUid($empresa);
        $usuarioCreador = trim($datos['usuario_creador'] ?? 'sistema');

        $sql = '
            INSERT INTO com_productos (
                uid, empresa, nombre, estado, estado_publicacion,
                id_producto_woocommerce, uid_producto_padre,
                producto_principal_variacion, nombre_grupo_catalogo,
                nombre_atributo_variacion, valor_atributo_variacion,
                categoria, marca, etiquetas,
                precio_regular, precio_oferta,
                fecha_oferta_desde, fecha_oferta_hasta,
                descripcion_corta, descripcion_larga,
                bullets_superiores, ingredientes_resumen, tabla_nutricional,
                problema_real, origen_macro, beneficios_explicados,
                experiencia_y_modo_de_uso,
                productor, ubicacion_productor,
                sistema_de_cultivo_origen, proceso_de_transformacion,
                galeria_adicional, url_producto,
                usuario_creador, usuario_ult_modificacion
            ) VALUES (
                :uid, :empresa, :nombre, :estado, :estado_publicacion,
                :id_producto_woocommerce, :uid_producto_padre,
                :producto_principal_variacion, :nombre_grupo_catalogo,
                :nombre_atributo_variacion, :valor_atributo_variacion,
                :categoria, :marca, :etiquetas,
                :precio_regular, :precio_oferta,
                :fecha_oferta_desde, :fecha_oferta_hasta,
                :descripcion_corta, :descripcion_larga,
                :bullets_superiores, :ingredientes_resumen, :tabla_nutricional,
                :problema_real, :origen_macro, :beneficios_explicados,
                :experiencia_y_modo_de_uso,
                :productor, :ubicacion_productor,
                :sistema_de_cultivo_origen, :proceso_de_transformacion,
                :galeria_adicional, :url_producto,
                :usuario_creador, :usuario_ult_modificacion
            )
        ';

        $stmt = $this->pdo->prepare($sql);
        $stmt->execute(array_merge(
            ['uid' => $uid, 'empresa' => $empresa,
             'usuario_creador' => $usuarioCreador,
             'usuario_ult_modificacion' => $usuarioCreador],
            $this->extraerCampos($datos)
        ));

        $producto = $this->buscarPorUid($uid);
        return $this->respuesta(true, $producto, 'Producto creado correctamente.');
    }

    // ── UPDATE: actualizar producto existente ─────────────────────
    private function actualizar(string $uid, array $datos): array
    {
        // Verificar que el producto existe
        $producto = $this->buscarPorUid($uid);
        if (!$producto) {
            return $this->respuesta(false, null, 'Producto no encontrado.', ['uid_no_existe']);
        }

        $usuarioModificacion = trim($datos['usuario_ult_modificacion'] ?? 'sistema');

        $sql = '
            UPDATE com_productos SET
                nombre                     = :nombre,
                estado                     = :estado,
                estado_publicacion         = :estado_publicacion,
                id_producto_woocommerce    = :id_producto_woocommerce,
                uid_producto_padre         = :uid_producto_padre,
                producto_principal_variacion = :producto_principal_variacion,
                nombre_grupo_catalogo      = :nombre_grupo_catalogo,
                nombre_atributo_variacion  = :nombre_atributo_variacion,
                valor_atributo_variacion   = :valor_atributo_variacion,
                categoria                  = :categoria,
                marca                      = :marca,
                etiquetas                  = :etiquetas,
                precio_regular             = :precio_regular,
                precio_oferta              = :precio_oferta,
                fecha_oferta_desde         = :fecha_oferta_desde,
                fecha_oferta_hasta         = :fecha_oferta_hasta,
                descripcion_corta          = :descripcion_corta,
                descripcion_larga          = :descripcion_larga,
                bullets_superiores         = :bullets_superiores,
                ingredientes_resumen       = :ingredientes_resumen,
                tabla_nutricional          = :tabla_nutricional,
                problema_real              = :problema_real,
                origen_macro               = :origen_macro,
                beneficios_explicados      = :beneficios_explicados,
                experiencia_y_modo_de_uso  = :experiencia_y_modo_de_uso,
                productor                  = :productor,
                ubicacion_productor        = :ubicacion_productor,
                sistema_de_cultivo_origen  = :sistema_de_cultivo_origen,
                proceso_de_transformacion  = :proceso_de_transformacion,
                galeria_adicional          = :galeria_adicional,
                url_producto               = :url_producto,
                usuario_ult_modificacion   = :usuario_ult_modificacion
            WHERE uid = :uid
        ';

        $stmt = $this->pdo->prepare($sql);
        $stmt->execute(array_merge(
            ['uid' => $uid, 'usuario_ult_modificacion' => $usuarioModificacion],
            $this->extraerCampos($datos)
        ));

        $producto = $this->buscarPorUid($uid);
        return $this->respuesta(true, $producto, 'Producto actualizado correctamente.');
    }

    // ── Extrae los campos del formulario para INSERT/UPDATE ───────
    // Centraliza la limpieza de datos. No incluye uid, empresa ni auditoría.
    private function extraerCampos(array $d): array
    {
        return [
            'nombre'                      => trim($d['nombre']                    ?? ''),
            'estado'                      => $d['estado']                         ?? 'Activo',
            'estado_publicacion'          => $d['estado_publicacion']             ?? 'borrador',
            'id_producto_woocommerce'     => $d['id_producto_woocommerce']        ?? null,
            'uid_producto_padre'          => $d['uid_producto_padre']             ?? null,
            'producto_principal_variacion'=> $d['producto_principal_variacion']   ?? null,
            'nombre_grupo_catalogo'       => $d['nombre_grupo_catalogo']          ?? null,
            'nombre_atributo_variacion'   => $d['nombre_atributo_variacion']      ?? null,
            'valor_atributo_variacion'    => $d['valor_atributo_variacion']       ?? null,
            'categoria'                   => $d['categoria']                      ?? null,
            'marca'                       => $d['marca']                          ?? null,
            'etiquetas'                   => $d['etiquetas']                      ?? null,
            'precio_regular'              => $d['precio_regular']                 ?? null,
            'precio_oferta'               => $d['precio_oferta']                  ?? null,
            'fecha_oferta_desde'          => $d['fecha_oferta_desde']             ?? null,
            'fecha_oferta_hasta'          => $d['fecha_oferta_hasta']             ?? null,
            'descripcion_corta'           => $d['descripcion_corta']              ?? null,
            'descripcion_larga'           => $d['descripcion_larga']              ?? null,
            'bullets_superiores'          => $d['bullets_superiores']             ?? null,
            'ingredientes_resumen'        => $d['ingredientes_resumen']           ?? null,
            'tabla_nutricional'           => $d['tabla_nutricional']              ?? null,
            'problema_real'               => $d['problema_real']                  ?? null,
            'origen_macro'                => $d['origen_macro']                   ?? null,
            'beneficios_explicados'       => $d['beneficios_explicados']          ?? null,
            'experiencia_y_modo_de_uso'   => $d['experiencia_y_modo_de_uso']      ?? null,
            'productor'                   => $d['productor']                      ?? null,
            'ubicacion_productor'         => $d['ubicacion_productor']            ?? null,
            'sistema_de_cultivo_origen'   => $d['sistema_de_cultivo_origen']      ?? null,
            'proceso_de_transformacion'   => $d['proceso_de_transformacion']      ?? null,
            'galeria_adicional'           => $d['galeria_adicional']              ?? null,
            'url_producto'                => $d['url_producto']                   ?? null,
        ];
    }

    // ── Validaciones mínimas ──────────────────────────────────────
    private function validar(array $datos): array
    {
        $errores = [];

        $nombre = trim($datos['nombre'] ?? '');
        if ($nombre === '') {
            $errores[] = 'El campo nombre es obligatorio.';
        }

        // Al crear (uid vacío), empresa es obligatoria
        $uid = trim($datos['uid'] ?? '');
        if ($uid === '') {
            $empresa = trim($datos['empresa'] ?? '');
            if ($empresa === '') {
                $errores[] = 'El campo empresa es obligatorio al crear un producto.';
            }
        }

        return $errores;
    }

    // ── Busca un producto por UID y lo retorna como array ─────────
    private function buscarPorUid(string $uid): ?array
    {
        $stmt = $this->pdo->prepare('SELECT * FROM com_productos WHERE uid = :uid LIMIT 1');
        $stmt->execute([':uid' => $uid]);
        $fila = $stmt->fetch();
        return $fila ?: null;
    }

    // ── Genera UID único: {EMPRESA}-{YYYYMMDDHHMMSS}-{6hex} ───────
    // Ejemplo: OS-20260227143055-a7f3b2
    private function generarUid(string $empresa): string
    {
        $ts  = date('YmdHis');
        $hex = bin2hex(random_bytes(3)); // 6 caracteres hex únicos
        return strtoupper($empresa) . '-' . $ts . '-' . $hex;
    }

    // ── Estructura estándar de respuesta (Manifiesto § 5.3) ───────
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
