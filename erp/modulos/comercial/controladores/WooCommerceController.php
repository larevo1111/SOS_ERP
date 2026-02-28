<?php
// erp/modulos/comercial/controladores/WooCommerceController.php
//
// Punto de entrada para /api/comercial/woocommerce
// Autenticación: JWT via ValidarJwt.
//
// Estructura base de sincronización push/pull con WooCommerce (Fase 7).
// La implementación completa de cada acción se desarrolla en fases posteriores.
//
// Variables requeridas en erp/.env:
//   WC_URL              → URL de la tienda WooCommerce (ej: https://origensilvestre.com)
//   WC_CONSUMER_KEY     → Clave del consumidor de la API REST de WC
//   WC_CONSUMER_SECRET  → Secreto del consumidor de la API REST de WC
//
// Acciones planificadas:
//   listar_estado         → Tabla de estado de sincronización de productos
//   sincronizar_producto  → Push de un producto del ERP hacia WooCommerce
//   importar_producto     → Pull de un producto de WooCommerce hacia el ERP

require_once __DIR__ . '/../../../infraestructura/base_datos/Conexion.php';
require_once __DIR__ . '/../../../infraestructura/autenticacion/ValidarJwt.php';

use Infraestructura\BaseDatos\Conexion;

// ── Cabeceras ─────────────────────────────────────────────────────
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    responderWc(false, null, 'Solo se aceptan peticiones POST.', ['metodo_invalido']);
}

function responderWc(bool $exito, $datos = null, string $mensaje = '', array $errores = []): void
{
    echo json_encode([
        'exito'   => $exito,
        'datos'   => $datos ?? (object)[],
        'mensaje' => $mensaje,
        'errores' => $errores,
    ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

// ── Autenticación JWT ─────────────────────────────────────────────
ValidarJwt::verificar();

// ── Parsear petición ──────────────────────────────────────────────
$cuerpo = json_decode(file_get_contents('php://input'), true);
if (!$cuerpo) {
    responderWc(false, null, 'Petición inválida: se esperaba JSON.', ['sin_cuerpo']);
}

$accion = trim($cuerpo['accion'] ?? '');
$datos  = $cuerpo['datos'] ?? [];

// ── Enrutar por acción ────────────────────────────────────────────
try {
    $pdo = Conexion::obtenerInstancia();

    switch ($accion) {

        case 'listar_estado':
            // Devuelve el estado de sincronización de los productos com_ con WooCommerce.
            // Un producto sincronizado tiene id_producto_woocommerce != NULL.
            $stmt = $pdo->prepare(
                'SELECT uid, nombre, estado_publicacion, id_producto_woocommerce,
                        fecha_ult_modificacion
                 FROM com_productos
                 WHERE empresa = :empresa
                 ORDER BY nombre ASC'
            );
            $empresa = trim($datos['empresa'] ?? '');
            if ($empresa === '') {
                responderWc(false, null, 'El campo empresa es obligatorio.', ['empresa_requerida']);
            }
            $stmt->execute([':empresa' => $empresa]);
            $productos = $stmt->fetchAll();

            $sincronizados  = array_filter($productos, fn($p) => !empty($p['id_producto_woocommerce']));
            $pendientes     = array_filter($productos, fn($p) =>  empty($p['id_producto_woocommerce']));

            responderWc(true, [
                'productos'      => array_values($productos),
                'resumen'        => [
                    'total'         => count($productos),
                    'sincronizados' => count($sincronizados),
                    'pendientes'    => count($pendientes),
                ],
            ], 'Estado de sincronización obtenido.');

        case 'sincronizar_producto':
            // TODO Fase posterior: push de com_productos → WooCommerce REST API
            // Requiere implementar el cliente HTTP hacia WC usando WC_URL,
            // WC_CONSUMER_KEY y WC_CONSUMER_SECRET del .env.
            responderWc(false, null,
                'La sincronización individual estará disponible en la próxima fase.',
                ['no_implementado']);

        case 'importar_producto':
            // TODO Fase posterior: pull de WooCommerce → com_productos
            responderWc(false, null,
                'La importación desde WooCommerce estará disponible en la próxima fase.',
                ['no_implementado']);

        default:
            http_response_code(400);
            responderWc(false, null, "Acción desconocida: {$accion}", ['accion_invalida']);
    }

} catch (Exception $e) {
    http_response_code(500);
    responderWc(false, null, 'Error interno del servidor.', [$e->getMessage()]);
}
