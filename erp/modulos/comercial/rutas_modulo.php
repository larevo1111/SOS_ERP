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
    // Área: Productos
    // Acciones disponibles (vía parámetro 'accion' en el body):
    //   guardar_producto   → GuardarProducto.php
    //   subir_multimedia   → SubirMultimedia.php
    'comercial/productos' => __DIR__ . '/controladores/ProductoController.php',
];
