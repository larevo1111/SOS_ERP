<?php
// erp/modulos/sistema/controladores/MenuController.php

require_once __DIR__ . '/../../../infraestructura/base_datos/Conexion.php';

use Infraestructura\BaseDatos\Conexion;

class MenuController
{
    private PDO $pdo;

    public function __construct()
    {
        $this->pdo = Conexion::obtenerInstancia();
    }

    public function procesarPeticion(array $datos): void
    {
        $accion = $datos['accion'] ?? '';

        try {
            switch ($accion) {
                case 'obtener_menu':
                    $this->obtenerMenu($datos);
                    break;
                default:
                    $this->enviarRespuesta(false, null, "Acción no reconocida en Sistema/Menú: {$accion}");
                    break;
            }
        }
        catch (Exception $e) {
            $this->enviarRespuesta(false, null, "Error interno", [$e->getMessage()]);
        }
    }

    private function obtenerMenu(array $datos): void
    {
        // Traer todos los menús ordenados por nivel y luego por orden.
        $stmt = $this->pdo->prepare("SELECT * FROM sys_menu_v2 ORDER BY nivel_profundidad ASC, orden ASC");
        $stmt->execute();
        $menusFlat = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Algoritmo de Lista de Adyacencia a Árbol (Tree)
        $tree = [];
        $references = [];

        foreach ($menusFlat as $menu) {
            $menu['hijos'] = [];
            $references[$menu['uid']] = $menu;
        }

        foreach ($references as $uid => &$menu) {
            $padre = $menu['uid_padre'];
            if (empty($padre)) {
                // Es un nodo raíz (Nivel 1)
                $tree[] = & $menu;
            }
            else {
                // Es un subnodo, asignarlo a su padre
                if (isset($references[$padre])) {
                    $references[$padre]['hijos'][] = & $menu;
                }
            }
        }

        // Importante: No dejar referencias colgadas antes del encode
        unset($menu);

        $this->enviarRespuesta(true, ['menu' => $tree], "Menú cargado correctamente.");
    }

    private function enviarRespuesta(bool $exito, $datos = null, string $mensaje = '', array $errores = []): void
    {
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode([
            'exito' => $exito,
            'datos' => $datos ?? (object)[],
            'mensaje' => $mensaje,
            'errores' => $errores
        ], JSON_UNESCAPED_UNICODE);
        exit;
    }
}

// ── Punto de entrada HTTP para /api/sistema/menu ────────────────
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode([
        'exito' => false,
        'datos' => (object)[],
        'mensaje' => 'Solo se aceptan peticiones POST.',
        'errores' => ['metodo_invalido'],
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

$cuerpo = json_decode(file_get_contents('php://input'), true);
if (!$cuerpo) {
    http_response_code(400);
    echo json_encode([
        'exito' => false,
        'datos' => (object)[],
        'mensaje' => 'Petición inválida: se esperaba JSON.',
        'errores' => ['sin_cuerpo'],
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

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

$tokenEnviado = $cuerpo['token'] ?? '';
if (!$tokenEsperado || !hash_equals($tokenEsperado, $tokenEnviado)) {
    http_response_code(401);
    echo json_encode([
        'exito' => false,
        'datos' => (object)[],
        'mensaje' => 'Token inválido o ausente.',
        'errores' => ['token_invalido'],
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

$accion = trim($cuerpo['accion'] ?? '');
$datos = is_array($cuerpo['datos'] ?? null) ? $cuerpo['datos'] : [];
$datos['accion'] = $accion;

$controller = new MenuController();
$controller->procesarPeticion($datos);
