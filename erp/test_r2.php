<?php

// Script para probar la conexión con Cloudflare R2 (Simulación básica de parámetros)
// En un entorno real se usaría el AWS SDK for PHP, aquí solo validaremos que las variables existan y el endpoint responda.

require_once __DIR__ . '/infraestructura/base_datos/Conexion.php';
// Usamos la función cargarEnv que ya implementamos en la clase Conexion para leer el .env
// Pero como es privada, simplemente emularemos la carga para este test rápido.

echo "--- Prueba de Configuración Cloudflare R2 ---\n";

$rutaEnv = __DIR__ . '/.env';
if (!file_exists($rutaEnv)) {
    die("Error: No se encontró el archivo .env\n");
}

$lineas = file($rutaEnv, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
$config = [];
foreach ($lineas as $linea) {
    if (strpos(trim($linea), '#') === 0)
        continue;
    $parts = explode('=', $linea, 2);
    if (count($parts) == 2) {
        $config[trim($parts[0])] = trim($parts[1]);
    }
}

$required = ['R2_ACCESS_KEY_ID', 'R2_SECRET_ACCESS_KEY', 'R2_ENDPOINT', 'R2_BUCKET'];
$missing = [];

foreach ($required as $key) {
    if (empty($config[$key])) {
        $missing[] = $key;
    }
    else {
        echo "[OK] $key está configurado.\n";
    }
}

if (!empty($missing)) {
    echo "ERROR: Faltan variables: " . implode(', ', $missing) . "\n";
}
else {
    echo "Resultado: Configuración de R2 local completa.\n";

    // Intento de conexión básica al endpoint (HTTP 200/403/404 significa que el servidor existe)
    $ch = curl_init($config['R2_ENDPOINT']);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 5);
    curl_exec($ch);
    $code = curl_getinfo($ch, CURLINFO_HTTP_CODE);

    if ($code > 0) {
        echo "[OK] El endpoint de Cloudflare responde (Status: $code).\n";
    }
    else {
        echo "[ADVERTENCIA] El endpoint no responde. Verifica tu conexión a internet.\n";
    }
    curl_close($ch);
}
echo "---------------------------------------------\n";
