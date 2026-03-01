<?php
// erp/modulos/comercial/controladores/AsistenteComercialController.php
//
// Endpoint: /api/comercial/asistente
// Asistente IA comercial usando Google Gemini API.
//
// Autenticación: JWT (Authorization: Bearer <token>)
//
// Variable requerida en erp/.env:
//   GEMINI_API_KEY → clave de la API de Google Gemini
//
// Acciones disponibles:
//   sugerir_datos → recibe contexto parcial del producto/variación y retorna sugerencias
//
// Petición esperada:
//   POST { accion: "sugerir_datos", datos: { contexto: { ... } } }
//   El campo 'contexto' admite cualquier subconjunto de:
//     nombre_atributo_variacion, valor_atributo_variacion,
//     uid_producto_padre_nombre (nombre del producto de costos),
//     nombre_actual (nombre que el usuario ya escribió, si hay alguno)
//
// Respuesta exitosa:
//   { exito: true, datos: { nombre_sugerido, valor_atributo_normalizado, nota }, mensaje: "..." }

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
    responderAsistente(false, null, 'Solo se aceptan peticiones POST.', ['metodo_invalido']);
}

function responderAsistente(bool $exito, $datos = null, string $mensaje = '', array $errores = []): void
{
    echo json_encode([
        'exito'   => $exito,
        'datos'   => $datos ?? (object)[],
        'mensaje' => $mensaje,
        'errores' => $errores,
    ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

// ── Verificar JWT ─────────────────────────────────────────────────
$autoload = dirname(__DIR__, 3) . '/vendor/autoload.php';
if (!file_exists($autoload)) {
    http_response_code(500);
    responderAsistente(false, null,
        'Error de servidor: ejecuta `cd erp && composer install`.',
        ['composer_no_instalado']);
}
require_once $autoload;
require_once __DIR__ . '/../../../infraestructura/autenticacion/ValidarJwt.php';

use Infraestructura\Autenticacion\ValidarJwt;
ValidarJwt::verificar();

// ── Parsear petición ──────────────────────────────────────────────
$cuerpo = json_decode(file_get_contents('php://input'), true);
if (!$cuerpo) {
    responderAsistente(false, null, 'Petición inválida: se esperaba JSON.', ['sin_cuerpo']);
}

$accion  = trim($cuerpo['accion'] ?? '');
$datos   = $cuerpo['datos'] ?? [];

// ── Enrutar por acción ────────────────────────────────────────────
switch ($accion) {

    case 'sugerir_datos':
        $contexto = $datos['contexto'] ?? [];
        if (empty($contexto)) {
            responderAsistente(false, null, 'Se requiere el campo datos.contexto.', ['contexto_vacio']);
        }
        $resultado = llamarGemini($contexto);
        responderAsistente($resultado['exito'], $resultado['datos'], $resultado['mensaje'], $resultado['errores']);

    default:
        http_response_code(400);
        responderAsistente(false, null, "Acción desconocida: {$accion}", ['accion_invalida']);
}

// ── Llamada a Google Gemini via cURL ──────────────────────────────
function llamarGemini(array $contexto): array
{
    // Leer GEMINI_API_KEY del .env
    $apiKey = '';
    $rutaEnv = dirname(__DIR__, 3) . '/.env';
    if (file_exists($rutaEnv)) {
        foreach (file($rutaEnv, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $linea) {
            $linea = trim($linea);
            if (str_starts_with($linea, 'GEMINI_API_KEY=')) {
                $apiKey = trim(substr($linea, strlen('GEMINI_API_KEY=')));
                break;
            }
        }
    }

    if (!$apiKey) {
        return [
            'exito'   => false,
            'datos'   => null,
            'mensaje' => 'Error de configuración: GEMINI_API_KEY no definida en .env.',
            'errores' => ['gemini_key_faltante'],
        ];
    }

    // Construir prompt con el contexto recibido
    $nombreAtributo   = $contexto['nombre_atributo_variacion']  ?? '';
    $valorAtributo    = $contexto['valor_atributo_variacion']   ?? '';
    $nombreProductoCostos = $contexto['uid_producto_padre_nombre'] ?? '';
    $nombreActual     = $contexto['nombre_actual']               ?? '';

    $prompt = <<<PROMPT
Eres un asistente de datos para Origen Silvestre, empresa colombiana de alimentos naturales.
Tu tarea es sugerir el nombre comercial de una variación de producto y normalizar el atributo de variación.

Contexto recibido:
- Producto base (costos): "{$nombreProductoCostos}"
- Nombre actual del producto (puede estar vacío): "{$nombreActual}"
- Atributo de variación: "{$nombreAtributo}"
- Valor del atributo: "{$valorAtributo}"

Reglas:
1. El nombre sugerido debe combinar el producto base con el valor del atributo (Ej: "Miel Silvestre 500g").
2. Normaliza el valor del atributo: "grs" → "gramos", "grs." → "gramos", "500gr" → "500g", "ml." → "ml". Si ya está bien, devuélvelo igual.
3. Si el nombre actual ya es correcto y descriptivo, puedes devolverlo sin cambios.
4. Responde ÚNICAMENTE con JSON válido, sin texto extra, sin bloques de código, sin comillas triples.

Formato de respuesta:
{"nombre_sugerido":"...","valor_atributo_normalizado":"...","nota":"..."}
PROMPT;

    $url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=' . urlencode($apiKey);

    $payload = json_encode([
        'contents' => [
            ['parts' => [['text' => $prompt]]]
        ],
        'generationConfig' => [
            'temperature'     => 0.3,
            'maxOutputTokens' => 256,
        ],
    ]);

    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST           => true,
        CURLOPT_POSTFIELDS     => $payload,
        CURLOPT_HTTPHEADER     => ['Content-Type: application/json'],
        CURLOPT_TIMEOUT        => 15,
    ]);

    $respuestaRaw = curl_exec($ch);
    $httpCode     = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError    = curl_error($ch);
    curl_close($ch);

    if ($curlError) {
        return [
            'exito'   => false,
            'datos'   => null,
            'mensaje' => 'Error de red al contactar Gemini.',
            'errores' => [$curlError],
        ];
    }

    $respuesta = json_decode($respuestaRaw, true);

    if ($httpCode !== 200 || !isset($respuesta['candidates'][0]['content']['parts'][0]['text'])) {
        return [
            'exito'   => false,
            'datos'   => null,
            'mensaje' => "Gemini respondió con HTTP {$httpCode}.",
            'errores' => [$respuestaRaw],
        ];
    }

    $textoGemini = trim($respuesta['candidates'][0]['content']['parts'][0]['text']);

    // Parsear JSON que devuelve Gemini
    $sugerencias = json_decode($textoGemini, true);
    if (!$sugerencias) {
        return [
            'exito'   => false,
            'datos'   => null,
            'mensaje' => 'Gemini devolvió una respuesta no estructurada.',
            'errores' => [$textoGemini],
        ];
    }

    return [
        'exito'   => true,
        'datos'   => $sugerencias,
        'mensaje' => 'Sugerencias generadas correctamente.',
        'errores' => [],
    ];
}
