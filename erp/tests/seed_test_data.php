<?php
// erp/tests/seed_test_data.php
// Script para generar datos de prueba complejos para el módulo Comercial.
// Versión Diamante v2: Ajuste de nulos por cadenas vacías para integridad.

require_once __DIR__ . "/../infraestructura/base_datos/Conexion.php";

use Infraestructura\BaseDatos\Conexion;

try {
    $pdo = Conexion::obtenerInstancia();
    $empresa = "os";
    $usuario = "santi@origensilvestre.com";

    echo "--- Iniciando Seeding de Datos de Prueba (Versión Diamante v2) ---\n";

    // 1. Limpiar datos previos de prueba
    $pdo->prepare("DELETE FROM com_productos_multimedia WHERE empresa = ?")->execute([$empresa]);
    $pdo->prepare("DELETE FROM com_productos WHERE empresa = ?")->execute([$empresa]);

    // ── FUNCIÓN AUXILIAR PARA INSERTAR PRODUCTO ─────────────────────────
    $insertarProducto = function ($datos) use ($pdo, $usuario, $empresa) {
        $sql = "INSERT INTO com_productos (
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
            :uid, :empresa, :nombre, :estado, :estado_pub,
            :id_wc, :uid_padre,
            :ppal_var, :grupo,
            :attr_n, :attr_v,
            :cat, :marca, :tags,
            :p_reg, :p_off,
            :f_off_d, :f_off_h,
            :desc_c, :desc_l,
            :bullets, :ingr, :nutri,
            :prob, :orig, :bene,
            :exp,
            :prod, :loc,
            :cult, :tran,
            :gal, :url_p,
            :crea, :modi
        )";

        $stmt = $pdo->prepare($sql);

        // Unificar defaults: campos de texto no deben ser NULL si la DB es estricta
        $defaults = [
            'uid' => '', 'empresa' => $empresa, 'nombre' => '', 'estado' => 'Activo', 'estado_pub' => 'publicado',
            'id_wc' => null, 'uid_padre' => '', 'ppal_var' => '', 'grupo' => '',
            'attr_n' => '', 'attr_v' => '', 'cat' => '', 'marca' => '', 'tags' => '',
            'p_reg' => 0, 'p_off' => 0, 'f_off_d' => null, 'f_off_h' => null,
            'desc_c' => '', 'desc_l' => '', 'bullets' => '', 'ingr' => '', 'nutri' => '',
            'prob' => '', 'orig' => '', 'bene' => '', 'exp' => '',
            'prod' => '', 'loc' => '', 'cult' => '', 'tran' => '',
            'gal' => '', 'url_p' => '', 'crea' => $usuario, 'modi' => $usuario
        ];

        $stmt->execute(array_merge($defaults, $datos));
    };

    // 2. Insertar Producto Maestro
    $uidMaestro = "OS-" . date("YmdHis") . "-MAESTRO";
    $insertarProducto([
        'uid' => $uidMaestro,
        'nombre' => "Miel de Bosque Nativo (Maestro)",
        'cat' => 'Alimentos',
        'marca' => 'Origen Silvestre',
        'p_reg' => 45000,
        'desc_c' => 'Miel pura de bosque nativo de Origen Silvestre.',
        'desc_l' => 'Miel recolectada de forma sostenible en los bosques vírgenes del sur de Colombia.',
        'prod' => 'Asociación de Apicultores del Sur',
        'loc' => 'Cauca, Colombia',
        'url_p' => 'https://origensilvestre.com/producto/miel-bosque'
    ]);
    echo "✔ Producto Maestro creado: $uidMaestro\n";

    // 3. Insertar Variación 1 (250g)
    $uidV1 = "OS-" . date("YmdHis") . "-V250G";
    $insertarProducto([
        'uid' => $uidV1,
        'nombre' => "Miel de Bosque Nativo - 250g",
        'uid_padre' => $uidMaestro,
        'ppal_var' => $uidMaestro,
        'attr_n' => 'Tamaño',
        'attr_v' => '250g',
        'p_reg' => 25000,
        'cat' => 'Alimentos',
        'marca' => 'Origen Silvestre'
    ]);
    echo "✔ Variación 1 creada: $uidV1\n";

    // 4. Insertar Variación 2 (500g)
    $uidV2 = "OS-" . date("YmdHis") . "-V500G";
    $insertarProducto([
        'uid' => $uidV2,
        'nombre' => "Miel de Bosque Nativo - 500g",
        'uid_padre' => $uidMaestro,
        'ppal_var' => $uidMaestro,
        'attr_n' => 'Tamaño',
        'attr_v' => '500g',
        'p_reg' => 40000,
        'cat' => 'Alimentos',
        'marca' => 'Origen Silvestre'
    ]);
    echo "✔ Variación 2 creada: $uidV2\n";

    // 5. Insertar Multimedia
    $sqlImg = "INSERT INTO com_productos_multimedia (
        uid, empresa, uid_producto, tipo_archivo,
        nombre_archivo, ruta_archivo, url_publica,
        uso, orden, estado,
        usuario_creador, usuario_ult_modificacion
    ) VALUES (
        :uid, :empresa, :uid_p, :tipo,
        :nombre, :ruta, :url,
        :uso, :orden, :estado,
        :creador, :modificador
    )";

    $stmtImg = $pdo->prepare($sqlImg);

    // Portada Maestro
    $stmtImg->execute([
        ":uid" => "IMG-" . uniqid(),
        ":empresa" => $empresa,
        ":uid_p" => $uidMaestro,
        ":tipo" => 'imagen',
        ":nombre" => "miel_portada.jpg",
        ":ruta" => "os_com_fotos/miel_portada.jpg",
        ":url" => "https://pub-807d8848135848e08670868f08f0a9f5.r2.dev/miel_test.jpg",
        ":uso" => "Portada",
        ":orden" => 1,
        ":estado" => 'Activo',
        ":creador" => $usuario,
        ":modificador" => $usuario
    ]);

    // Galería Maestro
    $stmtImg->execute([
        ":uid" => "IMG-" . uniqid(),
        ":empresa" => $empresa,
        ":uid_p" => $uidMaestro,
        ":tipo" => 'imagen',
        ":nombre" => "miel_detalle.jpg",
        ":ruta" => "os_com_fotos/miel_detalle.jpg",
        ":url" => "https://pub-807d8848135848e08670868f08f0a9f5.r2.dev/miel_detalle_test.jpg",
        ":uso" => "Galeria",
        ":orden" => 2,
        ":estado" => 'Activo',
        ":creador" => $usuario,
        ":modificador" => $usuario
    ]);

    echo "✔ Multimedia insertada correctamente.\n";
    echo "--- Seeding completado con éxito ---\n";

}
catch (Exception $e) {
    echo "❌ ERROR: " . $e->getMessage() . "\n";
}