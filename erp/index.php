<?php
// erp/index.php
// Punto de entrada central de la API SOS_ERP.
// Maneja CORS, carga de entorno y despacho de rutas.

// ── Configuración de CORS [Estándar 5S Seguridad] ──────────────────
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");

// Manejo de peticiones preflight (Pre-vuelo)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// ── Despachar a Rutas ─────────────────────────────────────────────
// El servidor web redirige aquí via .htaccess
require_once __DIR__ . "/infraestructura/rutas.php";