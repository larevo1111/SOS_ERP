<?php

require_once __DIR__ . '/infraestructura/base_datos/Conexion.php';

use Infraestructura\BaseDatos\Conexion;

try {
    echo "--- Prueba de Conexión SOS ERP ---\n";
    $db = Conexion::obtenerInstancia();

    $query = $db->query("SELECT 'Conexión Exitosa' AS mensaje, @@version AS version");
    $resultado = $query->fetch();

    echo "Resultado: " . $resultado['mensaje'] . "\n";
    echo "Motor: " . $resultado['version'] . "\n";
    echo "----------------------------------\n";
}
catch (Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
}
