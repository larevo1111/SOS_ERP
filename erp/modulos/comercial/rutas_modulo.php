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
    // Área: Productos — guardar_producto, subir_multimedia, obtener_producto, listar_productos
    'comercial/productos'   => __DIR__ . '/controladores/ProductoController.php',

    // Área: Costos (Fase 7) — listar_maestros_costo
    // Lee costos_encabezados_productos (tabla protegida, solo lectura). Requiere JWT.
    'comercial/costos'      => __DIR__ . '/controladores/CostosController.php',

    // Área: WooCommerce (Fase 7) — listar_estado, sincronizar_producto (próxima fase)
    // Requiere JWT.
    'comercial/woocommerce' => __DIR__ . '/controladores/WooCommerceController.php',
];
