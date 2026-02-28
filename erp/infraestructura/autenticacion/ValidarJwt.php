<?php
// erp/infraestructura/autenticacion/ValidarJwt.php
//
// Middleware de autenticación JWT para los endpoints de la API.
// Usa firebase/php-jwt (instalado con Composer: `cd erp && composer install`).
//
// Variable requerida en erp/.env:
//   JWT_SECRET → clave secreta para firmar/verificar tokens (mínimo 32 caracteres)
//
// Uso en un controlador:
//   require_once __DIR__ . '/../../../infraestructura/autenticacion/ValidarJwt.php';
//   ValidarJwt::verificar(); // detiene la ejecución con 401 si el token es inválido
//   $usuario = ValidarJwt::$usuarioActual; // payload del JWT para usar en el controlador

namespace Infraestructura\Autenticacion;

use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Firebase\JWT\ExpiredException;
use Firebase\JWT\SignatureInvalidException;

class ValidarJwt
{
    // Payload decodificado del JWT, disponible después de verificar()
    public static ?object $usuarioActual = null;

    // Verifica el token JWT del header Authorization: Bearer <token>
    // Si el token es inválido o ausente, responde con 401 y detiene la ejecución.
    public static function verificar(): void
    {
        // ── Verificar que Composer está instalado ─────────────────
        $autoload = dirname(__DIR__, 2) . '/vendor/autoload.php';
        if (!file_exists($autoload)) {
            http_response_code(500);
            header('Content-Type: application/json; charset=utf-8');
            echo json_encode([
                'exito'   => false,
                'datos'   => (object)[],
                'mensaje' => 'Error de configuración del servidor: dependencias no instaladas.',
                'errores' => ['ejecuta: cd erp && composer install'],
            ], JSON_UNESCAPED_UNICODE);
            exit;
        }
        require_once $autoload;

        // ── Cargar JWT_SECRET del .env ────────────────────────────
        $secreto = self::leerEnv('JWT_SECRET');
        if (!$secreto) {
            http_response_code(500);
            header('Content-Type: application/json; charset=utf-8');
            echo json_encode([
                'exito'   => false,
                'datos'   => (object)[],
                'mensaje' => 'Error de configuración: JWT_SECRET no definido en .env.',
                'errores' => ['jwt_secret_faltante'],
            ], JSON_UNESCAPED_UNICODE);
            exit;
        }

        // ── Extraer Bearer token del header ──────────────────────
        $headerAuth = $_SERVER['HTTP_AUTHORIZATION']
            ?? apache_request_headers()['Authorization']
            ?? '';

        if (!str_starts_with($headerAuth, 'Bearer ')) {
            self::rechazar('Token de autenticación ausente.', 'sin_token');
        }

        $token = trim(substr($headerAuth, 7));
        if ($token === '') {
            self::rechazar('Token de autenticación vacío.', 'token_vacio');
        }

        // ── Decodificar y verificar ───────────────────────────────
        try {
            $payload = JWT::decode($token, new Key($secreto, 'HS256'));
            self::$usuarioActual = $payload;
        } catch (ExpiredException) {
            self::rechazar('La sesión ha expirado. Vuelve a iniciar sesión.', 'token_expirado');
        } catch (SignatureInvalidException) {
            self::rechazar('Token inválido.', 'firma_invalida');
        } catch (\Exception $e) {
            self::rechazar('Error al verificar el token: ' . $e->getMessage(), 'token_error');
        }
    }

    // Lee una variable del archivo erp/.env (sin depender de la clase Conexion)
    private static function leerEnv(string $clave): string
    {
        // Primero intentar getenv() en caso de que ya esté cargado
        $valor = getenv($clave);
        if ($valor !== false) {
            return $valor;
        }

        $ruta = dirname(__DIR__, 2) . '/.env';
        if (!file_exists($ruta)) {
            return '';
        }

        foreach (file($ruta, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $linea) {
            $linea = trim($linea);
            if (str_starts_with($linea, '#') || !str_contains($linea, '=')) {
                continue;
            }
            [$k, $v] = explode('=', $linea, 2);
            if (trim($k) === $clave) {
                return trim($v);
            }
        }
        return '';
    }

    // Responde 401 y detiene la ejecución
    private static function rechazar(string $mensaje, string $codigo): void
    {
        http_response_code(401);
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode([
            'exito'   => false,
            'datos'   => (object)[],
            'mensaje' => $mensaje,
            'errores' => [$codigo],
        ], JSON_UNESCAPED_UNICODE);
        exit;
    }
}
