/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.6-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: sos_erp_local
-- ------------------------------------------------------
-- Server version	11.8.6-MariaDB-ubu2404

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `Ensayoski`
--

DROP TABLE IF EXISTS `Ensayoski`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ensayoski` (
  `id` int(11) NOT NULL,
  `dos` int(11) NOT NULL,
  `tres` date NOT NULL,
  `cuatro` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `com_marcas`
--

DROP TABLE IF EXISTS `com_marcas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `com_marcas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(80) NOT NULL DEFAULT '',
  `empresa` varchar(50) NOT NULL DEFAULT '',
  `nombre` varchar(150) NOT NULL DEFAULT '',
  `descripcion` text NOT NULL,
  `url_amigable` varchar(200) NOT NULL DEFAULT '',
  `logo` varchar(500) DEFAULT '',
  `estado` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  `usuario_creador` varchar(80) NOT NULL DEFAULT '',
  `usuario_ult_modificacion` varchar(80) NOT NULL DEFAULT '',
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_uid` (`uid`),
  UNIQUE KEY `uk_nombre_empresa` (`empresa`,`nombre`),
  KEY `idx_empresa` (`empresa`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `com_productos`
--

DROP TABLE IF EXISTS `com_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `com_productos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(80) NOT NULL DEFAULT '',
  `empresa` varchar(50) NOT NULL DEFAULT '',
  `estado` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  `id_producto_woocommerce` bigint(20) unsigned DEFAULT 0,
  `uid_producto_padre` varchar(80) NOT NULL DEFAULT '',
  `nombre` varchar(255) NOT NULL DEFAULT '',
  `nombre_grupo_catalogo` varchar(255) DEFAULT NULL,
  `estado_publicacion` enum('borrador','publicado','privado','pendiente') NOT NULL DEFAULT 'borrador',
  `url_producto` varchar(255) NOT NULL,
  `producto_principal_variacion` varchar(500) DEFAULT '',
  `nombre_atributo_variacion` varchar(150) DEFAULT '',
  `valor_atributo_variacion` varchar(150) DEFAULT '',
  `categoria` varchar(150) DEFAULT '',
  `marca` varchar(150) DEFAULT '',
  `descripcion_corta` text DEFAULT NULL,
  `descripcion_larga` longtext DEFAULT NULL,
  `etiquetas` varchar(500) DEFAULT '',
  `precio_regular` decimal(12,2) DEFAULT NULL,
  `precio_oferta` decimal(12,2) DEFAULT NULL,
  `fecha_oferta_desde` date DEFAULT NULL,
  `fecha_oferta_hasta` date DEFAULT NULL,
  `bullets_superiores` longtext DEFAULT NULL,
  `ingredientes_resumen` longtext DEFAULT NULL,
  `tabla_nutricional` longtext DEFAULT NULL,
  `problema_real` longtext DEFAULT NULL,
  `origen_macro` longtext DEFAULT NULL,
  `beneficios_explicados` longtext DEFAULT NULL,
  `experiencia_y_modo_de_uso` longtext DEFAULT NULL,
  `productor` longtext DEFAULT NULL,
  `ubicacion_productor` longtext DEFAULT NULL,
  `sistema_de_cultivo_origen` longtext DEFAULT NULL,
  `proceso_de_transformacion` longtext DEFAULT NULL,
  `galeria_adicional` longtext DEFAULT NULL,
  `usuario_creador` varchar(80) NOT NULL,
  `usuario_ult_modificacion` varchar(80) NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_uid` (`uid`),
  UNIQUE KEY `uk_id_producto_woocommerce` (`id_producto_woocommerce`),
  KEY `idx_empresa` (`empresa`),
  KEY `idx_uid_producto_padre` (`uid_producto_padre`),
  KEY `idx_slug` (`url_producto`),
  KEY `idx_estado_publicacion` (`estado_publicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `com_productos_multimedia`
--

DROP TABLE IF EXISTS `com_productos_multimedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `com_productos_multimedia` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(80) NOT NULL,
  `empresa` varchar(50) NOT NULL,
  `uid_producto` varchar(80) NOT NULL,
  `tipo_archivo` enum('imagen','video','documento','html') NOT NULL DEFAULT 'imagen',
  `uso` enum('Principal','Galeria','Variacion','Galeria secundaria','Otro') NOT NULL DEFAULT 'Galeria',
  `archivo_local` varchar(500) NOT NULL,
  `archivo_woocommerce` varchar(500) NOT NULL,
  `orden` int(11) NOT NULL DEFAULT 0,
  `estado` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  `usuario_creador` varchar(80) NOT NULL DEFAULT '',
  `usuario_ult_modificacion` varchar(80) NOT NULL DEFAULT '',
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_uid` (`uid`),
  KEY `idx_uid_producto` (`uid_producto`),
  KEY `idx_empresa` (`empresa`),
  KEY `idx_orden` (`orden`),
  CONSTRAINT `fk_multimedia_producto` FOREIGN KEY (`uid_producto`) REFERENCES `com_productos` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_categorias`
--

DROP TABLE IF EXISTS `costos_categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(80) NOT NULL,
  `Empresa` varchar(50) NOT NULL,
  `tipo` varchar(100) DEFAULT NULL,
  `categoria` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_matricula` datetime DEFAULT NULL,
  `fecha_ult_modificacion` datetime DEFAULT current_timestamp(),
  `usuario_creador` varchar(100) DEFAULT NULL,
  `usuario_ult_modificacion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_costos_categorias_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_consumibles`
--

DROP TABLE IF EXISTS `costos_consumibles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_consumibles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `Empresa` varchar(50) NOT NULL,
  `estado` varchar(50) NOT NULL DEFAULT 'Activo',
  `cod_barras` varchar(100) DEFAULT '',
  `nombre` varchar(255) NOT NULL,
  `unidad` varchar(50) DEFAULT '',
  `categoria` varchar(100) DEFAULT '',
  `costo_manual` decimal(12,4) DEFAULT 0.0000,
  `costo_promedio` decimal(12,4) DEFAULT 0.0000,
  `ultimo_costo` decimal(12,4) DEFAULT 0.0000,
  `gestion_de_stock` tinyint(1) DEFAULT 1,
  `stock_minimo` decimal(10,4) DEFAULT 0.0000,
  `stock_optimo` decimal(10,4) DEFAULT 0.0000,
  `stock_total_empresa` decimal(10,4) DEFAULT 0.0000,
  `observaciones` text DEFAULT '',
  `fecha_matricula` datetime DEFAULT NULL,
  `fecha_ult_modificacion` datetime DEFAULT current_timestamp(),
  `usuario_creador` varchar(100) DEFAULT NULL,
  `usuario_ult_modificacion` varchar(100) DEFAULT NULL,
  `Imagen_1` varchar(100) DEFAULT '',
  `Imagen_2` varchar(100) DEFAULT '',
  `Imagen_3` varchar(100) DEFAULT '',
  `Archivo_1` varchar(100) DEFAULT '',
  `Archivo_2` varchar(100) DEFAULT '',
  `Archivo_3` varchar(100) DEFAULT '',
  `observaciones_sistema` text DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  UNIQUE KEY `uq_costos_consumibles_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_encabezados_productos`
--

DROP TABLE IF EXISTS `costos_encabezados_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_encabezados_productos` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `Empresa` varchar(50) NOT NULL,
  `Producto` text NOT NULL,
  `Categoria` text DEFAULT '',
  `Grupo` text DEFAULT '',
  `Etiqueta` text DEFAULT '',
  `Tipo` text DEFAULT '',
  `unidad_producto` text DEFAULT '',
  `Estado` text DEFAULT 'Desarrollo',
  `version_estandar` text DEFAULT '',
  `uid_procedimiento` text DEFAULT '',
  `cantidad_reparto` decimal(12,4) DEFAULT 0.0000,
  `vlr_un_mercado` decimal(12,4) DEFAULT 0.0000,
  `proporcion_manual` decimal(12,4) DEFAULT 0.0000,
  `duracion_min` decimal(12,4) DEFAULT 0.0000,
  `base_reparto` decimal(12,4) DEFAULT 0.0000,
  `Proporcion` decimal(12,4) DEFAULT 0.0000,
  `unidad_procedimiento` varchar(50) DEFAULT '',
  `costo_conjunto` text DEFAULT '',
  `Costo Proced Total` decimal(12,4) DEFAULT 0.0000,
  `Costo Proced PP` decimal(12,4) DEFAULT 0.0000,
  `Costo Proced Mp insumos` decimal(12,4) DEFAULT 0.0000,
  `Costo Proced Consumibles` decimal(12,4) DEFAULT 0.0000,
  `Costo Proced Mo Servicios` decimal(12,4) DEFAULT 0.0000,
  `Costo Proced Herramientas` decimal(12,4) DEFAULT 0.0000,
  `Precio_Pub_sin_IVA` decimal(12,4) DEFAULT 0.0000,
  `Codigo_de_barras` text DEFAULT '',
  `imagen_1` text DEFAULT '',
  `imagen_2` text DEFAULT '',
  `imagen_3` text DEFAULT '',
  `imagen_4` text DEFAULT '',
  `imagen_5` text DEFAULT '',
  `imagen_6` text DEFAULT '',
  `imagen_7` text DEFAULT '',
  `archivo_1` text DEFAULT '',
  `archivo_2` text DEFAULT '',
  `archivo_3` text DEFAULT '',
  `video_1` text DEFAULT '',
  `video_2` text DEFAULT '',
  `video_3` text DEFAULT '',
  `Fecha_creacion` datetime DEFAULT NULL,
  `Fecha_ini_produccion` datetime DEFAULT NULL,
  `Fecha_ult_modificacion` datetime DEFAULT current_timestamp(),
  `Usuario_creador` text DEFAULT '',
  `Usuario_aprobador_prod` text DEFAULT '',
  `Usuario_ult_modificacion` text DEFAULT '',
  `Gestion_de_stock` text DEFAULT '',
  `Stock_minimo` decimal(12,4) DEFAULT 0.0000,
  `Stock_optimo` decimal(12,4) DEFAULT 0.0000,
  `Stock_total_empresa` decimal(12,4) DEFAULT 0.0000,
  `Observaciones` text DEFAULT '',
  `observaciones_sistema` text DEFAULT '',
  `Copiar_de` text DEFAULT '',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `uq_costos_enc_prod_uid` (`uid`),
  UNIQUE KEY `uq_costos_enc_prod_producto` (`Producto`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_etiquetas`
--

DROP TABLE IF EXISTS `costos_etiquetas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_etiquetas` (
  `uid` varchar(50) NOT NULL,
  `empresa` varchar(50) NOT NULL,
  `etiqueta` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `estado` varchar(20) DEFAULT 'Activo',
  `usuario_creador` varchar(100) DEFAULT NULL,
  `usuario_ult_modificacion` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_fases`
--

DROP TABLE IF EXISTS `costos_fases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_fases` (
  `uid` varchar(50) NOT NULL,
  `nombre_fase` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `orden` int(11) DEFAULT 0,
  `estado` varchar(20) DEFAULT 'Activa',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_formulas`
--

DROP TABLE IF EXISTS `costos_formulas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_formulas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(100) NOT NULL,
  `uid_producto_resultante` varchar(100) NOT NULL,
  `Empresa` varchar(50) NOT NULL,
  `tipo` varchar(20) DEFAULT NULL,
  `uid_producto_formula` varchar(50) DEFAULT NULL,
  `Producto_formula` varchar(100) NOT NULL,
  `unidad` varchar(50) DEFAULT NULL,
  `estandar` decimal(10,4) DEFAULT NULL,
  `costo_un` decimal(10,2) DEFAULT NULL,
  `orden` int(11) NOT NULL,
  `observaciones` text DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `usuario_creador` varchar(100) DEFAULT NULL,
  `usuario_ult_act` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_costos_formulas_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_grupos_productos`
--

DROP TABLE IF EXISTS `costos_grupos_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_grupos_productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(100) DEFAULT NULL,
  `Empresa` varchar(50) NOT NULL,
  `nombre_grupo` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `imagen_1` varchar(255) DEFAULT NULL,
  `imagen_2` varchar(255) DEFAULT NULL,
  `imagen_3` varchar(255) DEFAULT NULL,
  `archivo_1` varchar(255) DEFAULT NULL,
  `archivo_2` varchar(255) DEFAULT NULL,
  `archivo_3` varchar(255) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `Agregar_Productos` text DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_ult_modificacion` datetime DEFAULT NULL,
  `usuario_creador` varchar(100) DEFAULT NULL,
  `usuario_ult_modificacion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_costos_grupos_productos_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_herramientas`
--

DROP TABLE IF EXISTS `costos_herramientas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_herramientas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `Empresa` varchar(50) NOT NULL,
  `estado` varchar(50) NOT NULL DEFAULT 'Activo',
  `cod_barras` varchar(100) DEFAULT '',
  `nombre` varchar(255) NOT NULL,
  `categoria` varchar(250) NOT NULL,
  `descripcion` text DEFAULT '',
  `recomendaciones_uso` text DEFAULT '',
  `precauciones_seguridad` text DEFAULT '',
  `vida_util_aproximada_meses` int(12) DEFAULT 48,
  `horas_productivas_mes_estandar` int(12) DEFAULT 160,
  `horas_utiles_en_actividad` decimal(12,4) DEFAULT 0.0000,
  `estado_actual` text DEFAULT '',
  `fecha_ultimo_mantenimiento` date DEFAULT NULL,
  `ubicacion_actual` varchar(100) DEFAULT '',
  `responsable` varchar(100) DEFAULT '',
  `unidad_consumo` varchar(50) NOT NULL,
  `costoxunidad_consumo` decimal(12,4) DEFAULT 0.0000,
  `costo_manual_maq` decimal(12,4) DEFAULT 0.0000,
  `costo_promedio_maq` decimal(12,4) DEFAULT 0.0000,
  `ultimo_costo` decimal(12,4) DEFAULT 0.0000,
  `gestion_de_stock` tinyint(1) DEFAULT 1,
  `stock_minimo` decimal(12,4) DEFAULT 0.0000,
  `stock_optimo` decimal(12,4) DEFAULT 0.0000,
  `stock_total_empresa` decimal(12,4) DEFAULT 0.0000,
  `se_deprecia` tinyint(1) NOT NULL DEFAULT 0,
  `valor_residual` decimal(10,2) DEFAULT 0.00,
  `depreciacion_acumulada` decimal(10,2) DEFAULT 0.00,
  `fecha_ini_depreciacion` datetime DEFAULT NULL,
  `fecha_fin_depresiacion` datetime DEFAULT NULL,
  `fecha_baja` datetime DEFAULT NULL,
  `recurso_ambiental1` varchar(100) DEFAULT '',
  `consumo_x_unidad_tiempo1` decimal(12,6) DEFAULT 0.000000,
  `recurso_ambiental2` varchar(100) DEFAULT '',
  `consumo_x_unidad_tiempo2` decimal(12,6) DEFAULT 0.000000,
  `recurso_ambiental3` varchar(100) DEFAULT '',
  `consumo_x_unidad_tiempo3` decimal(12,6) DEFAULT 0.000000,
  `imagen1` varchar(255) DEFAULT '',
  `imagen2` varchar(255) DEFAULT '',
  `imagen3` varchar(255) DEFAULT '',
  `archivo1` varchar(255) DEFAULT '',
  `archivo2` varchar(255) DEFAULT '',
  `archivo3` varchar(255) DEFAULT '',
  `observaciones` text DEFAULT '',
  `fecha_matricula` datetime DEFAULT NULL,
  `fecha_ult_modificacion` datetime DEFAULT NULL,
  `usuario_creador` varchar(100) DEFAULT '',
  `usuario_ult_modificacion` varchar(100) DEFAULT '',
  `observaciones_sistema` text DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  UNIQUE KEY `uq_costos_herramientas_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_mp_insumos`
--

DROP TABLE IF EXISTS `costos_mp_insumos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_mp_insumos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `Empresa` varchar(50) NOT NULL,
  `estado` varchar(100) NOT NULL DEFAULT 'Activo',
  `cod_barras` varchar(100) DEFAULT '',
  `nombre` varchar(255) NOT NULL,
  `unidad` varchar(30) DEFAULT '',
  `tipo_de_articulo` varchar(100) DEFAULT '',
  `categoria` varchar(100) DEFAULT '',
  `costo_manual` decimal(12,4) DEFAULT 0.0000,
  `costo_promedio` decimal(12,4) DEFAULT 0.0000,
  `ultimo_costo` decimal(12,4) DEFAULT 0.0000,
  `gestion_de_stock` tinyint(1) DEFAULT 1,
  `stock_minimo` decimal(12,4) DEFAULT 0.0000,
  `stock_optimo` decimal(12,4) DEFAULT 0.0000,
  `stock_total_empresa` decimal(12,4) DEFAULT 0.0000,
  `fecha_matricula` datetime DEFAULT NULL,
  `fecha_ult_modificacion` datetime DEFAULT NULL,
  `usuario_creador` varchar(100) DEFAULT '',
  `usuario_ult_modificacion` varchar(100) DEFAULT '',
  `imagen1` varchar(255) DEFAULT '',
  `imagen2` varchar(255) DEFAULT '',
  `imagen3` varchar(255) DEFAULT '',
  `archivo1` varchar(255) DEFAULT '',
  `archivo2` varchar(255) DEFAULT '',
  `archivo3` varchar(255) DEFAULT '',
  `observaciones` text DEFAULT '',
  `observaciones_sistema` text DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  UNIQUE KEY `uq_costos_mp_insumos_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=550 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_procedimientos`
--

DROP TABLE IF EXISTS `costos_procedimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_procedimientos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `Empresa` varchar(50) NOT NULL,
  `area` varchar(100) NOT NULL,
  `Tipo_Procedimiento` text NOT NULL DEFAULT 'PROD',
  `Procedimiento` varchar(255) DEFAULT '',
  `estado` text DEFAULT '',
  `version_estandar` text DEFAULT '',
  `Etiqueta` text DEFAULT '',
  `costo_conjunto` varchar(50) NOT NULL DEFAULT 'SIN COSTO CONJUNTO',
  `tips_y_recomendaciones` text DEFAULT '',
  `instrucciones_procedimiento` text DEFAULT '',
  `duracion_minutos` decimal(12,4) DEFAULT 0.0000,
  `unidad` text DEFAULT '',
  `cant_minima` decimal(12,4) DEFAULT 0.0000,
  `cant_optima` decimal(12,4) DEFAULT 0.0000,
  `cant_maxima` decimal(12,4) DEFAULT 0.0000,
  `imagen_ppal` text DEFAULT '',
  `video_ppal` text DEFAULT '',
  `vlr_mp_ins` decimal(12,4) DEFAULT 0.0000,
  `vlr_pp` decimal(12,4) DEFAULT 0.0000,
  `vlr_maq_hrrmtas` decimal(12,4) DEFAULT 0.0000,
  `vlr_serv_mo` decimal(12,4) DEFAULT 0.0000,
  `vlr_cnsmbles` decimal(12,4) DEFAULT 0.0000,
  `vlr_tot` decimal(12,4) DEFAULT 0.0000,
  `usuario_creador` varchar(100) DEFAULT '',
  `usuario_ult_modificacion` varchar(100) DEFAULT '',
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_ult_modificacion` datetime DEFAULT NULL,
  `observaciones` text DEFAULT '',
  `observaciones_sistema` text DEFAULT '',
  `Copiar_de` text DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_costos_procedimientos_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_procedimientos_consumibles`
--

DROP TABLE IF EXISTS `costos_procedimientos_consumibles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_procedimientos_consumibles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `Empresa` varchar(50) NOT NULL,
  `uid_procedimiento` varchar(50) NOT NULL,
  `uid_consumible` varchar(50) NOT NULL,
  `fase` text NOT NULL,
  `unidad` varchar(50) NOT NULL,
  `cantidad` decimal(12,4) DEFAULT 0.0000,
  `sensibilidad_cantidad` decimal(10,2) NOT NULL DEFAULT 1.00,
  `costo_unitario` decimal(12,4) DEFAULT 0.0000,
  `orden` decimal(12,4) DEFAULT 0.0000,
  `observaciones` text DEFAULT '',
  `observaciones_sistema` text DEFAULT '',
  `usuario_creador` varchar(100) DEFAULT '',
  `usuario_ult_modificacion` varchar(100) DEFAULT '',
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_ult_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  UNIQUE KEY `uq_costos_proc_consumibles_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_procedimientos_herramientas`
--

DROP TABLE IF EXISTS `costos_procedimientos_herramientas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_procedimientos_herramientas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `Empresa` varchar(50) NOT NULL,
  `uid_procedimiento` varchar(50) NOT NULL,
  `uid_herramienta` varchar(50) NOT NULL,
  `fase` text DEFAULT '',
  `tiempo_estandar_uso_por_maquina` decimal(12,4) DEFAULT 0.0000,
  `costo_unitario_desgaste_x_maquina` decimal(12,4) DEFAULT 0.0000,
  `cantidad_maquinas` int(10) NOT NULL DEFAULT 1,
  `unidad_consumo` varchar(50) NOT NULL DEFAULT '',
  `cantidad_consumo` decimal(12,4) DEFAULT 0.0000,
  `costo_unitario_consumo` decimal(12,4) DEFAULT 0.0000,
  `sensibilidad_cantidad` decimal(12,2) NOT NULL DEFAULT 1.00,
  `orden` decimal(12,4) DEFAULT 0.0000,
  `observaciones` text DEFAULT '',
  `observaciones_sistema` text DEFAULT '',
  `usuario_creador` varchar(100) DEFAULT '',
  `usuario_ult_modificacion` varchar(100) DEFAULT '',
  `fecha_creacion` datetime NOT NULL,
  `fecha_ult_modificacion` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_costos_proc_herramientas_uid` (`uid`),
  KEY `id_procedimiento` (`uid_procedimiento`),
  KEY `id_herramienta` (`uid_herramienta`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_procedimientos_imag_vid`
--

DROP TABLE IF EXISTS `costos_procedimientos_imag_vid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_procedimientos_imag_vid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `Empresa` varchar(50) NOT NULL,
  `Tipo` varchar(50) NOT NULL,
  `uid_procedimiento` varchar(50) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `fase` text DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `archivo` varchar(255) DEFAULT NULL,
  `video` varchar(255) DEFAULT NULL,
  `url_video` text DEFAULT NULL,
  `url_general` text DEFAULT NULL,
  `orden` int(11) DEFAULT 0,
  `Observaciones` text DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL,
  `fecha_ult_act` datetime NOT NULL,
  `usuario_creador` varchar(100) NOT NULL,
  `usuario_ult_modificacion` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  UNIQUE KEY `uq_costos_proc_imag_vid_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_procedimientos_mp_insumos`
--

DROP TABLE IF EXISTS `costos_procedimientos_mp_insumos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_procedimientos_mp_insumos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `Empresa` varchar(50) NOT NULL,
  `uid_procedimiento` varchar(50) NOT NULL,
  `uid_mp_insumo` varchar(50) NOT NULL,
  `fase` text NOT NULL,
  `unidad` varchar(50) NOT NULL,
  `cantidad` decimal(12,4) DEFAULT 0.0000,
  `costo_unitario` decimal(12,4) DEFAULT 0.0000,
  `orden` decimal(12,4) DEFAULT 0.0000,
  `observaciones` text DEFAULT '',
  `observaciones_sistema` text DEFAULT '',
  `usuario_creador` varchar(100) DEFAULT '',
  `usuario_ult_modificacion` varchar(100) DEFAULT '',
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_ult_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_costos_proc_mp_insumos_uid` (`uid`),
  KEY `id_procedimiento` (`uid_procedimiento`),
  KEY `id_mp_insumo` (`uid_mp_insumo`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_procedimientos_pp`
--

DROP TABLE IF EXISTS `costos_procedimientos_pp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_procedimientos_pp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `Empresa` varchar(50) NOT NULL,
  `uid_procedimiento` varchar(50) NOT NULL,
  `uid_producto_pp` varchar(50) NOT NULL,
  `fase` text NOT NULL,
  `unidad` varchar(50) NOT NULL,
  `cantidad` decimal(12,4) DEFAULT 0.0000,
  `costo_unitario` decimal(12,4) DEFAULT 0.0000,
  `orden` decimal(12,4) DEFAULT 0.0000,
  `observaciones` text DEFAULT '',
  `observaciones_sistema` text DEFAULT '',
  `usuario_creador` varchar(100) DEFAULT '',
  `usuario_ult_modificacion` varchar(100) DEFAULT '',
  `fecha_matricula` datetime DEFAULT NULL,
  `fecha_ult_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_costos_proc_pp_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_procedimientos_servicios_mo`
--

DROP TABLE IF EXISTS `costos_procedimientos_servicios_mo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_procedimientos_servicios_mo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `Empresa` varchar(50) NOT NULL,
  `uid_procedimiento` varchar(50) NOT NULL,
  `uid_servicio_mo` varchar(50) NOT NULL,
  `descripcion` text DEFAULT '',
  `fase` varchar(50) NOT NULL,
  `unidad` varchar(50) NOT NULL,
  `cantidad` decimal(12,4) DEFAULT 0.0000,
  `costo_unitario` decimal(12,4) DEFAULT 0.0000,
  `tiempo_estandar_unidad_base` decimal(12,4) DEFAULT 0.0000,
  `sensibilidad_cantidad` decimal(12,2) NOT NULL DEFAULT 1.00,
  `Grupo_mo` varchar(50) DEFAULT '',
  `orden` decimal(12,4) DEFAULT 0.0000,
  `observaciones` text DEFAULT '',
  `observaciones_sistema` text DEFAULT '',
  `usuario_creador` varchar(100) NOT NULL,
  `usuario_ult_modificacion` varchar(100) NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  `fecha_ult_modificacion` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_costos_proc_servicios_mo_uid` (`uid`),
  KEY `id_procedimiento` (`uid_procedimiento`),
  KEY `id_servicio_mo` (`uid_servicio_mo`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_producto_procedimientos`
--

DROP TABLE IF EXISTS `costos_producto_procedimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_producto_procedimientos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) DEFAULT NULL,
  `Empresa` varchar(50) NOT NULL,
  `uid_producto` varchar(50) NOT NULL,
  `uid_procedimiento` varchar(50) NOT NULL,
  `orden` int(11) DEFAULT 1,
  `cantidad_reparto` decimal(12,4) DEFAULT NULL,
  `vlr_un_mercado` decimal(12,4) DEFAULT NULL,
  `costo_adicional` decimal(12,4) DEFAULT NULL,
  `proporcion_manual` decimal(12,4) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `Duracion (min)` decimal(14,4) DEFAULT NULL,
  `Costo Total Proced` decimal(14,4) DEFAULT NULL,
  `Costo Consumibles` decimal(14,4) DEFAULT NULL,
  `Costo herramientas` decimal(14,4) DEFAULT NULL,
  `Costo MP Insumos` decimal(14,4) DEFAULT NULL,
  `Costo PP` decimal(14,4) DEFAULT NULL,
  `Costo MO Servicios` decimal(14,4) DEFAULT NULL,
  `base_reparto` decimal(14,4) DEFAULT NULL,
  `Proporcion` decimal(14,4) DEFAULT NULL,
  `Unidad` varchar(50) DEFAULT NULL,
  `costo_conjunto` text DEFAULT NULL,
  `usuario_creador` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `usuario_ult_modificacion` varchar(100) DEFAULT NULL,
  `fecha_ult_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_costos_producto_proc_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_recursos_ambientales`
--

DROP TABLE IF EXISTS `costos_recursos_ambientales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_recursos_ambientales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL DEFAULT '',
  `Empresa` varchar(100) NOT NULL,
  `nombre_recurso` varchar(150) NOT NULL DEFAULT '',
  `tipo_recurso` enum('Energia','Agua','Combustible','Otro') NOT NULL DEFAULT 'Energia',
  `descripcion` text DEFAULT '',
  `unidad_base` varchar(20) NOT NULL DEFAULT '',
  `factor_emision_co2` decimal(10,6) DEFAULT 0.000000,
  `metodo_factor` enum('IPCC','DEFRA','Local','Personalizado') NOT NULL DEFAULT 'Personalizado',
  `estado` varchar(50) NOT NULL DEFAULT 'Activo',
  `observaciones` text DEFAULT '',
  `observaciones_sistema` text DEFAULT '',
  `usuario_creador` varchar(100) NOT NULL DEFAULT '',
  `usuario_ult_modificacion` varchar(100) NOT NULL DEFAULT '',
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_uid` (`uid`),
  KEY `idx_tipo_recurso` (`tipo_recurso`),
  KEY `idx_activo` (`estado`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_residuos`
--

DROP TABLE IF EXISTS `costos_residuos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_residuos` (
  `uid` varchar(20) NOT NULL,
  `empresa` varchar(50) NOT NULL,
  `uid_tipo_residuo` varchar(20) NOT NULL,
  `costo_disposicion` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `factor_huella_carbono` decimal(12,6) NOT NULL DEFAULT 0.000000,
  `estado` varchar(50) NOT NULL DEFAULT 'Activo',
  `usuario_creador` varchar(50) NOT NULL,
  `usuario_ult_modificacion` varchar(50) NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uk_empresa_residuo` (`empresa`,`uid_tipo_residuo`),
  KEY `fk_residuo_tipo` (`uid_tipo_residuo`),
  CONSTRAINT `fk_residuo_tipo` FOREIGN KEY (`uid_tipo_residuo`) REFERENCES `costos_tipos_residuos` (`uid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_residuos_destinos`
--

DROP TABLE IF EXISTS `costos_residuos_destinos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_residuos_destinos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `Empresa` varchar(50) NOT NULL DEFAULT '',
  `nombre` varchar(100) NOT NULL,
  `factor_destino` decimal(12,6) NOT NULL,
  `descripcion` text DEFAULT '',
  `tiene_valor` tinyint(1) NOT NULL DEFAULT 0,
  `es_final` tinyint(1) NOT NULL DEFAULT 0,
  `sale_de_la_empresa` tinyint(1) NOT NULL DEFAULT 0,
  `estado` varchar(20) NOT NULL DEFAULT 'Activo',
  `usuario_creador` varchar(100) DEFAULT '',
  `usuario_ult_modificacion` varchar(100) DEFAULT '',
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_residuos_destinos_uid` (`uid`),
  UNIQUE KEY `uq_residuos_destinos_nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_rutas_producto`
--

DROP TABLE IF EXISTS `costos_rutas_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_rutas_producto` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `empresa` varchar(50) NOT NULL,
  `uid_producto_final` varchar(255) NOT NULL,
  `uid_procedimiento_final` varchar(255) NOT NULL,
  `rama` varchar(200) NOT NULL DEFAULT '0',
  `nivel` int(11) NOT NULL,
  `uid_producto_actual` varchar(255) NOT NULL,
  `uid_procedimiento_actual` varchar(255) DEFAULT NULL,
  `fecha_actualizacion` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_empresa` (`empresa`),
  KEY `idx_empresa_producto_final` (`empresa`,`uid_producto_final`),
  KEY `idx_empresa_producto_actual` (`empresa`,`uid_producto_actual`),
  KEY `idx_empresa_proc_final` (`empresa`,`uid_procedimiento_final`),
  KEY `idx_empresa_rama_nivel` (`empresa`,`uid_producto_final`,`rama`,`nivel`)
) ENGINE=InnoDB AUTO_INCREMENT=424 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_servicios_mo`
--

DROP TABLE IF EXISTS `costos_servicios_mo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_servicios_mo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `Empresa` varchar(50) NOT NULL,
  `estado` varchar(100) NOT NULL DEFAULT 'Activo',
  `cod_barras` varchar(100) DEFAULT '',
  `nombre` varchar(255) DEFAULT '',
  `unidad` varchar(50) DEFAULT '',
  `categoria` varchar(100) DEFAULT '',
  `costo_manual` decimal(12,4) DEFAULT 0.0000,
  `costo_promedio` decimal(12,4) DEFAULT 0.0000,
  `ultimo_costo` decimal(12,4) DEFAULT 0.0000,
  `fecha_matricula` datetime NOT NULL,
  `fecha_ult_modificacion` datetime NOT NULL,
  `observaciones` text DEFAULT '',
  `observaciones_sistema` text DEFAULT '',
  `usuario_creador` varchar(100) DEFAULT '',
  `usuario_ult_modificacion` varchar(100) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_tipos_procedimientos`
--

DROP TABLE IF EXISTS `costos_tipos_procedimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_tipos_procedimientos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `Empresa` varchar(100) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Descripcion` text DEFAULT '',
  `predeterminado` tinyint(1) NOT NULL DEFAULT 0,
  `Usuario_creador` varchar(100) NOT NULL,
  `Fecha_matricula` date NOT NULL,
  `Usuario_ult_modificacion` varchar(100) NOT NULL,
  `Fecha_ult_modificacion` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_costos_tipos_proc_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_tipos_residuos`
--

DROP TABLE IF EXISTS `costos_tipos_residuos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_tipos_residuos` (
  `uid` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT '',
  `usuario_creador` varchar(50) NOT NULL,
  `usuario_ult_modificacion` varchar(50) NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uk_nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_unidades`
--

DROP TABLE IF EXISTS `costos_unidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_unidades` (
  `uid` varchar(50) NOT NULL,
  `Empresa` varchar(50) NOT NULL,
  `unidad` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `tipo_unidad` text DEFAULT NULL,
  `factor` decimal(12,6) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `usuario_creador` varchar(100) DEFAULT NULL,
  `usuario_ult_modificacion` varchar(100) DEFAULT NULL,
  `fecha_matricula` datetime DEFAULT NULL,
  `fecha_ult_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `costos_unidades_tipos`
--

DROP TABLE IF EXISTS `costos_unidades_tipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `costos_unidades_tipos` (
  `uid` varchar(50) NOT NULL,
  `nombre_tipo` varchar(50) NOT NULL,
  `unidad_estandar` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `estado` varchar(20) DEFAULT 'Activa',
  `usuario_creador` varchar(100) DEFAULT NULL,
  `usuario_ult_modificacion` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `din_categorias_egresos`
--

DROP TABLE IF EXISTS `din_categorias_egresos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `din_categorias_egresos` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Empresa` text DEFAULT NULL,
  `Categoria` text DEFAULT NULL,
  `Subcategoria` text DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `din_categorias_ingresos`
--

DROP TABLE IF EXISTS `din_categorias_ingresos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `din_categorias_ingresos` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Empresa` varchar(255) DEFAULT NULL,
  `Categoria_ing` text DEFAULT NULL,
  `Subcategoria_ing` text DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `din_cuentas`
--

DROP TABLE IF EXISTS `din_cuentas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `din_cuentas` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Empresa` varchar(255) DEFAULT NULL,
  `Nombre_Cuenta` varchar(255) DEFAULT NULL,
  `Saldo_inicial` decimal(15,2) DEFAULT NULL,
  `Saldo_actual` decimal(15,2) DEFAULT NULL,
  `Observaciones` text DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `din_egresos`
--

DROP TABLE IF EXISTS `din_egresos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `din_egresos` (
  `Empresa` text DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `Usuario` text DEFAULT NULL,
  `Tipo_Doc` text DEFAULT NULL,
  `No_registro` varchar(255) NOT NULL,
  `Categoria` text DEFAULT NULL,
  `Subcategoria` text DEFAULT NULL,
  `Nombre_y_Apellido` text DEFAULT NULL,
  `Tipo_de_Identificacion` text DEFAULT NULL,
  `Numero_de_Identificacion` text DEFAULT NULL,
  `Remision` text DEFAULT NULL,
  `Factura` text DEFAULT NULL,
  `Direccion` text DEFAULT NULL,
  `Telefono` text DEFAULT NULL,
  `Ciudad` text DEFAULT NULL,
  `Concepto_Producto` text DEFAULT NULL,
  `Valor` decimal(10,2) DEFAULT NULL,
  `Rete_Fte` decimal(10,2) DEFAULT NULL,
  `Otros_dctos` decimal(10,2) DEFAULT NULL,
  `Cuenta` text DEFAULT NULL,
  `Observaciones` text DEFAULT NULL,
  `Adjunto_1` text DEFAULT NULL,
  `Adjunto_2` text DEFAULT NULL,
  `RUT` text DEFAULT NULL,
  `Adjunto_3_archivo` text DEFAULT NULL,
  `Fac_PDF` text DEFAULT NULL,
  `Hora` time DEFAULT NULL,
  PRIMARY KEY (`No_registro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `din_filtro_egresos`
--

DROP TABLE IF EXISTS `din_filtro_egresos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `din_filtro_egresos` (
  `Empresa` text DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Fecha_ini` date DEFAULT NULL,
  `Fecha_fin` date DEFAULT NULL,
  `Usuario` text DEFAULT NULL,
  `Tipo_Doc` text DEFAULT NULL,
  `No_Registro` varchar(255) DEFAULT NULL,
  `Categoria` text DEFAULT NULL,
  `Subcategoria` text DEFAULT NULL,
  `Nombre_y_Apellido` text DEFAULT NULL,
  `Numero_de_Identificacion` text DEFAULT NULL,
  `Remision` text DEFAULT NULL,
  `Factura` text DEFAULT NULL,
  `Telefono` text DEFAULT NULL,
  `Ciudad` text DEFAULT NULL,
  `Concepto_Producto` text DEFAULT NULL,
  `Valor` decimal(10,2) DEFAULT NULL,
  `Rete_Fte` decimal(10,2) DEFAULT NULL,
  `Cuenta` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `din_filtro_ingresos`
--

DROP TABLE IF EXISTS `din_filtro_ingresos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `din_filtro_ingresos` (
  `Empresa` text DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Fecha_ini` date DEFAULT NULL,
  `Fecha_fin` date DEFAULT NULL,
  `Usuario` text DEFAULT NULL,
  `No_Registro` varchar(255) DEFAULT NULL,
  `Categoria_ing` text DEFAULT NULL,
  `Subcategoria_ing` text DEFAULT NULL,
  `Nombre_y_Apellido` text DEFAULT NULL,
  `Numero_de_Identificacion` text DEFAULT NULL,
  `Telefono` text DEFAULT NULL,
  `Ciudad` text DEFAULT NULL,
  `Concepto_Producto` text DEFAULT NULL,
  `Valor` decimal(10,2) DEFAULT NULL,
  `Cuenta` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `din_ingresos`
--

DROP TABLE IF EXISTS `din_ingresos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `din_ingresos` (
  `Empresa` text DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `Usuario` text DEFAULT NULL,
  `No_registro` varchar(255) NOT NULL,
  `Cuenta` text DEFAULT NULL,
  `Categoria_ing` text DEFAULT NULL,
  `Subcategoria_ing` text DEFAULT NULL,
  `Valor` decimal(10,2) DEFAULT NULL,
  `Observaciones` text DEFAULT NULL,
  `Remision_vta` text DEFAULT NULL,
  `Factura_vta` text DEFAULT NULL,
  `Nombre_y_Apellido` text DEFAULT NULL,
  `Tipo_de_Identificacion` text DEFAULT NULL,
  `Numero_de_Identificacion` text DEFAULT NULL,
  `Direccion` text DEFAULT NULL,
  `Telefono` text DEFAULT NULL,
  `Ciudad` text DEFAULT NULL,
  `Adjunto_1` text DEFAULT NULL,
  `Adjunto_2` text DEFAULT NULL,
  `Adjunto_3_archivo` text DEFAULT NULL,
  `Fac_PDF` text DEFAULT NULL,
  `Hora` time DEFAULT NULL,
  PRIMARY KEY (`No_registro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `din_traslados`
--

DROP TABLE IF EXISTS `din_traslados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `din_traslados` (
  `Empresa` text DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `Usuario` text DEFAULT NULL,
  `No_Traslado` varchar(255) NOT NULL,
  `Valor_Traslado` decimal(10,2) DEFAULT NULL,
  `Cuenta_Origen` text DEFAULT NULL,
  `Cuenta_Destino` text DEFAULT NULL,
  `Observaciones` text DEFAULT NULL,
  `Soporte_Traslado` text DEFAULT NULL,
  `Hora` time DEFAULT NULL,
  PRIMARY KEY (`No_Traslado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_bodegas`
--

DROP TABLE IF EXISTS `inv_bodegas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_bodegas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `empresa` varchar(50) NOT NULL,
  `nombre_bodega` varchar(150) NOT NULL,
  `tipo` varchar(100) NOT NULL DEFAULT 'General',
  `responsable` varchar(100) DEFAULT '',
  `ubicacion` text DEFAULT '',
  `descripcion` text DEFAULT '',
  `predeterminado` tinyint(1) NOT NULL DEFAULT 0,
  `estado` enum('Activa','Inactiva') DEFAULT 'Activa',
  `usuario_creador` varchar(100) NOT NULL,
  `usuario_ult_modificacion` varchar(100) NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_tipos_pp`
--

DROP TABLE IF EXISTS `inv_tipos_pp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_tipos_pp` (
  `uid` varchar(50) NOT NULL,
  `condicion_pp` varchar(100) NOT NULL,
  `descripcion` text DEFAULT '',
  `estado` varchar(50) NOT NULL DEFAULT 'Activo',
  `usuario_creador` varchar(100) NOT NULL,
  `usuario_ult_modificacion` varchar(100) NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uq_inv_tipos_pp_tipo` (`condicion_pp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menu_ppal`
--

DROP TABLE IF EXISTS `menu_ppal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_ppal` (
  `uid` varchar(50) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `modulo` text NOT NULL,
  `icono` varchar(255) DEFAULT NULL,
  `vista_destino` varchar(100) DEFAULT NULL,
  `orden` int(11) DEFAULT NULL,
  `visible_if` text DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prod_estados_op`
--

DROP TABLE IF EXISTS `prod_estados_op`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_estados_op` (
  `uid` int(11) NOT NULL,
  `orden` int(11) NOT NULL,
  `tipo_objeto` text NOT NULL,
  `estado` varchar(50) NOT NULL,
  `proposito` text DEFAULT NULL,
  `finalizacion` varchar(50) DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL,
  `fecha_ult_modificacion` datetime NOT NULL,
  `usuario_creador` text NOT NULL,
  `usuario_ult_modificacion` text NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prod_ordenes_consumos`
--

DROP TABLE IF EXISTS `prod_ordenes_consumos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_ordenes_consumos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `empresa` varchar(50) NOT NULL,
  `Etiqueta` text DEFAULT '',
  `uid_orden` varchar(50) NOT NULL,
  `uid_detalle` varchar(50) NOT NULL,
  `uid_recurso` varchar(50) NOT NULL,
  `nombre_recurso` text NOT NULL,
  `fase` int(11) NOT NULL,
  `estado_consumo` int(11) NOT NULL DEFAULT 10,
  `unidad` varchar(50) NOT NULL,
  `Grupo_mo` varchar(50) DEFAULT '',
  `condicion_pp` varchar(100) NOT NULL DEFAULT 'PP.NORMAL',
  `cantidad_real` decimal(12,4) DEFAULT 0.0000,
  `costo_unitario_real` decimal(14,4) DEFAULT 0.0000,
  `tiempo_real_min` decimal(12,4) DEFAULT 0.0000,
  `costo_por_unidad_base_tiempo` decimal(14,4) DEFAULT 0.0000,
  `cantidad_maquinas_real` int(11) DEFAULT 1,
  `bodega` varchar(100) NOT NULL DEFAULT '',
  `recurso_ambiental_1` varchar(50) DEFAULT '',
  `consumo_recurso_real_1` decimal(12,6) DEFAULT 0.000000,
  `recurso_ambiental_2` varchar(50) DEFAULT '',
  `consumo_recurso_real_2` decimal(12,6) DEFAULT 0.000000,
  `recurso_ambiental_3` varchar(50) DEFAULT '',
  `consumo_recurso_real_3` decimal(12,6) DEFAULT 0.000000,
  `observaciones` text DEFAULT '',
  `usuario_creador` varchar(100) DEFAULT '',
  `usuario_ult_modificacion` varchar(100) DEFAULT '',
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `observaciones_sistema` text DEFAULT '\'\'',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_uid` (`uid`),
  KEY `fk_consumos_op` (`uid_orden`),
  CONSTRAINT `fk_consumos_op` FOREIGN KEY (`uid_orden`) REFERENCES `prod_ordenes_encabezados` (`uid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=411 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prod_ordenes_detalles`
--

DROP TABLE IF EXISTS `prod_ordenes_detalles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_ordenes_detalles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `empresa` varchar(50) NOT NULL,
  `Etiqueta` text DEFAULT NULL,
  `uid_orden` varchar(50) NOT NULL,
  `tipo_recurso` varchar(50) NOT NULL,
  `uid_recurso` varchar(50) NOT NULL,
  `nombre_recurso` text NOT NULL,
  `fase` text NOT NULL,
  `orden` decimal(11,4) DEFAULT NULL,
  `unidad` varchar(50) NOT NULL,
  `Grupo_mo` varchar(50) DEFAULT '',
  `cantidad_teorica` decimal(12,4) DEFAULT 0.0000,
  `costo_unitario_teorico` decimal(12,4) DEFAULT 0.0000,
  `Tiempo_estandar_unidad_base` decimal(12,4) DEFAULT 0.0000,
  `costo_por_unidad_base_tiempo` decimal(12,4) DEFAULT 0.0000,
  `cantidad_maquinas` int(11) DEFAULT 1,
  `descripcion` text DEFAULT '',
  `recurso_ambiental_1` varchar(100) DEFAULT '',
  `consumo_recurso_teorico_1` decimal(12,6) DEFAULT 0.000000,
  `recurso_ambiental_2` varchar(50) DEFAULT '',
  `consumo_recurso_teorico_2` decimal(12,6) DEFAULT 0.000000,
  `recurso_ambiental_3` varchar(50) DEFAULT '',
  `consumo_recurso_teorico_3` decimal(12,6) DEFAULT 0.000000,
  `observaciones` text DEFAULT '',
  `usuario_creador` varchar(100) DEFAULT '',
  `usuario_ult_modificacion` varchar(100) DEFAULT '',
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_ult_modificacion` datetime DEFAULT NULL,
  `observaciones_sistema` text DEFAULT '\'\'',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_prod_ordenes_detalles_uid` (`uid`),
  KEY `fk_detalles_op` (`uid_orden`),
  CONSTRAINT `fk_detalles_op` FOREIGN KEY (`uid_orden`) REFERENCES `prod_ordenes_encabezados` (`uid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1656 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prod_ordenes_encabezados`
--

DROP TABLE IF EXISTS `prod_ordenes_encabezados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_ordenes_encabezados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `empresa` varchar(50) NOT NULL,
  `uid_procedimiento_base` varchar(50) DEFAULT '',
  `Etiqueta` text DEFAULT '',
  `tipo_op` text NOT NULL,
  `estado` varchar(30) DEFAULT '1',
  `Pausa` tinyint(1) NOT NULL DEFAULT 0,
  `Motivo_Pausa` text DEFAULT '',
  `unidad` varchar(50) NOT NULL,
  `cantidad` decimal(12,4) DEFAULT 0.0000,
  `duracion_planificada` decimal(12,4) DEFAULT 0.0000,
  `duracion_real` decimal(12,4) DEFAULT 0.0000,
  `tips` text DEFAULT '',
  `instrucciones` text DEFAULT '',
  `fecha_inicio_prog` datetime DEFAULT NULL,
  `fecha_fin_prog` datetime DEFAULT NULL,
  `responsable_principal` varchar(255) DEFAULT '',
  `responsable_auxiliar` text DEFAULT '',
  `area` varchar(100) DEFAULT '1',
  `prioridad` varchar(100) DEFAULT 'Media',
  `bodega_consumos` varchar(50) DEFAULT '1',
  `bodega_lotes` varchar(50) DEFAULT '1',
  `observaciones` text DEFAULT '',
  `costo_result_tot` decimal(16,4) DEFAULT 0.0000,
  `costo_teo_tot` decimal(16,4) DEFAULT 0.0000,
  `costo_teo_pp` decimal(16,4) DEFAULT 0.0000,
  `costo_teo_mp` decimal(16,4) DEFAULT 0.0000,
  `costo_teo_consum` decimal(16,4) DEFAULT 0.0000,
  `costo_teo_mo` decimal(16,4) DEFAULT 0.0000,
  `costo_teo_herramientas` decimal(16,4) DEFAULT 0.0000,
  `costo_real_tot` decimal(16,4) DEFAULT 0.0000,
  `costo_real_pp` decimal(16,4) DEFAULT 0.0000,
  `costo_real_mp` decimal(16,4) DEFAULT 0.0000,
  `costo_real_mo` decimal(16,4) DEFAULT 0.0000,
  `costo_real_consum` decimal(16,4) DEFAULT 0.0000,
  `costo_real_herramientas` decimal(16,4) DEFAULT 0.0000,
  `costo_real_residuos` decimal(12,4) DEFAULT 0.0000,
  `huella_carbono_kg_teorica` decimal(12,6) DEFAULT 0.000000,
  `huella_carbono_kg_real` decimal(12,6) DEFAULT 0.000000,
  `copiar_de` text DEFAULT '',
  `tipo_consumo_adicional` text DEFAULT '',
  `consumo_adicional` text DEFAULT '',
  `lote_producto_adicional` text DEFAULT '',
  `usuario_creador` varchar(100) DEFAULT '',
  `usuario_ult_modificacion` varchar(100) DEFAULT '',
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime DEFAULT current_timestamp(),
  `observaciones_sistema` text DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_prod_ordenes_encabezados_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prod_ordenes_lotes`
--

DROP TABLE IF EXISTS `prod_ordenes_lotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_ordenes_lotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `empresa` varchar(50) NOT NULL,
  `uid_orden` varchar(50) NOT NULL,
  `Etiqueta` text DEFAULT '',
  `uid_producto` varchar(50) NOT NULL,
  `estado_lote` varchar(50) NOT NULL,
  `unidad` varchar(50) NOT NULL,
  `cantidad_real` decimal(14,4) DEFAULT 0.0000,
  `bodega_destino` varchar(50) DEFAULT '',
  `costo_unitario_real` decimal(14,4) DEFAULT 0.0000,
  `responsable_revision` text DEFAULT '',
  `comentarios_revision` text DEFAULT '',
  `condicion_prod_rechazado` varchar(100) DEFAULT '',
  `bool_cond_prod_rechazado` tinyint(1) DEFAULT NULL,
  `observaciones` text DEFAULT '',
  `usuario_creador` varchar(100) DEFAULT '',
  `usuario_ult_modificacion` varchar(100) DEFAULT '',
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `observaciones_sistema` text DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_uid` (`uid`),
  KEY `fk_lotes_op` (`uid_orden`),
  CONSTRAINT `fk_lotes_op` FOREIGN KEY (`uid_orden`) REFERENCES `prod_ordenes_encabezados` (`uid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prod_ordenes_residuos`
--

DROP TABLE IF EXISTS `prod_ordenes_residuos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_ordenes_residuos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `empresa` varchar(50) NOT NULL,
  `uid_orden` varchar(50) NOT NULL,
  `uid_tipo_residuo` varchar(50) NOT NULL,
  `cantidad` decimal(12,4) DEFAULT 0.0000,
  `costo_un_disposicion` decimal(12,4) DEFAULT 0.0000,
  `destino_residuo` varchar(100) DEFAULT '',
  `estado` int(11) NOT NULL DEFAULT 17,
  `observaciones` text DEFAULT '',
  `usuario_creador` varchar(100) NOT NULL,
  `usuario_ult_modificacion` varchar(100) NOT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_prod_ordenes_residuos_uid` (`uid`),
  KEY `idx_uid_orden` (`uid_orden`),
  KEY `idx_uid_tipo_residuo` (`uid_tipo_residuo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prod_ordenes_resultantes`
--

DROP TABLE IF EXISTS `prod_ordenes_resultantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_ordenes_resultantes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `empresa` varchar(50) NOT NULL,
  `uid_orden` varchar(50) NOT NULL,
  `uid_producto` varchar(50) NOT NULL,
  `cantidad_teorica` decimal(12,3) DEFAULT 0.000,
  `costo_unitario` decimal(12,4) DEFAULT 0.0000,
  `unidad` varchar(50) NOT NULL,
  `tipo_resultante` varchar(50) DEFAULT 'Principal',
  `orden` int(11) DEFAULT 0,
  `observaciones` text DEFAULT '',
  `usuario_creador` varchar(100) DEFAULT '',
  `usuario_ult_modificacion` varchar(100) DEFAULT '',
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime DEFAULT NULL,
  `observaciones_sistema` text DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_prod_ordenes_resultantes_uid` (`uid`),
  KEY `fk_resultantes_op` (`uid_orden`),
  CONSTRAINT `fk_resultantes_op` FOREIGN KEY (`uid_orden`) REFERENCES `prod_ordenes_encabezados` (`uid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prod_ordenes_trazabilidad`
--

DROP TABLE IF EXISTS `prod_ordenes_trazabilidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_ordenes_trazabilidad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `empresa` varchar(50) NOT NULL,
  `uid_orden` varchar(50) NOT NULL,
  `tipo_objeto` varchar(20) NOT NULL,
  `uid_objeto` varchar(50) NOT NULL,
  `tipo_cambio` varchar(30) NOT NULL,
  `valor_anterior` text DEFAULT NULL,
  `valor_nuevo` text DEFAULT NULL,
  `comentario` text DEFAULT NULL,
  `origen_cambio` varchar(50) DEFAULT 'Manual',
  `usuario` varchar(150) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prod_tipos_orden`
--

DROP TABLE IF EXISTS `prod_tipos_orden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_tipos_orden` (
  `uid` varchar(80) NOT NULL,
  `orden` int(11) NOT NULL,
  `empresa` varchar(50) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text NOT NULL,
  `predeterminado` tinyint(1) NOT NULL DEFAULT 0,
  `estado` varchar(50) DEFAULT 'Activo',
  `usuario_creador` varchar(100) NOT NULL,
  `usuario_ult_modificacion` varchar(100) NOT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_acciones`
--

DROP TABLE IF EXISTS `sys_acciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_acciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tabla` varchar(200) NOT NULL,
  `nombre_accion` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=489 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_areas`
--

DROP TABLE IF EXISTS `sys_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_areas` (
  `uid` varchar(50) NOT NULL,
  `empresa` varchar(50) NOT NULL,
  `nombre_area` varchar(100) NOT NULL,
  `tipo_area` varchar(50) DEFAULT '',
  `descripcion` text DEFAULT '',
  `predeterminado` tinyint(1) NOT NULL DEFAULT 0,
  `responsable_area` varchar(255) DEFAULT '',
  `estado` varchar(20) DEFAULT 'Activa',
  `usuario_creador` varchar(100) NOT NULL DEFAULT '',
  `usuario_ult_modificacion` varchar(100) NOT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_banderas`
--

DROP TABLE IF EXISTS `sys_banderas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_banderas` (
  `uid` varchar(50) NOT NULL,
  `tabla` varchar(100) NOT NULL,
  `accion` varchar(100) NOT NULL,
  `bandera` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_empresa`
--

DROP TABLE IF EXISTS `sys_empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_empresa` (
  `uid` varchar(50) NOT NULL,
  `nombre_empresa` varchar(255) NOT NULL,
  `tipo_identificacion` varchar(50) DEFAULT NULL,
  `numero_identificacion` varchar(100) DEFAULT NULL,
  `siglas` varchar(50) NOT NULL,
  `storage_proveedor` varchar(50) DEFAULT 'r2',
  `storage_url_publica` varchar(255) DEFAULT NULL,
  `storage_endpoint` varchar(255) DEFAULT NULL,
  `storage_bucket` varchar(100) DEFAULT NULL,
  `storage_access_key` varchar(255) DEFAULT NULL,
  `storage_secret_key` varchar(255) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `telefono` varchar(100) DEFAULT NULL,
  `ciudad` varchar(100) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `tipo_empresa` varchar(100) DEFAULT NULL,
  `titulo_personalizado` varchar(255) DEFAULT NULL,
  `subtitulo_personalizado` varchar(255) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `logo` text DEFAULT NULL,
  `bandera_impuestos` int(11) DEFAULT 0,
  `bandera_nomina` int(11) DEFAULT 0,
  `bandera_contabilidad` int(11) DEFAULT 0,
  `bandera_admon` int(11) DEFAULT 0,
  `bandera_produccion` int(11) DEFAULT 0,
  `bandera_inventarios` int(11) DEFAULT 0,
  `bandera_logistica` int(11) DEFAULT 0,
  `bandera_costos` int(11) DEFAULT 0,
  `usuario_creador` varchar(100) DEFAULT NULL,
  `usuario_ult_modificacion` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_ult_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_menu_v2`
--

DROP TABLE IF EXISTS `sys_menu_v2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu_v2` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(100) NOT NULL,
  `empresa` varchar(50) NOT NULL,
  `uid_padre` varchar(100) DEFAULT NULL,
  `titulo` varchar(100) NOT NULL,
  `icono` varchar(100) DEFAULT NULL,
  `ruta_vue` varchar(255) DEFAULT NULL,
  `orden` int(11) DEFAULT 0,
  `nivel_profundidad` int(11) DEFAULT 1,
  `usuario_creador` varchar(150) NOT NULL,
  `usuario_ult_modificacion` varchar(150) NOT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `uid_padre` (`uid_padre`),
  CONSTRAINT `sys_menu_v2_ibfk_1` FOREIGN KEY (`uid_padre`) REFERENCES `sys_menu_v2` (`uid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_permisos`
--

DROP TABLE IF EXISTS `sys_permisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_permisos` (
  `uid` varchar(50) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `categoria` varchar(50) NOT NULL,
  `es_critico` tinyint(1) NOT NULL DEFAULT 0,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_permisos_acciones`
--

DROP TABLE IF EXISTS `sys_permisos_acciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_permisos_acciones` (
  `uid` varchar(50) NOT NULL,
  `tabla` varchar(200) NOT NULL,
  `accion` varchar(200) NOT NULL,
  `tabla_accion` varchar(200) NOT NULL,
  `visible_if` text DEFAULT NULL,
  `Empresa` varchar(50) NOT NULL,
  `usuario_creador` varchar(100) DEFAULT NULL,
  `usuario_ult_modificacion` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `bandera` text DEFAULT NULL,
  `copiar_permisos` text DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_permisos_campos`
--

DROP TABLE IF EXISTS `sys_permisos_campos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_permisos_campos` (
  `uid` varchar(50) NOT NULL,
  `tabla` varchar(100) NOT NULL,
  `campo` varchar(100) NOT NULL,
  `tabla_campo` varchar(200) NOT NULL,
  `editable_if` text DEFAULT NULL,
  `visible_if` text DEFAULT NULL,
  `empresa` varchar(50) DEFAULT NULL,
  `usuario_creador` varchar(100) DEFAULT NULL,
  `usuario_ult_modificacion` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `bandera` text DEFAULT NULL,
  `copiar_permisos` text DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_roles`
--

DROP TABLE IF EXISTS `sys_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_roles` (
  `uid` varchar(50) NOT NULL,
  `rol` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `capacidades_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`capacidades_json`)),
  `estado` varchar(20) DEFAULT 'Activo',
  `empresa` varchar(255) NOT NULL,
  `usuario_creador` varchar(100) DEFAULT NULL,
  `usuario_ult_modificacion` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_usuarios`
--

DROP TABLE IF EXISTS `sys_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_usuarios` (
  `Email` varchar(255) NOT NULL,
  `Nombre_Usuario` text DEFAULT NULL,
  `Nivel_Acceso` int(11) NOT NULL,
  `Perfil_ocupacional` text DEFAULT NULL,
  `tipo_id` varchar(30) DEFAULT NULL,
  `num_id` varchar(50) DEFAULT NULL,
  `genero` text DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `whatsapp` varchar(30) DEFAULT NULL,
  `instagram` varchar(100) DEFAULT NULL,
  `facebook` varchar(100) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `ciudad` varchar(100) DEFAULT NULL,
  `pais` varchar(100) DEFAULT NULL,
  `foto_url` varchar(255) DEFAULT NULL,
  `estado` varchar(20) DEFAULT 'Activo',
  `observaciones` text DEFAULT NULL,
  `ultima_empresa` varchar(50) DEFAULT NULL,
  `usuario_creador` varchar(100) DEFAULT NULL,
  `usuario_ult_modificacion` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_ult_modificacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_usuarios_empresas`
--

DROP TABLE IF EXISTS `sys_usuarios_empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_usuarios_empresas` (
  `uid` varchar(50) NOT NULL,
  `usuario` varchar(255) NOT NULL,
  `empresa` varchar(50) NOT NULL,
  `Nivel_Acceso` int(11) DEFAULT NULL,
  `rol` varchar(50) DEFAULT NULL,
  `permisos_json` text DEFAULT NULL,
  `estado` varchar(20) DEFAULT 'Activo',
  `observaciones` text DEFAULT NULL,
  `usuario_creador` varchar(100) DEFAULT NULL,
  `usuario_ult_modificacion` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_ult_modificacion` datetime DEFAULT NULL,
  `Mail_y_empresa` text NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `vw_costos_ruta_productos_pp`
--

DROP TABLE IF EXISTS `vw_costos_ruta_productos_pp`;
/*!50001 DROP VIEW IF EXISTS `vw_costos_ruta_productos_pp`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `vw_costos_ruta_productos_pp` AS SELECT
 1 AS `empresa`,
  1 AS `uid_producto_final`,
  1 AS `producto_final`,
  1 AS `uid_rama`,
  1 AS `nivel`,
  1 AS `uid_producto_actual`,
  1 AS `producto_actual`,
  1 AS `uid_producto_padre`,
  1 AS `producto_padre`,
  1 AS `uid_procedimiento_actual`,
  1 AS `procedimiento_actual`,
  1 AS `uid_procedimiento_padre`,
  1 AS `procedimiento_padre` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_sys_tablas`
--

DROP TABLE IF EXISTS `vw_sys_tablas`;
/*!50001 DROP VIEW IF EXISTS `vw_sys_tablas`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `vw_sys_tablas` AS SELECT
 1 AS `tabla`,
  1 AS `uid` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_sys_tablas_campos`
--

DROP TABLE IF EXISTS `vw_sys_tablas_campos`;
/*!50001 DROP VIEW IF EXISTS `vw_sys_tablas_campos`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `vw_sys_tablas_campos` AS SELECT
 1 AS `uid`,
  1 AS `tabla`,
  1 AS `columna` */;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'sos_erp_local'
--

--
-- Dumping routines for database 'sos_erp_local'
--

--
-- Final view structure for view `vw_costos_ruta_productos_pp`
--

/*!50001 DROP VIEW IF EXISTS `vw_costos_ruta_productos_pp`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`u768061575_ssierra047`@`127.0.0.1` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_costos_ruta_productos_pp` AS with recursive ruta as (select `p`.`Empresa` AS `empresa`,`p`.`uid` AS `uid_producto_final`,0 AS `nivel`,`p`.`uid` AS `uid_producto_hijo`,cast(NULL as char(255) charset utf8mb4) AS `uid_producto_padre`,cast(`p`.`uid_procedimiento` as char(255) charset utf8mb4) AS `uid_procedimiento_hijo`,cast(NULL as char(255) charset utf8mb4) AS `uid_procedimiento_padre`,cast(NULL as char(255) charset utf8mb4) AS `uid_rama` from `costos_encabezados_productos` `p` where `p`.`uid_procedimiento` is not null and trim(`p`.`uid_procedimiento`) <> '' union all select `r`.`empresa` AS `empresa`,`r`.`uid_producto_final` AS `uid_producto_final`,`r`.`nivel` + 1 AS `nivel`,cast(`pp`.`uid_producto_pp` as char(255) charset utf8mb4) AS `uid_producto_hijo`,cast(`r`.`uid_producto_hijo` as char(255) charset utf8mb4) AS `uid_producto_padre`,cast(`pprod`.`uid_procedimiento` as char(255) charset utf8mb4) AS `uid_procedimiento_hijo`,cast(`r`.`uid_procedimiento_hijo` as char(255) charset utf8mb4) AS `uid_procedimiento_padre`,case when `r`.`nivel` = 0 then cast(`pp`.`uid_producto_pp` as char(255) charset utf8mb4) else `r`.`uid_rama` end AS `uid_rama` from ((`ruta` `r` join `costos_procedimientos_pp` `pp` on(`pp`.`Empresa` = `r`.`empresa` and `pp`.`uid_procedimiento` = `r`.`uid_procedimiento_hijo` and `pp`.`uid_producto_pp` is not null and trim(`pp`.`uid_producto_pp`) <> '')) left join `costos_encabezados_productos` `pprod` on(`pprod`.`Empresa` = `r`.`empresa` and `pprod`.`uid` = `pp`.`uid_producto_pp`)) where `r`.`nivel` < 20)select `r`.`empresa` AS `empresa`,`r`.`uid_producto_final` AS `uid_producto_final`,`pf`.`Producto` AS `producto_final`,`r`.`uid_rama` AS `uid_rama`,`r`.`nivel` AS `nivel`,`r`.`uid_producto_hijo` AS `uid_producto_actual`,`ph`.`Producto` AS `producto_actual`,`r`.`uid_producto_padre` AS `uid_producto_padre`,`pp`.`Producto` AS `producto_padre`,`r`.`uid_procedimiento_hijo` AS `uid_procedimiento_actual`,`pr_hijo`.`Procedimiento` AS `procedimiento_actual`,`r`.`uid_procedimiento_padre` AS `uid_procedimiento_padre`,`pr_padre`.`Procedimiento` AS `procedimiento_padre` from (((((`ruta` `r` left join `costos_encabezados_productos` `pf` on(`pf`.`Empresa` = `r`.`empresa` and `pf`.`uid` = `r`.`uid_producto_final`)) left join `costos_encabezados_productos` `ph` on(`ph`.`Empresa` = `r`.`empresa` and `ph`.`uid` = `r`.`uid_producto_hijo`)) left join `costos_encabezados_productos` `pp` on(`pp`.`Empresa` = `r`.`empresa` and `pp`.`uid` = `r`.`uid_producto_padre`)) left join `costos_procedimientos` `pr_hijo` on(`pr_hijo`.`Empresa` = `r`.`empresa` and `pr_hijo`.`uid` = `r`.`uid_procedimiento_hijo`)) left join `costos_procedimientos` `pr_padre` on(`pr_padre`.`Empresa` = `r`.`empresa` and `pr_padre`.`uid` = `r`.`uid_procedimiento_padre`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_sys_tablas`
--

/*!50001 DROP VIEW IF EXISTS `vw_sys_tablas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`u768061575_ssierra047`@`127.0.0.1` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_sys_tablas` AS select `information_schema`.`tables`.`TABLE_NAME` AS `tabla`,row_number() over ( order by `information_schema`.`tables`.`TABLE_NAME`) AS `uid` from `information_schema`.`tables` where `information_schema`.`tables`.`TABLE_SCHEMA` = 'u768061575_os_comunidad' */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_sys_tablas_campos`
--

/*!50001 DROP VIEW IF EXISTS `vw_sys_tablas_campos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`u768061575_ssierra047`@`127.0.0.1` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_sys_tablas_campos` AS select concat(`information_schema`.`columns`.`TABLE_NAME`,'||',`information_schema`.`columns`.`COLUMN_NAME`) AS `uid`,`information_schema`.`columns`.`TABLE_NAME` AS `tabla`,`information_schema`.`columns`.`COLUMN_NAME` AS `columna` from `information_schema`.`columns` where `information_schema`.`columns`.`TABLE_SCHEMA` = 'u768061575_os_comunidad' order by `information_schema`.`columns`.`TABLE_NAME`,`information_schema`.`columns`.`ORDINAL_POSITION` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-03-02 17:12:31
