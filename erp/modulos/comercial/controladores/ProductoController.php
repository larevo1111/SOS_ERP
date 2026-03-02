<?php
// erp/modulos/comercial/controladores/ProductoController.php
//
// Punto de entrada único para /api/comercial/productos
// Recibe todas las peticiones con { token, accion, datos }
// según el protocolo del Manifiesto § 5.2 y § 5.3

require_once __DIR__ . '/../../../infraestructura/base_datos/Conexion.php';
require_once __DIR__ . '/../casos_de_uso/GuardarProducto.php';
require_once __DIR__ . '/../casos_de_uso/SubirMultimedia.php';
require_once __DIR__ . '/../casos_de_uso/ObtenerProducto.php';
require_once __DIR__ . '/../casos_de_uso/ListarProductos.php';
require_once __DIR__ . '/../casos_de_uso/ListarVariaciones.php';
require_once __DIR__ . '/../casos_de_uso/GuardarVariacionExpress.php';

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
        'exito' => $exito,
        'datos' => $datos ?? (object)[],
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
    $tokenEnviado = $_POST['token'] ?? '';
    $accion = trim($_POST['accion'] ?? '');
    $datos = isset($_POST['datos']) ? json_decode($_POST['datos'], true) : [];
}
else {
    // Petición JSON estándar
    $cuerpo = json_decode(file_get_contents('php://input'), true);
    if (!$cuerpo) {
        responder(false, null, 'Petición inválida: se esperaba JSON.', ['sin_cuerpo']);
    }
    $tokenEnviado = $cuerpo['token'] ?? '';
    $accion = trim($cuerpo['accion'] ?? '');
    $datos = $cuerpo['datos'] ?? [];
}

// ── Filtro de Seguridad Multi-tenant (OBLIGATORIO) ──────────────
// El middleware ValidarJwt ya se ejecutó en rutas.php.
// Extraemos la información del token y blindamos el payload ($datos)
require_once __DIR__ . '/../../../infraestructura/autenticacion/ValidarJwt.php';
use Infraestructura\Autenticacion\ValidarJwt;

$usuarioRef = ValidarJwt::$usuarioActual;
if (!$usuarioRef) {
    http_response_code(401);
    responder(false, null, 'Acceso denegado: Sesión no validada.', ['jwt_ausente']);
}

// Inyección forzada en el arreglo de datos: esto propaga el blindaje
// a GuardarProducto, ListarProductos, SubirMultimedia, etc.
$datos['empresa'] = $usuarioRef->empresa_activa ?? '';
$datos['usuario_creador'] = $usuarioRef->email ?? '';
$datos['usuario_ult_modificacion'] = $usuarioRef->email ?? '';

if (empty($datos['empresa'])) {
    http_response_code(403);
    responder(false, null, 'Bloqueo de seguridad: No seleccionaste una empresa activa en el token.', ['empresa_activa_ausente']);
}

// ── Enrutar por acción ────────────────────────────────────────────
try {
    $pdo = Conexion::obtenerInstancia();

    switch ($accion) {

        case 'guardar_producto':
            $caso = new GuardarProducto($pdo);
            $resultado = $caso->ejecutar($datos);
            responder($resultado['exito'], $resultado['datos'], $resultado['mensaje'], $resultado['errores']);

        case 'subir_multimedia':
            $archivo = $_FILES['archivo'] ?? null;
            $caso = new SubirMultimedia($pdo);
            $resultado = $caso->ejecutar($datos, $archivo);
            responder($resultado['exito'], $resultado['datos'], $resultado['mensaje'], $resultado['errores']);

        case 'obtener_producto':
            $caso = new ObtenerProducto($pdo);
            $resultado = $caso->ejecutar($datos);
            responder($resultado['exito'], $resultado['datos'], $resultado['mensaje'], $resultado['errores']);

        case 'listar_productos':
            $caso = new ListarProductos($pdo);
            $resultado = $caso->ejecutar($datos);
            responder($resultado['exito'], $resultado['datos'], $resultado['mensaje'], $resultado['errores']);

        case 'listar_variaciones':
            $caso = new ListarVariaciones($pdo);
            $resultado = $caso->ejecutar($datos);
            responder($resultado['exito'], $resultado['datos'], $resultado['mensaje'], $resultado['errores']);

        case 'guardar_variacion_express':
            $caso = new GuardarVariacionExpress($pdo);
            $resultado = $caso->ejecutar($datos);
            responder($resultado['exito'], $resultado['datos'], $resultado['mensaje'], $resultado['errores']);

        default:
            http_response_code(400);
            responder(false, null, "Acción desconocida: {$accion}", ['accion_invalida']);
    }

}
catch (Exception $e) {
    http_response_code(500);
    responder(false, null, 'Error interno del servidor.', [$e->getMessage()]);
}