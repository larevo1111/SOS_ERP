<?php

namespace Infraestructura\BaseDatos;

use PDO;
use PDOException;
use Exception;

/**
 * Clase Conexion
 * Maneja la conexión a MariaDB usando PDO y variables de entorno.
 * Siguiendo el Manifiesto Operativo (Sección 6.8).
 */
class Conexion
{
    private static $instancia = null;
    private $pdo;

    private function __construct()
    {
        // Cargar .env manualmente si no se usa una librería externa (para minimalismo)
        $this->cargarEnv(__DIR__ . '/../../.env');

        $host = getenv('DB_HOST') ?: 'localhost';
        $port = getenv('DB_PORT') ?: '3306';
        $db = getenv('DB_NAME');
        $user = getenv('DB_USER');
        $pass = getenv('DB_PASS');
        $charset = getenv('DB_CHARSET') ?: 'utf8mb4';

        if (!$db || !$user) {
            throw new Exception("Faltan variables de configuración en el archivo .env");
        }

        $dsn = "mysql:host=$host;port=$port;dbname=$db;charset=$charset";

        $opciones = [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ];

        try {
            $this->pdo = new PDO($dsn, $user, $pass, $opciones);
        }
        catch (PDOException $e) {
            throw new PDOException("Error de conexión: " . $e->getMessage(), (int)$e->getCode());
        }
    }

    public static function obtenerInstancia()
    {
        if (self::$instancia === null) {
            self::$instancia = new self();
        }
        return self::$instancia->pdo;
    }

    /**
     * Carga las variables de un archivo .env al entorno de ejecución.
     */
    private function cargarEnv($ruta)
    {
        if (!file_exists($ruta)) {
            return;
        }

        $lineas = file($ruta, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
        foreach ($lineas as $linea) {
            if (strpos(trim($linea), '#') === 0)
                continue;

            list($nombre, $valor) = explode('=', $linea, 2);
            $nombre = trim($nombre);
            $valor = trim($valor);

            if (!empty($nombre)) {
                putenv("$nombre=$valor");
                $_ENV[$nombre] = $valor;
                $_SERVER[$nombre] = $valor;
            }
        }
    }
}
