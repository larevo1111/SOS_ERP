<?php
// erp/modulos/sistema/base_datos/migracion_sys_menu_v2.php
// Script para crear y sembrar la tabla sys_menu_v2

require_once __DIR__ . "/../../../infraestructura/base_datos/Conexion.php";

use Infraestructura\BaseDatos\Conexion;

try {
    $pdo = Conexion::obtenerInstancia();

    // 1. Crear Tabla
    $sql = "
    CREATE TABLE IF NOT EXISTS sys_menu_v2 (
        id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
        uid VARCHAR(100) NOT NULL UNIQUE,
        empresa VARCHAR(50) NOT NULL,
        uid_padre VARCHAR(100) DEFAULT NULL,
        titulo VARCHAR(100) NOT NULL,
        icono VARCHAR(100) DEFAULT NULL,
        ruta_vue VARCHAR(255) DEFAULT NULL,
        orden INT DEFAULT 0,
        nivel_profundidad INT DEFAULT 1,
        
        -- Auditoría obligatoria 5S
        usuario_creador VARCHAR(150) NOT NULL,
        usuario_ult_modificacion VARCHAR(150) NOT NULL,
        fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
        fecha_ult_modificacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        
        PRIMARY KEY (id),
        FOREIGN KEY (uid_padre) REFERENCES sys_menu_v2(uid) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ";

    $pdo->exec($sql);
    echo "Tabla sys_menu_v2 creada exitosamente.\n";

    // 2. Sembrar Datos Iniciales
    // Verificar si ya existe el root Comercial
    $stmt = $pdo->prepare("SELECT id FROM sys_menu_v2 WHERE uid = 'OS-MENU-COMERCIAL'");
    $stmt->execute();
    if (!$stmt->fetch()) {
        $usuario = 'santi@origensilvestre.com';

        // Padre: Comercial (Nivel 1)
        $stmtInsert = $pdo->prepare("
            INSERT INTO sys_menu_v2 (uid, empresa, uid_padre, titulo, icono, ruta_vue, orden, nivel_profundidad, usuario_creador, usuario_ult_modificacion)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ");

        $stmtInsert->execute(['OS-MENU-COMERCIAL', 'os', null, 'Comercial', 'storefront', null, 10, 1, $usuario, $usuario]);

        // Hijo: Catálogo (Nivel 2)
        $stmtInsert->execute(['OS-MENU-COM-CAT', 'os', 'OS-MENU-COMERCIAL', 'Catálogo Comercial', 'inventory_2', 'catalogo-productos', 1, 2, $usuario, $usuario]);

        // Hijo: WooCommerce (Nivel 2)
        $stmtInsert->execute(['OS-MENU-COM-WOO', 'os', 'OS-MENU-COMERCIAL', 'Integración WooCommerce', 'sync_alt', 'integracion-woocommerce', 2, 2, $usuario, $usuario]);

        echo "Datos sembrados exitosamente.\n";
    }
    else {
        echo "Los datos ya estaban sembrados.\n";
    }

}
catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}