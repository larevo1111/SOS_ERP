<?php
// erp/modulos/comercial/rutas_modulo.php
//
// Registro de endpoints del módulo Comercial.
// Este archivo es incluido por erp/infraestructura/rutas.php
// para construir la tabla de rutas del sistema.
//
// Formato: 'ruta_relativa' => 'ruta_absoluta_al_controlador'
// El enrutador principal (rutas.php) busca la ruta solicitada
// en esta tabla y delega al controlador correspondiente.

return [
    // Área: Productos — guardar_producto, subir_multimedia, obtener_producto,
    //                   listar_productos, listar_variaciones, guardar_variacion_express
    'comercial/productos'   => __DIR__ . '/controladores/ProductoController.php',

    // Área: Costos (Fase 7) — listar_maestros_costo
    // Lee costos_encabezados_productos (tabla protegida, solo lectura). Requiere JWT.
    'comercial/costos'      => __DIR__ . '/controladores/CostosController.php',

    // Área: Marcas (Fase 7.5) — listar_marcas
    // Lee com_marcas para el selector del FormularioProducto.
    'comercial/marcas'      => __DIR__ . '/controladores/MarcasController.php',

    // Área: WooCommerce (Fase 7) — listar_estado, sincronizar_producto (próxima fase)
    // Requiere JWT.
    'comercial/woocommerce' => __DIR__ . '/controladores/WooCommerceController.php',

    // Área: Asistente IA (Fase 7.5) — sugerir_datos via Google Gemini
    // Requiere JWT. Necesita GEMINI_API_KEY en erp/.env.
    'comercial/asistente'   => __DIR__ . '/controladores/AsistenteComercialController.php',
];
