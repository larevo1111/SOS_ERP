<?php
// erp/modulos/sistema/rutas_modulo.php
//
// Rutas exclusivas del módulo Sistema (Usuarios, Empresa, Menús, etc.)

return [
    // Menú dinámico de 3 niveles (sys_menu_v2)
    'sistema/menu'  => __DIR__ . '/controladores/MenuController.php',

    // Login JWT (Fase 8) — endpoint público, sin token previo requerido
    'sistema/login' => __DIR__ . '/controladores/AuthController.php',
];