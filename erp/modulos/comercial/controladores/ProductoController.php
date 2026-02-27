<?php
// erp/modulos/comercial/controladores/ProductoController.php
//
// Punto de entrada único para /api/comercial/productos
// Recibe todas las peticiones con { token, accion, datos }
// según el protocolo del Manifiesto § 5.2 y § 5.3

require_once __DIR__ . '/../../../infraestructura/base_datos/Conexion.php';
require_once __DIR__ . '/../casos_de_uso/GuardarProducto.php';
require_once __DIR__ . '/../casos_de_uso/SubirMultimedia.php';

use Infraestructura\BaseDatos\Conexion;

// ── Cabeceras ─────────────────────────────────────────────────────
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Responder al preflight de CORS sin procesar nada
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

// Solo aceptamos POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    responder(false, null, 'Solo se aceptan peticiones POST.', ['metodo_invalido']);
}

// ── Función estándar de respuesta (Manifiesto § 5.3) ──────────────
function responder(bool $exito, $datos = null, string $mensaje = '', array $errores = []): void
{
    echo json_encode([
        'exito'   => $exito,
        'datos'   => $datos ?? (object)[],
        'mensaje' => $mensaje,
        'errores' => $errores,
    ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

// ── Detectar tipo de petición: JSON o multipart (subida de archivos)
$esMultipart = isset($_SERVER['CONTENT_TYPE']) &&
               str_contains($_SERVER['CONTENT_TYPE'], 'multipart/form-data');

if ($esMultipart) {
    // Subida de archivos: el token y la acción llegan como campos de formulario
    $tokenEnviado = $_POST['token']  ?? '';
    $accion       = trim($_POST['accion'] ?? '');
    $datos        = isset($_POST['datos']) ? json_decode($_POST['datos'], true) : [];
} else {
    // Petición JSON estándar
    $cuerpo = json_decode(file_get_contents('php://input'), true);
    if (!$cuerpo) {
        responder(false, null, 'Petición inválida: se esperaba JSON.', ['sin_cuerpo']);
    }
    $tokenEnviado = $cuerpo['token']  ?? '';
    $accion       = trim($cuerpo['accion'] ?? '');
    $datos        = $cuerpo['datos']  ?? [];
}

// ── Validar token (R2_TOKEN del .env) ─────────────────────────────
// Cargamos el .env a través de Conexion, que lo hace en su constructor.
// Para validar el token antes de abrir BD, lo leemos directamente.
$rutaEnv = dirname(__DIR__, 3) . '/.env';
$tokenEsperado = '';
if (file_exists($rutaEnv)) {
    foreach (file($rutaEnv, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $linea) {
        $linea = trim($linea);
        if (str_starts_with($linea, 'R2_TOKEN=')) {
            $tokenEsperado = trim(substr($linea, strlen('R2_TOKEN=')));
            break;
        }
    }
}

if (!$tokenEsperado || !hash_equals($tokenEsperado, $tokenEnviado)) {
    http_response_code(401);
    responder(false, null, 'Token inválido o ausente.', ['token_invalido']);
}

// ── Enrutar por acción ────────────────────────────────────────────
try {
    $pdo = Conexion::obtenerInstancia();

    switch ($accion) {

        case 'guardar_producto':
            $caso      = new GuardarProducto($pdo);
            $resultado = $caso->ejecutar($datos);
            responder($resultado['exito'], $resultado['datos'], $resultado['mensaje'], $resultado['errores']);

        case 'subir_multimedia':
            $archivo = $_FILES['archivo'] ?? null;
            $caso    = new SubirMultimedia($pdo);
            $resultado = $caso->ejecutar($datos, $archivo);
            responder($resultado['exito'], $resultado['datos'], $resultado['mensaje'], $resultado['errores']);

        default:
            http_response_code(400);
            responder(false, null, "Acción desconocida: {$accion}", ['accion_invalida']);
    }

} catch (Exception $e) {
    http_response_code(500);
    responder(false, null, 'Error interno del servidor.', [$e->getMessage()]);
}
