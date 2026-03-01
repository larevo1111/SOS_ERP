<?php
// erp/modulos/comercial/controladores/CostosController.php
//
// Punto de entrada para /api/comercial/costos
// Autenticación: JWT via ValidarJwt (Fase 8).
// Acciones disponibles:
//   listar_maestros_costo → ListarMaestrosCosto.php

require_once __DIR__ . '/../../../infraestructura/base_datos/Conexion.php';
require_once __DIR__ . '/../../../infraestructura/autenticacion/ValidarJwt.php';
require_once __DIR__ . '/../casos_de_uso/ListarMaestrosCosto.php';

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
    responderCostos(false, null, 'Solo se aceptan peticiones POST.', ['metodo_invalido']);
}

function responderCostos(bool $exito, $datos = null, string $mensaje = '', array $errores = []): void
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
    responderCostos(false, null, 'Petición inválida: se esperaba JSON.', ['sin_cuerpo']);
}

// ── Validar token R2_TOKEN (Temporal hasta Fase 8 JWT) ───────────────
$tokenEnviado = $cuerpo['token'] ?? '';
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
    responderCostos(false, null, 'Token inválido o ausente.', ['token_invalido']);
}

$accion = trim($cuerpo['accion'] ?? '');
$datos = $cuerpo['datos'] ?? [];

// ── Enrutar por acción ────────────────────────────────────────────
try {
    $pdo = Conexion::obtenerInstancia();

    switch ($accion) {

        case 'listar_maestros_costo':
            $caso = new ListarMaestrosCosto($pdo);
            $resultado = $caso->ejecutar($datos);
            responderCostos($resultado['exito'], $resultado['datos'], $resultado['mensaje'], $resultado['errores']);

        default:
            http_response_code(400);
            responderCostos(false, null, "Acción desconocida: {$accion}", ['accion_invalida']);
    }

}
catch (Exception $e) {
    http_response_code(500);
    responderCostos(false, null, 'Error interno del servidor.', [$e->getMessage()]);
}