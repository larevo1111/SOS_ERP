-- SOS_ERP: Estructura de Tablas Comerciales (Módulo Comercial)
-- Siguiendo el Manifiesto Operativo Sección 6.5

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ---------------------------------------------------------
-- Tabla: com_marcas
-- ---------------------------------------------------------
CREATE TABLE IF NOT EXISTS `com_marcas` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(100) NOT NULL,
  `empresa` VARCHAR(50) NOT NULL,
  `nombre` VARCHAR(150) NOT NULL,
  `usuario_creador` VARCHAR(150) NOT NULL,
  `usuario_ult_modificacion` VARCHAR(150) NOT NULL,
  `fecha_creacion` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `fecha_ult_modificacion` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_UNIQUE` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------
-- Tabla: com_productos
-- ---------------------------------------------------------
CREATE TABLE IF NOT EXISTS `com_productos` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(100) NOT NULL,
  `empresa` VARCHAR(50) NOT NULL,
  `id_producto_woocommerce` BIGINT DEFAULT NULL,
  `uid_producto_padre` VARCHAR(100) DEFAULT NULL COMMENT 'Vínculo con ficha de costos',
  `nombre` VARCHAR(255) NOT NULL,
  `nombre_grupo_catalogo` VARCHAR(255) DEFAULT NULL COMMENT 'Solo para Producto Maestro',
  `estado` ENUM('Activo','Inactivo') DEFAULT 'Activo',
  `estado_publicacion` VARCHAR(50) DEFAULT 'borrador',
  `url_producto` TEXT DEFAULT NULL,
  `producto_principal_variacion` VARCHAR(100) DEFAULT NULL COMMENT 'UID del Maestro si es Variación',
  `nombre_atributo_variacion` VARCHAR(100) DEFAULT NULL,
  `valor_atributo_variacion` VARCHAR(100) DEFAULT NULL,
  `categoria` VARCHAR(100) DEFAULT NULL,
  `marca` VARCHAR(100) DEFAULT NULL,
  `descripcion_corta` TEXT DEFAULT NULL,
  `descripcion_larga` LONGTEXT DEFAULT NULL,
  `etiquetas` TEXT DEFAULT NULL,
  `precio_regular` DECIMAL(12,2) DEFAULT 0.00,
  `precio_oferta` DECIMAL(12,2) DEFAULT NULL,
  `fecha_oferta_desde` DATE DEFAULT NULL,
  `fecha_oferta_hasta` DATE DEFAULT NULL,
  `bullets_superiores` TEXT DEFAULT NULL,
  `ingredientes_resumen` TEXT DEFAULT NULL,
  `tabla_nutricional` TEXT DEFAULT NULL,
  `problema_real` TEXT DEFAULT NULL,
  `origen_macro` TEXT DEFAULT NULL,
  `beneficios_explicados` TEXT DEFAULT NULL,
  `experiencia_y_modo_de_uso` TEXT DEFAULT NULL,
  `productor` VARCHAR(150) DEFAULT NULL,
  `ubicacion_productor` VARCHAR(255) DEFAULT NULL,
  `sistema_de_cultivo_origen` TEXT DEFAULT NULL,
  `proceso_de_transformacion` TEXT DEFAULT NULL,
  `galeria_adicional` TEXT DEFAULT NULL,
  `usuario_creador` VARCHAR(150) NOT NULL,
  `usuario_ult_modificacion` VARCHAR(150) NOT NULL,
  `fecha_creacion` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `fecha_ult_modificacion` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_UNIQUE` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------
-- Tabla: com_productos_multimedia
-- ---------------------------------------------------------
CREATE TABLE IF NOT EXISTS `com_productos_multimedia` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(100) NOT NULL,
  `empresa` VARCHAR(50) NOT NULL,
  `uid_producto` VARCHAR(100) NOT NULL,
  `tipo_archivo` ENUM('imagen','video') DEFAULT 'imagen',
  `uso` VARCHAR(50) DEFAULT 'Galeria' COMMENT 'Principal, Galeria, Variacion...',
  `archivo_local` VARCHAR(255) DEFAULT NULL,
  `archivo_cloudflare` VARCHAR(255) DEFAULT NULL,
  `orden` INT DEFAULT 0,
  `usuario_creador` VARCHAR(150) NOT NULL,
  `usuario_ult_modificacion` VARCHAR(150) NOT NULL,
  `fecha_creacion` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `fecha_ult_modificacion` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_UNIQUE` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
