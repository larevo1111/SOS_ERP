<?php
// erp/modulos/sistema/controladores/AuthController.php
//
// Endpoint público: /api/sistema/login
// NO requiere token previo — es el punto de obtención del JWT.
//
// Petición esperada:
//   POST { accion: "login", datos: { email, password } }
//
// Respuesta exitosa:
//   { exito: true, datos: { token, usuario: { uid, nombre, email, rol, empresa } }, mensaje: "..." }
//
// Variables requeridas en erp/.env:
//   JWT_SECRET  → clave secreta para firmar el token (mínimo 32 caracteres)
// Variables de Composer:
//   firebase/php-jwt debe estar instalado (cd erp && composer install)

require_once __DIR__ . '/../../../infraestructura/base_datos/Conexion.php';

use Infraestructura\BaseDatos\Conexion;
use Firebase\JWT\JWT;

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
    responderAuth(false, null, 'Solo se aceptan peticiones POST.', ['metodo_invalido']);
}

function responderAuth(bool $exito, $datos = null, string $mensaje = '', array $errores = []): void
{
    echo json_encode([
        'exito'   => $exito,
        'datos'   => $datos ?? (object)[],
        'mensaje' => $mensaje,
        'errores' => $errores,
    ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

// ── Cargar Composer (firebase/php-jwt) ────────────────────────────
$autoload = dirname(__DIR__, 3) . '/vendor/autoload.php';
if (!file_exists($autoload)) {
    http_response_code(500);
    responderAuth(false, null,
        'Error de servidor: ejecuta `cd erp && composer install` para instalar dependencias.',
        ['composer_no_instalado']);
}
require_once $autoload;

// ── Parsear petición ──────────────────────────────────────────────
$cuerpo = json_decode(file_get_contents('php://input'), true);
if (!$cuerpo) {
    responderAuth(false, null, 'Petición inválida: se esperaba JSON.', ['sin_cuerpo']);
}

$accion = trim($cuerpo['accion'] ?? '');
$datos  = $cuerpo['datos'] ?? [];

if ($accion !== 'login') {
    http_response_code(400);
    responderAuth(false, null, "Acción desconocida: {$accion}", ['accion_invalida']);
}

// ── Acción: login ─────────────────────────────────────────────────
$email    = trim($datos['email']    ?? '');
$password = trim($datos['password'] ?? '');

if ($email === '' || $password === '') {
    responderAuth(false, null, 'Email y contraseña son obligatorios.', ['credenciales_vacias']);
}

// ── Buscar usuario en sys_usuarios ────────────────────────────────
try {
    $pdo  = Conexion::obtenerInstancia();
    $stmt = $pdo->prepare(
        'SELECT uid, nombre, email, password, rol, empresa
         FROM sys_usuarios
         WHERE email = :email
         LIMIT 1'
    );
    $stmt->execute([':email' => $email]);
    $usuario = $stmt->fetch();

} catch (Exception $e) {
    http_response_code(500);
    responderAuth(false, null, 'Error interno del servidor.', [$e->getMessage()]);
}

// Credenciales inválidas — mismo mensaje para email no encontrado y contraseña incorrecta
// (no revelar cuál de los dos falló, por seguridad)
if (!$usuario || !password_verify($password, $usuario['password'])) {
    http_response_code(401);
    responderAuth(false, null, 'Email o contraseña incorrectos.', ['credenciales_invalidas']);
}

// ── Generar JWT ───────────────────────────────────────────────────
$secreto = '';
$rutaEnv = dirname(__DIR__, 3) . '/.env';
if (file_exists($rutaEnv)) {
    foreach (file($rutaEnv, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $linea) {
        $linea = trim($linea);
        if (str_starts_with($linea, 'JWT_SECRET=')) {
            $secreto = trim(substr($linea, strlen('JWT_SECRET=')));
            break;
        }
    }
}

if (!$secreto) {
    http_response_code(500);
    responderAuth(false, null,
        'Error de configuración: JWT_SECRET no está definido en el archivo .env.',
        ['jwt_secret_faltante']);
}

$ahora  = time();
$expira = $ahora + 86400; // 24 horas

$payload = [
    'sub'     => $usuario['uid'],
    'email'   => $usuario['email'],
    'nombre'  => $usuario['nombre'],
    'rol'     => $usuario['rol'],
    'empresa' => $usuario['empresa'],
    'iat'     => $ahora,
    'exp'     => $expira,
];

$token = JWT::encode($payload, $secreto, 'HS256');

// ── Respuesta exitosa ─────────────────────────────────────────────
responderAuth(true, [
    'token'   => $token,
    'expira'  => $expira,
    'usuario' => [
        'uid'     => $usuario['uid'],
        'nombre'  => $usuario['nombre'],
        'email'   => $usuario['email'],
        'rol'     => $usuario['rol'],
        'empresa' => $usuario['empresa'],
    ],
], 'Sesión iniciada correctamente.');
