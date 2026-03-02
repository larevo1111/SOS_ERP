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
        'exito' => $exito,
        'datos' => $datos ?? (object)[],
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

$accion = trim($cuerpo['accion'] ?? '');
$datos = $cuerpo['datos'] ?? [];

// ── Filtro de Seguridad Multi-tenant (OBLIGATORIO) ──────────────
require_once __DIR__ . '/../../../infraestructura/autenticacion/ValidarJwt.php';
use Infraestructura\Autenticacion\ValidarJwt;

$usuarioRef = ValidarJwt::$usuarioActual;
if (!$usuarioRef) {
    http_response_code(401);
    responderMarcas(false, null, 'Acceso denegado: Sesión no validada.', ['jwt_ausente']);
}

$datos['empresa'] = $usuarioRef->empresa_activa ?? '';
if (empty($datos['empresa'])) {
    http_response_code(403);
    responderMarcas(false, null, 'Bloqueo: No hay empresa activa en el token.', ['empresa_activa_ausente']);
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
                     WHERE empresa = :empresa AND nombre LIKE :busqueda
                     ORDER BY nombre ASC'
                );
                $stmt->execute([
                    ':empresa' => $datos['empresa'],
                    ':busqueda' => '%' . $busqueda . '%'
                ]);
            }
            else {
                $stmt = $pdo->prepare('SELECT id, uid, nombre FROM com_marcas WHERE empresa = :empresa ORDER BY nombre ASC');
                $stmt->execute([':empresa' => $datos['empresa']]);
            }
            $marcas = $stmt->fetchAll();
            responderMarcas(true, ['marcas' => $marcas], 'Marcas obtenidas correctamente.');

        default:
            http_response_code(400);
            responderMarcas(false, null, "Acción desconocida: {$accion}", ['accion_invalida']);
    }

}
catch (Exception $e) {
    http_response_code(500);
    responderMarcas(false, null, 'Error interno del servidor.', [$e->getMessage()]);
}