-- SOS_ERP: Estructura REAL de Tablas Comerciales (Auditada 2026-02-27)
-- Referencia para el desarrollo del backend.

SET NAMES utf8mb4;

-- ---------------------------------------------------------
-- Tabla: com_marcas
-- ---------------------------------------------------------
CREATE TABLE IF NOT EXISTS `com_marcas` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(100) NOT NULL,
  `empresa` VARCHAR(50) NOT NULL,
  -- ... otros campos existentes ...
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_UNIQUE` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------
-- Tabla: com_productos
-- ---------------------------------------------------------
-- Estructura simplificada basada en DESCRIBE real
CREATE TABLE IF NOT EXISTS `com_productos` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(100) NOT NULL,
  `empresa` VARCHAR(50) NOT NULL,
  `nombre` VARCHAR(255) NOT NULL,
  `precio_regular` DECIMAL(12,2),
  -- ... auditoria ...
  `usuario_creador` VARCHAR(80) NOT NULL,
  `usuario_ult_modificacion` VARCHAR(80) NOT NULL,
  `fecha_creacion` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `fecha_ult_modificacion` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_UNIQUE` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------
-- Tabla: com_productos_multimedia (ESPECIAL ATENCIÓN AQUÍ)
-- Schema REAL verificado con DESCRIBE (2026-03-01)
-- ⚠️ CRÍTICO: NO agregar columnas que no estén aquí al hacer INSERT
-- ---------------------------------------------------------
CREATE TABLE IF NOT EXISTS `com_productos_multimedia` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(80) NOT NULL,
  `empresa` VARCHAR(50) NOT NULL,
  `uid_producto` VARCHAR(80) NOT NULL,
  `tipo_archivo` ENUM('imagen','video','documento','html') NOT NULL DEFAULT 'imagen',
  `uso` ENUM('Principal','Galeria','Variacion','Galeria secundaria','Otro') NOT NULL DEFAULT 'Galeria',
  `archivo_local` VARCHAR(500) NOT NULL COMMENT 'Nombre original del archivo subido',
  `archivo_woocommerce` VARCHAR(500) NOT NULL COMMENT 'URL pública en Cloudflare R2 o WooCommerce',
  `orden` INT NOT NULL DEFAULT 0,
  `estado` ENUM('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  `usuario_creador` VARCHAR(80) NOT NULL,
  `usuario_ult_modificacion` VARCHAR(80) NOT NULL,
  `fecha_creacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_ult_modificacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_UNIQUE` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- ⚠️ El campo `uso` tiene como 'Principal' (NO 'Portada') para la imagen de portada.
