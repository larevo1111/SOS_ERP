<?php
// erp/infraestructura/rutas.php
//
// Enrutador principal del ERP.
// Reúne las tablas de rutas de todos los módulos y despacha
// la petición al controlador que corresponda.
//
// Cómo se invoca:
//   El servidor web (Apache) debe redirigir /api/* a este archivo
//   mediante el .htaccess ubicado en erp/.htaccess.
//   La URL esperada: /api/{modulo}/{area}
//   Ejemplo: POST /api/comercial/productos

// ── Construir tabla de rutas cargando todos los módulos ──────────
$rutas = [];
$rutas = array_merge($rutas, require __DIR__ . '/../modulos/comercial/rutas_modulo.php');
// Agregar nuevos módulos aquí cuando se creen:
// $rutas = array_merge($rutas, require __DIR__ . '/../modulos/ventas/rutas_modulo.php');

// ── Resolver la ruta solicitada ───────────────────────────────────
// Extraemos el segmento de la URL que viene después de /api/
$uri = $_SERVER['REQUEST_URI'] ?? '';

// Remover query string si existe (?foo=bar)
$uri = strtok($uri, '?');

// Normalizar: buscar el segmento después de /api/
$posApi = strpos($uri, '/api/');
if ($posApi !== false) {
    $uri = substr($uri, $posApi + 5);
}
else {
    // Si no viene con /api/, intentar limpiar barras iniciales
    $uri = ltrim($uri, '/');
}
$uri = rtrim($uri, '/');

// Buscar la ruta en la tabla
if (!array_key_exists($uri, $rutas)) {
    http_response_code(404);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode([
        'exito' => false,
        'datos' => (object)[],
        'mensaje' => "Ruta no encontrada: {$uri}",
        'errores' => ['ruta_no_encontrada'],
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

// Despachar al controlador del módulo
require $rutas[$uri];