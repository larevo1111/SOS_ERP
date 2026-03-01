<?php
// erp/modulos/comercial/controladores/AsistenteComercialController.php
//
// Endpoint: /api/comercial/asistente
// Asistente IA comercial usando Google Gemini API.
//
// Autenticación: R2_TOKEN (Temporal hasta Fase 8 JWT)
//
// Variable requerida en erp/.env:
//   GEMINI_API_KEY → clave de la API de Google Gemini
//

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
    responderAsistente(false, null, 'Petición inválida: se esperaba JSON.', ['sin_cuerpo']);
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
    responderAsistente(false, null, 'Token inválido o ausente.', ['token_invalido']);
}

$accion = trim($cuerpo['accion'] ?? '');
$datos = $cuerpo['datos'] ?? [];

// ── Autoload (Solo si existe para herramientas futuras) ───────────
$autoload = dirname(__DIR__, 3) . '/vendor/autoload.php';
if (file_exists($autoload)) {
    require_once $autoload;
}

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
            'exito' => false,
            'datos' => null,
            'mensaje' => 'Error de configuración: GEMINI_API_KEY no definida en .env.',
            'errores' => ['gemini_key_faltante'],
        ];
    }

    // Construir prompt con el contexto recibido
    $nombreAtributo = $contexto['nombre_atributo_variacion'] ?? '';
    $valorAtributo = $contexto['valor_atributo_variacion'] ?? '';
    $nombreProductoCostos = $contexto['uid_producto_padre_nombre'] ?? '';
    $nombreActual = $contexto['nombre_actual'] ?? '';
    $campoObjetivo = $contexto['campo_peticion'] ?? 'nombre';

    $prompt = <<<PROMPT
Eres un asistente de datos experto para Origen Silvestre, una empresa colombiana de alimentos artesanales y naturales.
Tu tarea es sugerir valores coherentes para campos de productos basados en el contexto de su "Matriz de Costos" de origen.

Contexto actual:
- Producto base (Matriz de Costos): "{$nombreProductoCostos}"
- Nombre escrito por el usuario: "{$nombreActual}"
- Atributo: "{$nombreAtributo}" | Valor: "{$valorAtributo}"

Campo que debes sugerir: "{$campoObjetivo}"

Reglas de Sugerencia:
1. CRÍTICO: Si "Producto base" está vacío o no se provee, tu sugerencia debe estar vacía y la "nota" debe pedirle al usuario amigablemente que primero seleccione un "Producto de costos".
2. Si pido "nombre": Combina el producto base con el valor/atributo. Ej: "Miel Silvestre" + "500g" -> "Miel Silvestre 500g".
3. Si pido "nombre_grupo_catalogo": Debe ser el nombre del grupo/familia General, sin pesos ni medidas específicas. Ej: "Miel Silvestre 300g" -> "Miel Silvestre". "Miel de Abejas con Jengibre 250ml" -> "Miel de Abejas con Jengibre".
4. Si pido "valor_atributo_variacion": Normaliza unidades eliminando puntos y estandarizando. Ej: "grs" -> "g", "ml." -> "ml", "500 gr" -> "500g".
5. Responde ÚNICAMENTE en JSON válido con esta estructura estricta: {"sugerencia":"...", "nota":"..."}. Nada de texto adicional antes ni después.
PROMPT;

    $url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=' . urlencode($apiKey);

    $payload = json_encode([
        'contents' => [
            ['parts' => [['text' => $prompt]]]
        ],
        'generationConfig' => [
            'temperature' => 0.2,
            'maxOutputTokens' => 8192,
            'responseMimeType' => 'application/json'
        ],
    ]);

    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => $payload,
        CURLOPT_HTTPHEADER => ['Content-Type: application/json'],
        CURLOPT_TIMEOUT => 15,
    ]);

    $respuestaRaw = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError = curl_error($ch);
    curl_close($ch);

    if ($curlError) {
        return [
            'exito' => false,
            'datos' => null,
            'mensaje' => 'Error de red al contactar Gemini.',
            'errores' => [$curlError],
        ];
    }

    $respuesta = json_decode($respuestaRaw, true);

    if ($httpCode !== 200 || !isset($respuesta['candidates'][0]['content']['parts'][0]['text'])) {
        return [
            'exito' => false,
            'datos' => null,
            'mensaje' => "Gemini respondió con HTTP {$httpCode}.",
            'errores' => [$respuestaRaw],
        ];
    }

    $textoGemini = trim($respuesta['candidates'][0]['content']['parts'][0]['text']);

    // Extraer forzosamente el JSON incluso si Gemini incluye texto introductorio ("Claro, aquí tienes...")
    $inicio = strpos($textoGemini, '{');
    $fin = strrpos($textoGemini, '}');

    if ($inicio !== false && $fin !== false) {
        $textoGemini = substr($textoGemini, $inicio, $fin - $inicio + 1);
    }
    else {
        // Fallback: Limpiar posibles bloques de código que Gemini a veces agrega por error
        $textoGemini = preg_replace('/^```json\s*|```$/m', '', $textoGemini);
    }

    $sugerencias = json_decode($textoGemini, true);
    if (!$sugerencias || !array_key_exists('sugerencia', $sugerencias)) {
        return [
            'exito' => false,
            'datos' => null,
            'mensaje' => 'Gemini devolvió una respuesta no estructurada o incompleta.',
            'errores' => [$textoGemini],
        ];
    }

    return [
        'exito' => true,
        'datos' => $sugerencias,
        'mensaje' => 'Sugerencias generadas correctamente.',
        'errores' => [],
    ];
}