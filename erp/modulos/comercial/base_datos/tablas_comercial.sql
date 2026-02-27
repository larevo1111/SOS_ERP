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
-- ---------------------------------------------------------
-- Esta es la estructura que Claude debe usar para los INSERT/UPDATE
CREATE TABLE IF NOT EXISTS `com_productos_multimedia` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(100) NOT NULL,
  `empresa` VARCHAR(50) NOT NULL,
  `uid_producto` VARCHAR(100) NOT NULL,
  `id_archivo_wc` BIGINT DEFAULT NULL,
  `tipo_archivo` VARCHAR(50) DEFAULT 'imagen',
  `nombre_archivo` VARCHAR(255) NOT NULL,
  `ruta_archivo` VARCHAR(255) NOT NULL COMMENT 'Ruta local',
  `url_publica` TEXT DEFAULT NULL COMMENT 'URL de Cloudflare R2',
  `orden` INT DEFAULT 0,
  `estado` ENUM('Activo','Inactivo') DEFAULT 'Activo',
  `usuario_creador` VARCHAR(80) NOT NULL,
  `usuario_ult_modificacion` VARCHAR(80) NOT NULL,
  `fecha_creacion` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `fecha_ult_modificacion` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_UNIQUE` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
