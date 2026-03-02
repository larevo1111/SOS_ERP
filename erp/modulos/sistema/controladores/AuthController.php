<?php
// erp/modulos/sistema/controladores/AuthController.php
// Endpoint público: /api/sistema/auth/*

require_once __DIR__ . '/../../../infraestructura/base_datos/Conexion.php';
require_once __DIR__ . '/../../../vendor/autoload.php';

use Infraestructura\BaseDatos\Conexion;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use PDO;

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

function responderAuth(bool $exito, $datos = null, string $mensaje = '', array $errores = [], $httpCode = null): void
{
    if ($httpCode !== null)
        http_response_code($httpCode);
    echo json_encode([
        'exito' => $exito,
        'datos' => $datos ?? (object)[],
        'mensaje' => $mensaje,
        'errores' => $errores,
    ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

function getJwtSecret()
{
    $rutaEnv = dirname(__DIR__, 3) . '/.env';
    if (file_exists($rutaEnv)) {
        foreach (file($rutaEnv, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $linea) {
            $linea = trim($linea);
            if (str_starts_with($linea, 'JWT_SECRET=')) {
                return trim(substr($linea, strlen('JWT_SECRET=')));
            }
        }
    }
    responderAuth(false, null, 'Error de servidor: JWT_SECRET no configurado.', ['missing_secret'], 500);
}

// ── Parsear petición ──────────────────────────────────────────────
$cuerpo = json_decode(file_get_contents('php://input'), true);
if (!$cuerpo) {
    responderAuth(false, null, 'Petición inválida: se esperaba JSON.', ['sin_cuerpo'], 400);
}

$accion = trim($cuerpo['accion'] ?? '');
$datos = $cuerpo['datos'] ?? [];

$pdo = Conexion::obtenerInstancia();
$jwtSecret = getJwtSecret();

switch ($accion) {
    case 'autenticar_google':
        if (empty($datos['id_token']))
            responderAuth(false, null, 'Falta el id_token.', ['id_token_missing'], 400);

        // Validar con Google
        $url = 'https://oauth2.googleapis.com/tokeninfo?id_token=' . $datos['id_token'];
        $response = @file_get_contents($url);
        if ($response === false)
            responderAuth(false, null, 'Token de Google inválido o expirado.', ['invalid_google_token'], 401);

        $payload = json_decode($response, true);
        if (!isset($payload['email']))
            responderAuth(false, null, 'No se pudo obtener el email.', ['no_email'], 401);

        validarIdentidadYEmpresas($pdo, $payload['email'], $jwtSecret);
        break;

    case 'autenticar_correo':
        if (empty($datos['correo']) || empty($datos['contrasena']))
            responderAuth(false, null, 'Correo y contraseña requeridos.', ['credenciales_vacias'], 400);

        $email = trim($datos['correo']);
        $pass = $datos['contrasena'];

        $stmt = $pdo->prepare("SELECT password, estado FROM sys_usuarios WHERE email = :email LIMIT 1");
        $stmt->execute(['email' => $email]);
        $usuario = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$usuario || !password_verify($pass, $usuario['password'])) {
            responderAuth(false, null, 'Email o contraseña incorrectos.', ['auth_fail'], 401);
        }
        if ($usuario['estado'] !== 'Activo') {
            responderAuth(false, null, 'Usuario inactivo.', ['user_inactive'], 403);
        }

        validarIdentidadYEmpresas($pdo, $email, $jwtSecret);
        break;

    case 'seleccionar_empresa':
        if (empty($datos['token_temporal']) || empty($datos['empresa']))
            responderAuth(false, null, 'Faltan datos.', ['missing_data'], 400);

        try {
            $decoded = JWT::decode($datos['token_temporal'], new Key($jwtSecret, 'HS256'));
            $tempData = (array)$decoded;
        }
        catch (Exception $e) {
            responderAuth(false, null, 'Token temporal expirado o inválido.', ['invalid_temp_token'], 401);
        }

        $empresaElegida = $datos['empresa'];
        $empresas = (array)$tempData['empresas_disponibles'];
        $esValida = false;
        $nombreEmpresaElegida = '';

        foreach ($empresas as $emp) {
            $empArr = (array)$emp;
            // El identificador real es uid_empresa (ej: 'Ori_Sil_2'), NO las siglas
            if ($empArr['uid_empresa'] === $empresaElegida) {
                $esValida = true;
                $nombreEmpresaElegida = $empArr['nombre_empresa'] ?? $empresaElegida;
                $siglasEmpresaElegida = $empArr['siglas'] ?? '';
                break;
            }
        }

        if (!$esValida)
            responderAuth(false, null, 'Empresa no autorizada.', ['unauthorized_company'], 403);

        // Emitir Token Final — incluye uid, nombre_empresa y siglas de la empresa activa
        $ahora = time();
        $finalPayload = [
            'sub'            => $tempData['email'],
            'email'          => $tempData['email'],
            'nombre'         => $tempData['nombre'],
            'foto'           => $tempData['foto'],
            'Nivel_Acceso'   => $tempData['nivel'],
            'empresa_activa' => $empresaElegida,         // uid de sys_empresa (ej: 'Ori_Sil_2')
            'empresa_nombre' => $nombreEmpresaElegida,   // nombre completo (ej: 'Origen Silvestre')
            'empresa_siglas' => $siglasEmpresaElegida ?? '', // abreviatura (ej: 'OS')
            'iat'            => $ahora,
            'exp'            => $ahora + 86400 * 7       // 7 días
        ];

        $tokenFinal = JWT::encode($finalPayload, $jwtSecret, 'HS256');

        responderAuth(true, [
            'token' => $tokenFinal,
            'usuario' => $finalPayload,
            'empresas_disponibles' => $empresas
        ], 'Acceso concedido.');
        break;

    default:
        responderAuth(false, null, "Acción desconocida: {$accion}", ['accion_invalida'], 400);
}

// ── Helpers ───────────────────────────────────────────────────────
function validarIdentidadYEmpresas($pdo, $email, $jwtSecret)
{
    try {
        // sys_usuarios usa Email como PK (tabla heredada, NO tiene columna 'uid')
        $stmt = $pdo->prepare("
            SELECT Email, Nombre_Usuario, Nivel_Acceso, estado, foto_url, ultima_empresa
            FROM sys_usuarios 
            WHERE Email = :email 
            LIMIT 1
        ");
        $stmt->execute(['email' => $email]);
        $usuario = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$usuario)
            responderAuth(false, null, 'Usuario no registrado. Comunícate con el administrador.', ['user_not_found'], 403);
        if ($usuario['estado'] !== 'Activo')
            responderAuth(false, null, 'Usuario inactivo. Comunícate con el administrador.', ['user_inactive'], 403);

        // Buscar empresas asignadas — sys_empresa.uid ('Ori_Sil_2') es el identificador real
        // que coincide exactamente con sys_usuarios_empresas.empresa
        $stmtEmp = $pdo->prepare("
            SELECT 
                e.uid          as uid_empresa,
                e.nombre_empresa,
                e.siglas
            FROM sys_usuarios_empresas ue
            INNER JOIN sys_empresa e ON e.uid = ue.empresa
            WHERE ue.usuario = :email AND ue.estado = 'Activo'
        ");
        $stmtEmp->execute(['email' => $email]);
        $empresas = $stmtEmp->fetchAll(PDO::FETCH_ASSOC);

        if (count($empresas) === 0) {
            responderAuth(false, null, 'No tienes ninguna empresa asignada. Comunícate con el administrador.', ['no_companies'], 403);
        }

        // Token temporal (5 min) para que el usuario elija empresa
        $tempPayload = [
            'iat' => time(),
            'exp' => time() + 300,
            'email' => $usuario['Email'],
            'nombre' => $usuario['Nombre_Usuario'],
            'foto' => $usuario['foto_url'] ?? '',
            'nivel' => $usuario['Nivel_Acceso'],
            'empresas_disponibles' => $empresas
        ];

        $tempToken = JWT::encode($tempPayload, $jwtSecret, 'HS256');

        responderAuth(true, [
            'requiere_seleccion' => true,
            'token_temporal' => $tempToken,
            'empresas' => $empresas,
            'usuario' => [
                'nombre' => $usuario['Nombre_Usuario'],
                'email' => $usuario['Email'],
                'foto' => $usuario['foto_url'] ?? ''
            ]
        ], 'Selecciona una empresa.');

    }
    catch (Exception $e) {
        responderAuth(false, null, 'Error interno: ' . $e->getMessage(), ['db_error'], 500);
    }
}