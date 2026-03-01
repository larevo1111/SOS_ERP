<?php
// erp/modulos/comercial/controladores/MarcasController.php
//
// Endpoint: /api/comercial/marcas
// Sirve el catálogo de marcas (com_marcas) para el selector del FormularioProducto.
//
// Autenticación: R2_TOKEN (misma que ProductoController, sin JWT, es un selector público del form).
//
// Acciones disponibles:
//   listar_marcas → devuelve [ { id, uid, nombre } ] de com_marcas ordenado por nombre

require_once __DIR__ . '/../../../infraestructura/base_datos/Conexion.php';

use Infraestructura\BaseDatos\Conexion;

// ── Cabeceras ─────────────────────────────────────────────────────
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    responderMarcas(false, null, 'Solo se aceptan peticiones POST.', ['metodo_invalido']);
}

function responderMarcas(bool $exito, $datos = null, string $mensaje = '', array $errores = []): void
{
    echo json_encode([
        'exito'   => $exito,
        'datos'   => $datos ?? (object)[],
        'mensaje' => $mensaje,
        'errores' => $errores,
    ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

// ── Parsear petición JSON ─────────────────────────────────────────
$cuerpo = json_decode(file_get_contents('php://input'), true);
if (!$cuerpo) {
    responderMarcas(false, null, 'Petición inválida: se esperaba JSON.', ['sin_cuerpo']);
}

$tokenEnviado = $cuerpo['token'] ?? '';
$accion       = trim($cuerpo['accion'] ?? '');
$datos        = $cuerpo['datos'] ?? [];

// ── Validar token R2_TOKEN ─────────────────────────────────────────
$rutaEnv      = dirname(__DIR__, 3) . '/.env';
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
    responderMarcas(false, null, 'Token inválido o ausente.', ['token_invalido']);
}

// ── Enrutar por acción ────────────────────────────────────────────
try {
    $pdo = Conexion::obtenerInstancia();

    switch ($accion) {

        case 'listar_marcas':
            $busqueda = trim($datos['busqueda'] ?? '');
            if ($busqueda !== '') {
                $stmt = $pdo->prepare(
                    'SELECT id, uid, nombre FROM com_marcas
                     WHERE nombre LIKE :busqueda
                     ORDER BY nombre ASC'
                );
                $stmt->execute([':busqueda' => '%' . $busqueda . '%']);
            } else {
                $stmt = $pdo->query('SELECT id, uid, nombre FROM com_marcas ORDER BY nombre ASC');
            }
            $marcas = $stmt->fetchAll();
            responderMarcas(true, ['marcas' => $marcas], 'Marcas obtenidas correctamente.');

        default:
            http_response_code(400);
            responderMarcas(false, null, "Acción desconocida: {$accion}", ['accion_invalida']);
    }

} catch (Exception $e) {
    http_response_code(500);
    responderMarcas(false, null, 'Error interno del servidor.', [$e->getMessage()]);
}
