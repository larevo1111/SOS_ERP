/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.3-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: u768061575_os_comunidad
-- ------------------------------------------------------
-- Server version	11.8.3-MariaDB-log

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
-- Dumping data for table `Ensayoski`
--

LOCK TABLES `Ensayoski` WRITE;
/*!40000 ALTER TABLE `Ensayoski` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `Ensayoski` VALUES
(212,33,'2025-03-04','ddfasdfasdfasdfasdfasdfasdf'),
(424234,42432342,'2025-04-01','appsheets');
/*!40000 ALTER TABLE `Ensayoski` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `com_marcas`
--

LOCK TABLES `com_marcas` WRITE;
/*!40000 ALTER TABLE `com_marcas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `com_marcas` VALUES
(1,'OS.resd21','Ori_Sil_2','SANJEN','Superalimentos saludables','fsadfsda','Origen Silvestre/marcas/SANJEN//1.logo.010337.png','Activo','Sistema','Sistema','2026-02-20 00:42:38','2026-02-20 01:03:41');
/*!40000 ALTER TABLE `com_marcas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `com_productos`
--

LOCK TABLES `com_productos` WRITE;
/*!40000 ALTER TABLE `com_productos` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `com_productos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
  KEY `idx_orden` (`orden`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `com_productos_multimedia`
--

LOCK TABLES `com_productos_multimedia` WRITE;
/*!40000 ALTER TABLE `com_productos_multimedia` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `com_productos_multimedia` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_categorias`
--

LOCK TABLES `costos_categorias` WRITE;
/*!40000 ALTER TABLE `costos_categorias` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_categorias` VALUES
(1,'Pt_Proapi','Ori_Sil_2','Producto terminado','Productos apicolas','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(2,'Pt_Choyder','Ori_Sil_2','Producto terminado','Chocolate y derivados','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(3,'Pt_Frusecygra','Ori_Sil_2','Producto terminado','Frutos secos y granos','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(4,'Pt_Inf','Ori_Sil_2','Producto terminado','Infusiones','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(5,'Pt_Cre','Ori_Sil_2','Producto terminado','Cremas','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(6,'Pt_Conyext','Ori_Sil_2','Producto terminado','Concentrados y extractos','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(7,'Pt_Otr','Ori_Sil_2','Producto terminado','Otros','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(8,'Pt_ProTerObs','Ori_Sil_2','Producto terminado','Prod Terminado Obsoleto','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(9,'Pt_ProTerDañ','Ori_Sil_2','Producto terminado','Prod Terminado Dañado','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(10,'PP_Niv1','Ori_Sil_2','Producto Proceso','Nivel 1','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(11,'PP_Niv2','Ori_Sil_2','Producto Proceso','Nivel 2','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(12,'PP_Niv3','Ori_Sil_2','Producto Proceso','Nivel 3','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(13,'PP_Niv4','Ori_Sil_2','Producto Proceso','Nivel 4','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(14,'PP_Niv5','Ori_Sil_2','Producto Proceso','Nivel 5','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(15,'PP_Niv6','Ori_Sil_2','Producto Proceso','Nivel 6','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(16,'PP_Niv7','Ori_Sil_2','Producto Proceso','Nivel 7','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(17,'PP_Niv8','Ori_Sil_2','Producto Proceso','Nivel 8','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(18,'PP_Niv9','Ori_Sil_2','Producto Proceso','Nivel 9','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(19,'PP_Niv10','Ori_Sil_2','Producto Proceso','Nivel 10','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(20,'PP_Niv11','Ori_Sil_2','Producto Proceso','Nivel 11','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(21,'PP_Niv12','Ori_Sil_2','Producto Proceso','Nivel 12','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(22,'PP_ProenproObs','Ori_Sil_2','Producto Proceso','Prod en proceso Obsoleto','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(23,'PP_ProenproDañ','Ori_Sil_2','Producto Proceso','Prod en proceso Dañado','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(24,'MP_ProapiMP','Ori_Sil_2','Materias Primas','Productos apicolas MP','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(25,'MP_Grasemalmdecacetcnat','Ori_Sil_2','Materias Primas','Granos, semillas, almendras de cacao etc naturales','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(26,'MP_Grasemalmdecacetctos','Ori_Sil_2','Materias Primas','Granos, semillas, almendras de cacao etc tostadas','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(27,'MP_Grasemalmdecacetcpro','Ori_Sil_2','Materias Primas','Granos, semillas, almendras de cacao etc procesadas','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(29,'MP_Frusecfrudesetc','Ori_Sil_2','Materias Primas','Frutos secos, frutas deshidratadas, etc','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(30,'MP_Escextetc','Ori_Sil_2','Materias Primas','Escencias, extractos etc','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(31,'MP_Plahorfru','Ori_Sil_2','Materias Primas','Plantas, hortalizas, frutas','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(32,'MP_SalAzubicharetc','Ori_Sil_2','Materias Primas','Sal, Azucares, bicarbonato, harina  etc','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(33,'MP_Aceyotrsim','Ori_Sil_2','Materias Primas','Aceites y otros similares','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(34,'MP_Proman','Ori_Sil_2','Materias Primas','Productos manofacturados','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(35,'MP_Otrmatprisinpro','Ori_Sil_2','Materias Primas','Otras materias primas sin procesar','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(36,'MP_Otrmatpripro','Ori_Sil_2','Materias Primas','Otras materias primas procesadas','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(37,'MP_MatpriObs','Ori_Sil_2','Materias Primas','Mateias primas Obsoletas','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(38,'MP_MatpriDañ','Ori_Sil_2','Materias Primas','Materias primas Dañadas','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(39,'I_Envytap','Ori_Sil_2','Insumos','Envases y tapas','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(40,'I_Bol','Ori_Sil_2','Insumos','Bolsas','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(41,'I_Eti','Ori_Sil_2','Insumos','Etiquetas','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(42,'I_Caj','Ori_Sil_2','Insumos','Cajas','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(43,'I_Otrins','Ori_Sil_2','Insumos','Otros insumos','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(44,'I_Insobs','Ori_Sil_2','Insumos','Insumos obsoletos','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(45,'I_Insdañ','Ori_Sil_2','Insumos','Insumos dañados','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(46,'AP_Maq','Ori_Sil_2','Activos Productivos','Maquinaria','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(47,'AP_Her','Ori_Sil_2','Activos Productivos','Herramientas','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(48,'AP_Mol','Ori_Sil_2','Activos Productivos','Molderia','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(49,'AP_MatPOP','Ori_Sil_2','Activos Productivos','Material POP','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(50,'AP_Veh','Ori_Sil_2','Activos Productivos','Vehiculos','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(51,'AP_Mue','Ori_Sil_2','Activos Productivos','Muebles','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(52,'AP_Actproobs','Ori_Sil_2','Activos Productivos','Activos productivos obsoletos','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(53,'AP_Actprodañ','Ori_Sil_2','Activos Productivos','Activos productivos dañados','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(54,'C_Limyase','Ori_Sil_2','Consumibles','Limpieza y aseo','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(55,'C_Pro','Ori_Sil_2','Consumibles','Produccion','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(56,'C_Emp','Ori_Sil_2','Consumibles','Empaque','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(57,'C_Log','Ori_Sil_2','Consumibles','Logistica','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(58,'C_Ven','Ori_Sil_2','Consumibles','Ventas','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(59,'C_Ofi','Ori_Sil_2','Consumibles','Oficina','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(60,'C_Conobs','Ori_Sil_2','Consumibles','Consumibles obsoletos','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(61,'C_ConDañ','Ori_Sil_2','Consumibles','Consumibles Dañados','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(62,'S_Maqpro','Ori_Sil_2','Servicios','Maquilas produccion','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(63,'S_Serlog','Ori_Sil_2','Servicios','Servicios logisticos','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(64,'S_Serdeemp','Ori_Sil_2','Servicios','Servicios de empaque','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(65,'S_Serfin','Ori_Sil_2','Servicios','Servicios financieros','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(66,'S_Serdeven','Ori_Sil_2','Servicios','Servicios de ventas','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(67,'S_MOint','Ori_Sil_2','Servicios','MO interna','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(68,'S_MOext','Ori_Sil_2','Servicios','MO externa','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(69,'S_Maqint','Ori_Sil_2','Servicios','Maquina interna','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(70,'S_MaqExt','Ori_Sil_2','Servicios','Maquina Externa','','2025-08-23 00:03:34','2025-08-23 00:03:34','larevo1111@gmail.com','larevo1111@gmail.com'),
(100,'OSS_ensuidind_b1','Ori_Sil_2','Servicios','ensayyo uid indice','11','2025-12-26 03:28:19','2025-12-26 08:30:23','larevo1111@gmail.com','larevo1111@gmail.com');
/*!40000 ALTER TABLE `costos_categorias` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_consumibles`
--

LOCK TABLES `costos_consumibles` WRITE;
/*!40000 ALTER TABLE `costos_consumibles` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_consumibles` VALUES
(2,'Pro_PapKra120corTamcarplix9ud_2','Ori_Sil_2','Activo','','Papel Kraf 120g cortado Tamaño carta pliego x 9uds','Und','C_Pro',650000.0000,0.0000,0.0000,0,0.0000,0.0000,10.0000,NULL,'0000-00-00 00:00:00',NULL,'larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,'--Actualizados: 2 | Errores unidad: 0 | 2025-12-29 19:12--'),
(3,'Pro_Papkra150corTamcarPli(10CMS_3','Ori_Sil_2','Activo','','Papel kraf 150g cortado Tamaño carta Pliego (100x70 CMS)','Und','C_Pro',750.0000,0.0000,0.0000,0,0.0000,0.0000,1.0000,NULL,'0000-00-00 00:00:00','2025-12-25 10:14:04','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,''),
(4,'Pro_PAPPARROLX100EMPYDESLAMAY_4','Ori_Sil_2','Activo','','PAPEL PARAFINADO ROLLO X 100M EMPAQUES Y DESECHABLES LA MAYORISTA','Und','C_Pro',20000.0000,0.0000,0.0000,0,0.0000,0.0000,0.0000,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,''),
(5,'Emp_PINPINBAMBE-PARDEGX20U_5','Ori_Sil_2','Activo','','PINCHO PINZA BAMBÚ BE-GREEN PARA DEGUSTACIÓN X 20UDS','Und','C_Emp',4202.0000,0.0000,0.0000,0,0.0000,0.0000,0.0000,NULL,'0000-00-00 00:00:00','2025-07-25 23:03:16','larevo1111@gmail.com','larevo1111@gmail.com','costos consumibles/PINCHO PINZA BAMBÚ BE-GREEN PARA DEGUSTACIÓN X 20UDS//Emp_PINPINBAMBE-PARDEGX20U_',NULL,NULL,NULL,NULL,NULL,''),
(6,'Limyase_AmoCuaxlit(Liydes_6','Ori_Sil_2','Activo','','Amonio Cuaternario x litro (Limpieza y desinfección)','Und','C_Limyase',12700.0000,0.0000,0.0000,0,0.0000,0.0000,1.0000,NULL,'0000-00-00 00:00:00','2025-07-25 23:02:21','larevo1111@gmail.com','larevo1111@gmail.com','costos consumibles/Amonio Cuaternario x litro (Limpieza y desinfección)//Limyase_AmoCuaxlit(Liydes_6',NULL,NULL,NULL,NULL,NULL,''),
(7,'Limyase_BATDESPOLXUNI_7','Ori_Sil_2','Activo','','BATA DESECHABLE POLIPROPILENO X UNIDAD','Und','C_Limyase',5090.0000,0.0000,0.0000,0,0.0000,0.0000,10.0000,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,''),
(8,'Limyase_GORDESBLAX100UNI_8','Ori_Sil_2','Activo','','GORRO DESECHABLE BLANCO X 100 UNIDADS','Und','C_Limyase',19300.0000,0.0000,0.0000,0,0.0000,0.0000,1.0000,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,''),
(9,'Limyase_GUADENITTALMCAJX50PAR_9','Ori_Sil_2','Activo','','GUANTES DE NITRILO TALLA M CAJA X 50 PARES','Und','C_Limyase',33000.0000,0.0000,0.0000,0,0.0000,0.0000,1.0000,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,''),
(10,'Ven_PLACANBAM10C25uSIG_10','Ori_Sil_2','Activo','','PLATO CANOA BAMBÚ 10CMS 25uds SIGMAPLAST','Und','C_Ven',2240.1230,0.0000,0.0000,0,0.0000,0.0000,0.0000,'--Actualizados: 4 | Errores unidad: 1 | 2025-12-25 23:34--ERROR_UNIDAD | MAESTRA=Und | PROC=hoja | 2025-12-25 23:34--Actualizados: 4 | Errores unidad: 0 | 2025-12-26 05:56--','0000-00-00 00:00:00','2025-12-26 05:56:28','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,''),
(11,'Pro_ROLEXTPLAALIRAP300_11','Ori_Sil_2','Activo','','ROLLO EXTENSIBLE PLASTICO ALIMENTOS RAP 300M','Und','C_Pro',16500.0000,0.0000,0.0000,0,0.0000,0.0000,0.0000,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,''),
(12,'Pro_TOADEPAPPARCOCx3Rol_12','Ori_Sil_2','Activo','','SERVILLETA REUTILIZABLE TELA PARA COCINA','und','C_Pro',240.0000,0.0000,0.0000,1,0.0000,0.0000,0.0000,NULL,'0000-00-00 00:00:00','2025-10-10 16:16:00','larevo1111@gmail.com','ssierra047@gmail.com','consumibles/SERVILLETA REUTILIZABLE TELA PARA COCINA//Pro_TOADEPAPPARCOCx3Rol_12.Imagen_1.211615.jpg','costos consumibles/SERVILLETA REUTILIZABLE TELA PARA COCINA//Pro_TOADEPAPPARCOCx3Rol_12.Imagen_2.210',NULL,NULL,NULL,NULL,''),
(13,'Limyase_VIN/ACIACEX3LIT/MIN(LI_13','Ori_Sil_2','Activo','','VINAGRE / ACIDO ACETICO X 3 LITROS / MINORISTA (LIMPIEZA Y DESINFECCION)','Lt','C_Limyase',4800.0000,0.0000,0.0000,0,0.0000,0.0000,1.0000,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,''),
(14,'C_E_CosdeFibmed_13','Ori_Sil_2','Activo',NULL,'Costal de Fibra mediano','und','C_Emp',2000.0000,NULL,NULL,NULL,NULL,NULL,NULL,'--Actualizados: 0 | Errores unidad: 1 | 2025-12-29 10:59--ERROR_UNIDAD | MAESTRA=und | PROC=hora | 2025-12-29 10:59--Actualizados: 0 | Errores unidad: 1 | 2025-12-29 10:59--ERROR_UNIDAD | MAESTRA=und | PROC=hora | 2025-12-29 10:59--Actualizados: 1 | Errores unidad: 0 | 2025-12-29 11:01--','2025-10-03 12:31:40','2025-12-29 11:01:01','jennifercanogarcia@gmail.com','larevo1111@gmail.com','','','','','','',''),
(15,'C_E_VinAnc30c_14','Ori_Sil_2','Activo',NULL,'Vinipel Ancho 30cm','mt','C_Emp',37.0000,NULL,NULL,1,NULL,NULL,NULL,'--Actualizados: 1 | Errores unidad: 0 | 2025-12-28 15:43--','2025-10-03 12:37:55','2025-12-28 15:43:26','jennifercanogarcia@gmail.com','larevo1111@gmail.com','','','','','','',''),
(16,'C_P_Serdepap_15','Ori_Sil_2','Activo',NULL,'Servilletas de papel','cm','C_Pro',3.4800,NULL,NULL,1,NULL,NULL,100.0000,NULL,'2025-10-10 15:56:58','2025-10-10 16:15:44','jennifercanogarcia@gmail.com','ssierra047@gmail.com','consumibles/Servilletas de papel//C_P_Serdepap_15.Imagen_1.211558.jpg','','','','','',''),
(17,'C_L_JabNeu_16','Ori_Sil_2','Activo',NULL,'Jabon Neutro','ml','C_Limyase',10.2600,NULL,NULL,1,NULL,NULL,2000.0000,NULL,'2025-10-10 16:10:50','2025-10-10 16:10:50','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','','','','','','','');
/*!40000 ALTER TABLE `costos_consumibles` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_encabezados_productos`
--

LOCK TABLES `costos_encabezados_productos` WRITE;
/*!40000 ALTER TABLE `costos_encabezados_productos` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_encabezados_productos` VALUES
(2,'PTFrusecygra_ALMDECACORGTOS100GRS_02','Ori_Sil_2','ALMENDRA DE CACAO ORGANICO TOSTADA 100 GRS','Pt_Frusecygra','ALMDECACORGTOS_02',NULL,'PT','Und','Produccion','PTFrusecygra_ALMDECACORGTOS200GRS_03','PRO_EnsProOps1_74',1.1000,7000.0000,NULL,119.0909,7700.0000,0.1694,'meses','NVR (VALOR NETO REALIZABLE)',400822.5319,2439.1884,5486.7987,303313.1804,88266.2266,1317.1377,14600.0000,'7708773404959','Encabezados productos/ALMENDRA DE CACAO ORGANICO TOSTADA 100 GRS//2.imagen_1.000053.png','Encabezados productos/ALMENDRA DE CACAO ORGANICO TOSTADA 100 GRS//PTFrusecygra_ALMDECACORGTOS100GRS_02.imagen_2.223223.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04','2025-12-28 01:44:39','2026-01-16 19:51:36','ssierra047@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','',0.0000,0.0000,0.0000,NULL,'',NULL),
(3,'PTFrusecygra_ALMDECACORGTOS200GRS_03','Ori_Sil_2','ALMENDRA DE CACAO ORGANICO TOSTADA 200 GRS','Pt_Frusecygra','ALMDECACORGTOS_02',NULL,'PT','Und','Produccion',NULL,'PRO_EmpAlmdecactos200_93',1.0000,NULL,NULL,0.0000,0.0000,1.0000,'und','SIN COSTO CONJUNTO',6219.3089,4742.6000,476.0000,0.0000,1000.0000,0.7089,23.3000,'7708773404690','Encabezados productos/ALMENDRA DE CACAO ORGANICO TOSTADA 200 GRS//PTFrusecygra_ALMDECACORGTOS200GRS_03.imagen_1.223154.png','Encabezados productos/ALMENDRA DE CACAO ORGANICO TOSTADA 200 GRS//PTFrusecygra_ALMDECACORGTOS200GRS_03.imagen_2.223154.png',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-12-24 02:04:30','ssierra047@gmail.com','ssierra047@gmail.com','larevo1111@gmail.com','',0.0000,0.0000,0.0000,NULL,'',NULL),
(4,'PPNiv1_ALMDECACTOS_04','Ori_Sil_2','ALMENDRA DE CACAO TOSTADA','PP_Niv1','ALMDECACORGTOS_02',NULL,'PP','kg','Produccion',NULL,'PRO_Tosalmdecac_10',1.0000,NULL,NULL,0.0000,0.0000,1.0000,'kg','SIN COSTO CONJUNTO',23713.0000,0.0000,20000.0000,0.0000,3300.0000,413.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-12-27 07:09:00','ssierra047@gmail.com','ssierra047@gmail.com','larevo1111@gmail.com','',0.0000,0.0000,0.0000,'--ERROR | Unknown column \'Unidad\' in \'SELECT\' | 2025-12-27 06:47----ERROR | Unknown column \'Unidad\' in \'SELECT\' | 2025-12-27 06:54----ERROR | Unknown column \'Unidad\' in \'SELECT\' | 2025-12-27 06:57----Actualizados: 1 | Errores unidad: 0 | 2025-12-27 07:08----Actualizados: 2 | Errores unidad: 0 | 2025-12-27 07:09--','',NULL),
(9,'PPNiv2_CASDECACLTxKL_09','Ori_Sil_2','CASCARILLA DE CACAO LT x Kg','PP_Niv2','CASDECAC_04',NULL,'PP','kg','Produccion','PTFrusecygra_ALMDECACORGTOS200GRS_03','PRO_MaqTosyDesdeCac_bc',0.3000,25000.0000,NULL,0.0000,7500.0000,0.2246,'kg','NVR (VALOR NETO REALIZABLE)',22026.1976,0.0000,15718.5629,211.0778,6096.5569,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2026-01-04 15:30:49','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','1',0.0000,0.0000,0.0000,'','',NULL),
(10,'PTCre_CHOOS130GRS_10','Ori_Sil_2','CHOCOBEETAL OS 130 GRS','Pt_Cre','CHOOS_05',NULL,'PT','Und','Produccion','PTFrusecygra_ALMDECACORGTOS200GRS_03',NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,16.2000,'7709186439330',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-12-24 02:31:16','ssierra047@gmail.com','ssierra047@gmail.com','larevo1111@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(11,'PTCre_CHOOS230GRS_11','Ori_Sil_2','CHOCOBEETAL OS 230 GRS','Pt_Cre','CHOOS_05',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,23.8000,'7709186439378',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(12,'PTCre_CHOOS90GRS_12','Ori_Sil_2','CHOCOBEETAL OS 90 GRS','Pt_Cre','CHOOS_05',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,11.6000,'7709186439354',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','larevo1111@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(13,'PPNiv4_CHOXKG_13','Ori_Sil_2','CHOCOBEETAL X KG','PP_Niv4','CHOOS_05',NULL,'PP','kg','Produccion','PTFrusecygra_ALMDECACORGTOS200GRS_03',NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-12-24 02:04:30','ssierra047@gmail.com','ssierra047@gmail.com','larevo1111@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(14,'PPNiv4_CHOLT100-REF24H-_14','Ori_Sil_2','CHOCOLATE LT 100% - REFINADO 24H - ENMOLDADO MOLDE 9 a 12 g','PP_Niv5','Cho100Cac_06',NULL,'PP','kg','Produccion',NULL,'PRO_Enmbom_3a',1.0000,NULL,NULL,447.4500,0.0000,1.0000,'kg','SIN COSTO CONJUNTO',50616.3391,45773.1303,0.0000,51.7500,4575.0000,216.4588,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2026-01-09 17:15:35','ssierra047@gmail.com','ssierra047@gmail.com','larevo1111@gmail.com','',0.0000,0.0000,0.0000,NULL,'--Actualizados: 2 | Errores unidad: 0 | 2026-01-09 17:15--',NULL),
(15,'PPNiv3_CHOLT100-REF24H-_15','Ori_Sil_2','CHOCOLATE LT 100% - REFINADO 24H - BLOQUE','PP_Niv4','Cho100Cac_06',NULL,'PP','kg','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(16,'PTChoyder_Cho100Cac250grsBomLT_16','Ori_Sil_2','Chocolate 100% Cacao 250 grs Bombones LT','Pt_Choyder','Cho100Cac_06',NULL,'PT','Und','Produccion',NULL,'OS.PRO_EmpChobom250_dc',1.0000,NULL,NULL,6.0000,0.0000,1.0000,'und','SIN COSTO CONJUNTO',14130.7937,12654.0848,476.0000,0.0000,1000.0000,0.7089,33.0000,'7708773404409',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2026-01-08 13:11:36','ssierra047@gmail.com','ssierra047@gmail.com','larevo1111@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(17,'PTChoyder_Cho100Cac250grsGraLT_17','Ori_Sil_2','Chocolate 100% Cacao 250 grs Granulado LT','Pt_Choyder','Cho100Cac_06',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,34.6000,'7708773404805',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(18,'PTChoyder_Cho100Cac500grsBomLT_18','Ori_Sil_2','Chocolate 100% Cacao 500 grs Bombones LT','Pt_Choyder','Cho100Cac_06',NULL,'PT','Und','Produccion',NULL,'OS.PRO_EmpChobom500_af',1.0000,NULL,NULL,6.0000,0.0000,1.0000,'und','SIN COSTO CONJUNTO',26784.8785,25308.1696,476.0000,0.0000,1000.0000,0.7089,61.9000,'7708773404737',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2026-01-08 13:13:27','ssierra047@gmail.com','ssierra047@gmail.com','larevo1111@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(19,'PTChoyder_Cho100Cac500grsGraLT_19','Ori_Sil_2','Chocolate 100% Cacao 500 grs Granulado LT','Pt_Choyder','Cho100Cac_06',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,63.8000,'7708773404980',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(20,'PTChoyder_Cho100CacDeg20grs_20','Ori_Sil_2','Chocolate 100% Cacao Degustacion 20 grs','Pt_Choyder','Cho100Cac_06',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,5.5000,'7708773404522',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(21,'PPNiv4_CHOLT100-REF24H-_21','Ori_Sil_2','CHOCOLATE LT 100% - REFINADO 24H - GRANULADO','PP_Niv5','Cho100Cac_06',NULL,'PP','kg','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(22,'PPNiv4_CHOLT80/_22','Ori_Sil_2','CHOCOMIEL LT 80/20 ','PP_Niv4','ChoOS_07',NULL,'PP','kg','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(23,'PTCre_ChoOS135_23','Ori_Sil_2','Chocomiel OS 135cc','Pt_Cre','ChoOS_07',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,17.6000,'7708773404485',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(24,'PTCre_ChoOS250_24','Ori_Sil_2','Chocomiel OS 250cc','Pt_Cre','ChoOS_07',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,24.2000,'7708773404591',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(25,'PTCre_ChoOSDegenvvidx65g_25','Ori_Sil_2','Chocomiel OS Degustación envase vidrio x 65g','Pt_Cre','ChoOS_07',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(26,'PPNiv4_COBCHOCPM73%OSBLOSIN_26','Ori_Sil_2','COBERTURA CHOCOLATE CPM 73% OS BLOQUE SIN TEMPLAR X KILO','PP_Niv5','Choosc73%CPM_08',NULL,'PP','kg','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(27,'PPNiv5_COBCHOCPM73%OSBLOTEM_27','Ori_Sil_2','COBERTURA CHOCOLATE CPM 73% OS BLOQUE TEMPLADA X KILO','PP_Niv6','Choosc73%CPM_08',NULL,'PP','kg','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(28,'PPNiv6_COBCHOCPM73%OSENMX_28','Ori_Sil_2','COBERTURA CHOC CPM 73% OS TEMPLADA Y ENMOLDADAX KG','PP_Niv7','Choosc73%CPM_08',NULL,'PP','kg','Produccion',NULL,'PRO_EnsProOps1_74',0.6500,15000.0000,NULL,201.5385,9750.0000,0.2145,'meses','NVR (VALOR NETO REALIZABLE)',858905.4255,5226.8324,11757.4257,649956.8152,189141.9142,2822.4380,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,NULL,'',NULL),
(37,'PTCre_CREDEMANOS130GRS_37','Ori_Sil_2','CREMA DE MANI OS 130 GRS','Pt_Cre','Credeman_11',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,13.6000,'7708773404461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(38,'PTCre_CREDEMANOS230GRS_38','Ori_Sil_2','CREMA DE MANI OS 230 GRS','Pt_Cre','Credeman_11',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,20.6000,'7708773404782',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(39,'PTCre_CREDEMANOS500GRS_39','Ori_Sil_2','CREMA DE MANI OS 500 GRS','Pt_Cre','Credeman_11',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,38.4000,'7708773404898',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(40,'PTCre_CredemanOSdeg65grs_40','Ori_Sil_2','Crema de mani OS degustacion 65 grs','Pt_Cre','Credeman_11',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,7.9000,'7708773404300',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(41,'PPNiv3_CREDEMAN_41','Ori_Sil_2','CREMA DE MANI','PP_Niv3','Credeman_11',NULL,'PP','kg','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','larevo1111@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(42,'PTOtr_CUCMIEGRA_42','Ori_Sil_2','CUCHARA MIELERA GRANDE','Pt_Otr','Cucmie_18',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,6.7000,'7708773404195',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(43,'PTOtr_CUCMIEMED_43','Ori_Sil_2','CUCHARA MIELERA MEDIANA','Pt_Otr','Cucmie_18',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,5.9000,'7708773404706',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(44,'PTOtr_CUCMIEPEQ_44','Ori_Sil_2','CUCHARA MIELERA PEQUEÑA','Pt_Otr','Cucmie_18',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,4.0000,'7708773404850',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(51,'PPNiv1_ExtdeVaienMie_51','Ori_Sil_2','Extracto de Vainilla en Miel','PP_Niv2','Vaienmie_13',NULL,'PP','kg','Produccion',NULL,'PRO_EnsProOps1_74',2.0000,14000.0000,NULL,65.5000,28000.0000,0.6161,'meses','NVR (VALOR NETO REALIZABLE)',801645.0638,4878.3769,10973.5974,606626.3608,176532.4532,2634.2755,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,NULL,'',NULL),
(52,'PTInf_InfdeCacconMenyPol_52','Ori_Sil_2','Infusión de Cacao con Menta y Polen 200 grs','Pt_Inf','Vaienmie_13',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(53,'PTInf_INFDECACOSCONMENy_53','Ori_Sil_2','INFUSION DE CACAO OS CON MENTA y POLEN X 200 GRS','Pt_Inf','INFDECACOSCONMENy_14',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,15.6000,'7708773404508',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(54,'PPNiv1_INFDECACOSCONMENY_54','Ori_Sil_2','INFUSION DE CACAO OS CON MENTA Y POLEN','PP_Niv2','INFDECACOSCONMENy_14',NULL,'PP','kg','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(55,'PTProapi_MiedelcarOSdegenvvid_55','Ori_Sil_2','Miel del carmen OS degustacion envase vidrio x 65g','Pt_Proapi','MiedelcarOS_20',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(56,'PPNiv1_MIELTFIL_56','Ori_Sil_2','MIEL LT FILTRADA','PP_Niv1','MieOSLaTie_15',NULL,'PP','kg','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(57,'PPNiv2_MIELTFILyPAS_57','Ori_Sil_2','MIEL LT FILTRADA y PASTEURIZADA','PP_Niv2','MieOSLaTie_15',NULL,'PP','kg','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(59,'PTProapi_MieOSCarCri100grs_59','Ori_Sil_2','Miel OS Carmen Cristalizada 1000 grs','Pt_Proapi','MieOSdelcar_21',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,49.8000,'7708773404492',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(60,'PTProapi_MieOSCarCri150grs_60','Ori_Sil_2','Miel OS Carmen Cristalizada 150 grs','Pt_Proapi','MieOSdelcar_21',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,12.7000,'7708773404812',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(61,'PTProapi_MieOSCarCri275grs_61','Ori_Sil_2','Miel OS Carmen Cristalizada 275 grs','Pt_Proapi','MieOSdelcar_21',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,19.8000,'7708773404133',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(62,'PTProapi_MieOSCarCri640grs_62','Ori_Sil_2','Miel OS Carmen Cristalizada 640 grs','Pt_Proapi','MieOSdelcar_21',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,34.7000,'7708773404553',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(63,'PTProapi_MieOSdeg65grs_63','Ori_Sil_2','Miel OS degustacion 65 grs','Pt_Proapi','MieOSLaTie_15',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,6.6000,'7708773404744',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(64,'PTProapi_MieOSPan150grs_64','Ori_Sil_2','Miel OS Panal 150 grs','Pt_Proapi','MieOSLaTie_15',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,17.1000,'7708773404560',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(65,'PTProapi_MieOSPan275grs_65','Ori_Sil_2','Miel OS Panal 275 grs','Pt_Proapi','MieOSLaTie_15',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,17.6000,'7708773404775',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(66,'PTProapi_MieOSPan640grs_66','Ori_Sil_2','Miel OS Panal 640 grs','Pt_Proapi','MieOSLaTie_15',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(70,'PTProapi_MieOsVid100grs_70','Ori_Sil_2','Miel Os Vidrio 1000 grs','Pt_Proapi','MieOSLaTie_15',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,46.6000,'7708773404638',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(71,'PTProapi_MieOsVid150grs_71','Ori_Sil_2','Miel Os Vidrio 150 grs','Pt_Proapi','MieOSLaTie_15',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,11.0000,'7708773404126',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(72,'PTProapi_MieOsvid275grs_72','Ori_Sil_2','Miel Os vidrio 275 grs','Pt_Proapi','MieOSLaTie_15',NULL,'PT','Und','Produccion',NULL,NULL,1.0000,NULL,NULL,14400.0000,0.0000,0.0000,'kg','NVR (VALOR NETO REALIZABLE)',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,24.8000,'7708773404904',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2026-01-04 15:34:19','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(75,'PTProapi_MieOsVid640grs_75','Ori_Sil_2','Miel Os Vidrio 640 grs','Pt_Proapi','MieOSLaTie_15',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,32.0000,'7708773404829',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(78,'PTFrusecygra_NIBDECACORGOS100GRS_78','Ori_Sil_2','NIBS DE CACAO ORGANICO OS 100 GRS','Pt_Frusecygra','Nibdecac_16',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,16.2000,'7708773404751',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(79,'PTFrusecygra_NIBDECACORGOS200GRS_79','Ori_Sil_2','NIBS DE CACAO ORGANICO OS 200 GRS','Pt_Frusecygra','Nibdecac_16',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,25.5000,'7708773404386',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(80,'PPNiv2_NIBDECACLT_80','Ori_Sil_2','NIBS DE CACAO LT','PP_Niv2','Nibdecac_16',NULL,'PP','kg','Produccion',NULL,'PRO_MaqTosyDesdeCac_bc',0.7000,37000.0000,NULL,0.0000,25900.0000,0.7754,'kg','NVR (VALOR NETO REALIZABLE)',32598.7725,0.0000,23263.4731,312.3952,9022.9042,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2026-01-08 12:05:35','ssierra047@gmail.com','ssierra047@gmail.com','larevo1111@gmail.com','1',0.0000,0.0000,0.0000,'El estándar es 1,43 porque se necesitan 1,43 kilos de almendra para obtener 1 kilo de nibs, el desperdicio es del 70%','--Actualizados: 2 | Errores unidad: 0 | 2026-01-08 12:05--',NULL),
(81,'PTProapi_POLDEABEOS150grs_81','Ori_Sil_2','POLEN DE ABEJA OS 150 grs','Pt_Proapi','Pol_23',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,20.7000,'7708773404652',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(82,'PTProapi_POLDEABEOS200grs_82','Ori_Sil_2','POLEN DE ABEJA OS 200 grs','Pt_Proapi','Pol_23',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(83,'PTProapi_POLDEABEOS320grs_83','Ori_Sil_2','POLEN DE ABEJA OS 320 grs','Pt_Proapi','Pol_23',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,38.6000,'7708773404096',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(84,'PTProapi_POLDEABEOS80g_84','Ori_Sil_2','POLEN DE ABEJA OS 80grs','Pt_Proapi','Pol_23',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,13.0000,'7708773404287',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(85,'PTProapi_PROOS150grs_85','Ori_Sil_2','PROPOLEO OS 150 grs','Pt_Proapi','Pro_24',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,11.6000,'7708773404614',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(86,'PTProapi_PROOS265grs_86','Ori_Sil_2','PROPOLEO OS 265 grs','Pt_Proapi','Pro_24',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,18.0000,'7708773404362',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(87,'PTProapi_PROOS325grs_87','Ori_Sil_2','PROPOLEO OS 325 grs','Pt_Proapi','Pro_24',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(88,'PTProapi_PROOS600grs_88','Ori_Sil_2','PROPOLEO OS 600 grs','Pt_Proapi','Pro_24',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,33.3000,'7708773404928',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(89,'PTProapi_ProOSdeg65grs_89','Ori_Sil_2','Propóleo OS degustacion 65 grs','Pt_Proapi','Pro_24',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,6.6000,'7708773404393',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(90,'PTChoyder_TabdeChoOsc73%50grs_90','Ori_Sil_2','Tableta de Chocolate Oscuro 73% 50 grs - CPM','Pt_Choyder','Choosc73%CPM_08',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,14.2000,'7708773404874',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(91,'PTChoyder_TabdeChoOsc73%50grs_91','Ori_Sil_2','Tableta de Chocolate Oscuro 73% 50 grs - CPM X 5','Pt_Choyder','Choosc73%CPM_08',NULL,'PT','Und','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-09-11 21:49:04',NULL,'2025-09-11 21:49:04','ssierra047@gmail.com','ssierra047@gmail.com','ssierra047@gmail.com','',0.0000,0.0000,0.0000,'','',NULL),
(93,'PPPP__CHOLT100-REF24H_2c','Ori_Sil_2','CHOCOLATE LT 100% - REFINADO 24H','PP_Niv4','Cho100Cac_06',NULL,'PP','kg','Produccion',NULL,'PRO_Refdenib24hor_5a',1.0000,NULL,NULL,0.0000,0.0000,1.0000,'kg','SIN COSTO CONJUNTO',45773.1303,32598.7725,0.0000,51.7500,10800.0000,2322.6078,0.0000,NULL,'','','','','','','','','','',NULL,NULL,NULL,'2025-10-10 00:00:00',NULL,'2026-01-10 12:20:04','jennifercanogarcia@gmail.com','','larevo1111@gmail.com',NULL,0.0000,0.0000,0.0000,NULL,'',NULL),
(94,'PPPt__ENSNIB_00','Ori_Sil_2','ENSA NIBS','Pt_Choyder',NULL,NULL,'PP','kg','Produccion',NULL,'PRO_ENSNIBPRO_44',0.6890,37000.0000,NULL,87.0827,25493.0000,0.7667,'kg','NVR (VALOR NETO REALIZABLE)',45623.3741,34495.7219,0.0000,0.0000,11127.6522,0.0000,NULL,NULL,'','','','','','','','','','',NULL,NULL,NULL,'2025-10-30 00:00:00',NULL,'2025-10-30 22:31:15','larevo1111@gmail.com','','larevo1111@gmail.com',NULL,NULL,NULL,NULL,NULL,'',NULL),
(95,'PPPt__ENSCAS_7a','Ori_Sil_2','ENSA CASCARILLA','Pt_Choyder',NULL,NULL,'PP','kg','Produccion',NULL,'PRO_ENSNIBPRO_44',0.3103,25000.0000,NULL,193.3613,7757.5000,0.2333,'kg','NVR (VALOR NETO REALIZABLE)',30826.6041,23307.9202,0.0000,0.0000,7518.6839,0.0000,NULL,NULL,'','','','','','','','','','',NULL,NULL,NULL,'2025-10-30 00:00:00',NULL,'2025-12-29 11:03:55','larevo1111@gmail.com','','larevo1111@gmail.com',NULL,NULL,NULL,NULL,'--Actualizados: 1 | Errores unidad: 0 | 2025-12-29 11:02--','',NULL),
(96,'PPPt__ENSALMTOS_f2','Ori_Sil_2','ENSA ALMENDRAS TOSTA','Pt_Choyder',NULL,NULL,'PP','kg','Produccion',NULL,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,'','',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,NULL,'','','','','','','','','','',NULL,NULL,NULL,'2025-10-30 00:00:00',NULL,'2025-10-30 22:32:57','larevo1111@gmail.com','','larevo1111@gmail.com',NULL,NULL,NULL,NULL,NULL,'',NULL);
/*!40000 ALTER TABLE `costos_encabezados_productos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_etiquetas`
--

LOCK TABLES `costos_etiquetas` WRITE;
/*!40000 ALTER TABLE `costos_etiquetas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_etiquetas` VALUES
('Api_5a','Ori_Sil_2','Apicolas','Productos apicolas','Activa','larevo1111@gmail.com','larevo1111@gmail.com','2025-09-22 23:05:51','2025-09-22 23:05:51'),
('CacyCho_d0','Ori_Sil_2','Cacao y Chocolate',NULL,'Activa','larevo1111@gmail.com','larevo1111@gmail.com','2025-09-22 23:06:19','2025-09-22 23:06:19');
/*!40000 ALTER TABLE `costos_etiquetas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_fases`
--

LOCK TABLES `costos_fases` WRITE;
/*!40000 ALTER TABLE `costos_fases` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_fases` VALUES
('1','Alistamiento','Preparación previa de equipos, materiales o áreas de trabajo antes de la operación.',1,'Activa'),
('2','Operación','Ejecución principal del procedimiento donde se realiza la transformación del producto.',2,'Activa'),
('3','Reposo / Maduración','Tiempo en el que el producto permanece en cámaras, moldes o tanques sin intervención activa, para enfriamiento, decantación o maduración.',4,'Activa'),
('4','Limpieza','Etapa de limpieza, lavado y organización posterior a la operación.',3,'Activa'),
('99','Consumo Adicional','Consumos adicionales registrados al final',9,'Activa');
/*!40000 ALTER TABLE `costos_fases` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_formulas`
--

LOCK TABLES `costos_formulas` WRITE;
/*!40000 ALTER TABLE `costos_formulas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_formulas` VALUES
(16,'PTCre_AREMIEOS130GRS_05+Pro_PAPPARROLX100EMPYDESLA','PTCre_AREMIEOS130GRS_05','Ori_Sil_2','Consumible','Pro_PAPPARROLX100EMPYDESLAMAY_4','PAPEL PARAFINADO ROLLO X 100M EMPAQUES Y DESECHABLES LA MAYORISTA','Und',7.0000,20000.00,1,'NULL','2025-07-26','2025-07-26','larevo1111@gmail.com','larevo1111@gmail.com'),
(18,'PTCre_CHOOS130GRS_10+Pro_Papkra150corTamcarPli(10C','PTCre_CHOOS130GRS_10','Ori_Sil_2','Consumible','Pro_Papkra150corTamcarPli(10CMS_3','Papel kraf 150g cortado Tamaño carta Pliego (100x70 CMS)','Und',3.0000,750.00,1,'NULL','2025-07-26','2025-07-26','larevo1111@gmail.com','larevo1111@gmail.com'),
(80,'eb181a74','PPNiv3_CREDEMAN_41','Ori_Sil_2','MP e Insumos','IN_Enyta_TAPMETDORB.3UNI_68','TAPA METALICA DORADA B.38 UNICOR','und',1.0000,183.00,3,'1','2025-08-29','2025-08-29','larevo1111@gmail.com','larevo1111@gmail.com'),
(81,'1c82b866','PPNiv3_CREDEMAN_41','Ori_Sil_2','MP e Insumos','MP_SaAzbihaet_PANPULXKG_44','PANELA PULVERIZADA X KG','kg',3.0000,8700.00,2,'3','2025-08-29','2025-08-29','larevo1111@gmail.com','larevo1111@gmail.com'),
(82,'23d7a135','PPNiv3_CREDEMAN_41','Ori_Sil_2','Consumible','Emp_PINPINBAMBE-PARDEGX20U_5','PINCHO PINZA BAMBÚ BE-GREEN PARA DEGUSTACIÓN X 20UDS','Und',6.0000,4202.00,1,'NULL','2025-08-29','2025-08-29','larevo1111@gmail.com','larevo1111@gmail.com'),
(83,'a14bdf7a','PPNiv3_CREDEMAN_41','Ori_Sil_2','MP e Insumos','MP_Frsefrdeet_MACCRU(SITOSXKIL_63','MACADAMIA CRUDA (SIN TOSTAR) X KILO','kg',6.0000,90000.00,4,'4','2025-08-29','2025-08-29','larevo1111@gmail.com','larevo1111@gmail.com'),
(84,'9f8d100c','PPNiv3_CREDEMAN_41','Ori_Sil_2','Producto Proceso','PPNiv6_COBCHOCPM73%OSENMX_28','COBERTURA CHOCOLATE CPM 73% OS ENMOLDADA X KILO','Kgs',1.0000,32.85,2,NULL,'2025-08-29','2025-08-29','larevo1111@gmail.com','larevo1111@gmail.com'),
(85,'63ae62be','PPNiv3_CREDEMAN_41','Ori_Sil_2','Producto Proceso','PPNiv5_AREMIEOSXKIL_07','AREQUIPE MIEL OS X KILO','Kgs',2.0000,0.00,1,NULL,'2025-08-29','2025-08-29','larevo1111@gmail.com','larevo1111@gmail.com'),
(86,'ae4450eb','PPNiv3_CREDEMAN_41','Ori_Sil_2','Servicio','Mapr_ENVMIE_04','ENVASADO MIEL','Kgs',3.0000,560.00,1,NULL,'2025-08-29','2025-08-29','larevo1111@gmail.com','larevo1111@gmail.com'),
(87,'5b14e538','PPNiv3_CREDEMAN_41','Ori_Sil_2','MP e Insumos','MP_Plhofr_JENRAIXKG_29','JENGIBRE RAIZ X KG','kg',3.0000,20000.00,1,'2','2025-08-29','2025-08-29','larevo1111@gmail.com','larevo1111@gmail.com'),
(88,'e66a97ae','PPNiv3_CREDEMAN_41','Ori_Sil_2','Consumible','Limyase_BATDESPOLXUNI_7','BATA DESECHABLE POLIPROPILENO X UNIDAD','Und',8.0000,5090.00,2,NULL,'2025-08-29','2025-08-29','larevo1111@gmail.com','larevo1111@gmail.com'),
(89,'cfdd877c','PTCre_AREMIEOS230GRS_06','Ori_Sil_2','MP e Insumos','IN_Enyta_TAPMETDORB.3UNI_68','TAPA METALICA DORADA B.38 UNICOR','und',1.0000,183.00,3,'1','2025-09-10','2025-09-10','larevo1111@gmail.com','larevo1111@gmail.com'),
(90,'4ce4e4ac','PTCre_AREMIEOS230GRS_06','Ori_Sil_2','MP e Insumos','MP_SaAzbihaet_PANPULXKG_44','PANELA PULVERIZADA X KG','kg',3.0000,8700.00,2,'3','2025-09-10','2025-09-10','larevo1111@gmail.com','larevo1111@gmail.com'),
(91,'73e202c0','PTCre_AREMIEOS230GRS_06','Ori_Sil_2','Consumible','Emp_PINPINBAMBE-PARDEGX20U_5','PINCHO PINZA BAMBÚ BE-GREEN PARA DEGUSTACIÓN X 20UDS','Und',6.0000,4202.00,1,'NULL','2025-09-10','2025-09-10','larevo1111@gmail.com','larevo1111@gmail.com'),
(92,'4ab42298','PTCre_AREMIEOS230GRS_06','Ori_Sil_2','MP e Insumos','MP_Frsefrdeet_MACCRU(SITOSXKIL_63','MACADAMIA CRUDA (SIN TOSTAR) X KILO','kg',6.0000,90000.00,4,'4','2025-09-10','2025-09-10','larevo1111@gmail.com','larevo1111@gmail.com'),
(93,'a9b96256','PTCre_AREMIEOS230GRS_06','Ori_Sil_2','Producto Proceso','PPNiv5_AREMIEOSXKIL_07','AREQUIPE MIEL OS X KILO','Kgs',1.0000,32.85,2,NULL,'2025-09-10','2025-09-10','larevo1111@gmail.com','larevo1111@gmail.com'),
(94,'50e45e56','PTCre_AREMIEOS230GRS_06','Ori_Sil_2','Producto Proceso','PPNiv1_ExtdeVaienMie_51','Extracto de Vainilla en Miel','Kgs',2.0000,74.23,1,NULL,'2025-09-10','2025-09-10','larevo1111@gmail.com','larevo1111@gmail.com'),
(95,'91e197dd','PTCre_AREMIEOS230GRS_06','Ori_Sil_2','Servicio','Mapr_ENVMIE_04','ENVASADO MIEL','Kgs',3.0000,560.00,1,NULL,'2025-09-10','2025-09-10','larevo1111@gmail.com','larevo1111@gmail.com'),
(96,'e6c2bc7b','PTCre_AREMIEOS230GRS_06','Ori_Sil_2','MP e Insumos','MP_Plhofr_JENRAIXKG_29','JENGIBRE RAIZ X KG','kg',3.0000,20000.00,1,'2','2025-09-10','2025-09-10','larevo1111@gmail.com','larevo1111@gmail.com'),
(97,'064527c0','PTCre_AREMIEOS230GRS_06','Ori_Sil_2','Consumible','Limyase_BATDESPOLXUNI_7','BATA DESECHABLE POLIPROPILENO X UNIDAD','Und',8.0000,5090.00,2,NULL,'2025-09-10','2025-09-10','larevo1111@gmail.com','larevo1111@gmail.com');
/*!40000 ALTER TABLE `costos_formulas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_grupos_productos`
--

LOCK TABLES `costos_grupos_productos` WRITE;
/*!40000 ALTER TABLE `costos_grupos_productos` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_grupos_productos` VALUES
(2,'ALMDECACORGTOS_02','Ori_Sil_2','ALMENDRA DE CACAO ORGANICO TOSTADA','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-09-11 12:08:30','ssierra047@gmail.com','larevo1111@gmail.com'),
(3,'AREMIEOS_03','Ori_Sil_2','AREQUIPE MIEL OS','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-09-11 12:08:59','ssierra047@gmail.com','larevo1111@gmail.com'),
(4,'CASDECAC_04','Ori_Sil_2','CASCARILLA DE CACAO','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(5,'CHOOS_05','Ori_Sil_2','CHOCOBEETAL OS','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(6,'Cho100Cac_06','Ori_Sil_2','Chocolate 100% Cacao','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(7,'ChoOS_07','Ori_Sil_2','Chocomiel OS','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(8,'Choosc73%CPM_08','Ori_Sil_2','Chocolate oscuro 73% CPM','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(9,'CredechoArt_09','Ori_Sil_2','Crema de chocolate Artesanal','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(10,'Credemac_10','Ori_Sil_2','Crema de macadamia','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(11,'Credeman_11','Ori_Sil_2','Crema de mani','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(12,'Duldelec_12','Ori_Sil_2','Dulce de leche','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(13,'Vaienmie_13','Ori_Sil_2','Vainilla en miel','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(14,'INFDECACOSCONMENy_14','Ori_Sil_2','INFUSION DE CACAO OS CON MENTA y POLEN','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(15,'MieOSLaTie_15','Ori_Sil_2','Miel OS La Tierrita','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(16,'Nibdecac_16','Ori_Sil_2','Nibs de cacao','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(17,'CAJPOLMIEPROYMIE_17','Ori_Sil_2','CAJA POLEN, MIEL, PROPOLO Y MIELERO','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(18,'Cucmie_18','Ori_Sil_2','Cuchara mielera','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(19,'Mieinf_19','Ori_Sil_2','Miel infusionada','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(20,'MiedelcarOS_20','Ori_Sil_2','Miel del carmen OS','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(21,'MieOSdelcar_21','Ori_Sil_2','Miel OS del carmen','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(22,'Frusec_22','Ori_Sil_2','Frutos secos','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(23,'Pol_23','Ori_Sil_2','Polen','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com'),
(24,'Pro_24','Ori_Sil_2','Propoleo','','','','','','','','',NULL,'2025-05-29 02:43:42','2025-05-29 02:43:42','ssierra047@gmail.com','ssierra047@gmail.com');
/*!40000 ALTER TABLE `costos_grupos_productos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_herramientas`
--

LOCK TABLES `costos_herramientas` WRITE;
/*!40000 ALTER TABLE `costos_herramientas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_herramientas` VALUES
(5,'He_BowMetde32c_05','Ori_Sil_2','Activo','','Bowld Metálico 32cms','AP_Her','','','',36,160,12.0000,'Bueno','0000-00-00','','','NA_20',14.0000,30000.0000,0.0000,0.0000,1,0.0000,0.0000,1.0000,0,0.00,0.00,NULL,'1972-12-15 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'herramientas/Bowld Metálico 32cms//He_BowMetde32c_05.imagen1.191606.jpg','','','','','',NULL,'0000-00-00 00:00:00','2025-12-29 21:11:51','','larevo1111@gmail.com','--ERROR | Unknown column \'costo_unitario_uso_por_maquina\' in \'SELECT\' | 2025-12-29 20:47----Actualizados: 1 | Errores unidad: 0 | 2025-12-29 21:11--'),
(6,'He_EspAltTem16p_06','Ori_Sil_2','Activo','','Espátula Silicona Blanca Alta Temperatura 16pulg.','AP_Her','','','',0,160,NULL,'Bueno','0000-00-00','','','NA_20',0.0000,31933.0000,0.0000,0.0000,1,0.0000,0.0000,1.0000,0,0.00,0.00,NULL,'1969-12-31 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'herramientas/Espátula Silicona Vlanca Alta Temperatura 16pulg.//He_EspAltTem16p_06.imagen1.192750.jpg','','','','','',NULL,'0000-00-00 00:00:00','2025-10-10 14:33:27','','jennifercanogarcia@gmail.com',''),
(7,'He_ESPBLA_07','Ori_Sil_2','Activo','','ESPATULA BLANCA','AP_Her','','','',0,160,NULL,'','0000-00-00','','','NA_20',0.0000,0.0000,0.0000,0.0000,0,0.0000,0.0000,0.0000,0,0.00,0.00,NULL,NULL,NULL,'',0.000000,'',0.000000,'',0.000000,'','','','','','',NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00','','',''),
(8,'Mo_MOLPOLAMAFIG9-12g_08','Ori_Sil_2','Activo','','MOLDE POLICARBONATO AMAZON FIGURAS 9 - 12g X UNIDAD','AP_Mol','','','',0,160,NULL,'','0000-00-00','','','NA_20',0.0000,55000.0000,0.0000,0.0000,0,0.0000,0.0000,19.0000,0,0.00,0.00,NULL,NULL,NULL,'',0.000000,'',0.000000,'',0.000000,'','','','','','',NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00','','',''),
(9,'Mo_MOLPOLAMAFIGVARXUNI_09','Ori_Sil_2','Activo','','MOLDE POLICARBONATO AMAZON FIGURAS VARIAS X UNIDAD','AP_Mol','','','',323,160,NULL,'','0000-00-00','','','cm',0.0000,55000.0000,0.0000,0.0000,0,0.0000,0.0000,4.0000,0,0.00,0.00,NULL,NULL,NULL,'',0.000000,'',0.000000,'',0.000000,'','','','','','',NULL,'0000-00-00 00:00:00','2025-06-18 21:28:33','','larevo1111@gmail.com',''),
(10,'Mo_MOLPOLAMATABCUAXUNI_10','Ori_Sil_2','Activo','','MOLDE POLICARBONATO AMAZON TABLETA CUADRICULA X UNIDAD','AP_Mol','','','',0,160,NULL,'','0000-00-00','','','NA_20',0.0000,15000.0000,0.0000,0.0000,0,0.0000,0.0000,16.0000,0,0.00,0.00,NULL,NULL,NULL,'',0.000000,'',0.000000,'',0.000000,'','','','','','',NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00','','',''),
(11,'Mo_MOLPOLAMATABRAYXUNI_11','Ori_Sil_2','Activo','','MOLDE POLICARBONATO AMAZON TABLETA RAYA X UNIDAD','AP_Mol','','','',0,160,NULL,'','0000-00-00','','','NA_20',0.0000,55000.0000,0.0000,0.0000,0,0.0000,0.0000,1.0000,0,0.00,0.00,NULL,NULL,NULL,'',0.000000,'',0.000000,'',0.000000,'','','','','','',NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00','','',''),
(12,'Mo_MOLPOLFORCAC_12','Ori_Sil_2','Activo','','MOLDE POLICARBONATO FORMA CACAITO','AP_Mol','','','',0,160,NULL,'','0000-00-00','','','NA_20',0.0000,55000.0000,0.0000,0.0000,0,0.0000,0.0000,2.0000,0,0.00,0.00,NULL,NULL,NULL,'',0.000000,'',0.000000,'',0.000000,'','','','','','',NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00','','',''),
(13,'Ma_PISDECALRAN_13','Ori_Sil_2','Activo','','PISTOLA DE CALOR RANGER','AP_Maq','','','',0,160,NULL,'','0000-00-00','','','NA_20',0.0000,100840.0000,0.0000,0.0000,0,0.0000,0.0000,0.0000,0,0.00,0.00,NULL,NULL,NULL,'',0.000000,'',0.000000,'',0.000000,'','','','','','',NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00','','',''),
(14,'Ma_REFCHOPRE_14','Ori_Sil_2','Activo','','REFINADORA CHOCOLATE PREMIER 10LB 1','AP_Maq','','','',48,160,NULL,'Bueno','0000-00-00','','','hora',160.0000,3500000.0000,0.0000,0.0000,0,0.0000,0.0000,1.0000,0,0.00,0.00,NULL,'1973-12-10 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'herramientas/REFINADORA CHOCOLATE PREMIER1//Ma_REFCHOPRE_14.imagen1.192935.jpg','','','','','',NULL,'0000-00-00 00:00:00','2025-10-10 15:07:57','','ssierra047@gmail.com',''),
(15,'He_REJCOC_15','Ori_Sil_2','Activo','','REJILLA COCINA','AP_Her','','','',0,160,100.0000,'','0000-00-00','','','cm3',99.0000,50000.0000,0.0000,0.0000,0,0.0000,0.0000,0.0000,0,0.00,0.00,NULL,NULL,NULL,'',0.000000,'',0.000000,'',0.000000,'','','','','','',NULL,'0000-00-00 00:00:00','2025-06-18 20:50:05','','larevo1111@gmail.com',''),
(16,'He_TAPSIL_16','Ori_Sil_2','Activo','','TAPETE SILICONA','AP_Her','','','',0,160,NULL,'','0000-00-00','','','NA_20',0.0000,0.0000,0.0000,0.0000,0,0.0000,0.0000,0.0000,0,0.00,0.00,NULL,NULL,NULL,'',0.000000,'',0.000000,'',0.000000,'','','','','','',NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00','','',''),
(17,'Ma_TER_17','Ori_Sil_2','Activo','','TERMOMIX','AP_Maq','','','',0,160,NULL,'','0000-00-00','','','hora',0.0000,0.0000,0.0000,0.0000,0,0.0000,0.0000,0.0000,0,0.00,0.00,NULL,'1969-12-31 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'','','','','','',NULL,'0000-00-00 00:00:00','2025-12-30 13:30:57','','larevo1111@gmail.com','--Actualizados: 1 | Errores unidad: 0 | 2025-12-30 12:32----Actualizados: 1 | Errores unidad: 0 | 2025-12-30 13:30--'),
(18,'AP_Seldebolaped_14','Ori_Sil_2','Activo',NULL,'Selladora de bolsas a pedal','AP_Maq',NULL,NULL,NULL,18,160,NULL,'Nuevo',NULL,NULL,'amaragonzalez21valen@gmail.com','segundo',0.0900,237690.0000,NULL,NULL,1,NULL,NULL,NULL,1,50000.00,NULL,'2025-09-23 12:51:00',NULL,NULL,'',0.000000,'',0.000000,'',0.000000,'herramientas/Selladora de bolsas a pedal//AP_Seldebolaped_14.imagen1.175701.jpg','herramientas/Selladora de bolsas a pedal//AP_Seldebolaped_14.imagen2.175931.jpg','','','','',NULL,'2025-09-23 12:40:30','2025-09-23 13:50:42','jennifercanogarcia@gmail.com','larevo1111@gmail.com',''),
(19,'AP_Horpeq2ban_15','Ori_Sil_2','Activo',NULL,'Horno pequeño 2 bandejas','AP_Maq',NULL,NULL,NULL,48,160,NULL,'Bueno',NULL,NULL,NULL,'hora',700.0000,100000.0000,NULL,NULL,1,NULL,NULL,1.0000,1,30000.00,0.00,NULL,'1973-12-10 00:00:00',NULL,'OS.ELEC.RED',0.025000,'',0.000000,'',0.000000,'herramientas/Horno pequeño 2 bandejas//AP_Horpeq2ban_15.imagen1.193149.jpg','','','','','',NULL,'2025-09-23 13:41:53','2026-01-28 17:04:49','larevo1111@gmail.com','larevo1111@gmail.com',''),
(21,'AP_Moldemaiele_16','Ori_Sil_2','Activo',NULL,'Molino de maiz electrico','AP_Maq',NULL,NULL,'1. Nunca meter manos en  zona de molienda mientras esté encendido.\n\n2. Usar siempre empujadores o herramientas para alimentar el grano, nunca la mano.\n\n3. Evitar ropa suelta, cabello sin recoger o accesorios que puedan engancharse.\n\n4. Mantener el área seca y limpia, sin agua cerca del motor ni cables.\n\n5. Desconectar el equipo antes de limpieza o mantenimiento.\n\n6. Revisar cables, enchufe y carcasa antes de usar; no operar con daños eléctricos.\n\n7. Colocar el molino sobre superficie firme y estable.\n\n8. Solo personal autorizado y capacitado debe operarlo.',60,160,NULL,'Bueno',NULL,NULL,NULL,'hora',700.0000,500000.0000,NULL,NULL,1,NULL,NULL,NULL,1,150000.00,0.00,'2025-10-03 00:00:00','2030-09-07 00:00:00',NULL,'OS.ELEC.RED',0.373000,'OS.AGUA.ACUEDUCTO',0.000100,'OS.LENA',0.000010,'herramientas/Molino de maiz electrico//AP_Moldemaiele_16.imagen1.192309.jpg','','','','','',NULL,'2025-10-03 14:38:12','2026-01-29 10:15:58','jennifercanogarcia@gmail.com','larevo1111@gmail.com',''),
(22,'AP_BowMet27c_17','Ori_Sil_2','Activo',NULL,'Bowld Metálico 27cms','AP_Her',NULL,NULL,NULL,36,160,NULL,'Bueno','0001-01-01',NULL,NULL,'NA_20',14.0000,30000.0000,NULL,NULL,1,0.0000,0.0000,1.0000,0,0.00,0.00,NULL,'1972-12-15 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'herramientas/Bowld Metálico 27cms//AP_BowMet27c_17.imagen1.191152.jpg','','','','','',NULL,'2025-10-10 13:56:59','2026-01-02 11:10:41','ssierra047@gmail.com','larevo1111@gmail.com','--Actualizados: 2 | Errores unidad: 0 | 2026-01-02 11:10--'),
(23,'AP_BowMet33c_18','Ori_Sil_2','Activo',NULL,'Bowld Metálico 33cms','AP_Her',NULL,NULL,NULL,36,160,NULL,'Bueno','0001-01-01',NULL,NULL,'NA_20',14.0000,30000.0000,NULL,NULL,1,0.0000,0.0000,2.0000,0,0.00,0.00,NULL,'1972-12-15 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'herramientas/Bowld Metálico 33cms//AP_BowMet33c_18.imagen1.191714.jpg','','','','','',NULL,'2025-10-10 13:59:59','2025-10-10 14:16:58','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com',''),
(24,'AP_BowMet36c_19','Ori_Sil_2','Activo',NULL,'Bowld Metálico 36cms','AP_Her',NULL,NULL,NULL,36,160,NULL,'Bueno','0001-01-01',NULL,NULL,'NA_20',14.0000,30000.0000,NULL,NULL,1,0.0000,0.0000,1.0000,0,0.00,0.00,NULL,'1972-12-15 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'herramientas/Bowld Metálico 36cms//AP_BowMet36c_19.imagen1.191906.jpg','','','','','',NULL,'2025-10-10 14:01:31','2025-10-10 14:18:47','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com',''),
(25,'AP_BowMet38c_20','Ori_Sil_2','Activo',NULL,'Bowld Metálico 38cms','AP_Her',NULL,NULL,NULL,36,160,NULL,'Bueno','0001-01-01',NULL,NULL,'NA_20',14.0000,30000.0000,NULL,NULL,1,0.0000,0.0000,1.0000,0,0.00,0.00,NULL,'1972-12-15 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'herramientas/Bowld Metálico 38cms//AP_BowMet38c_20.imagen1.191823.jpg','','','','','',NULL,'2025-10-10 14:01:57','2025-10-10 14:17:58','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com',''),
(26,'AP_BowMet40c_21','Ori_Sil_2','Activo',NULL,'Bowld Metálico 40cms','AP_Her',NULL,NULL,NULL,36,160,NULL,'Bueno','0001-01-01',NULL,NULL,'NA_20',14.0000,30000.0000,NULL,NULL,1,0.0000,0.0000,1.0000,0,0.00,0.00,NULL,'1972-12-15 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'herramientas/Bowld Metálico 40cms//AP_BowMet40c_21.imagen1.191447.jpg','herramientas/Bowld Metálico 40cms//AP_BowMet40c_21.imagen2.191447.jpg','','','','',NULL,'2025-10-10 14:02:08','2025-10-10 14:14:17','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com',''),
(27,'AP_BowMet21c_22','Ori_Sil_2','Activo',NULL,'Bowld Metálico 21cms','AP_Her',NULL,NULL,NULL,36,160,NULL,'Bueno','0001-01-01',NULL,NULL,'NA_20',14.0000,30000.0000,NULL,NULL,1,0.0000,0.0000,1.0000,0,0.00,0.00,NULL,'1972-12-15 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'herramientas/Bowld Metálico 21cms//AP_BowMet21c_22.imagen1.191029.jpg','','','','','',NULL,'2025-10-10 14:04:47','2025-10-10 14:09:03','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com',''),
(28,'AP_GraMed(ha30kil_23','Ori_Sil_2','Activo',NULL,'Gramera Mediana (hasta 30 kilos)','AP_Her',NULL,NULL,NULL,24,160,NULL,'Bueno',NULL,NULL,NULL,'NA_20',0.0000,150000.0000,NULL,NULL,1,NULL,NULL,2.0000,1,40000.00,0.00,'2025-10-10 00:00:00','2027-09-30 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'','','','','','',NULL,'2025-10-10 14:52:13','2026-01-02 11:56:43','jennifercanogarcia@gmail.com','larevo1111@gmail.com','--Actualizados: 5 | Errores unidad: 0 | 2026-01-02 11:56--'),
(29,'AP_REFCHOPRE10L2_24','Ori_Sil_2','Activo',NULL,'REFINADORA CHOCOLATE PREMIER 10LB 2','AP_Maq',NULL,NULL,NULL,48,160,NULL,'Bueno','0001-01-01',NULL,NULL,'hora',160.0000,3500000.0000,NULL,NULL,0,0.0000,0.0000,1.0000,0,0.00,0.00,NULL,'1973-12-10 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'herramientas/REFINADORA CHOCOLATE PREMIER1//Ma_REFCHOPRE_14.imagen1.192935.jpg','','','','','',NULL,'2025-10-10 15:12:22','2025-10-10 15:12:22','ssierra047@gmail.com','ssierra047@gmail.com',''),
(30,'AP_REFCHOPRE10L3_25','Ori_Sil_2','Activo',NULL,'REFINADORA CHOCOLATE PREMIER 10LB 3','AP_Maq',NULL,NULL,NULL,48,160,NULL,'Bueno','0001-01-01',NULL,NULL,'hora',160.0000,3500000.0000,NULL,NULL,0,0.0000,0.0000,1.0000,0,0.00,0.00,NULL,'1973-12-10 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'herramientas/REFINADORA CHOCOLATE PREMIER1//Ma_REFCHOPRE_14.imagen1.192935.jpg','','','','','',NULL,'2025-10-10 15:12:31','2025-10-10 15:12:33','ssierra047@gmail.com','ssierra047@gmail.com',''),
(31,'AP_EspMet_26','Ori_Sil_2','Activo',NULL,'Espatula Metalica','AP_Her',NULL,NULL,NULL,NULL,160,NULL,'Bueno',NULL,NULL,NULL,'NA_20',0.0000,40000.0000,NULL,NULL,0,NULL,NULL,NULL,0,NULL,0.00,'2025-10-10 00:00:00','2025-10-10 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'herramientas/Espatula Metalica//AP_EspMet_26.imagen1.205638.jpg','','','','','',NULL,'2025-10-10 15:50:20','2026-01-08 17:48:44','jennifercanogarcia@gmail.com','larevo1111@gmail.com',''),
(32,'AP_EMBGRABOCANC_27','Ori_Sil_2','Activo',NULL,'EMBUDO GRANDE BOCA ANCHA','AP_Her',NULL,NULL,NULL,36,160,NULL,'Bueno',NULL,NULL,NULL,'NA_20',0.0000,20000.0000,NULL,NULL,0,NULL,NULL,NULL,0,NULL,0.00,'2025-10-21 00:00:00','2028-10-05 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'','','','','','',NULL,'2025-10-21 17:19:34','2026-01-08 12:32:31','larevo1111@gmail.com','larevo1111@gmail.com','--Actualizados: 3 | Errores unidad: 0 | 2026-01-08 12:31--'),
(33,'AP_PALACRTRA_28','Ori_Sil_2','Activo',NULL,'PALA ACRILICA TRANSPARENTE','AP_Her',NULL,NULL,NULL,NULL,160,NULL,'Bueno',NULL,NULL,NULL,'NA_20',0.0000,30000.0000,NULL,NULL,0,NULL,NULL,NULL,0,NULL,0.00,'2025-10-21 00:00:00','2025-10-21 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'','','','','','',NULL,'2025-10-21 17:20:54','2025-10-21 17:20:54','larevo1111@gmail.com','larevo1111@gmail.com',''),
(34,'AP_EmbDos_29','Ori_Sil_2','Activo',NULL,'Embudo Dosificador','AP_Her',NULL,NULL,NULL,60,160,NULL,'Muy Bueno',NULL,NULL,NULL,'NA_20',0.0000,80000.0000,NULL,NULL,1,1.0000,NULL,1.0000,0,NULL,0.00,'2025-11-07 00:00:00','2030-10-12 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'herramientas/Embudo Dosificador//AP_EmbDos_29.imagen1.225924.jpg','','','','','',NULL,'2025-11-07 17:49:24','2025-11-07 17:49:24','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com',''),
(35,'AP_ConNevPeq_30','Ori_Sil_2','Activo',NULL,'Congelador Nevera Pequeña','AP_Maq',NULL,NULL,NULL,60,160,NULL,'Bueno',NULL,NULL,NULL,'minuto',0.0000,600000.0000,NULL,NULL,0,NULL,NULL,NULL,1,300000.00,0.00,'2025-11-07 00:00:00','2030-10-12 00:00:00','2030-11-07 18:04:58','OS.ELEC.RED',0.001000,'OS.AGUA.ACUEDUCTO',0.000010,'',0.000000,'','','','','','',NULL,'2025-11-07 18:00:15','2026-01-29 10:17:40','jennifercanogarcia@gmail.com','larevo1111@gmail.com',''),
(36,'AP_EstdeGas3Pue_31','Ori_Sil_2','Activo',NULL,'Estufa de Gas 3 Puestos','AP_Maq',NULL,NULL,'Siempre dejar cerrado el cilindro del gas después de usar',60,160,NULL,'Muy Bueno',NULL,NULL,NULL,'minuto',15.0000,500000.0000,NULL,NULL,0,NULL,NULL,NULL,1,300000.00,0.00,'2025-11-07 00:00:00','2030-10-12 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'herramientas/Estufa de Gas 3 Puestos//AP_EstdeGas3Pue_31.imagen1.232350.jpg','','','','','',NULL,'2025-11-07 18:12:05','2025-11-07 18:12:05','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com',''),
(37,'AP_ZondeLav_32','Ori_Sil_2','Activo',NULL,'Zona de Lavado','AP_Maq','Lo que se usa de este lavadero es el agua',NULL,NULL,60,160,NULL,'Muy Bueno',NULL,NULL,NULL,'minuto',28.0000,200000.0000,NULL,NULL,0,NULL,NULL,NULL,0,NULL,0.00,'2025-11-07 00:00:00','2030-10-12 00:00:00',NULL,'',0.000000,'',0.000000,'',0.000000,'','','','','','',NULL,'2025-11-07 18:27:17','2025-11-07 18:27:17','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','');
/*!40000 ALTER TABLE `costos_herramientas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_mp_insumos`
--

LOCK TABLES `costos_mp_insumos` WRITE;
/*!40000 ALTER TABLE `costos_mp_insumos` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_mp_insumos` VALUES
(53,'MP_Proa_MIESANCARCRUxKIL_53','Ori_Sil_2','Activo','','MIEL SAN CARLOS CRUDA x KILO','kg','Materia prima','MP_ProapiMP',16000.0000,16000.0000,16000.0000,1,50.0000,150.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(55,'MP_Gras_CACLTALMKL_55','Ori_Sil_2','Activo','','CACAO LT ALMENDRA KL','kg','Materia prima','MP_Grasemalmdecacetcnat',21000.0000,14999.0000,15000.0000,1,25.0000,35.0000,0.0000,'0000-00-00 00:00:00','2025-10-03 12:30:00','ssierra047@gmail.com','jennifercanogarcia@gmail.com','','','','','','','',''),
(64,'I_Envyt_TAPMETB.5UNI_64','Ori_Sil_2','Activo','','TAPA METALICA B.53 UNICOR','und','Insumo','I_Envytap',325.0000,0.0000,0.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(68,'I_Envyt_TAPMETDORB.3UNI_68','Ori_Sil_2','Activo','','TAPA METALICA DORADA B.38 UNICOR','und','Insumo','I_Envytap',183.0000,0.0000,0.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(77,'I_Envyt_ENVVIDR267230CCB.6_77','Ori_Sil_2','Activo','','ENVASE VIDRIO R 2670, 230 CC B.63 UNICOR','und','Insumo','I_Envytap',806.0000,823.0000,806.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(78,'I_Envyt_TAPMETB.6XUNI_78','Ori_Sil_2','Activo','','TAPA METALICA B.63 X UNIDAD','und','Insumo','I_Envytap',370.0000,332.0000,334.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(85,'I_Envyt_EnvVidR126Fli750B._85','Ori_Sil_2','Activo','','Envase Vidrio R 1264 Flint, 750cc, B. 63 C Tapa UNICOR','und','Insumo','I_Envytap',2205.0000,2044.0000,2205.0000,1,10.0000,15.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(86,'I_Envyt_EnvVidRmb1Fli110B._86','Ori_Sil_2','Activo','','Envase Vidrio R mb110h Flint, 110cc, B. 46 C Tapa UNICOR','und','Insumo','I_Envytap',1000.0000,1073.0000,1080.0000,1,20.0000,30.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(87,'I_Envyt_EnvVidR267Fli230B.6_87','Ori_Sil_2','Activo','','Envase Vidrio R 2670 Flint, 230cc, B.63, C Tapa UNICOR','und','Insumo','I_Envytap',1060.0000,1060.0000,1060.0000,1,20.0000,30.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(88,'I_Envyt_EnvVid126Fli500b.6C_88','Ori_Sil_2','Activo','','Envase Vidrio 1263 Flint, 500cc, b.63, C Tapa UNICOR','und','Insumo','I_Envytap',1555.0000,1493.0000,1479.0000,1,20.0000,30.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(90,'I_Eti_EtiOriSiltap_90','Ori_Sil_2','Activo','','Etiqueta Origen Silvestre tapa','und','Insumo','I_Eti',390.0000,258.0000,200.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(95,'I_Envyt_BOLFLEUPMIN133X170_95','Ori_Sil_2','Activo','','BOLSA FLEX UP MINI 133 X 170 80-160 GRS ALICO','und','Insumo','I_Envytap',315.0000,311.0000,315.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(96,'I_Envyt_BOLFLEUPPEQ133X210_96','Ori_Sil_2','Activo','','BOLSA FLEX UP PEQUE 133 X 210 150-250 GRS ALICO','und','Insumo','I_Envytap',372.0000,330.0000,372.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(97,'I_Envyt_BOLFLEUPMED160X240_97','Ori_Sil_2','Activo','','BOLSA FLEX UP MED 160 X 240 350-450 GRS ALICO','und','Insumo','I_Envytap',490.0000,444.0000,490.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(98,'I_Envyt_BOLFLEUPGRA190X250_98','Ori_Sil_2','Activo','','BOLSA FLEX UP GRANDE 190 X 250 480-650 GRS ALICO','und','Insumo','I_Envytap',591.0000,591.0000,591.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(99,'I_Envyt_BOLFLEUPVENPEQ133X_99','Ori_Sil_2','Activo','','BOLSA FLEX UP VENTANA PEQUE 133 X 210 150-250 GRS ALICO','und','Insumo','I_Envytap',382.0000,265.0000,382.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(100,'I_Envyt_BOLFLEUPVENMED160X_00','Ori_Sil_2','Activo','','BOLSA FLEX UP VENTANA MED 160 X 240 350-450 GRS ALICO','und','Insumo','I_Envytap',487.0000,471.0000,487.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(101,'I_Envyt_BOLTRAVALDOYPAC10X_01','Ori_Sil_2','Activo','','BOLSA TRANSP VALVULA DOY PACK 10 X 18 + FFA 6cms 200 - 300 GRS (ABIERTA) Bolsa transparente con tapa pequeña ALICO','und','Insumo','I_Envytap',344.0000,319.0000,344.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(102,'I_Envyt_BOLTRAVALDOYPAC10X_02','Ori_Sil_2','Activo','','BOLSA TRANSP VALVULA DOY PACK 10 X 18 + FFA 6cms 200 - 300 GRS (CERRADA) Bolsa transparente con tapa pequeña ALICO','und','Insumo','I_Envytap',345.0000,297.0000,345.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(103,'I_Envyt_BOLTRAVALDOYPAC13.X_03','Ori_Sil_2','Activo','','BOLSA TRANSP VALVULA DOY PACK 13.3 X 21 + FFA 7cms 300 - 400 GRS (ABIERTA) Bolsa transparente con tapa mediana ALICO','und','Insumo','I_Envytap',458.0000,447.0000,458.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(104,'I_Envyt_BOLTRAVALDOYPAC13.X_04','Ori_Sil_2','Activo','','BOLSA TRANSP VALVULA DOY PACK 13.3 X 21 + FFA 7cms 300 - 400 GRS (CERRADA) Bolsa transparente con tapa mediana ALICO','und','Insumo','I_Envytap',458.0000,445.0000,458.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(113,'MP_Plah_VAIENVAIUNI_13','Ori_Sil_2','Activo','','VAINILLA EN VAINA UNIDAD','und','Materia prima','MP_Plahorfru',25499.0000,25499.0000,25499.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(116,'MP_Frus_ALMSINTOSKG_16','Ori_Sil_2','Activo','','ALMENDRAS SIN TOSTAR KG','kg','Materia prima','MP_Frusecfrudesetc',20000.0000,37562.0000,42000.0000,1,500.0000,1000.0000,0.0000,'0000-00-00 00:00:00','2025-10-21 20:16:43','ssierra047@gmail.com','larevo1111@gmail.com','','','','','','','',''),
(135,'I_Envyt_ENVVIDR418130CCB.4_35','Ori_Sil_2','Activo','','ENVASE VIDRIO R 4186-2465, 130 CC B.48 C Tapa UNICOR','und','Insumo','I_Envytap',947.0000,947.0000,947.0000,1,10.0000,15.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(138,'I_Envyt_BOLPLAFLETRASINIMP6_38','Ori_Sil_2','Activo','','BOLSA PLANA FLEXIBLE TRANSPARENTE SIN IMPRESION 6 X 20 CM 70 MICRAS - CON VALVULA - PERFORACION','und','Insumo','I_Envytap',271.0000,267.0000,271.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(139,'I_Envyt_BOLDOYPACPETSINIMPTRA_39','Ori_Sil_2','Activo','','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA','und','Insumo','I_Envytap',0.0000,60.0000,243.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(140,'I_Envyt_REC2.0-AB100FLEUP_40','Ori_Sil_2','Activo','','RECIPACK 2.0 - AB 100X180FFA60MM FLEX UP TTE','und','Insumo','I_Envytap',0.0000,235.0000,1.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(141,'I_Envyt_REC2.0133FLEUPTTE_41','Ori_Sil_2','Activo','','RECIPACK 2.0-AB 133X210FFA70MM FLEX UP TTE','und','Insumo','I_Envytap',0.0000,215.0000,431.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(142,'I_Envyt_REC2.0160FLEUPTTE_42','Ori_Sil_2','Activo','','RECIPACK 2.0 160X240FFA80MM FLEX UP TTE','und','Insumo','I_Envytap',0.0000,279.0000,1.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(143,'I_Envyt_BOLFLEUPPETHBACOLMET_43','Ori_Sil_2','Activo','','BOLSA FLEX UP PET/COEXT HBA COLOR METALIZADO CON VENTANA 14 X 22 CM + FFA 8 CM 130 MICRAS CON ZIPPER ALICO','und','Insumo','I_Envytap',476.0000,476.0000,476.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(146,'MP_Proa_POLXKIL_46','Ori_Sil_2','Activo','','POLEN X KILO','kg','Materia prima','MP_ProapiMP',48500.0000,48500.0000,48500.0000,1,4.0000,7.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(167,'MP_Plah_MENSECXKG_67','Ori_Sil_2','Activo','','MENTA SECA X KG','kg','Materia prima','MP_Plahorfru',50.0000,21315.0000,50.0000,1,1000.0000,2000.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(179,'I_Envyt_Empminparmuedechode_79','Ori_Sil_2','Activo','','Empaque mini para muestra de chocolate de mesa','und','Insumo','I_Envytap',1000.0000,1000.0000,1000.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(180,'I_Envyt_TAPMETDORB.4_80','Ori_Sil_2','Activo','','TAPA METALICA DORADA B.48','und','Insumo','I_Envytap',462.0000,462.0000,462.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(183,'MP_SalA_AzudeCocOrgxkg_83','Ori_Sil_2','Activo','','Azucar de Coco Organica x kg','kg','Materia prima','MP_SalAzubicharetc',75000.0000,63309.0000,60504.0000,1,5.0000,7.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(193,'MP_Acey_MANDECACXKG_93','Ori_Sil_2','Activo','','MANTECA DE CACAO X KG','kg','Materia prima','MP_Aceyotrsim',45400.0000,68533.0000,45.0000,1,2.0000,5.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(195,'MP_Frus_MARSINTOSxKG_95','Ori_Sil_2','Activo','','MARAÑON SIN TOSTAR x KG','kg','Materia prima','MP_Frusecfrudesetc',0.0000,53350.0000,53700.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(208,'I_Envyt_EnvVidRmb1Fli110B._08','Ori_Sil_2','Activo','','Envase Vidrio R mb110h Flint, 110cc, B. 46 UNICOR','und','Insumo','I_Envytap',1020.0000,816.0000,812.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(212,'MP_SalA_Bicxgra_12','Ori_Sil_2','Activo','','Bicarbonato x gramo','g','Materia prima','MP_SalAzubicharetc',15.0000,0.0000,15.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','2026-01-01 13:40:27','ssierra047@gmail.com','larevo1111@gmail.com','','','','','','','','--Actualizados: 1 | Errores unidad: 0 | 2026-01-01 13:40--'),
(213,'MP_SalA_SalComxGra_13','Ori_Sil_2','Activo','','Sal Común x Gramo','g','Materia prima','MP_SalAzubicharetc',2.0000,0.0000,2.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(229,'MP_Plah_JENRAIXKG_29','Ori_Sil_2','Activo','','JENGIBRE RAIZ X KG','kg','Materia prima','MP_Plahorfru',20000.0000,20835.0000,20000.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(232,'I_Envyt_EnvVidMB5Fli50cB.46_32','Ori_Sil_2','Activo','','Envase Vidrio MB50H Flint, 50cc, B. 46 C Tapa UNICOR','und','Insumo','I_Envytap',827.0000,842.0000,827.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(233,'I_Envyt_EnvVidMB3Fli30cB.41_33','Ori_Sil_2','Activo','','Envase Vidrio MB30R Flint, 30cc, B. 41 C Tapa UNICOR','und','Insumo','I_Envytap',784.0000,784.0000,784.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(244,'MP_SalA_PANPULXKG_44','Ori_Sil_2','Activo','','PANELA PULVERIZADA X KG','kg','Materia prima','MP_SalAzubicharetc',8700.0000,7.0000,7.0000,1,2.0000,4.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(252,'I_Envyt_BOLPLAFLE25Xconval_52','Ori_Sil_2','Activo','','BOLSA PLANA FLEXIBLE 25X35cms con valvula','und','Insumo','I_Envytap',776.0000,774.0000,776.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(253,'I_Envyt_BOLFLEUP16X26CON_53','Ori_Sil_2','Activo','','BOLSA FLEX UP 16 X 26 CON VALVULA','und','Insumo','I_Envytap',693.0000,589.0000,693.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(254,'I_Envyt_BOLPLAFLEX20CMCON_54','Ori_Sil_2','Activo','','BOLSA PLANA FLEXIBLE15 X 20 CM CON VALVULA','und','Insumo','I_Envytap',302.0000,272.0000,302.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(262,'I_Eti_ETIMIE640XUNI_62','Ori_Sil_2','Activo','','ETIQUETA MIEL 640 X UNIDAD','und','Insumo','I_Eti',300.0000,325.0000,300.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(263,'I_Eti_ETIMIE100XUNI_63','Ori_Sil_2','Activo','','ETIQUETA MIEL 1000 X UNIDAD','und','Insumo','I_Eti',300.0000,368.0000,300.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(264,'I_Eti_ETICREDEMAN500XUNI_64','Ori_Sil_2','Activo','','ETIQUETA CREMA DE MANÍ 500 X UNIDAD','und','Insumo','I_Eti',300.0000,271.0000,300.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(283,'I_Eti_EtichoBom250Delxuni_83','Ori_Sil_2','Activo','','Etiquetas chocolate Bombon 250g Delantera x unidad','und','Insumo','I_Eti',1250.0000,1085.0000,1084.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(284,'I_Eti_EtiInf200Delxuni_84','Ori_Sil_2','Activo','','Etiquetas Infusión 200g Delantera x unidad','und','Insumo','I_Eti',1250.0000,2168.0000,2500.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(289,'I_Eti_EtiNibdecac200delx_89','Ori_Sil_2','Activo','','Etiqueta Nibs de cacao 200g delantera x unidad','und','Insumo','I_Eti',800.0000,1010.0000,750.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(290,'I_Eti_EtiMie150_90','Ori_Sil_2','Activo','','Etiqueta Miel 150','und','Insumo','I_Eti',300.0000,299.0000,300.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(291,'I_Eti_EtiMie275_91','Ori_Sil_2','Activo','','Etiqueta Miel 275','und','Insumo','I_Eti',300.0000,300.0000,300.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(295,'I_Eti_EtiPol80_95','Ori_Sil_2','Activo','','Etiqueta Polen 80','und','Insumo','I_Eti',300.0000,300.0000,300.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(296,'I_Eti_EtiPol150_96','Ori_Sil_2','Activo','','Etiqueta Polen 150','und','Insumo','I_Eti',300.0000,305.0000,300.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(297,'I_Eti_EtiPol320_97','Ori_Sil_2','Activo','','Etiqueta Polen 320','und','Insumo','I_Eti',300.0000,300.0000,300.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(298,'I_Eti_EtiPro150_98','Ori_Sil_2','Activo','','Etiqueta Propóleo 150','und','Insumo','I_Eti',300.0000,300.0000,300.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(299,'I_Eti_EtiPro265_99','Ori_Sil_2','Activo','','Etiqueta Propóleo 265','und','Insumo','I_Eti',300.0000,300.0000,300.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(300,'I_Eti_EtiPro600_00','Ori_Sil_2','Activo','','Etiqueta Propóleo 600','und','Insumo','I_Eti',300.0000,267.0000,300.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(301,'I_Eti_EtiCredeMan130_01','Ori_Sil_2','Activo','','Etiqueta Crema de Maní 130','und','Insumo','I_Eti',300.0000,271.0000,300.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(302,'I_Eti_EtiCredeMan230_02','Ori_Sil_2','Activo','','Etiqueta Crema de Maní 230','und','Insumo','I_Eti',300.0000,271.0000,300.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(310,'I_Eti_EtiAlmdeCac200delx_10','Ori_Sil_2','Activo','','Etiqueta Almendra de Cacao 200g delantera x unidad','und','Insumo','I_Eti',1350.0000,1715.0000,1350.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(311,'I_Eti_ETIMIXFRUSEC200DELX_11','Ori_Sil_2','Activo','','ETIQUETA MIX FRUTOS SECOS 200G DELANTERA X UNIDAD','und','Insumo','I_Eti',1350.0000,1341.0000,1350.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(312,'I_Eti_EtiCho500BomDelxuni_12','Ori_Sil_2','Activo','','Etiquetas Chocolate 500g Bombon Delantera x unidad','und','Insumo','I_Eti',1125.0000,2192.0000,2250.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(327,'MP_SalA_PANDEABEXKIL_27','Ori_Sil_2','Activo','','PANAL DE ABEJAS X KILO','kg','Materia prima','MP_SalAzubicharetc',17000.0000,17000.0000,17000.0000,1,2.0000,6.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(329,'I_Eti_ETIMIXFRUSEC100DELX_29','Ori_Sil_2','Activo','','ETIQUETA MIX FRUTOS SECOS 100G DELANTERA X UNIDAD','und','Insumo','I_Eti',410.0000,691.0000,410.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(330,'I_Eti_ETIALMDECAC100DELX_30','Ori_Sil_2','Activo','','ETIQUETA ALMENDRA DE CACAO 100G DELANTERA X UNIDAD','und','Insumo','I_Eti',410.0000,1328.0000,410.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(331,'I_Eti_ETINIBDECAC100delx_31','Ori_Sil_2','Activo','','ETIQUETA NIBS DE CACAO 100G delantera x unidad','und','Insumo','I_Eti',410.0000,465.0000,409.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(332,'I_Envyt_BOLDOYPACPETTRASINIMP_32','Ori_Sil_2','Activo','','BOLSA DOY PACK PET/FLEXIBLE TRANSP. SIN IMP. 10x18 zipper (alt.recipack)','und','Insumo','I_Envytap',248.0000,246.0000,248.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(333,'I_Envyt_BOLPLAFLESINIMPTRA32X_33','Ori_Sil_2','Activo','','BOLSA PLANA FLEXIBLE SIN IMPRESION TRANSPARENTE 32X42 EMPAQUE MAT. PRIMA','und','Insumo','I_Envytap',465.0000,465.0000,465.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(337,'I_Envyt_ENVMB5FLI50CB.4DEGRED_37','Ori_Sil_2','Activo','','ENVASE MB50R FLINT 50CCTO B.45 DEGUSTACION REDONDO','und','Insumo','I_Envytap',915.0000,915.0000,915.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(338,'I_Envyt_BOLPLAPETMET/FLESIN_38','Ori_Sil_2','Activo','','BOLSA PLANA PET METALIZADA / FLEXIBLE SIN IMPRESION 16X22 EMPAQUE COBERTURA','und','Insumo','I_Envytap',318.0000,254.0000,254.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(341,'I_Envyt_BOLPLAPETMETFEL16X_41','Ori_Sil_2','Activo','','BOLSA PLANA PET METALIZADA FELXIBLE 16X28CM','und','Insumo','I_Envytap',405.0000,396.0000,396.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(342,'MP_Proa_MIEOSCARXKIL_42','Ori_Sil_2','Activo','','MIEL OS CARMEN X KILO','kg','Materia prima','MP_ProapiMP',15000.0000,15001.0000,15000.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(343,'I_Eti_ETICHO250_43','Ori_Sil_2','Activo','','ETIQUETA CHOCOMIEL 250','und','Insumo','I_Eti',150.0000,150.0000,150.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(344,'I_Eti_ETICHO135_44','Ori_Sil_2','Activo','','ETIQUETA CHOCOMIEL 135','und','Insumo','I_Eti',150.0000,150.0000,150.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(351,'I_Eti_ETIMIEOSCARCRI150_51','Ori_Sil_2','Activo','','ETIQUETA MIEL OS CARMEN CRISTALIZADA 150G','und','Insumo','I_Eti',150.0000,290.0000,150.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(352,'I_Eti_ETIMIEOSCARCRI275_52','Ori_Sil_2','Activo','','ETIQUETA MIEL OS CARMEN CRISTALIZADA 275G','und','Insumo','I_Eti',150.0000,272.0000,150.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(353,'I_Eti_ETIMIEOSCARCRI640_53','Ori_Sil_2','Activo','','ETIQUETA MIEL OS CARMEN CRISTALIZADA 640G','und','Insumo','I_Eti',150.0000,260.0000,150.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(354,'I_Eti_ETIMIEOSCARCRI100_54','Ori_Sil_2','Activo','','ETIQUETA MIEL OS CARMEN CRISTALIZADA 1000G','und','Insumo','I_Eti',150.0000,317.0000,150.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(363,'MP_Frus_MACCRU(SITOSXKIL_63','Ori_Sil_2','Activo','','MACADAMIA CRUDA (SIN TOSTAR) X KILO','kg','Materia prima','MP_Frusecfrudesetc',90000.0000,62000.0000,62000.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(374,'I_Envyt_BOLGRAFOR13KEMPMATPRI_74','Ori_Sil_2','Activo','','BOLSA GRAN FORMATO 13KG EMPAQUE MAT. PRIMA','und','Insumo','I_Envytap',2566.0000,2566.0000,2566.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(376,'I_Eti_EtiCho500graDelxuni_76','Ori_Sil_2','Activo','','Etiquetas Chocolate 500g granulado Delantera x unidad','und','Insumo','I_Eti',1125.0000,1825.0000,2250.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(377,'I_Eti_Eticho250graDelxuni_77','Ori_Sil_2','Activo','','Etiquetas chocolate 250g granulado Delantera x unidad','und','Insumo','I_Eti',1250.0000,1521.0000,1250.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(379,'MP_Plah_AJItabxKG_79','Ori_Sil_2','Activo','','AJI tabasco x KG','kg','Materia prima','MP_Plahorfru',50000.0000,5037.0000,50.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(380,'MP_Plah_EUCENRAMVERXKG_80','Ori_Sil_2','Activo','','EUCALIPTO EN RAMA VERDE X KG','kg','Materia prima','MP_Plahorfru',20000.0000,13661.0000,20.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(399,'I_Eti_ETICHO90g_99','Ori_Sil_2','Activo','','ETIQUETA CHOCOBEETAL 90g','und','Insumo','I_Eti',150.0000,185.0000,150.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(400,'I_Eti_ETICHO130_00','Ori_Sil_2','Activo','','ETIQUETA CHOCOBEETAL 130g','und','Insumo','I_Eti',150.0000,184.0000,150.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(401,'I_Eti_ETICHO200_01','Ori_Sil_2','Activo','','ETIQUETA CHOCOBEETAL 200g','und','Insumo','I_Eti',150.0000,197.0000,350.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(402,'I_Eti_ETICREDEMACCONNIBDE_02','Ori_Sil_2','Activo','','ETIQUETA CREMA DE MACADAMIA CON NIBS DE CACAO 60g','und','Insumo','I_Eti',150.0000,217.0000,150.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(403,'I_Eti_ETICREDEMACCONNIBDE_03','Ori_Sil_2','Activo','','ETIQUETA CREMA DE MACADAMIA CON NIBS DE CACAO 110g','und','Insumo','I_Eti',150.0000,202.0000,150.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(404,'I_Eti_ETICREDEMACCONNIBDE_04','Ori_Sil_2','Activo','','ETIQUETA CREMA DE MACADAMIA CON NIBS DE CACAO 200g','und','Insumo','I_Eti',150.0000,195.0000,150.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(412,'I_Caj_CAJCHOOSC73PXUND_12','Ori_Sil_2','Activo','','CAJA CHOCOLATE OSCURO 73Pgm X UND','und','Insumo','I_Caj',1000.0000,1000.0000,1000.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(414,'I_Envyt_BOLPLACOB3x6XUND_14','Ori_Sil_2','Activo','','BOLSA PLASTICA COBERTURA 3x6\" X UND','und','Insumo','I_Envytap',5.0000,7.0000,5.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(490,'I_Eti_EtiInf400Delxuni_90','Ori_Sil_2','Activo','','Etiquetas Infusion 400g Delantera x unidad','und','Insumo','I_Eti',1125.0000,1751.0000,2250.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(491,'I_Eti_ETIMIEOS500PLA_91','Ori_Sil_2','Activo','','ETIQUETA MIEL OS 500G PLAST.','und','Insumo','I_Eti',150.0000,150.0000,150.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(492,'I_Eti_ETIMIEOS265PLA_92','Ori_Sil_2','Activo','','ETIQUETA MIEL OS 265G PLAST.','und','Insumo','I_Eti',150.0000,150.0000,150.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(500,'MP_SalA_SALMARGRAFINSINREFX_00','Ori_Sil_2','Activo','','SAL MARINA GRANO FINO SIN REFINAR X GRAMO','g','Materia prima','MP_SalAzubicharetc',8.9000,8.9000,8.9000,1,1.0000,1.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(501,'I_Eti_ETIMAR100DELXUNI_01','Ori_Sil_2','Activo','','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD','und','Insumo','I_Eti',1000.0000,1000.0000,1000.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(502,'I_Eti_ETIMAR200DELXUNI_02','Ori_Sil_2','Activo','','ETIQUETA MARAÑON 200G DELANTERA X UNIDAD','und','Insumo','I_Eti',1500.0000,1500.0000,1500.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(503,'I_Eti_ETIMAC100DELXUNI_03','Ori_Sil_2','Activo','','ETIQUETA MACADAMIA 100G DELANTERA X UNIDAD','und','Insumo','I_Eti',818.0000,818.0000,818.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(504,'I_Eti_ETIMAC200DELXUNI_04','Ori_Sil_2','Activo','','ETIQUETA MACADAMIA 200G DELANTERA X UNIDAD','und','Insumo','I_Eti',1500.0000,1500.0000,1500.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(505,'I_Eti_ETIALM100XUNI_05','Ori_Sil_2','Activo','','ETIQUETA ALMENDRA 100G X UNIDAD','und','Insumo','I_Eti',818.0000,818.0000,818.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(506,'I_Eti_ETIALM200XUNI_06','Ori_Sil_2','Activo','','ETIQUETA ALMENDRA 200G X UNIDAD','und','Insumo','I_Eti',1500.0000,1500.0000,1500.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(507,'I_Eti_ETIPREXHOJ_07','Ori_Sil_2','Activo','','ETIQUETA PRECIOS X HOJA','und','Insumo','I_Eti',6500.0000,6500.0000,6500.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(518,'cat_Nom_18','EMPRESA','Activo','COD. BARRAS','Nombre','UNIDAD','tipo','cat',0.0000,0.0000,0.0000,0,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','usuario creador','usuario ult mod','img 1','img 2','img 3','arch 1','arch 2','arch 3','observaciones',''),
(523,'I_Eti_EtiInf400Traxuni_23','Ori_Sil_2','Activo','','Etiquetas Infusion 400g Trasera x unidad','und','Insumo','I_Eti',1125.0000,1125.0000,1125.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(524,'I_Eti_EtiInf200Traxuni_24','Ori_Sil_2','Activo','','Etiquetas Infusión 200g Trasera x unidad','und','Insumo','I_Eti',1250.0000,1250.0000,1250.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(525,'I_Eti_EtiCho500BomTraxuni_25','Ori_Sil_2','Activo','','Etiquetas Chocolate 500g Bombon Trasera x unidad','und','Insumo','I_Eti',1125.0000,1125.0000,1125.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(526,'I_Eti_EtiChogra500Traxuni_26','Ori_Sil_2','Activo','','Etiquetas Chocolate granulado 500g Trasera x unidad','und','Insumo','I_Eti',1125.0000,1023.0000,1125.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(527,'I_Eti_Eticho250graTraxuni_27','Ori_Sil_2','Activo','','Etiquetas chocolate 250g granulado Trasera x unidad','und','Insumo','I_Eti',1250.0000,1012.0000,1250.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(528,'I_Eti_EtichoBom250Traxuni_28','Ori_Sil_2','Activo','','Etiquetas chocolate Bombon 250g Trasera x unidad','und','Insumo','I_Eti',1250.0000,1250.0000,1250.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(529,'I_Eti_EtiNibdecac200trax_29','Ori_Sil_2','Activo','','Etiqueta Nibs de cacao 200g trasera x unidad','und','Insumo','I_Eti',800.0000,655.0000,800.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(530,'I_Eti_ETINIBDECAC100trax_30','Ori_Sil_2','Activo','','ETIQUETA NIBS DE CACAO 100G trasera x unidad','und','Insumo','I_Eti',410.0000,409.0000,410.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(531,'I_Eti_Etitabtorcacorgxuni_31','Ori_Sil_2','Activo','','Etiqueta tableta tornasol cacao organico x unidad','und','Insumo','I_Eti',22.0000,21.0000,21.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(532,'I_Eti_Etitabtor100natxuni_32','Ori_Sil_2','Activo','','Etiqueta tableta tornasol 100p natural x unidad','und','Insumo','I_Eti',22.0000,21.0000,21.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(533,'I_Eti_Etitabtorsolchoxuni_33','Ori_Sil_2','Activo','','Etiqueta tableta tornasol solo chocolate x unidad','und','Insumo','I_Eti',19.0000,19.0000,19.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(534,'I_Eti_Etitabtorconmacxuni_34','Ori_Sil_2','Activo','','Etiqueta tableta tornasol con macadamia x unidad','und','Insumo','I_Eti',19.0000,0.0000,0.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(535,'I_Eti_Etitabtorconmanxuni_35','Ori_Sil_2','Activo','','Etiqueta tableta tornasol con mani x unidad','und','Insumo','I_Eti',19.0000,19.0000,19.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(536,'I_Eti_Etitabtorconalmxuni_36','Ori_Sil_2','Activo','','Etiqueta tableta tornasol con almendra x unidad','und','Insumo','I_Eti',19.0000,19.0000,19.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(537,'I_Eti_Etitabtorconnibdecac_37','Ori_Sil_2','Activo','','Etiqueta tableta tornasol con nibs de cacao x unidad','und','Insumo','I_Eti',19.0000,19.0000,19.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(538,'I_Eti_Etitabtorconsalmarx_38','Ori_Sil_2','Activo','','Etiqueta tableta tornasol con sal marina x unidad','und','Insumo','I_Eti',19.0000,19.0000,19.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(539,'I_Eti_ETIALMDECAC100TRAX_39','Ori_Sil_2','Activo','','ETIQUETA ALMENDRA DE CACAO 100G TRASERA X UNIDAD','und','Insumo','I_Eti',410.0000,410.0000,410.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(540,'I_Eti_ETIMIXFRUSEC200TRAX_40','Ori_Sil_2','Activo','','ETIQUETA MIX FRUTOS SECOS 200G TRASERA X UNIDAD','und','Insumo','I_Eti',1350.0000,410.0000,410.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(541,'I_Eti_ETIMIXFRUSEC100TRAX_41','Ori_Sil_2','Activo','','ETIQUETA MIX FRUTOS SECOS 100G TRASERA X UNIDAD','und','Insumo','I_Eti',410.0000,410.0000,410.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(542,'I_Eti_ETIMAC100TRAXUNI_42','Ori_Sil_2','Activo','','ETIQUETA MACADAMIA 100G TRASERA X UNIDAD','und','Insumo','I_Eti',818.0000,0.0000,0.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(543,'I_Eti_ETIMAC200TRAXUNI_43','Ori_Sil_2','Activo','','ETIQUETA MACADAMIA 200G TRASERA X UNIDAD','und','Insumo','I_Eti',1500.0000,410.0000,410.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(544,'I_Eti_ETIMAR100TRAXUNI_44','Ori_Sil_2','Activo','','ETIQUETA MARAÑON 100G TRASERA X UNIDAD','und','Insumo','I_Eti',1000.0000,0.0000,0.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(545,'I_Eti_ETIMAR200TRAXUNI_45','Ori_Sil_2','Activo','','ETIQUETA MARAÑON 200G TRASERA X UNIDAD','und','Insumo','I_Eti',1500.0000,410.0000,410.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','',''),
(549,'I_Eti_EtiAlmdeCac200trax_49','Ori_Sil_2','Activo','','Etiqueta Almendra de Cacao 200g trasera x unidad','und','Insumo','I_Eti',1350.0000,410.0000,410.0000,1,0.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com','','','','','','','','');
/*!40000 ALTER TABLE `costos_mp_insumos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_procedimientos`
--

LOCK TABLES `costos_procedimientos` WRITE;
/*!40000 ALTER TABLE `costos_procedimientos` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_procedimientos` VALUES
(6,'PRO_Tosalmdecac_10','Ori_Sil_2','1','PROD','Tostion almendras de cacao','Aprobado',NULL,'CacyCho_d0','SIN COSTO CONJUNTO','- Precalentar siempre el horno antes de ingresar el cacao.\n- No sobrepasar los 170g rados centigrados.\n- Tiempo maximo 25 minutos\n- Cortar el calentamiento, es decir sacar del horno apenas se cumpla el tiempo\n- Distribuir las almendras en una sola capa, sin amontonarlas.\n- Revolver/intercambiar bandejas a mitad del proceso para lograr un tostado parejo.\n- Dejar reposar antes de empacar para estabilizar aroma y humedad.','- Precalentar el horno de convección a 150 °C.\n- Extender las almendras de cacao en bandejas (máx. 500 g por bandeja).\n- Tostar a 150–160 °C durante 20–25 minutos.\n- A los 10 min: revolver.\n- A los 15 min: intercambiar bandejas (arriba ↔ abajo).\n- Continuar hasta completar el tiempo.\n- Reposar las almendras 10 minutos a temperatura ambiente.\n- Empacar en bolsas herméticas (ziploc o válvula).',0.0000,'kg',1.0000,1.0000,1.0000,'','',20000.0000,0.0000,413.0000,3300.0000,0.0000,23713.0000,'larevo1111@gmail.com','larevo1111@gmail.com','2025-09-23 13:12:54','2025-09-23 13:24:31','son 500 gramos por bandeja, el horno tiene 2 bandejas','',NULL),
(7,'PRO_EmpAlmdecactos100_30','Ori_Sil_2','1','PROD','Empaque Almendra de cacao tostada 100g','Aprobado',NULL,'CacyCho_d0','SIN COSTO CONJUNTO',NULL,'1. Pegar etiqueta\n2. Poner lote y fecha en el lugar indicado, etiqueta trasera parte inferior, en la bolsa, no en la etiqueta. OJO: IDENTIFICAR LA VENTANA, LA CUAL ES LA PARTE DELANTERA, PARA NO PONER LAS ETIQUETAS AL REVES.\n3. Empacar las almendras con el embudo, ubicando la bolsa en la bascula.\n4. Sellar la bolsa..',0.0000,'und',12.0000,12.0000,15.0000,'','',248.0000,2370.6000,0.7089,1000.0000,0.0000,3619.3089,'ssierra047@gmail.com','larevo1111@gmail.com','2025-09-25 17:04:52','2025-12-05 15:24:22',NULL,'',NULL),
(8,'PRO_MaqTosyDesdeCac_bc','Ori_Sil_2','1','PROD','Maquila Tostion y Descascarillado de Cacao','Aprobado',NULL,'CacyCho_d0','NVR (VALOR NETO REALIZABLE)','El proveedor actual es arbol de cacao\nSe deben enviar minimo 50 kilos de almendra de cacao','1. Empacar las almendras de cacao en costales de maximo 50kilos cada uno\n2. Sellar completamente cada costal con vinipel.\n3. Poner la etiqueta de despacho con cinta  gestionar la llevada a la transportadora ( normalmente se hace con envia colvanes y cuesta 1.100 pesos por kilo el envío)\n4. El maquilador, se demora aprox 10 dias procesando, y normalmente envía los nibs y la cascarilla por Veloenvios, se recoge en la sede de Veloenvios de itagui. asegurarse de que el maquilar envie el producto bien sellado, ya sea con vinipel o bolsa plastica.\n5. Se reciben aproximadamente 70% de nibs de cacao y 30% de cascarilla y un desperdicio entre un 2 y 5%.',0.0000,'kg',50.0000,70.0000,NULL,'','',21000.0000,0.0000,0.0000,8145.0000,282.0000,29427.0000,'jennifercanogarcia@gmail.com','ssierra047@gmail.com','2025-10-03 12:18:16','2026-01-04 15:26:29','contacto Arbol de Cacao, Alexaner, 3183637209','',NULL),
(9,'PRO_Refdenib24hor_5a','Ori_Sil_2','1','PROD','Refinado de nibs 24 horas','Aprobado',NULL,'CacyCho_d0','SIN COSTO CONJUNTO',NULL,' 1. Alistamiento\n\nRevisar que las refinadoras estén limpias, secas y en buen estado.\nAlistar bowls, espátulas, moldes y gramera.\n\n⚖️ 2. Pesaje\n\nPesar 4 kg de nibs por refinadora a usar.\n\n 3. Pre-molienda (Molino de maíz eléctrico)\n\n⚠️ ADVERTENCIA:\n Por ningún motivo meter la mano en la tolva. Tener cuidado.\n✅ Siempre agregar los ingredientes con dosificadora.\n\nSi el molino se frena:\n\nApagarlo.\n\nAflojar la mariposa frontal para darle más espacio al paso de los nibs.\n\nSi persiste, vaciar y volver a pasar.\n\n Pasar las tandas lentamente, sin llenar la tolva al inicio para no forzar el molino.\nUna vez avance el proceso, se puede aumentar la cantidad agregada.\nPasar dos veces por el molino.\n\n Tip: En la segunda pasada, ayudar con la espátula metálica empujando los nibs, ya que al volverse pasta les cuesta más pasar.\n\n 4. Carga a refinadora\n\n Antes de comenzar a refinar, aflojar la tuerca central para evitar que se frene.\nCuando ya esté cargada la refinadora con los 4 kg y funcione correctamente, se puede apretar la tuerca.\n\nA medida que va saliendo la pasta del molino en la segunda pasada, se va agregando directamente a la refinadora.\nEmpezar con presión mínima y aumentar gradualmente, vigilando que la máquina no se fuerce.\n\n⏱️ 5. Refinado\n\nDejar 24 horas continuas de refinación.\n\n 6. Bajado del chocolate\n\nApagar la refinadora.\n\nMedir la temperatura y registrarla en la bitácora.\n\nPresionar el botón al lado izquierdo de la refinadora para poder girar el tambor.\n\nColocar el recipiente donde se va a bajar el chocolate en una mesa más baja que la refinadora.\n\nDescargar suavemente para evitar regueros.\n\nLimpiar bien las paredes y piedras con espátula de silicona para aprovechar el producto restante.\n\n Alistar los recipientes o moldes limpios y secos.\n\n Nota\n\nPara bloques de chocolate, se puede enmoldar directamente en bandejas.\n\nPara enmoldado de bombones, descargar primero en bowl.\n\nSi se va a continuar con cobertura, retirar la cantidad correspondiente (2.380 g) y dejar el excedente.\n(La diferencia entre 4.000 g y 2.380 g será el chocolate restante).\n\n⚠️ Puntos Críticos\n\n La pre-molienda debe quedar en pasta, no con granos sueltos.\n⚙️ La alimentación de la refinadora debe hacerse sin forzarla.\n️ Antes de desmontar, tomar y registrar la temperatura.\nSi supera los 45 °C, registrar como dificultad y dejar en observación.\n Respetar las 24 horas completas de refinado.',0.0000,'kg',4.0000,8.0000,12.0000,'','',0.0000,32598.7725,2322.6078,10800.0000,51.7500,45773.1303,'jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-10-03 13:08:03','2025-10-10 15:52:44',NULL,'',NULL),
(10,'PRO_EmpAlmdecactos200_93','Ori_Sil_2','1','PROD','Empaque Almendra de cacao tostada 200g','Aprobado',NULL,'CacyCho_d0','SIN COSTO CONJUNTO',NULL,'1. Pegar etiqueta\n2. Poner lote y fecha en el lugar indicado, etiqueta trasera parte inferior, en la bolsa, no en la etiqueta. OJO: IDENTIFICAR LA VENTANA, LA CUAL ES LA PARTE DELANTERA, PARA NO PONER LAS ETIQUETAS AL REVES.\n3. Empacar las almendras con el embudo, ubicando la bolsa en la bascula.\n4. Sellar la bolsa.',0.0000,'und',12.0000,12.0000,15.0000,'','',476.0000,4742.6000,0.7089,1000.0000,0.0000,6219.3089,'larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 16:51:33','2026-01-08 12:28:34',NULL,'--Actualizados: 2 | Errores unidad: 1 | 2026-01-08 12:28--ERROR_UNIDAD | PP | MAESTRA=kg | PROC=cm2 | 2026-01-08 12:28##',NULL),
(11,'PRO_Enmbom_3a','Ori_Sil_2','1','PROD','Enmoldado bombones','Aprobado',NULL,'CacyCho_d0','SIN COSTO CONJUNTO',NULL,'1️⃣  Alistamiento de Moldes\n\nAsegurarse de que los moldes estén limpios, secos y sin residuos grasos.\n\nLimpiar con paño de microfibra.\n\nDisponer los moldes juntos sobre una mesa grande.\n\n2️⃣  Fundido del Chocolate\n\nSi el chocolate está en la refinadora, verter en un bowl grande.\n\nSi el chocolate está en bloque, fundir previamente a unos 40 °C.\n\nSe recomienda tener baño maría listo, por si se empieza a espesar o empastar.\n\n3️⃣  Vertido y Distribución en Moldes\n\nVerter el licor de cacao caliente en el embudo metálico dosificador (capacidad de 1 kg).\n\nUsar espátula metálica para esparcir el chocolate en los moldes.\n\nVaciar los excesos nuevamente al bowl grande.\n\n4️⃣  Vibrado\n\nRealizar vibrado inmediato para retirar burbujas de aire.\n\n5️⃣ ️ Solidificación\n\nDejar reposar los moldes al aire libre hasta que el chocolate solidifique.\n\n6️⃣ ❄️ Desmoldado\n\nAntes de desmoldar, colocar los moldes en el congelador durante 10 minutos para facilitar el proceso.\n\nRealizar movimientos suaves de torsión del molde.\n\nVoltear sobre un tapete de silicona y dar golpes suaves pero secos en las uniones del molde.\n\n7️⃣  Recolección para Empaque\n\nRecolectar el chocolate en un recipiente seco, listo para su empaque.',447.4500,'kg',4.0000,4.0000,4.0000,'','',0.0000,45773.1303,216.4588,4575.0000,51.7500,50616.3391,'larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 17:36:58','2026-01-09 17:00:44',NULL,'--Actualizados: 4 | Errores unidad: 0 | 2026-01-09 17:00--',NULL),
(12,'PRO_BORENS_9c','Ori_Sil_2','1','PROD','BORRAR ENSAYO','Aprobado','PRO_EnsProOps1_74',NULL,'SIN COSTO CONJUNTO',NULL,NULL,90.0000,'dia',NULL,NULL,NULL,'','',20000.0000,32598.7725,14929.5431,18300.0000,5888936.6000,5974764.9156,'larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 20:11:21','2026-01-08 18:36:38',NULL,'--Actualizados: 7 | Errores unidad: 0 | 2026-01-08 18:36--',NULL),
(13,'PRO_ENSNIBPRO_44','Ori_Sil_2','1','PROD','ENSA NIBS PROC','Aprobado','PRO_EnsProOps1_74',NULL,'NVR (VALOR NETO REALIZABLE)',NULL,NULL,60.0000,'kg',NULL,NULL,NULL,'','',0.0000,31000.0000,0.0000,10000.0000,0.0000,41000.0000,'larevo1111@gmail.com','larevo1111@gmail.com','2025-10-30 22:33:37','2026-01-02 11:30:52',NULL,'',NULL),
(14,'PRO_EnsProOps1_74','Ori_Sil_2','1','PROD','Ensayos Proc Ops 1','Aprobado',NULL,'CacyCho_d0','NVR (VALOR NETO REALIZABLE)','Este es un primer ensato y estos son kos tips','Estas son las isntruccones del procedimiento',131.0000,'meses',NULL,NULL,NULL,'','',35625.0000,15837.3021,8551.9872,573100.0000,1969369.1500,2602483.4393,'larevo1111@gmail.com','larevo1111@gmail.com','2025-12-15 17:49:29','2026-01-02 12:54:47','se pone unida meses por joderFFSDF','--Actualizados: 13 | Errores unidad: 0 | 2026-01-02 12:54--',NULL),
(15,'PRO_ENSNIBPRO2_e4','Ori_Sil_2','1','PROD','ENSA NIBS PROC 2','Aprobado','PRO_EnsProOps1_74',NULL,'NVR (VALOR NETO REALIZABLE)',NULL,NULL,90.0000,'kg',NULL,NULL,NULL,'','',8580.0000,4739.0000,16325.7900,15000.0000,11950111.0000,11994755.7900,'larevo1111@gmail.com','larevo1111@gmail.com','2025-12-18 21:36:01','2026-01-02 11:30:52',NULL,'',NULL),
(16,'OS.PRO_EmpChobom250_dc','Ori_Sil_2','1','PROD','Empaque Chocolate bombones 250g',NULL,NULL,NULL,'SIN COSTO CONJUNTO',NULL,'1. Pegar etiqueta\n2. Poner lote y fecha en el lugar indicado, etiqueta trasera parte inferior, en la bolsa, no en la etiqueta. OJO: IDENTIFICAR LA VENTANA, LA CUAL ES LA PARTE DELANTERA, PARA NO PONER LAS ETIQUETAS AL REVES.\n3. Empacar las almendras con el embudo, ubicando la bolsa en la bascula.\n4. Sellar la bolsa.',6.0000,'und',12.0000,12.0000,15.0000,'','',476.0000,12654.0848,0.7089,1000.0000,0.0000,14130.7937,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-08 12:51:38','2026-01-08 12:59:44',NULL,NULL,NULL),
(17,'OS.PRO_EmpChobom500_af','Ori_Sil_2','1','PROD','Empaque Chocolate bombones 500g',NULL,NULL,NULL,'SIN COSTO CONJUNTO',NULL,'1. Pegar etiqueta\n2. Poner lote y fecha en el lugar indicado, etiqueta trasera parte inferior, en la bolsa, no en la etiqueta. OJO: IDENTIFICAR LA VENTANA, LA CUAL ES LA PARTE DELANTERA, PARA NO PONER LAS ETIQUETAS AL REVES.\n3. Empacar las almendras con el embudo, ubicando la bolsa en la bascula.\n4. Sellar la bolsa.',6.0000,'und',12.0000,12.0000,15.0000,'','',476.0000,25308.1696,0.7089,1000.0000,0.0000,26784.8785,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-08 13:10:00','2026-01-08 13:10:42',NULL,NULL,NULL);
/*!40000 ALTER TABLE `costos_procedimientos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_procedimientos_consumibles`
--

LOCK TABLES `costos_procedimientos_consumibles` WRITE;
/*!40000 ALTER TABLE `costos_procedimientos_consumibles` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_procedimientos_consumibles` VALUES
(19,'PRO_MaqTosyDesdeCac_bcC_E_CosdeFibmed_13077','Ori_Sil_2','PRO_MaqTosyDesdeCac_bc','C_E_CosdeFibmed_13','2','und',0.0300,1.00,2000.0000,1.0000,NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-10-03 12:30:58','2025-10-03 12:34:25'),
(20,'PRO_MaqTosyDesdeCac_bcC_E_VinAnc30c_14a9f','Ori_Sil_2','PRO_MaqTosyDesdeCac_bc','C_E_VinAnc30c_14','2','mt',6.0000,1.00,37.0000,2.0000,'Hace falta verificar la medicion del papel empleado para empacar\nACT_PHP_2025-12-25_14:49\nACT_PHP_2025-12-25_14:52\nACT_PHP_2025-12-25_15:07','','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-10-03 12:37:47','2025-10-03 12:37:47'),
(21,'PRO_Refdenib24hor_5aC_P_Serdepap_15451','Ori_Sil_2','PRO_Refdenib24hor_5a','C_P_Serdepap_15','2','cm',7.5000,1.00,3.4800,1.0000,NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-10-10 15:56:52','2025-10-10 16:18:15'),
(22,'PRO_Refdenib24hor_5aC_L_JabNeu_16864','Ori_Sil_2','PRO_Refdenib24hor_5a','C_L_JabNeu_16','2','ml',2.5000,1.00,10.2600,2.0000,NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-10-10 16:10:43','2025-10-10 16:16:53'),
(23,'PRO_BORENS_9cC_P_Serdepap_15a83','Ori_Sil_2','PRO_BORENS_9c','C_P_Serdepap_15','2','cm',7.5000,1.00,3.4800,1.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 20:19:15','2025-10-21 20:19:15'),
(24,'PRO_BORENS_9cC_L_JabNeu_16603','Ori_Sil_2','PRO_BORENS_9c','C_L_JabNeu_16','2','ml',2.5000,1.00,10.2600,2.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 20:19:15','2025-10-21 20:19:15'),
(28,'PRO_Enmbom_3aC_P_Serdepap_151d7','Ori_Sil_2','PRO_Enmbom_3a','C_P_Serdepap_15','4','cm',7.5000,1.00,3.4800,1.0000,NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-11-07 18:08:25','2025-11-07 18:08:25'),
(29,'PRO_Enmbom_3aC_L_JabNeu_165b5','Ori_Sil_2','PRO_Enmbom_3a','C_L_JabNeu_16','4','ml',2.5000,1.00,10.2600,2.0000,NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-11-07 18:09:07','2025-11-07 18:09:07'),
(30,'PRO_EnsProOps1_74C_P_Serdepap_152dd','Ori_Sil_2','PRO_EnsProOps1_74','C_P_Serdepap_15','4','cm',7.5000,1.00,3.4800,100.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-15 18:01:19','2025-12-16 22:22:37'),
(31,'PRO_EnsProOps1_74C_L_JabNeu_16189','Ori_Sil_2','PRO_EnsProOps1_74','C_L_JabNeu_16','4','ml',2.5000,1.00,10.2600,200.0000,'4','ACT_PHP_PROC | 2026-01-02 11:35##ACT_PHP_PROC | 2026-01-02 12:54##','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-15 18:01:19','2026-01-02 12:54:46'),
(32,'PRO_EnsProOps1_74Limyase_GORDESBLAX100UNI_8bf6','Ori_Sil_2','PRO_EnsProOps1_74','Limyase_GORDESBLAX100UNI_8','4','Und',1.0000,1.00,19300.0000,300.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-15 18:01:25','2025-12-16 22:06:12'),
(33,'PRO_EnsProOps1_74Pro_PapKra120corTamcarplix9ud_266','Ori_Sil_2','PRO_EnsProOps1_74','Pro_PapKra120corTamcarplix9ud_2','2','Und',3.0000,1.00,650000.0000,25.0000,NULL,'ERROR_UNIDAD | CONS | MAESTRA=Und | PROC=hoja | 2026-01-02 11:35##ACT_PHP | 2025-12-29 19:12\nACT_PHP_PROC | 2026-01-02 12:54##','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 22:32:11','2026-01-02 12:54:46'),
(34,'PRO_EnsProOps1_74C_P_Serdepap_15456','Ori_Sil_2','PRO_EnsProOps1_74','C_P_Serdepap_15','2','cm',5.0000,1.00,3.4800,50.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 22:32:35','2025-12-16 22:34:02'),
(35,'PRO_ENSNIBPRO2_e4Pro_PapKra120corTamcarplix9ud_2fc','Ori_Sil_2','PRO_ENSNIBPRO2_e4','Pro_PapKra120corTamcarplix9ud_2','1','Und',3.0000,1.00,650000.0000,1.0000,NULL,'ACT_PHP | 2025-12-29 19:12\n','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-18 21:36:39','2025-12-29 19:12:07'),
(36,'PRO_ENSNIBPRO2_e4C_E_CosdeFibmed_13012','Ori_Sil_2','PRO_ENSNIBPRO2_e4','C_E_CosdeFibmed_13','2','und',5.0000,1.00,2000000.0000,2.0000,'ERROR_UNIDAD | MAESTRA=und | PROC=hora | 2025-12-29 10:59\nERROR_UNIDAD | MAESTRA=und | PROC=hora | 2025-12-29 10:59\nACT_PHP | 2025-12-29 11:01\n','','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-18 21:36:39','2025-12-30 10:53:48'),
(37,'PRO_ENSNIBPRO2_e4C_E_VinAnc30c_14f23','Ori_Sil_2','PRO_ENSNIBPRO2_e4','C_E_VinAnc30c_14','4','mt',3.0000,1.00,37.0000,3.0000,'fasdfads\nACT_PHP_2025-12-25_14:49\nACT_PHP_2025-12-25_14:52\nACT_PHP_2025-12-25_15:07ACT_PHP | 2025-12-28 15:43\n','','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-18 21:36:39','2025-12-28 15:43:26'),
(38,'OS.PRO_BORENS_9cC_P_Serdepap_15c5d','Ori_Sil_2','PRO_BORENS_9c','C_P_Serdepap_15','4','cm',7.5000,1.00,3.4800,100.0000,NULL,'ACT_PHP_PROC | 2026-01-08 18:36##','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-02 13:02:30','2026-01-08 18:36:37'),
(39,'OS.PRO_BORENS_9cC_L_JabNeu_16c37','Ori_Sil_2','PRO_BORENS_9c','C_L_JabNeu_16','4','ml',2.5000,1.00,10.2600,200.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-02 13:02:30','2026-01-02 13:04:54'),
(41,'OS.PRO_BORENS_9cPro_PapKra120corTamcarplix9ud_249c','Ori_Sil_2','PRO_BORENS_9c','Pro_PapKra120corTamcarplix9ud_2','2','Und',3.0000,1.00,650000.0000,25.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-02 13:02:30','2026-01-02 13:02:30'),
(42,'OS.PRO_BORENS_9cC_P_Serdepap_15876','Ori_Sil_2','PRO_BORENS_9c','C_P_Serdepap_15','2','cm',5.0000,1.00,3.4800,50.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-02 13:02:30','2026-01-02 13:02:30'),
(44,'OS.PRO_BORENS_9cC_L_JabNeu_16079','Ori_Sil_2','PRO_BORENS_9c','C_L_JabNeu_16','4','ml',2.5000,1.00,10.2600,200.0000,'4','ACT_PHP_PROC | 2026-01-08 18:36##','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-02 13:02:57','2026-01-08 18:36:37'),
(48,'OS.PRO_BORENS_9cC_P_Serdepap_15a87','Ori_Sil_2','PRO_BORENS_9c','C_P_Serdepap_15','2','cm',7.5000,1.00,3.4800,1.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-02 13:14:22','2026-01-02 13:14:22'),
(49,'OS.PRO_BORENS_9cC_L_JabNeu_16828','Ori_Sil_2','PRO_BORENS_9c','C_L_JabNeu_16','2','ml',2.5000,1.00,10.2600,2.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-02 13:14:22','2026-01-02 13:14:22'),
(50,'OS.PRO_BORENS_9cC_P_Serdepap_152a2','Ori_Sil_2','PRO_BORENS_9c','C_P_Serdepap_15','4','cm',7.5000,1.00,3.4800,100.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-02 13:14:32','2026-01-02 13:14:32'),
(51,'OS.PRO_BORENS_9cC_L_JabNeu_16f11','Ori_Sil_2','PRO_BORENS_9c','C_L_JabNeu_16','4','ml',2.5000,1.00,10.2600,200.0000,'4',NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-02 13:14:32','2026-01-02 13:14:32'),
(52,'OS.PRO_BORENS_9cLimyase_GORDESBLAX100UNI_8c64','Ori_Sil_2','PRO_BORENS_9c','Limyase_GORDESBLAX100UNI_8','4','Und',1.0000,1.00,19300.0000,300.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-02 13:14:32','2026-01-02 13:14:32'),
(53,'OS.PRO_BORENS_9cPro_PapKra120corTamcarplix9ud_22bb','Ori_Sil_2','PRO_BORENS_9c','Pro_PapKra120corTamcarplix9ud_2','2','Und',3.0000,1.00,650000.0000,25.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-02 13:14:32','2026-01-02 13:14:32'),
(54,'OS.PRO_BORENS_9cC_P_Serdepap_15e77','Ori_Sil_2','PRO_BORENS_9c','C_P_Serdepap_15','2','cm',5.0000,1.00,3.4800,50.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-02 13:14:32','2026-01-02 13:14:32'),
(55,'OS.PRO_BORENS_9cC_P_Serdepap_15956','Ori_Sil_2','PRO_BORENS_9c','C_P_Serdepap_15','4','cm',7.5000,1.00,3.4800,100.0000,NULL,'ACT_PHP_PROC | 2026-01-08 18:36##','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-02 13:19:42','2026-01-08 18:36:37'),
(56,'OS.PRO_BORENS_9cC_L_JabNeu_16ffc','Ori_Sil_2','PRO_BORENS_9c','C_L_JabNeu_16','4','ml',2.5000,1.00,10.2600,200.0000,'4',NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-02 13:19:42','2026-01-02 13:19:42'),
(57,'OS.PRO_BORENS_9cLimyase_GORDESBLAX100UNI_82f5','Ori_Sil_2','PRO_BORENS_9c','Limyase_GORDESBLAX100UNI_8','4','Und',1.0000,1.00,19300.0000,300.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-02 13:19:42','2026-01-02 13:19:42'),
(58,'OS.PRO_BORENS_9cPro_PapKra120corTamcarplix9ud_24a0','Ori_Sil_2','PRO_BORENS_9c','Pro_PapKra120corTamcarplix9ud_2','2','Und',3.0000,1.00,650000.0000,25.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-02 13:19:42','2026-01-02 13:19:42'),
(59,'OS.PRO_BORENS_9cC_P_Serdepap_15a5d','Ori_Sil_2','PRO_BORENS_9c','C_P_Serdepap_15','2','cm',5.0000,1.00,3.4800,50.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-02 13:19:42','2026-01-02 13:19:42');
/*!40000 ALTER TABLE `costos_procedimientos_consumibles` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_procedimientos_herramientas`
--

LOCK TABLES `costos_procedimientos_herramientas` WRITE;
/*!40000 ALTER TABLE `costos_procedimientos_herramientas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_procedimientos_herramientas` VALUES
(10,'PRO_Tosalmdecac_10AP_Horpeq2ban_158d1','Ori_Sil_2','PRO_Tosalmdecac_10','AP_Horpeq2ban_15','2',35.0000,0.2000,1,'hora',0.5800,700.0000,1.00,1.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-09-23 13:54:08','2025-12-30 13:26:58'),
(12,'PRO_Refdenib24hor_5aAP_GraMed(ha30kil_23894','Ori_Sil_2','PRO_Refdenib24hor_5a','AP_GraMed(ha30kil_23','2',1.0000,0.6510,1,'NA_20',NULL,0.0000,1.00,1.0000,NULL,'ACT_PHP | 2026-01-02 11:56\n','jennifercanogarcia@gmail.com','larevo1111@gmail.com','2025-10-10 14:51:49','2026-01-02 11:56:43'),
(13,'PRO_Refdenib24hor_5aAP_BowMet27c_17a29','Ori_Sil_2','PRO_Refdenib24hor_5a','AP_BowMet27c_17','2',1.0000,0.0868,1,'NA_20',NULL,14.0000,1.00,2.0000,NULL,'ACT_PHP | 2026-01-02 11:10\n','jennifercanogarcia@gmail.com','larevo1111@gmail.com','2025-10-10 15:05:49','2026-01-02 11:10:41'),
(14,'PRO_Refdenib24hor_5aMa_REFCHOPRE_14f14','Ori_Sil_2','PRO_Refdenib24hor_5a','Ma_REFCHOPRE_14','2',360.0000,3.3800,1,'hora',6.0000,160.0000,1.00,5.0000,NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-10-10 15:16:19','2025-10-10 15:54:05'),
(15,'PRO_Refdenib24hor_5aAP_Moldemaiele_166f1','Ori_Sil_2','PRO_Refdenib24hor_5a','AP_Moldemaiele_16','2',13.0000,0.3900,1,'hora',0.2000,700.0000,1.00,3.0000,NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-10-10 15:31:25','2025-10-10 15:54:31'),
(17,'PRO_Refdenib24hor_5aAP_EspMet_26aeb','Ori_Sil_2','PRO_Refdenib24hor_5a','AP_EspMet_26','2',NULL,0.0000,1,'NA_20',NULL,0.0000,1.00,4.0000,NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-10-10 15:53:11','2025-10-10 15:54:31'),
(18,'PRO_EmpAlmdecactos200_93AP_GraMed(ha30kil_23058','Ori_Sil_2','PRO_EmpAlmdecactos200_93','AP_GraMed(ha30kil_23','2',1.0000,0.6510,1,'NA_20',NULL,0.0000,1.00,1.0000,NULL,'ACT_PHP | 2026-01-02 11:56\nACT_PHP_PROC | 2026-01-08 12:28##','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 17:17:24','2026-01-08 12:28:34'),
(19,'PRO_EmpAlmdecactos200_93AP_EMBGRABOCANC_27125','Ori_Sil_2','PRO_EmpAlmdecactos200_93','AP_EMBGRABOCANC_27','2',1.0000,0.0579,1,'NA_20',NULL,0.0000,1.00,2.0000,NULL,'ACT_PHP_PROC | 2026-01-08 12:28##ACT_PHP | 2026-01-08 12:31\n','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 17:19:24','2026-01-08 12:31:01'),
(20,'PRO_EmpAlmdecactos200_93AP_PALACRTRA_28272','Ori_Sil_2','PRO_EmpAlmdecactos200_93','AP_PALACRTRA_28','2',1.0000,0.0000,1,'NA_20',NULL,0.0000,1.00,3.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 17:20:50','2025-10-21 17:20:50'),
(21,'PRO_EmpAlmdecactos100_30AP_GraMed(ha30kil_232f9','Ori_Sil_2','PRO_EmpAlmdecactos100_30','AP_GraMed(ha30kil_23','2',1.0000,0.6510,1,'NA_20',NULL,0.0000,1.00,1.0000,NULL,'ACT_PHP | 2026-01-02 11:56\n','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 17:27:29','2026-01-02 11:56:43'),
(22,'PRO_EmpAlmdecactos100_30AP_EMBGRABOCANC_279ce','Ori_Sil_2','PRO_EmpAlmdecactos100_30','AP_EMBGRABOCANC_27','2',1.0000,0.0579,1,'NA_20',NULL,0.0000,1.00,2.0000,NULL,'ACT_PHP | 2026-01-08 12:31\n','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 17:27:29','2026-01-08 12:31:01'),
(23,'PRO_EmpAlmdecactos100_30AP_PALACRTRA_28a66','Ori_Sil_2','PRO_EmpAlmdecactos100_30','AP_PALACRTRA_28','2',1.0000,0.0000,1,'NA_20',NULL,0.0000,1.00,3.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 17:27:29','2025-10-21 17:27:29'),
(24,'PRO_BORENS_9cAP_GraMed(ha30kil_23ce8','Ori_Sil_2','PRO_BORENS_9c','AP_GraMed(ha30kil_23','2',1.0000,0.6510,1,'NA_20',NULL,0.0000,1.00,1.0000,NULL,'ACT_PHP | 2026-01-02 11:56\nACT_PHP_PROC | 2026-01-08 18:36##','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 20:19:15','2026-01-08 18:36:37'),
(25,'PRO_BORENS_9cAP_BowMet27c_17f41','Ori_Sil_2','PRO_BORENS_9c','AP_BowMet27c_17','2',1.0000,0.0868,1,'NA_20',NULL,14.0000,1.00,2.0000,NULL,'ACT_PHP | 2026-01-02 11:10\nACT_PHP_PROC | 2026-01-08 18:36##','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 20:19:15','2026-01-08 18:36:37'),
(26,'PRO_BORENS_9cMa_REFCHOPRE_14b52','Ori_Sil_2','PRO_BORENS_9c','Ma_REFCHOPRE_14','2',1440.0000,7.5955,1,'hora',24.0000,160.0000,1.00,5.0000,NULL,'ACT_PHP_PROC | 2026-01-08 18:36##','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 20:19:15','2026-01-08 18:36:37'),
(27,'PRO_BORENS_9cAP_Moldemaiele_16b67','Ori_Sil_2','PRO_BORENS_9c','AP_Moldemaiele_16','2',13.0000,0.8681,1,'hora',0.2000,700.0000,1.00,3.0000,NULL,'ACT_PHP_PROC | 2026-01-08 18:36##','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 20:19:15','2026-01-08 18:36:37'),
(28,'PRO_BORENS_9cAP_EspMet_263f4','Ori_Sil_2','PRO_BORENS_9c','AP_EspMet_26','2',NULL,0.0000,1,'NA_20',NULL,0.0000,1.00,4.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 20:19:15','2025-10-21 20:19:15'),
(31,'PRO_Enmbom_3aMo_MOLPOLAMAFIG9-12g_08c80','Ori_Sil_2','PRO_Enmbom_3a','Mo_MOLPOLAMAFIG9-12g_08','2',0.0000,0.0000,1,'NA_20',4.0000,0.0000,1.00,2.0000,NULL,'','jennifercanogarcia@gmail.com','larevo1111@gmail.com','2025-11-07 17:30:30','2026-01-01 16:20:33'),
(32,'PRO_Enmbom_3aAP_EmbDos_293e2','Ori_Sil_2','PRO_Enmbom_3a','AP_EmbDos_29','2',6.0000,0.1389,1,'NA_20',NULL,0.0000,1.00,1.0000,NULL,'ACT_PHP_PROC | 2026-01-09 17:00##','jennifercanogarcia@gmail.com','larevo1111@gmail.com','2025-11-07 17:48:57','2026-01-09 17:00:44'),
(33,'PRO_Enmbom_3aAP_ConNevPeq_307a9','Ori_Sil_2','PRO_Enmbom_3a','AP_ConNevPeq_30','3',10.0000,1.0417,1,'minuto',10.0000,0.0000,1.00,3.0000,NULL,'ACT_PHP_PROC | 2026-01-09 17:00##','jennifercanogarcia@gmail.com','larevo1111@gmail.com','2025-11-07 17:59:56','2026-01-09 17:00:44'),
(34,'PRO_Enmbom_3aAP_EstdeGas3Pue_31e20','Ori_Sil_2','PRO_Enmbom_3a','AP_EstdeGas3Pue_31','4',4.0000,0.8681,1,'minuto',4.0000,15.0000,1.00,4.0000,NULL,'ACT_PHP_PROC | 2026-01-09 17:00##','jennifercanogarcia@gmail.com','larevo1111@gmail.com','2025-11-07 18:11:45','2026-01-09 17:00:44'),
(35,'PRO_Enmbom_3aAP_ZondeLav_325ec','Ori_Sil_2','PRO_Enmbom_3a','AP_ZondeLav_32','4',5.0000,0.3472,1,'minuto',5.0000,28.0000,1.00,5.0000,NULL,'ACT_PHP_PROC | 2026-01-09 17:00##','jennifercanogarcia@gmail.com','larevo1111@gmail.com','2025-11-07 18:25:37','2026-01-09 17:00:44'),
(36,'PRO_EnsProOps1_74AP_Moldemaiele_1610e','Ori_Sil_2','PRO_EnsProOps1_74','AP_Moldemaiele_16','2',120.0000,0.8681,2,'hora',2.0000,700.0000,1.00,1.0000,'hmta 1','ACT_PHP_PROC | 2026-01-02 11:35##ACT_PHP_PROC | 2026-01-02 12:54##','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-15 18:04:16','2026-01-02 12:54:47'),
(37,'PRO_EnsProOps1_74Ma_REFCHOPRE_14872','Ori_Sil_2','PRO_EnsProOps1_74','Ma_REFCHOPRE_14','3',180.0000,7.5955,3,'hora',3.0000,160.0000,1.00,200.0000,'refind','ACT_PHP_PROC | 2026-01-02 11:35##ACT_PHP_PROC | 2026-01-02 12:54##','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-15 18:07:06','2026-01-02 12:54:47'),
(38,'PRO_EnsProOps1_74AP_ConNevPeq_308cb','Ori_Sil_2','PRO_EnsProOps1_74','AP_ConNevPeq_30','1',0.6000,1.0417,1,'minuto',0.6000,0.0000,1.00,100.0000,NULL,'ACT_PHP_PROC | 2026-01-02 11:35##ACT_PHP_PROC | 2026-01-02 12:54##','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 22:30:26','2026-01-02 12:54:47'),
(39,'PRO_EnsProOps1_74AP_EMBGRABOCANC_2702d','Ori_Sil_2','PRO_EnsProOps1_74','AP_EMBGRABOCANC_27','3',2.5250,0.0579,1,'NA_20',NULL,0.0000,1.00,100.0000,NULL,'ACT_PHP_PROC | 2026-01-02 11:35##ACT_PHP_PROC | 2026-01-02 12:54##ACT_PHP | 2026-01-08 12:31\n','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 22:31:10','2026-01-08 12:31:01'),
(40,'PRO_EnsProOps1_74AP_GraMed(ha30kil_23b9f','Ori_Sil_2','PRO_EnsProOps1_74','AP_GraMed(ha30kil_23','3',2.0000,0.6510,1,'NA_20',1.0000,0.0000,1.00,150.0000,NULL,'ACT_PHP_PROC | 2026-01-02 11:35##ACT_PHP | 2026-01-02 11:56\nACT_PHP_PROC | 2026-01-02 12:54##','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 22:33:02','2026-01-02 12:54:47'),
(41,'PRO_ENSNIBPRO2_e4Ma_TER_17fef','Ori_Sil_2','PRO_ENSNIBPRO2_e4','Ma_TER_17','2',5760.0000,0.4400,3,'hora',4.0000,2.0000,1.00,1.0000,NULL,'ACT_PHP | 2025-12-30 12:32\nACT_PHP | 2025-12-30 13:30\n','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-18 21:36:39','2025-12-30 13:31:58'),
(42,'PRO_ENSNIBPRO2_e4He_BowMetde32c_056e9','Ori_Sil_2','PRO_ENSNIBPRO2_e4','He_BowMetde32c_05','3',45.0000,0.0868,15,'NA_20',4.0000,144.0000,1.00,2.0000,NULL,'ACT_PHP | 2025-12-29 21:11\n','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-18 21:36:39','2025-12-30 13:49:28'),
(43,'OS.OS.PRO_EmpChobom250_dcAP_GraMed(ha30kil_2328b','Ori_Sil_2','OS.PRO_EmpChobom250_dc','AP_GraMed(ha30kil_23','2',1.0000,0.6510,1,'NA_20',NULL,0.0000,1.00,1.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-08 12:59:44','2026-01-08 12:59:44'),
(44,'OS.OS.PRO_EmpChobom250_dcAP_EMBGRABOCANC_27639','Ori_Sil_2','OS.PRO_EmpChobom250_dc','AP_EMBGRABOCANC_27','2',1.0000,0.0579,1,'NA_20',NULL,0.0000,1.00,2.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-08 12:59:44','2026-01-08 12:59:44'),
(45,'OS.OS.PRO_EmpChobom250_dcAP_PALACRTRA_28d78','Ori_Sil_2','OS.PRO_EmpChobom250_dc','AP_PALACRTRA_28','2',1.0000,0.0000,1,'NA_20',NULL,NULL,1.00,3.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-08 12:59:44','2026-01-08 12:59:44'),
(46,'OS.OS.PRO_EmpChobom500_afAP_GraMed(ha30kil_238cc','Ori_Sil_2','OS.PRO_EmpChobom500_af','AP_GraMed(ha30kil_23','2',1.0000,0.6510,1,'NA_20',NULL,0.0000,1.00,1.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-08 13:10:42','2026-01-08 13:10:42'),
(47,'OS.OS.PRO_EmpChobom500_afAP_EMBGRABOCANC_279c7','Ori_Sil_2','OS.PRO_EmpChobom500_af','AP_EMBGRABOCANC_27','2',1.0000,0.0579,1,'NA_20',NULL,0.0000,1.00,2.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-08 13:10:42','2026-01-08 13:10:42'),
(48,'OS.OS.PRO_EmpChobom500_afAP_PALACRTRA_2850e','Ori_Sil_2','OS.PRO_EmpChobom500_af','AP_PALACRTRA_28','2',1.0000,0.0000,1,'NA_20',NULL,0.0000,1.00,3.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-08 13:10:42','2026-01-08 13:10:42');
/*!40000 ALTER TABLE `costos_procedimientos_herramientas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_procedimientos_imag_vid`
--

LOCK TABLES `costos_procedimientos_imag_vid` WRITE;
/*!40000 ALTER TABLE `costos_procedimientos_imag_vid` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_procedimientos_imag_vid` VALUES
(31,'PRO_BORENS_9c_e7f','Ori_Sil_2','Imagen','PRO_BORENS_9c',NULL,'1','Ori_Sil_2/Procedimientos/BORRAR ENSAYO//PRO_BORENS_9c_e7f.imagen.034933.png','','','','',1,NULL,'2025-12-16 22:49:17','2025-12-16 22:49:17','larevo1111@gmail.com','larevo1111@gmail.com');
/*!40000 ALTER TABLE `costos_procedimientos_imag_vid` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_procedimientos_mp_insumos`
--

LOCK TABLES `costos_procedimientos_mp_insumos` WRITE;
/*!40000 ALTER TABLE `costos_procedimientos_mp_insumos` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_procedimientos_mp_insumos` VALUES
(18,'PRO_Tosalmdecac_10MP_Grsealdecaetna_CacAlmxKg.ProV','Ori_Sil_2','PRO_Tosalmdecac_10','MP_Frus_ALMSINTOSKG_16','2','kg',1.0000,20000.0000,1.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-09-23 13:29:05','2025-11-27 14:39:12'),
(19,'PRO_EmpAlmdecactos100_30I_Envyt_BOLDOYPACPETTRASIN','Ori_Sil_2','PRO_EmpAlmdecactos100_30','I_Envyt_BOLDOYPACPETTRASINIMP_32','2','und',1.0000,248.0000,1.0000,NULL,'','ssierra047@gmail.com','larevo1111@gmail.com','2025-09-25 17:06:18','2025-10-21 17:35:50'),
(20,'PRO_MaqTosyDesdeCac_bcMP_Gras_CACLTALMKL_5511','Ori_Sil_2','PRO_MaqTosyDesdeCac_bc','MP_Gras_CACLTALMKL_55','2','kg',1.0000,21000.0000,1.0000,NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-10-03 12:28:01','2025-10-03 12:30:31'),
(21,'PRO_EmpAlmdecactos200_93I_Envyt_BOLDOYPACPETTRASIN','Ori_Sil_2','PRO_EmpAlmdecactos200_93','I_Envyt_BOLFLEUPPETHBACOLMET_43','2','und',1.0000,476.0000,1.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 17:00:20','2025-10-21 17:14:58'),
(23,'PRO_BORENS_9cMP_Frus_ALMSINTOSKG_165','Ori_Sil_2','PRO_BORENS_9c','MP_Frus_ALMSINTOSKG_16','1','kg',1.0000,20000.0000,1.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 20:20:16','2025-10-24 20:40:58'),
(26,'PRO_EnsProOps1_74MP_Frus_ALMSINTOSKG_168','Ori_Sil_2','PRO_EnsProOps1_74','MP_Frus_ALMSINTOSKG_16','2','kg',1.0000,20000.0000,100.0000,NULL,'ACT_PHP_PROC | 2026-01-02 12:54##','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-15 17:59:37','2026-01-02 12:54:46'),
(27,'PRO_EnsProOps1_74MP_SalA_Bicxgra_129','Ori_Sil_2','PRO_EnsProOps1_74','MP_SalA_Bicxgra_12','1','g',23.0000,15.0000,2.0000,'bicarbonato','ACT_PHP | 2026-01-01 13:40\n','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-15 18:00:02','2026-01-01 13:40:27'),
(28,'PRO_EnsProOps1_74I_Eti_ETIMAR100DELXUNI_0110','Ori_Sil_2','PRO_EnsProOps1_74','I_Eti_ETIMAR100DELXUNI_01','4','und',4.0000,1000.0000,50.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-15 18:00:36','2025-12-16 23:11:03'),
(29,'PRO_EnsProOps1_74MP_Gras_CACLTALMKL_5511','Ori_Sil_2','PRO_EnsProOps1_74','MP_Gras_CACLTALMKL_55','2','kg',0.4300,21000.0000,200.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 23:02:11','2025-12-16 23:07:29'),
(30,'PRO_EnsProOps1_74I_Envyt_BOLDOYPACPETSINIMPTRA_391','Ori_Sil_2','PRO_EnsProOps1_74','I_Envyt_BOLDOYPACPETSINIMPTRA_39','2','und',1.8000,0.0000,50.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 23:02:37','2025-12-16 23:36:14'),
(31,'PRO_EnsProOps1_74I_Eti_EtiCho500graDelxuni_7613','Ori_Sil_2','PRO_EnsProOps1_74','I_Eti_EtiCho500graDelxuni_76','4','und',2.0000,1125.0000,100.0000,NULL,'ACT_PHP_PROC | 2026-01-02 11:35##ACT_PHP_PROC | 2026-01-02 12:54##','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 23:03:01','2026-01-02 12:54:46'),
(32,'PRO_ENSNIBPRO2_e4I_Envyt_TAPMETB.6XUNI_7814','Ori_Sil_2','PRO_ENSNIBPRO2_e4','I_Envyt_TAPMETB.6XUNI_78','3','und',12.0000,370.0000,1.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-18 21:36:39','2025-12-18 21:36:39'),
(33,'PRO_ENSNIBPRO2_e4I_Envyt_BOLTRAVALDOYPAC10X_0215','Ori_Sil_2','PRO_ENSNIBPRO2_e4','I_Envyt_BOLTRAVALDOYPAC10X_02','4','und',12.0000,345.0000,2.0000,'mpes','','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-18 21:36:39','2026-01-01 16:22:26'),
(34,'OS.OS.PRO_EmpChobom250_dcI_Envyt_BOLFLEUPPETHBACOL','Ori_Sil_2','OS.PRO_EmpChobom250_dc','I_Envyt_BOLFLEUPPETHBACOLMET_43','2','und',1.0000,476.0000,1.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-08 12:59:44','2026-01-08 12:59:44'),
(35,'OS.OS.PRO_EmpChobom500_afI_Envyt_BOLFLEUPPETHBACOL','Ori_Sil_2','OS.PRO_EmpChobom500_af','I_Envyt_BOLFLEUPPETHBACOLMET_43','2','und',1.0000,476.0000,1.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-08 13:10:42','2026-01-08 13:10:42');
/*!40000 ALTER TABLE `costos_procedimientos_mp_insumos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_procedimientos_pp`
--

LOCK TABLES `costos_procedimientos_pp` WRITE;
/*!40000 ALTER TABLE `costos_procedimientos_pp` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_procedimientos_pp` VALUES
(17,'PRO_EmpAlmdecactos100_30PPNiv1_ALMDECACTOS_049','Ori_Sil_2','PRO_EmpAlmdecactos100_30','PPNiv1_ALMDECACTOS_04','2','kg',0.1000,23706.0000,1.0000,'ACT_PHP | 2025-12-27 07:09\n','','ssierra047@gmail.com','larevo1111@gmail.com','2025-09-25 17:05:58','2025-12-27 07:09:00'),
(18,'PRO_Refdenib24hor_5aPPNiv2_NIBDECACLT_8010','Ori_Sil_2','PRO_Refdenib24hor_5a','PPNiv2_NIBDECACLT_80','2','kg',1.0000,32598.7725,1.0000,NULL,'ACT_PHP | 2026-01-08 12:05\n','jennifercanogarcia@gmail.com','larevo1111@gmail.com','2025-10-03 14:27:37','2026-01-08 12:05:34'),
(19,'PRO_EmpAlmdecactos200_93PPNiv1_ALMDECACTOS_043','Ori_Sil_2','PRO_EmpAlmdecactos200_93','PPNiv1_ALMDECACTOS_04','2','kg',0.2000,23713.0000,1.0000,'ACT_PHP | 2025-12-27 07:08\nACT_PHP | 2025-12-27 07:09\n',NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 17:00:20','2026-01-08 12:28:55'),
(20,'PRO_BORENS_9cPPNiv2_NIBDECACLT_804','Ori_Sil_2','PRO_BORENS_9c','PPNiv2_NIBDECACLT_80','2','kg',1.0000,32598.7725,1.0000,NULL,'ACT_PHP | 2026-01-08 12:05\n','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 20:19:15','2026-01-08 12:05:34'),
(21,'PRO_ENSNIBPRO_44PPPt__ENSALMTOS_f25','Ori_Sil_2','PRO_ENSNIBPRO_44','PPPt__ENSALMTOS_f2','2','kg',1.0000,31000.0000,1.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-30 22:34:32','2025-10-30 22:34:32'),
(24,'PRO_Enmbom_3aPPPP__CHOLT100-REF24H_2c7','Ori_Sil_2','PRO_Enmbom_3a','PPPP__CHOLT100-REF24H_2c','2','kg',1.0000,45773.1303,1.0000,'Este chocolate se usa inmediatamente sale de la refinadora, no se debe dejar solidificar','','jennifercanogarcia@gmail.com','larevo1111@gmail.com','2025-11-07 16:30:36','2026-01-08 12:09:51'),
(25,'PRO_EnsProOps1_74PPPt__ENSALMTOS_f28','Ori_Sil_2','PRO_EnsProOps1_74','PPPt__ENSALMTOS_f2','1','kg',0.4000,0.0000,1.0000,NULL,'ACT_PHP_PROC | 2026-01-02 11:35##','larevo1111@gmail.com','TEST','2025-12-15 17:57:57','2026-01-02 11:35:38'),
(26,'PRO_EnsProOps1_74PTCre_CHOOS90GRS_129','Ori_Sil_2','PRO_EnsProOps1_74','PTCre_CHOOS90GRS_12','2','Und',7.0000,0.0000,200.0000,NULL,'ACT_PHP_PROC | 2026-01-02 11:35##','larevo1111@gmail.com','TEST','2025-12-15 17:57:57','2026-01-02 11:35:38'),
(27,'PRO_EnsProOps1_74PPNiv1_MIELTFIL_5610','Ori_Sil_2','PRO_EnsProOps1_74','PPNiv1_MIELTFIL_56','2','kg',1.0000,0.0000,100.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 23:21:02','2025-12-16 23:22:56'),
(28,'PRO_EnsProOps1_74PTProapi_MieOsVid640grs_7511','Ori_Sil_2','PRO_EnsProOps1_74','PTProapi_MieOsVid640grs_75','1','Und',2.0000,212.0000,101.0000,NULL,'ACT_PHP_PROC | 2026-01-02 12:54##','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 23:21:19','2026-01-02 21:44:39'),
(29,'PRO_EnsProOps1_74PPPt__ENSCAS_7a12','Ori_Sil_2','PRO_EnsProOps1_74','PPPt__ENSCAS_7a','2','kg',0.5000,30826.6041,300.0000,'ACT_PHP | 2025-12-29 11:02\n','ACT_PHP_PROC | 2026-01-02 11:35##ACT_PHP_PROC | 2026-01-02 12:54##','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 23:21:33','2026-01-02 12:54:47'),
(30,'PRO_ENSNIBPRO2_e4PPPt__ENSALMTOS_f213','Ori_Sil_2','PRO_ENSNIBPRO2_e4','PPPt__ENSALMTOS_f2','2','kg',1.0000,0.0000,1.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-18 21:36:39','2025-12-27 02:47:12'),
(31,'PRO_ENSNIBPRO2_e4PTCre_CHOOS90GRS_1214','Ori_Sil_2','PRO_ENSNIBPRO2_e4','PTCre_CHOOS90GRS_12','2','Und',7.0000,677.0000,0.5000,NULL,'','larevo1111@gmail.com','ssierra047@gmail.com','2025-12-18 21:36:39','2025-12-26 22:11:16'),
(32,'OS.OS.PRO_EmpChobom250_dcPPNiv1_ALMDECACTOS_04918','Ori_Sil_2','OS.PRO_EmpChobom250_dc','PPNiv4_CHOLT100-REF24H-_14','2','kg',0.2500,50616.3391,1.0000,NULL,'ACT_PHP | 2026-01-09 17:15\n','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-08 12:59:44','2026-01-09 17:15:35'),
(33,'OS.OS.PRO_EmpChobom500_afPPNiv4_CHOLT100-REF24H-_1','Ori_Sil_2','OS.PRO_EmpChobom500_af','PPNiv4_CHOLT100-REF24H-_14','2','kg',0.5000,50616.3391,1.0000,NULL,'ACT_PHP | 2026-01-09 17:15\n','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-08 13:10:42','2026-01-09 17:15:35');
/*!40000 ALTER TABLE `costos_procedimientos_pp` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_procedimientos_servicios_mo`
--

LOCK TABLES `costos_procedimientos_servicios_mo` WRITE;
/*!40000 ALTER TABLE `costos_procedimientos_servicios_mo` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_procedimientos_servicios_mo` VALUES
(14,'PRO_Tosalmdecac_10MOin_MOIntNiv1_1213','Ori_Sil_2','PRO_Tosalmdecac_10','MOin_MOIntNiv1_12',NULL,'2','Hora',0.3300,10000.0000,NULL,1.00,'',1.0000,'- Incluye alistamiento y lavado de utencilios','','larevo1111@gmail.com','larevo1111@gmail.com','2025-09-23 13:30:28','2025-11-27 14:39:00'),
(15,'PRO_EmpAlmdecactos100_30MOin_MOIntNiv1_128','Ori_Sil_2','PRO_EmpAlmdecactos100_30','MOin_MOIntNiv1_12',NULL,'2','Hora',0.1000,10000.0000,NULL,1.00,'',1.0000,NULL,'','ssierra047@gmail.com','ssierra047@gmail.com','2025-09-25 17:10:50','2025-09-25 17:10:50'),
(16,'PRO_MaqTosyDesdeCac_bcMapr_MAQOBTDENIBDECAC_089','Ori_Sil_2','PRO_MaqTosyDesdeCac_bc','Mapr_MAQOBTDENIBDECAC_08',NULL,'2','kg',1.0000,4845.0000,NULL,1.00,'',3.0000,NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-10-03 12:23:41','2025-10-03 12:55:45'),
(17,'PRO_MaqTosyDesdeCac_bcSelo_FLEBUCMAQCAC_0610','Ori_Sil_2','PRO_MaqTosyDesdeCac_bc','Selo_FLEBUCMAQCAC_06',NULL,'2','kg',1.0000,1100.0000,NULL,1.00,'',2.0000,NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-10-03 12:25:29','2025-10-03 12:55:39'),
(18,'PRO_MaqTosyDesdeCac_bcMOin_MOIntNiv1_1211','Ori_Sil_2','PRO_MaqTosyDesdeCac_bc','MOin_MOIntNiv1_12',NULL,'2','Hora',0.0100,10000.0000,NULL,1.00,'',1.0000,NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-10-03 12:45:41','2025-10-03 12:53:30'),
(19,'PRO_MaqTosyDesdeCac_bcS_S_LogInt_1512','Ori_Sil_2','PRO_MaqTosyDesdeCac_bc','S_S_LogInt_15',NULL,'2','hora',0.0400,25000.0000,NULL,1.00,'',5.0000,'2 idas una hora cada una.','','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-10-03 12:47:29','2025-10-03 12:55:51'),
(20,'PRO_MaqTosyDesdeCac_bcSelo_FLEBUCMAQCAC_0613','Ori_Sil_2','PRO_MaqTosyDesdeCac_bc','Selo_FLEBUCMAQCAC_06',NULL,'2','kg',1.0000,1100.0000,NULL,1.00,'',4.0000,NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-10-03 12:55:04','2025-10-03 12:55:51'),
(21,'PRO_Refdenib24hor_5aMOin_MOIntNiv1_1214','Ori_Sil_2','PRO_Refdenib24hor_5a','MOin_MOIntNiv1_12',NULL,'2','Hora',0.7500,10000.0000,NULL,1.00,'',1.0000,'Alistamiento y montaje de nibs en refinadora','','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-10-03 14:29:03','2025-10-03 14:29:03'),
(22,'PRO_Refdenib24hor_5aMOin_MOIntNiv1_1215','Ori_Sil_2','PRO_Refdenib24hor_5a','MOin_MOIntNiv1_12',NULL,'2','Hora',0.3300,10000.0000,NULL,1.00,'',2.0000,'Bajar chocolate','','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-10-03 14:31:25','2025-10-03 14:31:25'),
(23,'PRO_EmpAlmdecactos200_93MOin_MOIntNiv1_1210','Ori_Sil_2','PRO_EmpAlmdecactos200_93','MOin_MOIntNiv1_12',NULL,'2','Hora',0.1000,10000.0000,NULL,1.00,'',1.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 17:00:20','2025-10-21 17:00:20'),
(24,'PRO_BORENS_9cMOin_MOIntNiv1_1211','Ori_Sil_2','PRO_BORENS_9c','MOin_MOIntNiv1_12',NULL,'2','Hora',1.5000,10000.0000,90.0000,1.00,'',1.0000,'Alistamiento y montaje de nibs en refinadora','','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 20:19:15','2025-10-24 13:01:09'),
(25,'PRO_BORENS_9cMOin_MOIntNiv1_1212','Ori_Sil_2','PRO_BORENS_9c','MOin_MOIntNiv1_12',NULL,'2','Hora',0.3300,10000.0000,NULL,1.00,'',2.0000,'Bajar chocolate','','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-21 20:19:15','2025-10-21 20:19:15'),
(26,'PRO_ENSNIBPRO_44MOex_MOExtNiv1_0913','Ori_Sil_2','PRO_ENSNIBPRO_44','MOex_MOExtNiv1_09',NULL,'2','Hora',1.0000,10000.0000,60.0000,1.00,'',1.0000,'UNO','ACT_PHP | 2026-01-01 13:40\n','larevo1111@gmail.com','larevo1111@gmail.com','2025-10-30 22:35:43','2026-01-01 13:40:51'),
(28,'PRO_Enmbom_3aMOin_MOIntNiv1_1215','Ori_Sil_2','PRO_Enmbom_3a','MOin_MOIntNiv1_12','Alistamiento para enmoldar','1','Hora',0.0625,10000.0000,3.7500,1.00,'',1.0000,NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-11-07 16:36:35','2025-11-07 16:36:35'),
(29,'PRO_Enmbom_3aMOin_MOIntNiv1_1216','Ori_Sil_2','PRO_Enmbom_3a','MOin_MOIntNiv1_12','Enmoldado','2','Hora',0.3300,10000.0000,19.8000,1.00,'',2.0000,NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-11-07 17:06:42','2025-11-07 17:06:42'),
(30,'PRO_Enmbom_3aMOin_MOIntNiv1_1217','Ori_Sil_2','PRO_Enmbom_3a','MOin_MOIntNiv1_12','Aseo','4','Hora',0.0650,10000.0000,3.9000,1.00,'',4.0000,NULL,'ACT_PHP | 2026-01-01 16:12\n','jennifercanogarcia@gmail.com','larevo1111@gmail.com','2025-11-07 17:13:29','2026-01-01 16:12:52'),
(31,'PRO_Enmbom_3aS_M_TiedeRep_1618','Ori_Sil_2','PRO_Enmbom_3a','S_M_TiedeRep_16','Tiempo de chocolate en moldes','3','hora',7.0000,NULL,420.0000,1.00,'',3.0000,NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com','2025-11-07 17:24:09','2025-11-07 17:29:06'),
(32,'PRO_EnsProOps1_74Selo_Dom_0219','Ori_Sil_2','PRO_EnsProOps1_74','Selo_Dom_02','domi','4','Und',0.7000,8000.0000,35.0000,0.60,'A',1.0000,'domic','ACT_PHP_PROC | 2026-01-02 12:54##','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-15 18:01:42','2026-01-15 12:17:30'),
(33,'PRO_EnsProOps1_74MOin_MOIntNiv1_1220','Ori_Sil_2','PRO_EnsProOps1_74','MOin_MOIntNiv1_12','mo int al','1','Hora',0.5500,10000.0000,32.8000,1.00,'A',2.0000,'mo 1','','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-15 18:02:44','2026-01-02 10:20:29'),
(34,'PRO_EnsProOps1_74MOin_MOIntNiv1_1221','Ori_Sil_2','PRO_EnsProOps1_74','MOin_MOIntNiv1_12','mo 1 2','2','Hora',0.6000,10000.0000,36.0000,1.00,'',100.0000,'ens','','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-15 18:03:38','2025-12-16 23:38:25'),
(35,'PRO_EnsProOps1_74MOex_MOExtNiv1_0922','Ori_Sil_2','PRO_EnsProOps1_74','MOex_MOExtNiv1_09','dos','2','Hora',1.0000,10000.0000,60.0000,1.00,'',300.0000,NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 23:36:29','2025-12-16 23:38:08'),
(36,'PRO_EnsProOps1_74Selo_FleMer_0723','Ori_Sil_2','PRO_EnsProOps1_74','Selo_FleMer_07','tres','2','Und',0.6000,910000.0000,0.0000,1.00,'',200.0000,'1','ACT_PHP_PROC | 2026-01-02 11:35##ACT_PHP_PROC | 2026-01-02 12:54##','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 23:37:09','2026-01-15 10:13:47'),
(37,'PRO_ENSNIBPRO2_e4MOex_MOExtNiv1_0924','Ori_Sil_2','PRO_ENSNIBPRO2_e4','MOex_MOExtNiv1_09',NULL,'2','Hora',1.0000,10000.0000,60.0000,1.00,'',1.0000,NULL,'ACT_PHP | 2026-01-01 13:40\n','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-18 21:36:39','2026-01-01 13:40:51'),
(38,'PRO_ENSNIBPRO2_e4MOex_MOExtNiv1_0925','Ori_Sil_2','PRO_ENSNIBPRO2_e4','MOex_MOExtNiv1_09',NULL,'2','Hora',0.5000,10000.0000,30.0000,1.00,'',2.0000,'gfgdsf','','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-18 21:36:39','2025-12-18 21:36:39'),
(39,'OS.OS.PRO_EmpChobom250_dcMOin_MOIntNiv1_12cf4','Ori_Sil_2','OS.PRO_EmpChobom250_dc','MOin_MOIntNiv1_12',NULL,'2','Hora',0.1000,10000.0000,6.0000,1.00,NULL,1.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-08 12:59:44','2026-01-08 12:59:44'),
(40,'OS.OS.PRO_EmpChobom500_afMOin_MOIntNiv1_125de','Ori_Sil_2','OS.PRO_EmpChobom500_af','MOin_MOIntNiv1_12',NULL,'2','Hora',0.1000,10000.0000,6.0000,1.00,NULL,1.0000,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-08 13:10:42','2026-01-08 13:10:42');
/*!40000 ALTER TABLE `costos_procedimientos_servicios_mo` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_producto_procedimientos`
--

LOCK TABLES `costos_producto_procedimientos` WRITE;
/*!40000 ALTER TABLE `costos_producto_procedimientos` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_producto_procedimientos` VALUES
(3,'ETI_FRAS_03_PTCre_AREMIEOS130GRS_053','Ori_Sil_2','PTCre_AREMIEOS130GRS_05','ETI_FRAS_03',1,1.0000,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,1.0000,NULL,NULL,'larevo1111@gmail.com','2025-08-04 21:15:27','larevo1111@gmail.com','2025-12-19 01:12:58'),
(4,'ENV_MIEL_01_PTCre_AREMIEOS130GRS_054','Ori_Sil_2','PTCre_AREMIEOS130GRS_05','ENV_MIEL_01',1,1.0000,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,1.0000,NULL,NULL,'larevo1111@gmail.com','2025-08-04 21:15:39','larevo1111@gmail.com','2025-12-19 01:12:58'),
(6,'PPNiv2_CASDECACLTxKL_09_FIL_MIEL_02_6','Ori_Sil_2','PPNiv2_CASDECACLTxKL_09','FIL_MIEL_02',2,1.0000,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,1.0000,NULL,NULL,'larevo1111@gmail.com','2025-08-30 00:23:23','larevo1111@gmail.com','2025-12-19 01:12:58'),
(7,'PPNiv2_CASDECACLTxKL_09_ETI_FRAS_03_7','Ori_Sil_2','PPNiv2_CASDECACLTxKL_09','ETI_FRAS_03',3,1.0000,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,1.0000,NULL,NULL,'larevo1111@gmail.com','2025-08-30 00:23:23','larevo1111@gmail.com','2025-12-19 01:12:58'),
(8,'PPNiv2_CASDECACLTxKL_09_ENV_MIEL_01_8','Ori_Sil_2','PPNiv2_CASDECACLTxKL_09','ENV_MIEL_01',1,1.0000,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,1.0000,NULL,NULL,'larevo1111@gmail.com','2025-08-30 00:23:23','larevo1111@gmail.com','2025-12-19 01:12:58'),
(9,'PTCre_AREMIEOS230GRS_06_FIL_MIEL_02_9','Ori_Sil_2','PTCre_AREMIEOS230GRS_06','FIL_MIEL_02',2,1.0000,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,1.0000,NULL,NULL,'larevo1111@gmail.com','2025-09-10 18:10:36','larevo1111@gmail.com','2025-12-19 01:12:58'),
(10,'PTCre_AREMIEOS230GRS_06_ETI_FRAS_03_10','Ori_Sil_2','PTCre_AREMIEOS230GRS_06','ETI_FRAS_03',3,1.0000,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,1.0000,NULL,NULL,'larevo1111@gmail.com','2025-09-10 18:10:36','larevo1111@gmail.com','2025-12-19 01:12:58'),
(11,'PTCre_AREMIEOS230GRS_06_ENV_MIEL_01_11','Ori_Sil_2','PTCre_AREMIEOS230GRS_06','ENV_MIEL_01',1,1.0000,NULL,NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,1.0000,NULL,NULL,'larevo1111@gmail.com','2025-09-10 18:10:36','larevo1111@gmail.com','2025-12-19 01:12:58'),
(12,'PPNiv1_ALMDECACTOS_04_PRO_Tosalmdecac_10_12','Ori_Sil_2','PPNiv1_ALMDECACTOS_04','PRO_Tosalmdecac_10',1,1.0000,NULL,NULL,NULL,NULL,35.0000,23706.0000,0.0000,406.0000,20000.0000,0.0000,3300.0000,0.0000,1.0000,'kg','SIN COSTO CONJUNTO','larevo1111@gmail.com','2025-09-23 14:04:02','larevo1111@gmail.com','2025-12-19 01:12:58'),
(14,'PTFrusecygra_ALMDECACORGTOS100GRS_02_PRO_EmpAlmdec','Ori_Sil_2','PTFrusecygra_ALMDECACORGTOS100GRS_02','PRO_EmpAlmdecactos100_30',1,1.0000,NULL,NULL,NULL,NULL,3.0000,4318.9917,0.0000,0.3917,248.0000,3070.6000,1000.0000,0.0000,1.0000,'und','SIN COSTO CONJUNTO','ssierra047@gmail.com','2025-09-25 17:24:38','larevo1111@gmail.com','2025-12-19 01:12:58'),
(15,'PPNiv2_NIBDECACLT_80_PRO_MaqTosyDesdeCac_bc_11','Ori_Sil_2','PPNiv2_NIBDECACLT_80','PRO_MaqTosyDesdeCac_bc',1,1.0000,NULL,NULL,NULL,'El estándar es 1,43 porque se necesitan 1,43 kilos de almendra para obtener 1 kilo de nibs, el desperdicio es del 70%',14400.0000,29427.0000,282.0000,0.0000,21000.0000,0.0000,8145.0000,0.0000,1.0000,'kg','SIN COSTO CONJUNTO','jennifercanogarcia@gmail.com','2025-10-03 12:58:20','larevo1111@gmail.com','2025-12-19 01:12:58'),
(17,'PPPP__CHOLT100-REF24H_2c_PRO_Refdenib24hor_5a_12','Ori_Sil_2','PPPP__CHOLT100-REF24H_2c','PRO_Refdenib24hor_5a',1,1.0000,NULL,NULL,NULL,NULL,1560.0000,55254.5600,51.7500,2322.2000,0.0000,42080.6100,10800.0000,0.0000,1.0000,'kg','SIN COSTO CONJUNTO','jennifercanogarcia@gmail.com','2025-10-10 16:29:31','larevo1111@gmail.com','2025-12-19 01:12:58'),
(18,'PTFrusecygra_ALMDECACORGTOS200GRS_03_PRO_EmpAlmdec','Ori_Sil_2','PTFrusecygra_ALMDECACORGTOS200GRS_03','PRO_EmpAlmdecactos200_93',1,1.0000,NULL,NULL,NULL,NULL,3.0000,7617.5900,0.0000,0.3900,476.0000,6141.2000,1000.0000,0.0000,1.0000,'und','SIN COSTO CONJUNTO','larevo1111@gmail.com','2025-10-21 17:28:45','larevo1111@gmail.com','2025-12-19 01:12:58'),
(20,'PPPt__ENSCAS_7a_PRO_ENSNIBPRO_44_6f','Ori_Sil_2','PPPt__ENSCAS_7a','PRO_ENSNIBPRO_44',1,0.3103,25000.0000,NULL,NULL,NULL,0.0000,28195.0647,0.0000,0.0000,0.0000,23307.9202,4887.1446,7757.5000,0.2333,'kg','NVR (VALOR NETO REALIZABLE)','larevo1111@gmail.com','2025-10-30 23:11:59','larevo1111@gmail.com','2025-12-19 01:12:58'),
(21,'PPPt__ENSNIB_00_PRO_ENSNIBPRO_44_f1','Ori_Sil_2','PPPt__ENSNIB_00','PRO_ENSNIBPRO_44',1,0.6890,37000.0000,NULL,NULL,NULL,0.0000,41728.6958,0.0000,0.0000,0.0000,34495.7219,7232.9739,25493.0000,0.7667,'kg','NVR (VALOR NETO REALIZABLE)','larevo1111@gmail.com','2025-10-30 23:16:31','larevo1111@gmail.com','2025-12-19 01:12:58'),
(22,'PPNiv4_CHOLT100-REF24H-_14_PRO_Enmbom_3a_35','Ori_Sil_2','PPNiv4_CHOLT100-REF24H-_14','PRO_Enmbom_3a',1,1.0000,NULL,NULL,NULL,NULL,840.0000,60090.4539,51.7500,209.1439,0.0000,55254.5600,4575.0000,0.0000,1.0000,'kg','SIN COSTO CONJUNTO','jennifercanogarcia@gmail.com','2025-11-07 18:32:41','larevo1111@gmail.com','2025-12-19 01:12:58'),
(23,'PPNiv6_COBCHOCPM73%OSENMX_28_PRO_EnsProOps1_74_98','Ori_Sil_2','PPNiv6_COBCHOCPM73%OSENMX_28','PRO_EnsProOps1_74',1,0.6500,15000.0000,NULL,NULL,NULL,3.0769,138410.5053,8471.1854,2636.6325,14155.6291,100209.3099,12937.7483,9750.0000,0.2583,'meses','NVR (VALOR NETO REALIZABLE)','larevo1111@gmail.com','2025-12-18 19:27:41','larevo1111@gmail.com','2025-12-19 01:12:58'),
(24,'PPNiv1_ExtdeVaienMie_51_PRO_EnsProOps1_74_0a','Ori_Sil_2','PPNiv1_ExtdeVaienMie_51','PRO_EnsProOps1_74',1,2.0000,14000.0000,7000.0000,NULL,NULL,1.0000,129183.1383,7906.4397,2460.8570,13211.9205,93528.6893,12075.2318,28000.0000,0.7417,'meses','NVR (VALOR NETO REALIZABLE)','larevo1111@gmail.com','2025-12-18 19:35:18','larevo1111@gmail.com','2025-12-19 01:12:58');
/*!40000 ALTER TABLE `costos_producto_procedimientos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_recursos_ambientales`
--

LOCK TABLES `costos_recursos_ambientales` WRITE;
/*!40000 ALTER TABLE `costos_recursos_ambientales` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_recursos_ambientales` VALUES
(1,'OS.ELEC.RED','Ori_Sil_2','Electricidad - Red','Energia','Energía eléctrica de red pública','OS.KWH_22',0.420000,'IPCC','1','','','ssierra047@gmail.com','larevo1111@gmail.com','2026-01-26 11:00:00','2026-01-26 11:41:00'),
(2,'OS.ELEC.SOLAR','Ori_Sil_2','Electricidad - Solar','Energia','Energía eléctrica de sistema solar fotovoltaico','OS.KWH_22',0.050000,'Local','1','','','ssierra047@gmail.com','ssierra047@gmail.com','2026-01-26 11:00:00','2026-01-26 11:00:00'),
(3,'OS.ELEC.PLANTA','Ori_Sil_2','Electricidad - Planta eléctrica','Energia','Electricidad generada por planta eléctrica a combustible','OS.KWH_22',0.700000,'DEFRA','1','','','ssierra047@gmail.com','ssierra047@gmail.com','2026-01-26 11:00:00','2026-01-26 11:00:00'),
(4,'OS.ELEC.BIOMASA','Ori_Sil_2','Electricidad - Biomasa','Energia','Electricidad generada a partir de biomasa','OS.KWH_22',0.120000,'IPCC','1','','','ssierra047@gmail.com','ssierra047@gmail.com','2026-01-26 11:00:00','2026-01-26 11:00:00'),
(5,'OS.AGUA.ACUEDUCTO','Ori_Sil_2','Agua - Acueducto','Agua','Agua proveniente de red de acueducto','lt',0.000300,'IPCC','1','','','ssierra047@gmail.com','ssierra047@gmail.com','2026-01-26 11:00:00','2026-01-26 11:00:00'),
(6,'OS.AGUA.RIO','Ori_Sil_2','Agua - Río o quebrada','Agua','Agua captada directamente de fuente natural','lt',0.000050,'Local','1','','','ssierra047@gmail.com','ssierra047@gmail.com','2026-01-26 11:00:00','2026-01-26 11:00:00'),
(7,'OS.AGUA.LLUVIA','Ori_Sil_2','Agua - Lluvia','Agua','Agua recolectada por captación de lluvia','lt',0.000000,'Local','1','','','ssierra047@gmail.com','ssierra047@gmail.com','2026-01-26 11:00:00','2026-01-26 11:00:00'),
(8,'OS.GAS.NATURAL','Ori_Sil_2','Gas natural','Combustible','Gas natural para combustión','m3',1.900000,'IPCC','1','','','ssierra047@gmail.com','ssierra047@gmail.com','2026-01-26 11:00:00','2026-01-26 11:00:00'),
(9,'OS.GAS.PROPANO','Ori_Sil_2','Gas propano','Combustible','Gas propano (GLP)','kg',3.000000,'DEFRA','1','','','ssierra047@gmail.com','ssierra047@gmail.com','2026-01-26 11:00:00','2026-01-26 11:00:00'),
(10,'OS.DIESEL','Ori_Sil_2','Diésel','Combustible','Combustible fósil diésel','lt',2.680000,'DEFRA','1','','','ssierra047@gmail.com','ssierra047@gmail.com','2026-01-26 11:00:00','2026-01-26 11:00:00'),
(11,'OS.GASOLINA','Ori_Sil_2','Gasolina','Combustible','Gasolina corriente','lt',2.310000,'DEFRA','1','','','ssierra047@gmail.com','ssierra047@gmail.com','2026-01-26 11:00:00','2026-01-26 11:00:00'),
(12,'OS.LENA','Ori_Sil_2','Leña','Combustible','Leña utilizada como combustible','kg',1.750000,'IPCC','1','','','ssierra047@gmail.com','ssierra047@gmail.com','2026-01-26 11:00:00','2026-01-26 11:00:00'),
(13,'OS.BIOGAS','Ori_Sil_2','Biogás','Combustible','Biogás generado a partir de residuos orgánicos','m3',0.200000,'Local','1','','','ssierra047@gmail.com','ssierra047@gmail.com','2026-01-26 11:00:00','2026-01-26 11:00:00');
/*!40000 ALTER TABLE `costos_recursos_ambientales` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_residuos`
--

LOCK TABLES `costos_residuos` WRITE;
/*!40000 ALTER TABLE `costos_residuos` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_residuos` VALUES
('OS.031b95e4','Ori_Sil_2','RES-ESP',0.0000,1.500000,'Activo','larevo1111@gmail.com','larevo1111@gmail.com','2026-02-04 09:51:29','2026-02-04 14:54:46'),
('OS.0d5b3f97','Ori_Sil_2','RES-ACE',0.0000,3.000000,'Activo','larevo1111@gmail.com','larevo1111@gmail.com','2026-02-04 09:51:10','2026-02-04 14:54:46'),
('OS.1df46c82','Ori_Sil_2','RES-ESC',0.0000,0.200000,'Activo','larevo1111@gmail.com','larevo1111@gmail.com','2026-02-04 09:50:59','2026-02-04 14:54:46'),
('OS.3254493a','Ori_Sil_2','RES-REC',0.0000,0.050000,'Activo','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-30 22:08:04','2026-02-04 14:54:46'),
('OS.99b625a5','Ori_Sil_2','RES-ELE',0.0000,2.000000,'Activo','larevo1111@gmail.com','larevo1111@gmail.com','2026-02-04 09:51:23','2026-02-04 14:54:46'),
('OS.e74944bc','Ori_Sil_2','RES-BIO',0.0000,5.000000,'Activo','larevo1111@gmail.com','larevo1111@gmail.com','2026-02-03 21:12:09','2026-02-04 14:54:46'),
('OS.e82ffcaf','Ori_Sil_2','RES-PEL',0.0000,6.000000,'Activo','larevo1111@gmail.com','larevo1111@gmail.com','2026-02-04 09:51:16','2026-02-04 14:54:46'),
('OS.f84d6d6b','Ori_Sil_2','RES-NRE',0.0000,1.000000,'Activo','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-30 22:08:22','2026-02-04 14:54:46'),
('OS.fb5c756b','Ori_Sil_2','RES-ORG',0.0000,0.100000,'Activo','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-30 22:05:15','2026-02-04 14:54:46');
/*!40000 ALTER TABLE `costos_residuos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_residuos_destinos`
--

LOCK TABLES `costos_residuos_destinos` WRITE;
/*!40000 ALTER TABLE `costos_residuos_destinos` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_residuos_destinos` VALUES
(1,'OS.DEST.COMPOSTAJE_INTERNO','Ori_Sil_2','Compostaje interno',0.300000,'Transformación del residuo orgánico en abono dentro de la empresa.',1,0,0,'Activo','sistema','sistema','2026-02-04 03:07:42','2026-02-05 23:11:42'),
(2,'OS.DEST.REUSO_INTERNO','Ori_Sil_2','Reuso interno',0.200000,'Reutilización directa del residuo dentro del proceso productivo.',1,0,0,'Activo','sistema','sistema','2026-02-04 03:07:42','2026-02-05 23:11:42'),
(3,'OS.DEST.RECICLAJE_EXTERNO','Ori_Sil_2','Reciclaje externo',0.250000,'Entrega del residuo a un tercero para reciclaje.',1,0,1,'Activo','sistema','sistema','2026-02-04 03:07:42','2026-02-05 23:11:42'),
(4,'OS.DEST.VALORIZACION_EXTERNA','Ori_Sil_2','Valorización externa',0.400000,'Aprovechamiento del residuo por un gestor externo.',1,0,1,'Activo','sistema','sistema','2026-02-04 03:07:42','2026-02-05 23:11:42'),
(5,'OS.DEST.ALMACENAMIENTO_TEMPORAL','Ori_Sil_2','Almacenamiento temporal',1.000000,'Residuo almacenado temporalmente a la espera de destino final.',0,0,0,'Activo','sistema','sistema','2026-02-04 03:07:42','2026-02-05 23:00:16'),
(6,'OS.DEST.ACUMULACION_CONTROLADA','Ori_Sil_2','Acumulación controlada',1.000000,'Acumulación interna bajo control operativo antes de gestión.',0,0,0,'Activo','sistema','sistema','2026-02-04 03:07:42','2026-02-05 23:00:16'),
(7,'OS.DEST.DISPOSICION_FINAL','Ori_Sil_2','Disposición final',1.000000,'Envío del residuo a relleno sanitario u otra disposición definitiva.',0,1,1,'Activo','sistema','sistema','2026-02-04 03:07:42','2026-02-05 23:00:16'),
(8,'OS.DEST.INCINERACION','Ori_Sil_2','Incineración',1.500000,'Eliminación del residuo mediante incineración controlada.',0,1,1,'Activo','sistema','sistema','2026-02-04 03:07:42','2026-02-05 23:11:42'),
(9,'OS.DEST.GESTOR_EXTERNO','Ori_Sil_2','Gestor externo',1.100000,'Entrega del residuo a un gestor autorizado para su manejo.',0,1,1,'Activo','sistema','sistema','2026-02-04 03:07:42','2026-02-05 23:11:42'),
(10,'OS.DEST.RETORNO_PROVEEDOR','Ori_Sil_2','Retorno a proveedor',1.050000,'Residuo devuelto al proveedor para su gestión.',0,1,1,'Activo','sistema','sistema','2026-02-04 03:07:42','2026-02-05 23:11:42'),
(11,'OS.DEST.TRATAMIENTO_ESPECIAL','Ori_Sil_2','Tratamiento especial',1.300000,'Residuo que requiere tratamiento especializado por normativa.',0,1,1,'Activo','sistema','sistema','2026-02-04 03:07:42','2026-02-05 23:11:42');
/*!40000 ALTER TABLE `costos_residuos_destinos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_rutas_producto`
--

LOCK TABLES `costos_rutas_producto` WRITE;
/*!40000 ALTER TABLE `costos_rutas_producto` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_rutas_producto` VALUES
(398,'Ori_Sil_2','PTFrusecygra_ALMDECACORGTOS100GRS_02','PRO_EnsProOps1_74','0',2,'PTFrusecygra_ALMDECACORGTOS100GRS_02','PRO_EnsProOps1_74','2026-01-16 19:51:36'),
(399,'Ori_Sil_2','PTFrusecygra_ALMDECACORGTOS100GRS_02','PRO_EnsProOps1_74','0',1,'PPPt__ENSCAS_7a','PRO_ENSNIBPRO_44','2026-01-16 19:51:36'),
(400,'Ori_Sil_2','PTFrusecygra_ALMDECACORGTOS200GRS_03','PRO_EmpAlmdecactos200_93','0',2,'PTFrusecygra_ALMDECACORGTOS200GRS_03','PRO_EmpAlmdecactos200_93','2026-01-16 19:51:36'),
(401,'Ori_Sil_2','PTFrusecygra_ALMDECACORGTOS200GRS_03','PRO_EmpAlmdecactos200_93','0',1,'PPNiv1_ALMDECACTOS_04','PRO_Tosalmdecac_10','2026-01-16 19:51:36'),
(402,'Ori_Sil_2','PPNiv1_ALMDECACTOS_04','PRO_Tosalmdecac_10','0',1,'PPNiv1_ALMDECACTOS_04','PRO_Tosalmdecac_10','2026-01-16 19:51:36'),
(403,'Ori_Sil_2','PPNiv2_CASDECACLTxKL_09','PRO_MaqTosyDesdeCac_bc','0',1,'PPNiv2_CASDECACLTxKL_09','PRO_MaqTosyDesdeCac_bc','2026-01-16 19:51:36'),
(404,'Ori_Sil_2','PPNiv4_CHOLT100-REF24H-_14','PRO_Enmbom_3a','0',3,'PPNiv4_CHOLT100-REF24H-_14','PRO_Enmbom_3a','2026-01-16 19:51:36'),
(405,'Ori_Sil_2','PPNiv4_CHOLT100-REF24H-_14','PRO_Enmbom_3a','0',2,'PPPP__CHOLT100-REF24H_2c','PRO_Refdenib24hor_5a','2026-01-16 19:51:36'),
(406,'Ori_Sil_2','PPNiv4_CHOLT100-REF24H-_14','PRO_Enmbom_3a','0',1,'PPNiv2_NIBDECACLT_80','PRO_MaqTosyDesdeCac_bc','2026-01-16 19:51:36'),
(407,'Ori_Sil_2','PTChoyder_Cho100Cac250grsBomLT_16','OS.PRO_EmpChobom250_dc','0',4,'PTChoyder_Cho100Cac250grsBomLT_16','OS.PRO_EmpChobom250_dc','2026-01-16 19:51:36'),
(408,'Ori_Sil_2','PTChoyder_Cho100Cac250grsBomLT_16','OS.PRO_EmpChobom250_dc','0',3,'PPNiv4_CHOLT100-REF24H-_14','PRO_Enmbom_3a','2026-01-16 19:51:36'),
(409,'Ori_Sil_2','PTChoyder_Cho100Cac250grsBomLT_16','OS.PRO_EmpChobom250_dc','0',2,'PPPP__CHOLT100-REF24H_2c','PRO_Refdenib24hor_5a','2026-01-16 19:51:36'),
(410,'Ori_Sil_2','PTChoyder_Cho100Cac250grsBomLT_16','OS.PRO_EmpChobom250_dc','0',1,'PPNiv2_NIBDECACLT_80','PRO_MaqTosyDesdeCac_bc','2026-01-16 19:51:36'),
(411,'Ori_Sil_2','PTChoyder_Cho100Cac500grsBomLT_18','OS.PRO_EmpChobom500_af','0',4,'PTChoyder_Cho100Cac500grsBomLT_18','OS.PRO_EmpChobom500_af','2026-01-16 19:51:36'),
(412,'Ori_Sil_2','PTChoyder_Cho100Cac500grsBomLT_18','OS.PRO_EmpChobom500_af','0',3,'PPNiv4_CHOLT100-REF24H-_14','PRO_Enmbom_3a','2026-01-16 19:51:36'),
(413,'Ori_Sil_2','PTChoyder_Cho100Cac500grsBomLT_18','OS.PRO_EmpChobom500_af','0',2,'PPPP__CHOLT100-REF24H_2c','PRO_Refdenib24hor_5a','2026-01-16 19:51:36'),
(414,'Ori_Sil_2','PTChoyder_Cho100Cac500grsBomLT_18','OS.PRO_EmpChobom500_af','0',1,'PPNiv2_NIBDECACLT_80','PRO_MaqTosyDesdeCac_bc','2026-01-16 19:51:36'),
(415,'Ori_Sil_2','PPNiv6_COBCHOCPM73%OSENMX_28','PRO_EnsProOps1_74','0',2,'PPNiv6_COBCHOCPM73%OSENMX_28','PRO_EnsProOps1_74','2026-01-16 19:51:36'),
(416,'Ori_Sil_2','PPNiv6_COBCHOCPM73%OSENMX_28','PRO_EnsProOps1_74','0',1,'PPPt__ENSCAS_7a','PRO_ENSNIBPRO_44','2026-01-16 19:51:36'),
(417,'Ori_Sil_2','PPNiv1_ExtdeVaienMie_51','PRO_EnsProOps1_74','0',2,'PPNiv1_ExtdeVaienMie_51','PRO_EnsProOps1_74','2026-01-16 19:51:36'),
(418,'Ori_Sil_2','PPNiv1_ExtdeVaienMie_51','PRO_EnsProOps1_74','0',1,'PPPt__ENSCAS_7a','PRO_ENSNIBPRO_44','2026-01-16 19:51:36'),
(419,'Ori_Sil_2','PPNiv2_NIBDECACLT_80','PRO_MaqTosyDesdeCac_bc','0',1,'PPNiv2_NIBDECACLT_80','PRO_MaqTosyDesdeCac_bc','2026-01-16 19:51:36'),
(420,'Ori_Sil_2','PPPP__CHOLT100-REF24H_2c','PRO_Refdenib24hor_5a','0',2,'PPPP__CHOLT100-REF24H_2c','PRO_Refdenib24hor_5a','2026-01-16 19:51:36'),
(421,'Ori_Sil_2','PPPP__CHOLT100-REF24H_2c','PRO_Refdenib24hor_5a','0',1,'PPNiv2_NIBDECACLT_80','PRO_MaqTosyDesdeCac_bc','2026-01-16 19:51:36'),
(422,'Ori_Sil_2','PPPt__ENSNIB_00','PRO_ENSNIBPRO_44','0',1,'PPPt__ENSNIB_00','PRO_ENSNIBPRO_44','2026-01-16 19:51:36'),
(423,'Ori_Sil_2','PPPt__ENSCAS_7a','PRO_ENSNIBPRO_44','0',1,'PPPt__ENSCAS_7a','PRO_ENSNIBPRO_44','2026-01-16 19:51:36');
/*!40000 ALTER TABLE `costos_rutas_producto` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_servicios_mo`
--

LOCK TABLES `costos_servicios_mo` WRITE;
/*!40000 ALTER TABLE `costos_servicios_mo` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_servicios_mo` VALUES
(1,'Sefi_Combol_01','Ori_Sil_2','Activo','','Comision bold','Und','S_Serfin',1.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','','','ssierra047@gmail.com','ssierra047@gmail.com'),
(2,'Selo_Dom_02','Ori_Sil_2','Activo','','Domicilio','Und','S_Serlog',8000.0000,8000.0000,8000.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','','','ssierra047@gmail.com','ssierra047@gmail.com'),
(3,'Mapr_ENMDECHOXKG_03','Ori_Sil_2','Activo','','ENMOLDADO DE CHOCOLATE X KG','kg','S_Maqpro',5000.0000,5000.0000,5000.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','','','ssierra047@gmail.com','ssierra047@gmail.com'),
(4,'Mapr_ENVMIE_04','Ori_Sil_2','Activo','','ENVASADO MIEL','kg','S_Maqpro',560.0000,60.0000,20.0000,'0000-00-00 00:00:00','2026-01-01 12:28:16','','','ssierra047@gmail.com','larevo1111@gmail.com'),
(5,'Mapr_FILMIE_05','Ori_Sil_2','Activo','','FILTRADO MIEL','kg','S_Maqpro',200.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','','','ssierra047@gmail.com','ssierra047@gmail.com'),
(6,'Selo_FLEBUCMAQCAC_06','Ori_Sil_2','Activo','','FLETE BUCARAMANGA MAQUILA CACAO','kg','S_Serlog',1000.0000,1000.0000,1000.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','','','ssierra047@gmail.com','ssierra047@gmail.com'),
(7,'Selo_FleMer_07','Ori_Sil_2','Activo','','Flete Mercadolibre','Und','S_Serlog',9100.0000,0.0000,0.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','','','ssierra047@gmail.com','ssierra047@gmail.com'),
(8,'Mapr_MAQOBTDENIBDECAC_08','Ori_Sil_2','Activo','','MAQUILA OBTENCION DE NIBS DE CACAO','kg','S_Maqpro',4845.0000,4845.0000,4845.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','','','ssierra047@gmail.com','ssierra047@gmail.com'),
(9,'MOex_MOExtNiv1_09','Ori_Sil_2','Activo','','MO Externa Nivel 1','Hora','S_MOext',10000.0000,10000.0000,10000.0000,'0000-00-00 00:00:00','2026-01-01 13:40:51','','--Actualizados: 2 | Errores unidad: 0 | 2026-01-01 13:40--','ssierra047@gmail.com','larevo1111@gmail.com'),
(10,'MOex_MOExtNiv2_10','Ori_Sil_2','Activo','','MO Externa Nivel 2','Hora','S_MOext',20000.0000,20000.0000,20000.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','','','ssierra047@gmail.com','ssierra047@gmail.com'),
(11,'MOex_MOExtNiv3_11','Ori_Sil_2','Activo','','MO Externa Nivel 3','Hora','S_MOext',30000.0000,30000.0000,30000.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','','','ssierra047@gmail.com','ssierra047@gmail.com'),
(12,'MOin_MOIntNiv1_12','Ori_Sil_2','Activo','','MO Interna Nivel 1','Hora','S_MOint',10000.0000,10000.0000,10000.0000,'0000-00-00 00:00:00','2026-01-01 16:12:52','','--Actualizados: 1 | Errores unidad: 0 | 2026-01-01 16:12--','ssierra047@gmail.com','larevo1111@gmail.com'),
(13,'MOin_MOIntNiv2_13','Ori_Sil_2','Activo','','MO Interna Nivel 2','Hora','S_MOint',15000.0000,15000.0000,15000.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','','','ssierra047@gmail.com','ssierra047@gmail.com'),
(14,'MOin_MOIntNiv3_14','Ori_Sil_2','Activo','','MO Interna Nivel 3','Hora','S_MOint',20000.0000,20000.0000,20000.0000,'0000-00-00 00:00:00','0000-00-00 00:00:00','','','ssierra047@gmail.com','ssierra047@gmail.com'),
(240,'S_S_LogInt_15','Ori_Sil_2','Activo',NULL,'Logistica Interna','hora','S_Serlog',25000.0000,NULL,NULL,'2025-10-03 12:47:48','2025-10-03 12:47:48',NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com'),
(241,'S_M_TiedeRep_16','Ori_Sil_2','Activo',NULL,'Tiempo de Reposo','hora','S_MOint',NULL,NULL,NULL,'2025-11-07 17:24:13','2025-11-07 17:24:13',NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com'),
(242,'S_M_TiedeMaq_128','Ori_Sil_2','Activo',NULL,'Tiempo de Maquina','hora','S_MOint',NULL,NULL,NULL,'2025-11-07 17:24:13','2025-11-07 17:24:13',NULL,'','jennifercanogarcia@gmail.com','jennifercanogarcia@gmail.com');
/*!40000 ALTER TABLE `costos_servicios_mo` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_tipos_procedimientos`
--

LOCK TABLES `costos_tipos_procedimientos` WRITE;
/*!40000 ALTER TABLE `costos_tipos_procedimientos` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_tipos_procedimientos` VALUES
(1,'PROD','Ori_Sil_2','Produccion','Procesos que transforman materia prima o insumos en productos elaborados',1,'ssierra047@gmail.com','2025-07-30','larevo1111@gmail.com','2026-01-24 16:00:41'),
(2,'ALIS','Ori_Sil_2','Alistamiento','Preparación previa de utensilios y materias primas o insumos, moldes, empaques o espacios antes de la producción',0,'ssierra047@gmail.com','2025-07-30','ssierra047@gmail.com','2025-07-30 00:00:00'),
(3,'EMPA','Ori_Sil_2','Empaque','Empaquetado final, preparacion para transportadora o envio',0,'ssierra047@gmail.com','2025-07-30','ssierra047@gmail.com','2025-07-30 00:00:00'),
(4,'VENT','Ori_Sil_2','Gestión Comercial / Ventas','Actividades del área comercial',0,'ssierra047@gmail.com','2025-07-30','ssierra047@gmail.com','2025-07-30 00:00:00'),
(5,'LIMP','Ori_Sil_2','Orden y Aseo','Sanitación y limpieza de herramientas, superficies, áreas y utensilios de trabajo, Clasificación de materiales, corte y disposición de etiquetas, rotulado, ubicación de herramientas y limpieza organizacional',0,'ssierra047@gmail.com','2025-07-30','ssierra047@gmail.com','2025-07-30 00:00:00'),
(6,'MATVENT','Ori_Sil_2','Material POP y Ventas','Montaje, armado, transformacion de material de ventas o publicitario',0,'ssierra047@gmail.com','2025-07-30','ssierra047@gmail.com','2025-07-30 00:00:00'),
(7,'MANT','Ori_Sil_2','Mantenimiento','Reparación, ajuste o mantenimiento preventivo y correctivo de equipos e infraestructura',0,'ssierra047@gmail.com','2025-07-30','ssierra047@gmail.com','2025-07-30 00:00:00'),
(8,'INST','Ori_Sil_2','Instalaciones Técnicas','Montajes eléctricos, cableado, estructura técnica, adecuación de espacios',0,'ssierra047@gmail.com','2025-07-30','ssierra047@gmail.com','2025-07-30 00:00:00'),
(9,'LOGI','Ori_Sil_2','Logística / Inventarios','Conteos físicos, ajustes de stock, transferencias y recepción de materiales',0,'ssierra047@gmail.com','2025-07-30','ssierra047@gmail.com','2025-07-30 00:00:00'),
(10,'COMP','Ori_Sil_2','Compras','Gestión y verificación de insumos, recepción, validación de calidad y precios',0,'ssierra047@gmail.com','2025-07-30','ssierra047@gmail.com','2025-07-30 00:00:00'),
(11,'SIST','Ori_Sil_2','Sistemas y Registros','Elaboración de órdenes, fichas técnicas, procedimientos y trazabilidad digital',0,'ssierra047@gmail.com','2025-07-30','ssierra047@gmail.com','2025-07-30 00:00:00'),
(12,'DESA','Ori_Sil_2','Desarrollo y Diseño','Creación, mejora o prueba de nuevos productos, fórmulas, presentaciones o recetas',0,'ssierra047@gmail.com','2025-07-30','ssierra047@gmail.com','2025-07-30 00:00:00');
/*!40000 ALTER TABLE `costos_tipos_procedimientos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_tipos_residuos`
--

LOCK TABLES `costos_tipos_residuos` WRITE;
/*!40000 ALTER TABLE `costos_tipos_residuos` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_tipos_residuos` VALUES
('RES-ACE','Aceites y grasas','Aceites usados y grasas de origen vegetal o mineral.','','','2026-01-30 02:51:01','2026-01-30 02:51:01'),
('RES-BIO','Biosanitario','Residuos con riesgo biológico o sanitario. Ej: guantes, tapabocas, material contaminado.','','','2026-01-30 02:51:01','2026-01-30 02:51:01'),
('RES-ELE','Electrónicos','Residuos de aparatos eléctricos y electrónicos. Ej: cables, tarjetas, baterías.','','','2026-01-30 02:51:01','2026-01-30 02:51:01'),
('RES-ESC','Escombros','Residuos de construcción, demolición o adecuaciones. Ej: concreto, ladrillo, tierra.','','','2026-01-30 02:51:01','2026-01-30 02:51:01'),
('RES-ESP','Especial / Otros','Residuos que requieren manejo particular y no encajan en otras categorías.','','','2026-01-30 02:51:01','2026-01-30 02:51:01'),
('RES-NRE','No reciclable','Residuos que no pueden reciclarse ni aprovecharse. Ej: icopor sucio, empaques contaminados.','','','2026-01-30 02:51:01','2026-01-30 02:51:01'),
('RES-ORG','Orgánico','Residuos biodegradables de origen vegetal o animal. Ej: restos de comida, residuos agrícolas.','','','2026-01-30 02:51:01','2026-01-30 02:51:01'),
('RES-PEL','Peligroso','Residuos con características corrosivas, reactivas, tóxicas o inflamables.','','','2026-01-30 02:51:01','2026-01-30 02:51:01'),
('RES-REC','Reciclable','Residuos aprovechables que pueden reciclarse. Ej: papel, cartón, plástico, vidrio, metales.','','','2026-01-30 02:51:01','2026-01-30 02:51:01');
/*!40000 ALTER TABLE `costos_tipos_residuos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_unidades`
--

LOCK TABLES `costos_unidades` WRITE;
/*!40000 ALTER TABLE `costos_unidades` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_unidades` VALUES
('cm','Ori_Sil_2','cm','Centímetro','LONGITUD',0.010000,NULL,'ssierra047@gmail.com','larevo1111@gmail.com','2025-07-01 00:00:00','2025-10-24 12:04:41'),
('cm2','Ori_Sil_2','cm2','Centímetro cuadrado','AREA',NULL,NULL,'ssierra047@gmail.com','larevo1111@gmail.com','2025-07-01 00:00:00','2025-10-22 21:05:12'),
('cm3','Ori_Sil_2','cm3','Centímetro cúbico','VOLUMEN',0.001000,NULL,'ssierra047@gmail.com','larevo1111@gmail.com','2025-07-01 00:00:00','2025-10-24 12:06:17'),
('dia','Ori_Sil_2','dia','Tiempo en días','TIEMPO',1440.000000,NULL,'ssierra047@gmail.com','larevo1111@gmail.com','2025-07-01 00:00:00','2025-10-24 12:02:10'),
('g','Ori_Sil_2','g','Gramo','MASA',0.001000,NULL,'ssierra047@gmail.com','larevo1111@gmail.com','2025-07-01 00:00:00','2025-10-22 21:06:48'),
('hoja','Ori_Sil_2','hoja','Hoja de papel, etiqueta o impresión',NULL,NULL,NULL,'ssierra047@gmail.com','ssierra047@gmail.com','2025-07-01 00:00:00','2025-07-01 00:00:00'),
('hora','Ori_Sil_2','hora','Tiempo en horas (MO, maquinaria)','TIEMPO',60.000000,NULL,'ssierra047@gmail.com','larevo1111@gmail.com','2025-07-01 00:00:00','2025-10-22 21:09:38'),
('kg','Ori_Sil_2','kg','Kilogramo','MASA',1.000000,NULL,'ssierra047@gmail.com','larevo1111@gmail.com','2025-07-01 00:00:00','2025-10-22 21:11:54'),
('kw','Ori_Sil_2','kw','Kilovatio - energía',NULL,NULL,NULL,'ssierra047@gmail.com','ssierra047@gmail.com','2025-07-01 00:00:00','2025-07-01 00:00:00'),
('lt','Ori_Sil_2','lt','Litro','VOLUMEN',1.000000,NULL,'ssierra047@gmail.com','larevo1111@gmail.com','2025-07-01 00:00:00','2025-10-22 21:14:09'),
('m3','Ori_Sil_2','mt3','Metro cúbico','VOLUMEN',1.000000,NULL,'ssierra047@gmail.com','larevo1111@gmail.com','2025-07-01 00:00:00','2025-10-24 12:08:22'),
('meses','Ori_Sil_2','meses',NULL,'TIEMPO',43200.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-10-22 21:10:55','2025-10-24 12:12:35'),
('mg','Ori_Sil_2','mg','Miligramo','MASA',0.000001,NULL,'ssierra047@gmail.com','larevo1111@gmail.com','2025-07-01 00:00:00','2025-10-22 21:12:11'),
('minuto','Ori_Sil_2','minuto','Tiempo en minutos','TIEMPO',1.000000,NULL,'ssierra047@gmail.com','larevo1111@gmail.com','2025-07-01 00:00:00','2025-10-22 20:27:12'),
('ml','Ori_Sil_2','ml','Mililitro','VOLUMEN',0.001000,NULL,'ssierra047@gmail.com','larevo1111@gmail.com','2025-07-01 00:00:00','2025-10-24 12:07:20'),
('mt','Ori_Sil_2','mt','Metro lineal','LONGITUD',1.000000,NULL,'ssierra047@gmail.com','larevo1111@gmail.com','2025-07-01 00:00:00','2025-10-24 12:05:32'),
('mt2','Ori_Sil_2','mt2','Metro cuadrado','AREA',1.000000,NULL,'ssierra047@gmail.com','larevo1111@gmail.com','2025-07-01 00:00:00','2025-10-24 12:09:18'),
('NA_20','Ori_Sil_2','NA','No Aplica',NULL,NULL,NULL,'ssierra047@gmail.com','ssierra047@gmail.com','2025-10-10 13:55:12','2025-10-10 13:55:12'),
('OS.KWH_22','Ori_Sil_2','Kwh',NULL,'ENERGIA',1.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-26 11:25:49','2026-01-26 11:25:49'),
('paquete','Ori_Sil_2','paquete','Conjunto cerrado de unidades','CANTIDAD',NULL,NULL,'ssierra047@gmail.com','larevo1111@gmail.com','2025-07-01 00:00:00','2025-10-24 12:02:28'),
('segundo','Ori_Sil_2','segundo','Tiempo en segundos','TIEMPO',0.016660,NULL,'ssierra047@gmail.com','larevo1111@gmail.com','2025-07-01 00:00:00','2025-10-22 20:20:51'),
('und','Ori_Sil_2','und','Unidad individual','CANTIDAD',1.000000,NULL,'ssierra047@gmail.com','larevo1111@gmail.com','2025-07-01 00:00:00','2025-10-24 12:09:54');
/*!40000 ALTER TABLE `costos_unidades` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `costos_unidades_tipos`
--

LOCK TABLES `costos_unidades_tipos` WRITE;
/*!40000 ALTER TABLE `costos_unidades_tipos` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `costos_unidades_tipos` VALUES
('ACELERACION','Aceleración','m/s²','Cambio de velocidad por tiempo. Base: m/s².','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('ACTIVIDAD','Actividad radiactiva','Bq','Desintegraciones por segundo. Base: becquerel.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('ALMACENAJE','Capacidad de almacenamiento','GB','Unidades digitales de datos. Base: gigabyte.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('ANGULO','Ángulo','°','Medidas de rotación o inclinación. Base: grado.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('AREA','Área','m2','Medidas de superficie o extensión. Base: metro cuadrado.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('CANTIDAD','Cantidad','unidad','Medidas discretas de conteo. Base: unidad.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('CAPACIDAD_TERMICA','Capacidad térmica','J/°C','Cantidad de energía necesaria por grado.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('CARGA','Carga eléctrica','C','Cantidad de electricidad. Base: coulomb.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('CONCENTRACION','Concentración','mol/L','Cantidad de sustancia por volumen. Base: mol/L.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('CONDUCT_TERMICA','Conductividad térmica','W/mK','Transferencia de calor por distancia. Base: watt por metro-kelvin.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('CORRIENTE','Corriente eléctrica','A','Flujo de carga eléctrica. Base: amperio.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('DENSIDAD','Densidad','kg/L','Relación masa/volumen. Base: kilogramo por litro.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('DENSIDAD_ENER','Densidad energética','kJ/kg','Energía por masa. Base: kilojoule por kilogramo.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('ENERGIA','Energía','J','Capacidad de realizar trabajo. Base: joule.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('FACTOR','Factor','adim.','Medida adimensional, sin unidades físicas.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('FLUJO_MASA','Flujo másico','kg/s','Masa por unidad de tiempo. Base: kg/s.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('FLUJO_VOLUMEN','Flujo volumétrico','L/s','Volumen por unidad de tiempo. Base: litro por segundo.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('FRECUENCIA','Frecuencia','Hz','Número de ciclos por segundo. Base: hertz.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('FUERZA','Fuerza','N','Interacción que produce movimiento. Base: newton.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('ILUMINANCIA','Iluminancia','lux','Cantidad de luz sobre una superficie. Base: lux.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('LONGITUD','Longitud','mt','Medidas de distancia o tamaño lineal. Base: metro.','Activa','system','larevo1111@gmail.com','2025-10-24 16:43:29','2025-10-24 12:03:30'),
('MASA','Masa','kg','Medidas de masa o peso. Base: kilogramo.','Activa','system','larevo1111@gmail.com','2025-10-24 16:43:29','2025-10-24 12:14:40'),
('MONEDA','Moneda','COP','Valor económico; base depende del país.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('PH','pH','pH','Medida del potencial de hidrógeno. Escala logarítmica.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('PORCENTAJE','Porcentaje','%','Unidades relativas o proporcionales.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('POTENCIA','Potencia','W','Tasa de transferencia de energía. Base: watt.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('PRESION','Presión','Pa','Fuerza aplicada por área. Base: pascal.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('PUREZA','Pureza','%','Grado de concentración o pureza. Base: 100%.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('RADIACION','Radiación','Gy','Energía absorbida por masa. Base: gray.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('RENDIMIENTO','Rendimiento','%','Relación entre producto obtenido y esperado.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('RESISTENCIA','Resistencia eléctrica','Ω','Oposición al flujo de corriente. Base: ohmio.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('TASA','Tasa','%/año','Tasa de variación o interés. Base: porcentaje anual.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('TEMPERATURA','Temperatura','°C','Medidas térmicas. Base: grado Celsius.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('TIEMPO','Tiempo','minuto','Medidas de duración o intervalo. Base: minuto.','Activa','system','larevo1111@gmail.com','2025-10-24 16:43:29','2025-10-24 12:01:09'),
('VELOCIDAD','Velocidad','m/s','Distancia recorrida en un tiempo. Base: metro por segundo.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('VISCOCIDAD','Viscosidad dinámica','Pa·s','Resistencia de un fluido a fluir. Base: pascal-segundo.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('VOLTAJE','Voltaje','V','Diferencia de potencial eléctrico. Base: voltio.','Activa','system',NULL,'2025-10-24 16:43:29','2025-10-24 16:43:29'),
('VOLUMEN','Volumen','lt','Medidas de capacidad o volumen. Base: litro.','Activa','system','larevo1111@gmail.com','2025-10-24 16:43:29','2025-10-24 12:14:11');
/*!40000 ALTER TABLE `costos_unidades_tipos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `din_categorias_egresos`
--

LOCK TABLES `din_categorias_egresos` WRITE;
/*!40000 ALTER TABLE `din_categorias_egresos` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `din_categorias_egresos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `din_categorias_ingresos`
--

LOCK TABLES `din_categorias_ingresos` WRITE;
/*!40000 ALTER TABLE `din_categorias_ingresos` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `din_categorias_ingresos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `din_cuentas`
--

LOCK TABLES `din_cuentas` WRITE;
/*!40000 ALTER TABLE `din_cuentas` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `din_cuentas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `din_egresos`
--

LOCK TABLES `din_egresos` WRITE;
/*!40000 ALTER TABLE `din_egresos` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `din_egresos` VALUES
('OS','2025-04-01','larevo1111@gmail.com',NULL,'0e387d57','O01. OS GENERAL','O01.02. Impuestos','Deivy Andres Gonzales','CC','74084937',NULL,NULL,'Vereda Mazo sector los vasquez','3116768236','Medellin',NULL,323.00,NULL,NULL,'Bancolombia Ahorros',NULL,'','','','','/Ingresos y Egresos/OS/abril/Egresos/ abril - 0e387d57 - Deivy Andres Gonzales.pdf','23:22:19'),
('TIERRITA','2025-04-01','larevo1111@gmail.com','Soporte de pago','47fd8f04','T01. La Tierrita General','T01.01. Ferreteria Tierrita',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ff',NULL,54345.00,88.00,NULL,'LA TIERRITA C. MENOR',NULL,'NULL','NULL','','','NULL','23:18:24');
/*!40000 ALTER TABLE `din_egresos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `din_filtro_egresos`
--

LOCK TABLES `din_filtro_egresos` WRITE;
/*!40000 ALTER TABLE `din_filtro_egresos` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `din_filtro_egresos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `din_filtro_ingresos`
--

LOCK TABLES `din_filtro_ingresos` WRITE;
/*!40000 ALTER TABLE `din_filtro_ingresos` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `din_filtro_ingresos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `din_ingresos`
--

LOCK TABLES `din_ingresos` WRITE;
/*!40000 ALTER TABLE `din_ingresos` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `din_ingresos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `din_traslados`
--

LOCK TABLES `din_traslados` WRITE;
/*!40000 ALTER TABLE `din_traslados` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `din_traslados` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `inv_bodegas`
--

LOCK TABLES `inv_bodegas` WRITE;
/*!40000 ALTER TABLE `inv_bodegas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `inv_bodegas` VALUES
(1,'1','Ori_Sil_2','Principal','General',NULL,NULL,NULL,1,'Activa','ssierra047@gmail.com','larevo1111@gmail.com','2025-11-04 13:46:03','2026-01-24 12:29:42'),
(2,'OS.67566c75','Ori_Sil_2','Ensa santy','General',NULL,NULL,NULL,0,'Activa','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-11 19:39:44','2026-01-24 12:29:41');
/*!40000 ALTER TABLE `inv_bodegas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `inv_tipos_pp`
--

LOCK TABLES `inv_tipos_pp` WRITE;
/*!40000 ALTER TABLE `inv_tipos_pp` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `inv_tipos_pp` VALUES
('PP.DEVUELTO','Devuelto / Reingresado','Producto que regresó al inventario por devolución, error logístico o ajuste.','Activo','SYSTEM','larevo1111@gmail.com','2026-01-23 00:00:00','2026-01-24 12:08:02'),
('PP.MUESTRA','Muestra / Consumo no comercial','Producto destinado a pruebas, degustaciones o muestras. No destinado a venta.','Activo','SYSTEM','SYSTEM','2026-01-23 00:00:00','2026-01-23 00:00:00'),
('PP.NORMAL','Normal','Producto estándar en proceso o terminado, apto para producción normal y venta.','Activo','SYSTEM','larevo1111@gmail.com','2026-01-23 00:00:00','2026-01-24 12:08:09'),
('PP.OBSOLETO','Obsoleto / Fuera de especificación','Producto válido físicamente pero no comercializable por norma, etiqueta, fecha o versión.','Activo','SYSTEM','SYSTEM','2026-01-23 00:00:00','2026-01-23 00:00:00'),
('PP.RECHAZADO.NO_REPROCESABLE','Rechazado – No reprocesable','Producto rechazado definitivamente por daño, contaminación o riesgo. No recuperable.','Activo','SYSTEM','larevo1111@gmail.com','2026-01-23 00:00:00','2026-01-24 12:08:09'),
('PP.RECHAZADO.REPROCESABLE','Rechazado – Reprocesable','Producto rechazado por calidad o forma, que puede entrar a un reproceso productivo.','Activo','SYSTEM','SYSTEM','2026-01-23 00:00:00','2026-01-23 00:00:00');
/*!40000 ALTER TABLE `inv_tipos_pp` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `menu_ppal`
--

LOCK TABLES `menu_ppal` WRITE;
/*!40000 ALTER TABLE `menu_ppal` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `menu_ppal` VALUES
('120dc746','Usuarios','SYSOP','Ori_Sil_2/Menu Ppal/Usuarios//120dc746.icono.114922.png','SU+ Usuarios',1,NULL,NULL),
('15e68c7a','Ordenes de produccion','PRODUCCION','Ori_Sil_2/Menu Ppal/Ordenes de produccion//15e68c7a.icono.105643.png','Produccion',1,'PRODUCCION_CALIDAD , PRODUCCION_CONSULTA , PRODUCCION_OPERADOR , PRODUCCION_SUPERUSUARIO , PRODUCCION_SUPERVISOR','OPs, consumos, lotes'),
('38b364cf','Tipos de Procedimientos','COSTOS','Ori_Sil_2/Menu Ppal/Tipos de Procedimientos//38b364cf.icono.113809.png','SU Tipos Procedimientos',9,NULL,'Tipos o clases de procedimientos'),
('3a8defdb','Areas de la empresa','ADMON EMPRESA','Ori_Sil_2/Menu Ppal/Areas de la empresa//3a8defdb.icono.120501.png','SU Areas',1,NULL,NULL),
('4194760f','Lista de estados posibles en OPs (ESTRUCTURAL)','SYSOP','Ori_Sil_2/Menu Ppal/Lista de estados posibles en OPs (ESTRUCTURAL)//4194760f.icono.120045.png','SU+ Lista Estados OP',6,NULL,NULL),
('487ae23f','Fases proceso productivo','COSTOS','Ori_Sil_2/Menu Ppal/Fases proceso productivo//487ae23f.icono.111556.png','Fases Productivas',6,NULL,NULL),
('6da45e20','Costos, productos y Procedimientos','PRINCIPAL','Ori_Sil_2/Menu Ppal/Productos, Costos y Procedimientos//6da45e20.icono.070111.png','Menu Costos',1,NULL,'Gestión de maestras de productos, maestras de costos, procedimientos, formulas, unidades etc'),
('71b3c05f','Bodegas','INVENTARIO','Ori_Sil_2/Menu Ppal/Bodegas//71b3c05f.icono.113156.png','Bodegas',1,NULL,'Maestra de Bodegas registradas en la empresa'),
('7cfe95f6','Tabla de Permisos','SYSOP','Ori_Sil_2/Menu Ppal/Tabla de Permisos//7cfe95f6.icono.115444.png','SU+ Sys Permisos',3,NULL,NULL),
('83d243f5','Administracion Empresa','PRINCIPAL','Ori_Sil_2/Menu Ppal/Supe-Usuario Empresa//83d243f5.icono.072500.png','Menu admon empresa',15,NULL,'Configuraciones de la empresa como'),
('9125657f','Tipos de OP (SU)','PRODUCCION','Ori_Sil_2/Menu Ppal/Tipos de OP (SU)//9125657f.icono.110547.png','SU Tipos de OPs',2,'PRODUCCION_SUPERUSUARIO',NULL),
('9bfe10f5','Empresas','SYSOP','Ori_Sil_2/Menu Ppal/Empresas//9bfe10f5.icono.114425.png','SU+ Empresas',2,NULL,'Empresas con acceso'),
('b2a3cfde','Tipos de unidad de medida (ESTRUCTURAL)','SYSOP','Ori_Sil_2/Menu Ppal/Tipos de unidad de medida (ESTRUCTURAL)//b2a3cfde.icono.115837.png','SU+ Tipos Unidad',4,NULL,'TABLA DELICADA Y ESTRUCTURAL'),
('b66917e0','Grupos productos','COSTOS','Ori_Sil_2/Menu Ppal/Grupos productos//b66917e0.icono.084431.png','Grupos productos',2,NULL,NULL),
('c30d4ae0','SYSOP','PRINCIPAL','Ori_Sil_2/Menu Ppal/SYSOP//c30d4ae0.icono.072555.png','Menu SYSOP',20,NULL,'Espacio exclusivo para el configurador y administrador del sistema'),
('d4e0723d','Categorias articulos y productos','COSTOS','Ori_Sil_2/Menu Ppal/Categorias articulos y productos//d4e0723d.icono.084921.png','Categorias',5,NULL,NULL),
('d92891dd','Inventario','PRINCIPAL','Ori_Sil_2/Menu Ppal/Inventario//d92891dd.icono.091225.png','Menu Inventarios',3,NULL,'Gestion de inventarios, bodegas,, etc'),
('d99a8cd9','Produccion','PRINCIPAL','Ori_Sil_2/Menu Ppal/Produccion//d99a8cd9.icono.070036.png','Menu Produccion',2,'PRODUCCION_CALIDAD , PRODUCCION_CONSULTA , PRODUCCION_OPERADOR , PRODUCCION_SUPERUSUARIO , PRODUCCION_SUPERVISOR','En este modulo puede consultar y realizar ordenes de producción'),
('e576cbf6','Productos','COSTOS','Ori_Sil_2/Menu Ppal/Productos//e576cbf6.icono.083919.png','Productos',1,NULL,NULL),
('f3208b27','Maestra de unidades','COSTOS','Ori_Sil_2/Menu Ppal/Maestra de unidades//f3208b27.icono.113207.png','SU Maestra Unidades',8,NULL,NULL),
('f6e491e2','Maestras de costos','COSTOS','Ori_Sil_2/Menu Ppal/Maestras de costos//f6e491e2.icono.085818.png','Maestras Costos Dash',4,NULL,NULL),
('fb8dd4e7','Procedimientos','COSTOS','Ori_Sil_2/Menu Ppal/Procedimientos//fb8dd4e7.icono.090352.png','Procedimientos',3,NULL,NULL);
/*!40000 ALTER TABLE `menu_ppal` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `prod_estados_op`
--

LOCK TABLES `prod_estados_op` WRITE;
/*!40000 ALTER TABLE `prod_estados_op` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `prod_estados_op` VALUES
(1,1,'OP','Planeada','Orden creada y programada. Editable libremente antes de iniciar.','No finalizada','2025-11-19 00:00:00','2025-11-19 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com'),
(2,2,'OP','Liberada','Aprobada para ejecución. Se confirma disponibilidad de recursos o condiciones.','No finalizada','2025-11-19 00:00:00','2025-11-19 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com'),
(3,3,'OP','En proceso','El procedimiento está en ejecución. Se registran consumos y avances.','No finalizada','2025-11-19 00:00:00','2025-11-19 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com'),
(4,4,'OP','Producida','Ejecución temporalmente detenida por condiciones externas o internas.','No finalizada','2025-11-19 00:00:00','2025-11-19 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com'),
(5,5,'OP','En revision','Estado donde se realiza la revisión de calidad, auditoria de consumos y productos. Es la ultima oportunidad para validar todos los consumos y lotes.\r\nAl cambiar a este estado los consumos y lotes pasan automáticamente a estado VALIDADOS, pero permite devolverlos.','No finalizada','2025-11-21 05:40:00','2025-11-21 05:40:00','ssierra047@gmail.com','ssierra047@gmail.com'),
(10,1,'CONSUMO','Pendiente reporte real','Pendiente de reporte del consumo real.','No finalizada','2025-11-19 00:00:00','2025-11-19 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com'),
(11,2,'CONSUMO','Reportado','Consumo real reportado por el operario.','No finalizada','2025-11-19 00:00:00','2025-11-19 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com'),
(12,3,'CONSUMO','Validado','Consumo real revisado y validado.','Finalizada','2025-11-19 00:00:00','2025-11-19 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com'),
(13,1,'LOTE','Pendiente reporte real','El lote está pendiente de registrar su producción real.','No finalizada','2025-11-19 00:00:00','2025-11-19 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com'),
(14,2,'LOTE','Reportado','Se registró la cantidad real producida del lote.','No finalizada','2025-11-19 00:00:00','2025-11-19 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com'),
(15,3,'LOTE','Revisado Aprobado','El lote fue revisado y aprobado en control de calidad.','Finalizada','2025-11-19 00:00:00','2025-11-19 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com'),
(16,4,'LOTE','Revisado Rechazado','El lote fue revisado y rechazado en control de calidad.','Finalizada','2025-11-19 00:00:00','2025-11-19 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com'),
(17,1,'RESIDUO','Reportado','Residuo registrado por el operario durante o al finalizar la orden.','No finalizada','2026-02-04 02:45:12','2026-02-04 02:45:12','ssierra047@gmail.com','ssierra047@gmail.com'),
(18,2,'RESIDUO','Validado','Residuo revisado y validado. Listo para ser considerado en costos e impacto.','Finalizada','2026-02-04 02:45:12','2026-02-04 02:45:12','ssierra047@gmail.com','ssierra047@gmail.com'),
(88,88,'OP','Cerrada','Orden completamente concluida y validada; lista para archivo o control.','No finalizada','2025-11-19 00:00:00','2025-11-19 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com'),
(99,99,'OP','Cancelada','La orden fue anulada o abortada antes de finalizar.','Finalizada','2025-11-19 00:00:00','2025-11-19 00:00:00','ssierra047@gmail.com','ssierra047@gmail.com');
/*!40000 ALTER TABLE `prod_estados_op` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `prod_ordenes_consumos`
--

LOCK TABLES `prod_ordenes_consumos` WRITE;
/*!40000 ALTER TABLE `prod_ordenes_consumos` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `prod_ordenes_consumos` VALUES
(36,'8eeea138','Ori_Sil_2',NULL,'O2511071509ad','7b07a77b','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds',0,11,'Und','','',75.0000,650.0000,0.0000,0.0000,0,'1','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-14 17:17:30','2025-11-21 20:25:11',''),
(37,'4f53c449','Ori_Sil_2',NULL,'O2511071509ad','84cfd583','C_E_CosdeFibmed_13','Costal de Fibra mediano',0,11,'und','','',125.0000,2000.0000,0.0000,0.0000,0,'1','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-14 17:17:30','2025-11-21 20:25:11',''),
(38,'78f9e75c','Ori_Sil_2',NULL,'O2511071509ad','de3fff3f','C_E_VinAnc30c_14','Vinipel Ancho 30cm',0,11,'mt','','',75.0000,37.0000,0.0000,0.0000,0,'1','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-14 17:17:30','2025-11-21 20:25:11',''),
(39,'365a601f','Ori_Sil_2',NULL,'O2511071509ad','49bdb205','I_Envyt_TAPMETB.6XUNI_78','TAPA METALICA B.63 X UNIDAD',0,11,'und','','',300.0000,370.0000,0.0000,0.0000,0,'1','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-14 17:17:30','2025-11-21 20:25:11',''),
(40,'bf0642a1','Ori_Sil_2',NULL,'O2511071509ad','b5f4ee3d','I_Envyt_BOLTRAVALDOYPAC10X_02','BOLSA TRANSP VALVULA DOY PACK 10 X 18 + FFA 6cms 200 - 300 GRS (CERRADA) Bolsa transparente con tapa pequeña ALICO',0,11,'und','','',300.0000,345.0000,0.0000,0.0000,0,'1','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-14 17:17:30','2025-11-27 23:12:49',''),
(41,'3a621f9e','Ori_Sil_2',NULL,'O2511071509ad','670b35a5','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA',0,11,'kg','','',25.0000,31000.0000,0.0000,0.0000,0,'1','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-14 17:17:30','2025-11-21 20:25:11',''),
(42,'6f42a4a9','Ori_Sil_2',NULL,'O2511071509ad','0de37e50','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS',0,11,'Und','','',175.0000,677.0000,0.0000,0.0000,0,'1','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-14 17:17:30','2025-11-21 20:25:11',''),
(43,'bc53b057','Ori_Sil_2',NULL,'O2511071509ad','3f4f026d','Ma_TER_17','TERMOMIX',0,11,'dia','','',100.0000,677.0000,144000.0000,4.0000,3,'1','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-14 17:17:30','2025-11-21 20:25:11',''),
(44,'9c4503b4','Ori_Sil_2',NULL,'O2511071509ad','ed5d7f29','He_BowMetde32c_05','Bowld Metálico 32cms',0,11,'NA_20','','',100.0000,14.0000,1125.0000,0.0482,15,'1','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-14 17:17:30','2025-11-21 20:25:11',''),
(45,'815fafda','Ori_Sil_2',NULL,'O2511071509ad','5c6874ce','MOex_MOExtNiv1_09','MO Externa Nivel 1',2,11,'Hora','A','',25.0000,6500.0000,1500.0000,0.0000,0,'1','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-14 17:17:30','2026-01-15 20:13:14',''),
(46,'02bd8fa7','Ori_Sil_2',NULL,'O2511071509ad','cee99069','MOex_MOExtNiv1_09','MO Externa Nivel 1',0,11,'Hora','A','',12.5000,10000.0000,750.0000,0.0000,0,'1','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-14 17:17:30','2026-01-15 20:19:05',''),
(47,'f4482bf1','Ori_Sil_2','CacyCho_d0','251127013','2bbc25b4','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG',0,10,'kg','','',15.0000,20000.0000,0.0000,0.0000,0,'1','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 14:44:53','2025-11-27 14:44:53',''),
(48,'e3cdd1dd','Ori_Sil_2','CacyCho_d0','251127013','90b55e0d','AP_Horpeq2ban_15','Horno pequeño 2 bandejas',0,10,'hora','','',8.7000,700.0000,525.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 14:44:53','2025-11-27 14:44:53',''),
(49,'bd79a606','Ori_Sil_2','CacyCho_d0','251127013','d28c1ec2','MOin_MOIntNiv1_12','MO Interna Nivel 1',0,10,'Hora','','',4.9500,10000.0000,0.0000,0.0000,0,'1','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 14:44:53','2025-11-27 14:44:53',''),
(61,'2f241304','Ori_Sil_2',NULL,'OP25-1101-0027-26','94664a90','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds',0,12,'Und','','',30.0000,650.0000,0.0000,0.0000,0,'','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-29 00:10:38','2025-11-29 01:35:45',''),
(62,'8705f122','Ori_Sil_2',NULL,'OP25-1101-0027-26','fcb9ac9a','C_E_CosdeFibmed_13','Costal de Fibra mediano',0,12,'und','','',50.0000,2000.0000,0.0000,0.0000,0,'','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-29 00:10:38','2025-11-29 01:35:45',''),
(63,'9b9d23dc','Ori_Sil_2',NULL,'OP25-1101-0027-26','3b77c633','C_E_VinAnc30c_14','Vinipel Ancho 30cm',0,12,'mt','','',30.0000,37.0000,0.0000,0.0000,0,'','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-29 00:10:38','2025-11-29 01:35:45',''),
(64,'43ea1802','Ori_Sil_2',NULL,'OP25-1101-0027-26','d8c97495','I_Envyt_TAPMETB.6XUNI_78','TAPA METALICA B.63 X UNIDAD',0,12,'und','','',120.0000,370.0000,0.0000,0.0000,0,'','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-29 00:10:38','2025-11-29 01:35:45',''),
(65,'797b0f1a','Ori_Sil_2',NULL,'OP25-1101-0027-26','66342750','I_Envyt_BOLTRAVALDOYPAC10X_02','BOLSA TRANSP VALVULA DOY PACK 10 X 18 + FFA 6cms 200 - 300 GRS (CERRADA) Bolsa transparente con tapa pequeña ALICO',0,12,'und','','',120.0000,345.0000,0.0000,0.0000,0,'','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-29 00:10:38','2025-11-29 01:35:45',''),
(66,'cedb4acd','Ori_Sil_2',NULL,'OP25-1101-0027-26','fe97ec93','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA',0,12,'kg','','',10.0000,31000.0000,0.0000,0.0000,0,'','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-29 00:10:38','2025-11-29 01:35:45',''),
(67,'2f4e373c','Ori_Sil_2',NULL,'OP25-1101-0027-26','0defb62b','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS',0,12,'Und','','',70.0000,677.0000,0.0000,0.0000,0,'','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-29 00:10:38','2025-11-29 01:35:45',''),
(68,'7898b3dc','Ori_Sil_2',NULL,'OP25-1101-0027-26','4df69ebc','Ma_TER_17','TERMOMIX',0,12,'dia','','',40.0000,677.0000,57600.0000,4.0000,3,'','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-29 00:10:38','2025-11-29 01:35:45',''),
(69,'f0c20bb7','Ori_Sil_2',NULL,'OP25-1101-0027-26','92def10e','He_BowMetde32c_05','Bowld Metálico 32cms',0,12,'NA_20','','',40.0000,14.0000,450.0000,0.0482,15,'','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-29 00:10:38','2025-11-29 01:35:45',''),
(70,'ce3c836a','Ori_Sil_2',NULL,'OP25-1101-0027-26','3167431b','MOex_MOExtNiv1_09','MO Externa Nivel 1',0,12,'Hora','','',10.0000,6500.0000,600.0000,0.0000,0,'','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-29 00:10:38','2025-11-29 01:35:45',''),
(71,'319a359d','Ori_Sil_2',NULL,'OP25-1101-0027-26','0812b0b6','MOex_MOExtNiv1_09','MO Externa Nivel 1',0,12,'Hora','','',5.0000,10000.0000,300.0000,0.0000,0,'','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-29 00:10:38','2025-11-29 01:35:45',''),
(72,'OS.4823b60f','Ori_Sil_2','','OS.26011001e','OS.4823b60f','PPNiv2_CASDECACLTxKL_09','CASCARILLA DE CACAO LT x Kg',99,10,'kg','','',0.0000,22026.1976,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 01:23:40','2026-01-12 01:23:40','Generado PHP| 2026-01-12 01:23:40 | larevo1111@gmail.com'),
(73,'OS.6a448b8a','Ori_Sil_2','','OS.26011001e','OS.6a448b8a','Limyase_BATDESPOLXUNI_7','BATA DESECHABLE POLIPROPILENO X UNIDAD',99,10,'Und','','',0.0000,5090.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 01:46:51','2026-01-12 01:46:51','Generado PHP| 2026-01-12 01:46:51 | larevo1111@gmail.com'),
(74,'OS.2c18379f','Ori_Sil_2','','OS.26011001e','OS.2c18379f','I_Eti_EtiOriSiltap_90','Etiqueta Origen Silvestre tapa',99,10,'und','','',0.0000,390.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 01:52:58','2026-01-12 01:52:58','Generado PHP| 2026-01-12 01:52:58 | larevo1111@gmail.com'),
(75,'OS.13b9b097','Ori_Sil_2','','OS.26011001e','OS.13b9b097','Selo_FLEBUCMAQCAC_06','FLETE BUCARAMANGA MAQUILA CACAO',99,10,'kg','','',0.0000,1000.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 02:05:32','2026-01-12 02:05:32','Generado PHP| 2026-01-12 02:05:32 | larevo1111@gmail.com'),
(76,'OS.c9316e30','Ori_Sil_2','','OS.26011001e','OS.c9316e30','Mapr_MAQOBTDENIBDECAC_08','MAQUILA OBTENCION DE NIBS DE CACAO',99,10,'kg','','',0.0000,4845.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 02:14:47','2026-01-12 02:14:47','Generado PHP| 2026-01-12 02:14:47 | larevo1111@gmail.com'),
(78,'Ori_Sil_2.CON456DEF','Ori_Sil_2','','OS.26011001e','Ori_Sil_2.DET123ABC','AP_Seldebolaped_14','Selladora de bolsas a pedal',99,10,'segundo','','',0.0000,0.0900,0.0000,1.3755,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','ensayosky','ensayosky','2026-01-12 02:51:45','2026-01-12 02:51:45','Generado PHP| 2026-01-12 02:51:45 | ensayosky'),
(79,'OS.4ca041f6','Ori_Sil_2','','OS.26011001e','OS.4ca041f6','AP_Horpeq2ban_15','Horno pequeño 2 bandejas',99,10,'hora','','',0.0000,700.0000,0.0000,0.2170,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 02:52:59','2026-01-12 02:52:59','Generado PHP| 2026-01-12 02:52:59 | larevo1111@gmail.com'),
(80,'OS.fec943a8','Ori_Sil_2','','OS.26011001e','OS.fec943a8','S_S_LogInt_15','Logistica Interna',99,10,'hora','','',0.0000,25000.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 03:06:54','2026-01-12 03:06:54','Generado PHP| 2026-01-12 03:06:54 | larevo1111@gmail.com'),
(81,'OS.58f8e4cf','Ori_Sil_2','','OS.26011001e','OS.58f8e4cf','Limyase_AmoCuaxlit(Liydes_6','Amonio Cuaternario x litro (Limpieza y desinfección)',99,10,'Und','','',0.0000,12700.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 03:22:11','2026-01-12 03:22:11','EXECUTION_ID=run_696468e326a151.14563070 | Generado PHP| 2026-01-12 03:22:11 | larevo1111@gmail.com'),
(82,'OS.e570d1e9','Ori_Sil_2','','OS.26011001e','OS.e570d1e9','I_Envyt_EnvVidR267Fli230B.6_87','Envase Vidrio R 2670 Flint, 230cc, B.63, C Tapa UNICOR',99,10,'und','','',0.0000,1060.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 03:33:20','2026-01-12 03:33:20','EXECUTION_ID=run_69646b803acae4.47596851 | Generado PHP| 2026-01-12 03:33:20 | larevo1111@gmail.com'),
(83,'OS.dbbee95d','Ori_Sil_2','','OS.26011001e','OS.dbbee95d','PPNiv3_CREDEMAN_41','CREMA DE MANI',99,10,'kg','','',0.0000,0.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 03:35:24','2026-01-12 03:35:24','Generado PHP| 2026-01-12 03:35:24 | larevo1111@gmail.com'),
(84,'OS.e406da55','Ori_Sil_2','','OS.26011001e','OS.e406da55','He_REJCOC_15','REJILLA COCINA',99,10,'cm3','','',0.0000,99.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 14:19:37','2026-01-12 14:19:37','Generado PHP| 2026-01-12 14:19:37 | larevo1111@gmail.com'),
(85,'OS.c66a217e','Ori_Sil_2','','OS.26011001e','OS.c66a217e','AP_REFCHOPRE10L2_24','REFINADORA CHOCOLATE PREMIER 10LB 2',99,10,'hora','','',0.0000,160.0000,0.0000,7.5955,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 23:22:18','2026-01-12 23:22:18','Generado PHP| 2026-01-12 18:22:18 | larevo1111@gmail.com'),
(86,'OS.8706c0d2','Ori_Sil_2','','OS.26011101b','OS.8706c0d2','Limyase_GUADENITTALMCAJX50PAR_9','GUANTES DE NITRILO TALLA M CAJA X 50 PARES',99,10,'Und','','',0.0000,33000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 19:45:38','2026-01-12 19:45:38','Generado PHP| 2026-01-12 19:45:38 | larevo1111@gmail.com'),
(87,'OS.f20ad0b8','Ori_Sil_2','','OS.26011101b','OS.f20ad0b8','Selo_FLEBUCMAQCAC_06','FLETE BUCARAMANGA MAQUILA CACAO',99,10,'kg','','',0.0000,1000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 19:52:06','2026-01-12 19:52:06','Generado PHP| 2026-01-12 19:52:06 | larevo1111@gmail.com'),
(88,'OS.tmp2','Ori_Sil_2','','OS.26011101b','OS.tmp1','S_M_TiedeRep_16','Tiempo de Reposo',99,10,'hora','','',0.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','ensayosky','ensayosky','2026-01-12 20:25:08','2026-01-12 20:25:08','Generado PHP| 2026-01-12 20:25:08 | ensayosky'),
(89,'OS.479f609d','Ori_Sil_2','','OS.26011101b','OS.479f609d','S_M_TiedeRep_16','Tiempo de Reposo',99,10,'hora','','',0.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 20:37:19','2026-01-12 20:37:19','Generado PHP| 2026-01-12 20:37:19 | larevo1111@gmail.com'),
(90,'OS.0201ba09','Ori_Sil_2',NULL,'O2511071509ad','84cfd583','C_E_CosdeFibmed_13','Costal de Fibra mediano',2,10,'und',NULL,'',125.0000,2000.0000,0.0000,0.0000,0,'1','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 20:07:32','2026-01-15 20:07:32',NULL),
(91,'OS.b96928e0','Ori_Sil_2',NULL,'O2511071509ad','cee99069','MOex_MOExtNiv1_09','MO Externa Nivel 1',2,10,'Hora',NULL,'',200.0000,10000.0000,1050.0000,0.0000,0,'1','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 20:08:37','2026-01-15 20:18:37',NULL),
(92,'OS.136540064','Ori_Sil_2',NULL,'OS.260112016','OS.RkfRZoQ2h','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA',1,10,'kg','','',400.0000,0.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(93,'OS.148535247','Ori_Sil_2',NULL,'OS.260112016','OS.r0OoYvaNv','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA',2,10,'kg','','',1000.0000,0.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(94,'OS.299850867','Ori_Sil_2',NULL,'OS.260112016','OS.5hdSHwJgu','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs',1,10,'Und','','',2000.0000,212.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(95,'OS.165355945','Ori_Sil_2',NULL,'OS.260112016','OS.uptLtz0Jm','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS',2,10,'Und','','',7000.0000,0.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(96,'OS.457273955','Ori_Sil_2',NULL,'OS.260112016','OS.NKyRJfsoI','PPPt__ENSCAS_7a','ENSA CASCARILLA',2,10,'kg','','',500.0000,30826.6041,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(97,'OS.927475429','Ori_Sil_2',NULL,'OS.260112016','OS.MxGefGX97','MP_SalA_Bicxgra_12','Bicarbonato x gramo',1,10,'g','','',23000.0000,15.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(98,'OS.114750025','Ori_Sil_2',NULL,'OS.260112016','OS.FI7Ezuz5m','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD',4,10,'und','','',4000.0000,1000.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(99,'OS.825672182','Ori_Sil_2',NULL,'OS.260112016','OS.MjGMDaPhM','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA',2,10,'und','','',1800.0000,0.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(100,'OS.440244967','Ori_Sil_2',NULL,'OS.260112016','OS.3a5O3C5LV','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG',2,10,'kg','','',1000.0000,20000.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(101,'OS.905661370','Ori_Sil_2',NULL,'OS.260112016','OS.s2ABZX0rA','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad',4,10,'und','','',2000.0000,1125.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(102,'OS.459337121','Ori_Sil_2',NULL,'OS.260112016','OS.2vm4S8V4K','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL',2,10,'kg','','',430.0000,21000.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(103,'OS.396860024','Ori_Sil_2',NULL,'OS.260112016','OS.zw7dkTXaO','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds',2,10,'Und','','',3000.0000,650000.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(104,'OS.189091255','Ori_Sil_2',NULL,'OS.260112016','OS.YMMeXUWJZ','C_P_Serdepap_15','Servilletas de papel',2,10,'cm','','',5000.0000,3.4800,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(105,'OS.659806584','Ori_Sil_2',NULL,'OS.260112016','OS.PPcZKWQNY','C_P_Serdepap_15','Servilletas de papel',4,10,'cm','','',7500.0000,3.4800,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(106,'OS.781176092','Ori_Sil_2',NULL,'OS.260112016','OS.rC2QkbRiP','C_L_JabNeu_16','Jabon Neutro',4,10,'ml','','',2500.0000,10.2600,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(107,'OS.459731706','Ori_Sil_2',NULL,'OS.260112016','OS.UFCfkIQQE','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS',4,10,'Und','','',1000.0000,19300.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(108,'OS.873832070','Ori_Sil_2',NULL,'OS.260112016','OS.6CtDgNUWn','Selo_Dom_02','Domicilio',4,10,'Und','','',700.0000,8000.0000,35000.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(109,'OS.565904693','Ori_Sil_2',NULL,'OS.260112016','OS.wjzUpFNNz','MOin_MOIntNiv1_12','MO Interna Nivel 1',1,10,'Hora','','',550.0000,10000.0000,32800.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(110,'OS.807739131','Ori_Sil_2',NULL,'OS.260112016','OS.FZS6NBRjK','MOin_MOIntNiv1_12','MO Interna Nivel 1',2,10,'Hora','','',600.0000,10000.0000,36000.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(111,'OS.784928483','Ori_Sil_2',NULL,'OS.260112016','OS.kYoY73D6L','Selo_FleMer_07','Flete Mercadolibre',2,10,'Und','','',600.0000,910000.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(112,'OS.336136473','Ori_Sil_2',NULL,'OS.260112016','OS.GKLi29Dyu','MOex_MOExtNiv1_09','MO Externa Nivel 1',2,10,'Hora','','',1000.0000,10000.0000,60000.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(113,'OS.281632961','Ori_Sil_2',NULL,'OS.260112016','OS.PnIo7p4eN','AP_Moldemaiele_16','Molino de maiz electrico',2,10,'hora','','',2000.0000,700.0000,120000.0000,0.8681,2,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(114,'OS.720249148','Ori_Sil_2',NULL,'OS.260112016','OS.xtf7p4Bkz','AP_ConNevPeq_30','Congelador Nevera Pequeña',1,10,'minuto','','',600.0000,0.0000,600.0000,1.0417,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(115,'OS.675207833','Ori_Sil_2',NULL,'OS.260112016','OS.CH1L7wcsx','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA',3,10,'NA_20','','',0.0000,0.0000,2525.0000,0.0579,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(116,'OS.511292975','Ori_Sil_2',NULL,'OS.260112016','OS.jGufjlcMC','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)',3,10,'NA_20','','',1000.0000,0.0000,2000.0000,0.6510,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(117,'OS.571512957','Ori_Sil_2',NULL,'OS.260112016','OS.chuy3duEe','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1',3,10,'hora','','',3000.0000,160.0000,180000.0000,7.5955,3,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 11:00:11','2026-01-16 11:00:11','COPY DETALLES PHP | 2026-01-16 11:00:11 | ensayosky'),
(118,'OS.964296487','Ori_Sil_2','','OS.260115011','OS.FyJfqnyHy','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA',1,10,'kg','','',40.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(119,'OS.205354255','Ori_Sil_2','','OS.260115011','OS.zSG8lwIsz','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA',2,10,'kg','','',100.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(120,'OS.360202031','Ori_Sil_2','','OS.260115011','OS.RESOG1LsB','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs',1,10,'Und','','',200.0000,212.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(121,'OS.929729628','Ori_Sil_2','','OS.260115011','OS.ndXGHcv32','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS',2,10,'Und','','',700.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(122,'OS.193913113','Ori_Sil_2','','OS.260115011','OS.InXJhziPm','PPPt__ENSCAS_7a','ENSA CASCARILLA',2,10,'kg','','',50.0000,30826.6041,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(123,'OS.175909740','Ori_Sil_2','','OS.260115011','OS.4U62BAWLD','MP_SalA_Bicxgra_12','Bicarbonato x gramo',1,10,'g','','',2300.0000,15.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(124,'OS.854408417','Ori_Sil_2','','OS.260115011','OS.5MCoZNQrY','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD',4,10,'und','','',400.0000,1000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(125,'OS.508918101','Ori_Sil_2','','OS.260115011','OS.lRVqATf79','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA',2,10,'und','','',180.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(126,'OS.373118885','Ori_Sil_2','','OS.260115011','OS.iUQKFzHJv','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG',2,10,'kg','','',100.0000,20000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(127,'OS.776039027','Ori_Sil_2','','OS.260115011','OS.QWgE8zRsK','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad',4,10,'und','','',200.0000,1125.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(128,'OS.952104688','Ori_Sil_2','','OS.260115011','OS.Cl8xZ3KJg','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL',2,10,'kg','','',43.0000,21000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(129,'OS.295524434','Ori_Sil_2','','OS.260115011','OS.ZQkkH7Yoe','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds',2,10,'Und','','',300.0000,650000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(130,'OS.157882201','Ori_Sil_2','','OS.260115011','OS.FsamCz7nL','C_P_Serdepap_15','Servilletas de papel',2,10,'cm','','',500.0000,3.4800,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'6','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:50:56','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(131,'OS.628009868','Ori_Sil_2','','OS.260115011','OS.H0aD1Je4o','C_P_Serdepap_15','Servilletas de papel',4,10,'cm','','',750.0000,3.4800,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(132,'OS.555157297','Ori_Sil_2','','OS.260115011','OS.YRLK6Pmaf','C_L_JabNeu_16','Jabon Neutro',4,10,'ml','','',250.0000,10.2600,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(133,'OS.768894839','Ori_Sil_2','','OS.260115011','OS.kGN05sZa5','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS',4,10,'Und','','',100.0000,19300.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(134,'OS.721312120','Ori_Sil_2','','OS.260115011','OS.C3oKYt10P','Selo_Dom_02','Domicilio',4,10,'Und','','',11.0943,8000.0000,554.7126,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(135,'OS.839699329','Ori_Sil_2','','OS.260115011','OS.eddSzsb0H','MOin_MOIntNiv1_12','MO Interna Nivel 1',1,10,'Hora','','',55.0000,10000.0000,3280.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(136,'OS.760504513','Ori_Sil_2','','OS.260115011','OS.5hwfOTAYG','MOin_MOIntNiv1_12','MO Interna Nivel 1',2,10,'Hora','','',60.0000,10000.0000,3600.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(137,'OS.467971908','Ori_Sil_2','','OS.260115011','OS.MelEXDHte','Selo_FleMer_07','Flete Mercadolibre',2,10,'Und','','',60.0000,910000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(138,'OS.539410444','Ori_Sil_2','','OS.260115011','OS.GkvIb2euJ','MOex_MOExtNiv1_09','MO Externa Nivel 1',2,10,'Hora','','',100.0000,10000.0000,6000.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(139,'OS.726982003','Ori_Sil_2','','OS.260115011','OS.pHLnuxHOA','AP_Moldemaiele_16','Molino de maiz electrico',2,10,'hora','','',200.0000,700.0000,12000.0000,0.8681,2,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(140,'OS.180832140','Ori_Sil_2','','OS.260115011','OS.6w8t1tdjH','AP_ConNevPeq_30','Congelador Nevera Pequeña',1,10,'minuto','','',60.0000,0.0000,60.0000,1.0417,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(141,'OS.656725479','Ori_Sil_2','','OS.260115011','OS.Znb2jNHOJ','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA',3,10,'NA_20','','',0.0000,0.0000,252.5000,0.0579,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(142,'OS.827851165','Ori_Sil_2','','OS.260115011','OS.kyOykzDvT','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)',3,10,'NA_20','','',100.0000,0.0000,200.0000,0.6510,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(143,'OS.673576299','Ori_Sil_2','','OS.260115011','OS.tONca6yBF','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1',3,10,'hora','','',300.0000,160.0000,18000.0000,7.5955,3,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 12:47:30','2026-01-16 12:47:30','COPY DETALLES PHP | 2026-01-16 12:47:30 | larevo1111@gmail.com'),
(222,'OS.472952334','Ori_Sil_2','','OS.260116015','OS.K3mRPd5tW','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA',1,10,'kg','','',0.8000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(223,'OS.222888339','Ori_Sil_2','','OS.260116015','OS.wtEx0zWOU','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA',2,10,'kg','','',2.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(224,'OS.397333184','Ori_Sil_2','','OS.260116015','OS.1ynHyHWVg','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs',1,10,'Und','','',4.0000,212.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(225,'OS.859871607','Ori_Sil_2','','OS.260116015','OS.XPFRZNybG','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS',2,10,'Und','','',14.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(226,'OS.313144806','Ori_Sil_2','','OS.260116015','OS.FRwkgXQf9','PPPt__ENSCAS_7a','ENSA CASCARILLA',2,10,'kg','','',1.0000,30826.6041,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(227,'OS.359502135','Ori_Sil_2','','OS.260116015','OS.nqKRYB7q8','MP_SalA_Bicxgra_12','Bicarbonato x gramo',1,10,'g','','',46.0000,15.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(228,'OS.657097606','Ori_Sil_2','','OS.260116015','OS.oBlZVdGIl','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD',4,10,'und','','',8.0000,1000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(229,'OS.988860510','Ori_Sil_2','','OS.260116015','OS.5rg804mSd','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA',2,10,'und','','',3.6000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(230,'OS.678931470','Ori_Sil_2','','OS.260116015','OS.oEqrrzGHF','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG',2,10,'kg','','',2.0000,20000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(231,'OS.156434664','Ori_Sil_2','','OS.260116015','OS.2NDa4RWRX','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad',4,10,'und','','',4.0000,1125.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(232,'OS.811713621','Ori_Sil_2','','OS.260116015','OS.fdcp4WWWo','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL',2,10,'kg','','',0.8600,21000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(233,'OS.346743532','Ori_Sil_2','','OS.260116015','OS.W7nESFGGe','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds',2,10,'Und','','',6.0000,650000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(234,'OS.618193115','Ori_Sil_2','','OS.260116015','OS.xLIUuD224','C_P_Serdepap_15','Servilletas de papel',2,10,'cm','','',10.0000,3.4800,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(235,'OS.201798500','Ori_Sil_2','','OS.260116015','OS.aNz5Xw01a','C_P_Serdepap_15','Servilletas de papel',4,10,'cm','','',15.0000,3.4800,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'1','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:17:59','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(236,'OS.872638293','Ori_Sil_2','','OS.260116015','OS.VXHlCTctf','C_L_JabNeu_16','Jabon Neutro',4,10,'ml','','',5.0000,10.2600,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(237,'OS.559599515','Ori_Sil_2','','OS.260116015','OS.kEjPW19LH','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS',4,10,'Und','','',2.0000,19300.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(238,'OS.610169349','Ori_Sil_2','','OS.260116015','OS.d3fqrx4ir','Selo_Dom_02','Domicilio',4,10,'Und','','',1.0610,8000.0000,53.0501,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(239,'OS.447755643','Ori_Sil_2','','OS.260116015','OS.OEBWw346q','MOin_MOIntNiv1_12','MO Interna Nivel 1',1,10,'Hora','','',1.1000,10000.0000,65.6000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(240,'OS.725247199','Ori_Sil_2','','OS.260116015','OS.xJ2AaTokU','MOin_MOIntNiv1_12','MO Interna Nivel 1',2,10,'Hora','','',1.2000,10000.0000,72.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(241,'OS.168728813','Ori_Sil_2','','OS.260116015','OS.FWuRkCH1k','Selo_FleMer_07','Flete Mercadolibre',2,10,'Und','','',1.2000,910000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(242,'OS.132787910','Ori_Sil_2','','OS.260116015','OS.3VvFPsofP','MOex_MOExtNiv1_09','MO Externa Nivel 1',2,10,'Hora','','',2.0000,10000.0000,120.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(243,'OS.292980466','Ori_Sil_2','','OS.260116015','OS.l5l2xMUzQ','AP_Moldemaiele_16','Molino de maiz electrico',2,10,'hora','','',4.0000,700.0000,240.0000,0.8681,2,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(244,'OS.266687629','Ori_Sil_2','','OS.260116015','OS.GNjVI8Kwh','AP_ConNevPeq_30','Congelador Nevera Pequeña',1,10,'minuto','','',1.2000,0.0000,1.2000,1.0417,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(245,'OS.748065738','Ori_Sil_2','','OS.260116015','OS.5ly4IHgcE','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA',3,10,'NA_20','','',0.0000,0.0000,5.0500,0.0579,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(246,'OS.873025172','Ori_Sil_2','','OS.260116015','OS.SMeITuKCI','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)',3,10,'NA_20','','',2.0000,0.0000,4.0000,0.6510,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(247,'OS.136604219','Ori_Sil_2','','OS.260116015','OS.ziy3DhKE5','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1',3,10,'hora','','',6.0000,160.0000,360.0000,7.5955,3,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:15:37','2026-01-16 21:15:37','COPY DETALLES PHP | 2026-01-16 21:15:37 | larevo1111@gmail.com'),
(248,'OS.3284d2c2','Ori_Sil_2','','OS.260116015','OS.3284d2c2','I_Envyt_TAPMETB.6XUNI_78','TAPA METALICA B.63 X UNIDAD',99,10,'und','','',0.0000,370.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:28:09','2026-01-16 21:28:09','Generado PHP| 2026-01-16 21:28:09 | larevo1111@gmail.com'),
(249,'OS.406133487','Ori_Sil_2','','OS.260122011','OS.86enwUN1n','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA',1,10,'kg','','',4.0000,0.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(250,'OS.711028144','Ori_Sil_2','','OS.260122011','OS.u6sZf8e9Q','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA',2,10,'kg','','',10.0000,0.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(251,'OS.495419136','Ori_Sil_2','','OS.260122011','OS.Q5ANjzRUe','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs',1,10,'Und','','',20.0000,212.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(252,'OS.382795902','Ori_Sil_2','','OS.260122011','OS.ExufACvoH','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS',2,10,'Und','','',70.0000,0.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(253,'OS.130930863','Ori_Sil_2','','OS.260122011','OS.befPdOMds','PPPt__ENSCAS_7a','ENSA CASCARILLA',2,10,'kg','','',5.0000,30826.6041,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(254,'OS.188662665','Ori_Sil_2','','OS.260122011','OS.5rxIWSZZ4','MP_SalA_Bicxgra_12','Bicarbonato x gramo',1,10,'g','','',230.0000,15.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(255,'OS.158638619','Ori_Sil_2','','OS.260122011','OS.UXMWhlVXC','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD',4,10,'und','','',40.0000,1000.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(256,'OS.635966289','Ori_Sil_2','','OS.260122011','OS.XL4Vy62hN','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA',2,10,'und','','',18.0000,0.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(257,'OS.878758918','Ori_Sil_2','','OS.260122011','OS.JlmRfwp8l','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG',2,10,'kg','','',10.0000,20000.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(258,'OS.294437822','Ori_Sil_2','','OS.260122011','OS.jZRVD5Ro7','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad',4,10,'und','','',20.0000,1125.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(259,'OS.801694281','Ori_Sil_2','','OS.260122011','OS.2oUIxuEvC','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL',2,10,'kg','','',4.3000,21000.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(260,'OS.671537501','Ori_Sil_2','','OS.260122011','OS.t4sbIGKZM','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds',2,10,'Und','','',30.0000,650000.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(261,'OS.326184976','Ori_Sil_2','','OS.260122011','OS.FyZkZ2905','C_P_Serdepap_15','Servilletas de papel',2,10,'cm','','',50.0000,3.4800,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(262,'OS.696227215','Ori_Sil_2','','OS.260122011','OS.lYRwPp8Wc','C_P_Serdepap_15','Servilletas de papel',4,10,'cm','','',75.0000,3.4800,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(263,'OS.822273014','Ori_Sil_2','','OS.260122011','OS.UQR5Fdtex','C_L_JabNeu_16','Jabon Neutro',4,10,'ml','','',25.0000,10.2600,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(264,'OS.416895116','Ori_Sil_2','','OS.260122011','OS.1JbKYHMeB','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS',4,10,'Und','','',10.0000,19300.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(265,'OS.990976222','Ori_Sil_2','','OS.260122011','OS.StZTRp0xY','Selo_Dom_02','Domicilio',4,10,'Und','','',2.7868,8000.0000,139.3375,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(266,'OS.186439586','Ori_Sil_2','','OS.260122011','OS.yLIUgCGKf','MOin_MOIntNiv1_12','MO Interna Nivel 1',1,11,'Hora','','',5.5000,10000.0000,328.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-23 16:35:46','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(267,'OS.136825856','Ori_Sil_2','','OS.260122011','OS.7bnkCRDBO','MOin_MOIntNiv1_12','MO Interna Nivel 1',2,10,'Hora','','',6.0000,10000.0000,360.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(268,'OS.266500357','Ori_Sil_2','','OS.260122011','OS.CxLhakX73','Selo_FleMer_07','Flete Mercadolibre',2,10,'Und','','',6.0000,910000.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(269,'OS.936434504','Ori_Sil_2','','OS.260122011','OS.4GFBSyklW','MOex_MOExtNiv1_09','MO Externa Nivel 1',2,10,'Hora','','',10.0000,10000.0000,600.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(270,'OS.841115487','Ori_Sil_2','','OS.260122011','OS.fSOtIK6p9','AP_Moldemaiele_16','Molino de maiz electrico',2,10,'hora','','',20.0000,700.0000,1200.0000,0.8681,2,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(271,'OS.493100733','Ori_Sil_2','','OS.260122011','OS.OfOpkqXPY','AP_ConNevPeq_30','Congelador Nevera Pequeña',1,10,'minuto','','',6.0000,0.0000,6.0000,1.0417,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(272,'OS.154365574','Ori_Sil_2','','OS.260122011','OS.SKEXanON8','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA',3,10,'NA_20','','',0.0000,0.0000,25.2500,0.0579,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(273,'OS.209431743','Ori_Sil_2','','OS.260122011','OS.SoYQOhxDx','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)',3,10,'NA_20','','',10.0000,0.0000,20.0000,0.6510,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(274,'OS.365196821','Ori_Sil_2','','OS.260122011','OS.7Cq10in4z','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1',3,10,'hora','','',30.0000,160.0000,1800.0000,7.5955,3,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:42:33','2026-01-22 11:42:33','COPY DETALLES PHP | 2026-01-22 11:42:33 | larevo1111@gmail.com'),
(275,'OS.46aadddf','Ori_Sil_2','','OS.260122011','OS.46aadddf','He_TAPSIL_16','TAPETE SILICONA',99,10,'NA_20','','',100.0000,2.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:50:29','2026-01-22 12:08:30','Generado PHP| 2026-01-22 11:50:29 | larevo1111@gmail.com'),
(276,'OS.1ac8e9fb','Ori_Sil_2','CacyCho_d0','OS.260122011','OS.t4sbIGKZM','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds',2,10,'Und',NULL,'',30.0000,650000.0000,0.0000,0.0000,0,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 18:05:23','2026-01-22 18:05:23',NULL),
(277,'OS.674460002','Ori_Sil_2',NULL,'OS.251227017','8RHzaS7RVOutWwrT','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA',1,10,'kg','','',40.0000,31000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(278,'OS.555054857','Ori_Sil_2',NULL,'OS.251227017','O041ShnBRHcOF512','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA',2,10,'kg','','',100.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(279,'OS.918005961','Ori_Sil_2',NULL,'OS.251227017','HD2f0RAY5hxFH0Dr','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs',1,10,'Und','','',200.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(280,'OS.209398442','Ori_Sil_2',NULL,'OS.251227017','VoeqXFH1O0sAQY8x','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS',2,10,'Und','','',700.0000,677.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(281,'OS.198264546','Ori_Sil_2',NULL,'OS.251227017','oNN83AKkZEo9mQOB','PPPt__ENSCAS_7a','ENSA CASCARILLA',2,10,'kg','','',50.0000,470108.8600,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(282,'OS.668287407','Ori_Sil_2',NULL,'OS.251227017','uOyxsoQ4lWJPGGgI','MP_SalA_Bicxgra_12','Bicarbonato x gramo',1,10,'g','','',2300.0000,15.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(283,'OS.985634955','Ori_Sil_2',NULL,'OS.251227017','ou0mO8U8Z3OatcPw','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD',4,10,'und','','',400.0000,1000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(284,'OS.615265439','Ori_Sil_2',NULL,'OS.251227017','wY8fMVPjri72AxZH','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA',2,10,'und','','',180.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(285,'OS.339457182','Ori_Sil_2',NULL,'OS.251227017','6Ten0jqtstzP65lW','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG',2,10,'kg','','',100.0000,20000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(286,'OS.723916794','Ori_Sil_2',NULL,'OS.251227017','f8W6hZPykKSQtfa3','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad',4,10,'und','','',200.0000,1125.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(287,'OS.325680607','Ori_Sil_2',NULL,'OS.251227017','BsEpReLfb4hmcOYz','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL',2,10,'kg','','',43.0000,21000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(288,'OS.318145649','Ori_Sil_2',NULL,'OS.251227017','hXOAbHOjuG1VHvAv','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds',2,10,'Und','','',300.0000,650.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(289,'OS.117666069','Ori_Sil_2',NULL,'OS.251227017','yadZpoPG5NPLd4Jr','C_P_Serdepap_15','Servilletas de papel',2,10,'cm','','',500.0000,3.4800,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(290,'OS.242301714','Ori_Sil_2',NULL,'OS.251227017','0MnwNF9eYGdNuAYR','C_P_Serdepap_15','Servilletas de papel',4,10,'cm','','',750.0000,3.4800,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(291,'OS.788810318','Ori_Sil_2',NULL,'OS.251227017','DqNSTTu1USFFCCM8','C_L_JabNeu_16','Jabon Neutro',4,10,'ml','','',250.0000,10.2600,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(292,'OS.279895188','Ori_Sil_2',NULL,'OS.251227017','wAa6CtN9cz6eD4bS','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS',4,10,'Und','','',100.0000,19300.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(293,'OS.525964732','Ori_Sil_2',NULL,'OS.251227017','LyMDEsTGt3gVBxML','Selo_Dom_02','Domicilio',4,10,'Und','','',70.0000,8000.0000,3500.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(294,'OS.352155569','Ori_Sil_2',NULL,'OS.251227017','o8xNlUuzBAegIMQG','MOin_MOIntNiv1_12','MO Interna Nivel 1',1,10,'Hora','','',55.0000,10000.0000,3280.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(295,'OS.900232775','Ori_Sil_2',NULL,'OS.251227017','ts3w3w8xl6MZCGcz','MOin_MOIntNiv1_12','MO Interna Nivel 1',2,10,'Hora','','',60.0000,10000.0000,3600.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(296,'OS.274715776','Ori_Sil_2',NULL,'OS.251227017','Pub4g41isaUAFbz5','Selo_FleMer_07','Flete Mercadolibre',2,10,'Und','','',60.0000,9100.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(297,'OS.437188407','Ori_Sil_2',NULL,'OS.251227017','4XvgnHPAvhhshWme','MOex_MOExtNiv1_09','MO Externa Nivel 1',2,10,'Hora','','',100.0000,10000.0000,6000.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(298,'OS.314975394','Ori_Sil_2',NULL,'OS.251227017','bOlOIIaZf1RaCTfg','AP_Moldemaiele_16','Molino de maiz electrico',2,10,'hora','','',200.0000,700.0000,12000.0000,0.4823,2,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(299,'OS.934680383','Ori_Sil_2',NULL,'OS.251227017','89eZmA6wPo5kjR5l','AP_ConNevPeq_30','Congelador Nevera Pequeña',1,10,'minuto','','',60.0000,0.0000,60.0000,0.5787,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(300,'OS.585905484','Ori_Sil_2',NULL,'OS.251227017','Mqe8SbLHATIFDrl2','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA',3,10,'NA_20','','',0.0000,0.0000,252.5000,0.0322,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(301,'OS.550824440','Ori_Sil_2',NULL,'OS.251227017','FfY0oJfkesc0rwAS','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)',3,10,'NA_20','','',100.0000,0.0000,200.0000,0.3617,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(302,'OS.875543103','Ori_Sil_2',NULL,'OS.251227017','yFiJdSiimzoIK1P2','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1',3,10,'hora','','',300.0000,160.0000,18000.0000,4.2197,3,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:04:06','2026-01-22 21:04:06','COPY DETALLES PHP | 2026-01-22 21:04:06 | larevo1111@gmail.com'),
(303,'OS.d9603628','Ori_Sil_2','','OS.260122011','OS.d9603628','Selo_FleMer_07','Flete Mercadolibre',99,10,'Und','','',0.0000,9100.0000,0.0000,0.0000,1,'OS.67566c75','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-23 17:14:03','2026-01-23 17:14:03','Generado PHP| 2026-01-23 17:14:03 | larevo1111@gmail.com'),
(330,'OS.135554952','Ori_Sil_2','','OS.260124017','OS.izS1K5yUV','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA',1,10,'kg','','PP.NORMAL',4.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(331,'OS.941478265','Ori_Sil_2','','OS.260124017','OS.KccQpdQhT','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA',2,10,'kg','','PP.NORMAL',10.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(332,'OS.912788297','Ori_Sil_2','','OS.260124017','OS.lnYpAk10E','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs',1,10,'Und','','PP.NORMAL',20.0000,212.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(333,'OS.228459585','Ori_Sil_2','','OS.260124017','OS.C7uR6u1Gf','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS',2,10,'Und','','PP.NORMAL',70.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(334,'OS.848855703','Ori_Sil_2','','OS.260124017','OS.wYRRsIahk','PPPt__ENSCAS_7a','ENSA CASCARILLA',2,10,'kg','','PP.NORMAL',5.0000,30826.6041,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(335,'OS.386990970','Ori_Sil_2','','OS.260124017','OS.4f4Hmm9D4','MP_SalA_Bicxgra_12','Bicarbonato x gramo',1,10,'g','','PP.NORMAL',230.0000,15.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(336,'OS.585580698','Ori_Sil_2','','OS.260124017','OS.Ie7xVrSB1','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD',4,10,'und','','PP.NORMAL',40.0000,1000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(337,'OS.526094985','Ori_Sil_2','','OS.260124017','OS.a5GvYZx6E','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA',2,10,'und','','PP.NORMAL',18.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(338,'OS.763472117','Ori_Sil_2','','OS.260124017','OS.itt8ZGcTj','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG',2,10,'kg','','PP.NORMAL',10.0000,20000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(339,'OS.247900352','Ori_Sil_2','','OS.260124017','OS.uhkc81pvA','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad',4,10,'und','','PP.NORMAL',20.0000,1125.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(340,'OS.960726051','Ori_Sil_2','','OS.260124017','OS.6caEyE2ZX','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL',2,10,'kg','','PP.NORMAL',4.3000,21000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(341,'OS.433255250','Ori_Sil_2','','OS.260124017','OS.XvP1RfG9l','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds',2,10,'Und','','PP.NORMAL',30.0000,650000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(342,'OS.296306370','Ori_Sil_2','','OS.260124017','OS.eDqQaLl9y','C_P_Serdepap_15','Servilletas de papel',2,10,'cm','','PP.NORMAL',50.0000,3.4800,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(343,'OS.428156627','Ori_Sil_2','','OS.260124017','OS.948vemqzV','C_P_Serdepap_15','Servilletas de papel',4,10,'cm','','PP.NORMAL',75.0000,3.4800,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(344,'OS.828635623','Ori_Sil_2','','OS.260124017','OS.ANZx49aQI','C_L_JabNeu_16','Jabon Neutro',4,10,'ml','','PP.NORMAL',25.0000,10.2600,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(345,'OS.670042415','Ori_Sil_2','','OS.260124017','OS.ef6Tz6zc5','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS',4,10,'Und','','PP.NORMAL',10.0000,19300.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(346,'OS.968550591','Ori_Sil_2','','OS.260124017','OS.o3ZiP4xf0','Selo_Dom_02','Domicilio',4,10,'Und','','PP.NORMAL',2.7868,8000.0000,139.3375,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(347,'OS.659411945','Ori_Sil_2','','OS.260124017','OS.3gzyBjsCp','MOin_MOIntNiv1_12','MO Interna Nivel 1',1,10,'Hora','','PP.NORMAL',5.5000,10000.0000,328.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(348,'OS.317959696','Ori_Sil_2','','OS.260124017','OS.K5vohTCag','MOin_MOIntNiv1_12','MO Interna Nivel 1',2,10,'Hora','','PP.NORMAL',6.0000,10000.0000,360.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(349,'OS.793706730','Ori_Sil_2','','OS.260124017','OS.fbeawlmDu','Selo_FleMer_07','Flete Mercadolibre',2,10,'Und','','PP.NORMAL',6.0000,910000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(350,'OS.849005083','Ori_Sil_2','','OS.260124017','OS.oNM56ltec','MOex_MOExtNiv1_09','MO Externa Nivel 1',2,10,'Hora','','PP.NORMAL',10.0000,10000.0000,600.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(351,'OS.392082346','Ori_Sil_2','','OS.260124017','OS.e18ru5pzD','AP_Moldemaiele_16','Molino de maiz electrico',2,10,'hora','','PP.NORMAL',20.0000,700.0000,1200.0000,0.8681,2,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(352,'OS.287745692','Ori_Sil_2','','OS.260124017','OS.MKFnrwqLn','AP_ConNevPeq_30','Congelador Nevera Pequeña',1,10,'minuto','','PP.NORMAL',6.0000,0.0000,6.0000,1.0417,1,'1','OS.ELEC.SOLAR',0.000100,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-29 20:20:33','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(353,'OS.990238390','Ori_Sil_2','','OS.260124017','OS.yu4pAKwTf','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA',3,10,'NA_20','','PP.NORMAL',0.0000,0.0000,25.2500,0.0579,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(354,'OS.888057586','Ori_Sil_2','','OS.260124017','OS.89OYajFmI','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)',3,10,'NA_20','','PP.NORMAL',10.0000,0.0000,20.0000,0.6510,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(355,'OS.391402818','Ori_Sil_2','','OS.260124017','OS.HtLPwyqJR','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1',3,10,'hora','','PP.NORMAL',30.0000,160.0000,1800.0000,7.5955,3,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:56:25','2026-01-24 20:56:25','COPY DETALLES PHP | 2026-01-24 20:56:25 | larevo1111@gmail.com'),
(356,'OS.00781eda','Ori_Sil_2','','OS.260124017','OS.00781eda','PTOtr_CUCMIEMED_43','CUCHARA MIELERA MEDIANA',99,10,'Und','','PP.NORMAL',0.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:57:12','2026-01-24 20:57:12','Generado PHP| 2026-01-24 20:57:12 | larevo1111@gmail.com'),
(357,'OS.b46047cd','Ori_Sil_2','','OS.260124017','OS.b46047cd','AP_Moldemaiele_16','Molino de maiz electrico',99,10,'hora','','PP.NORMAL',0.0000,700.0000,0.0000,52.0833,1,'1','OS.ELEC.RED',0.000000,'OS.AGUA.ACUEDUCTO',0.000000,'OS.LENA',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 12:46:58','2026-01-29 12:46:58','Generado PHP| 2026-01-29 12:46:58 | larevo1111@gmail.com'),
(358,'OS.16ce40eb','Ori_Sil_2','','OS.260122011','OS.16ce40eb','AP_Moldemaiele_16','Molino de maiz electrico',99,10,'hora','','PP.NORMAL',0.0000,700.0000,0.0000,52.0833,1,'OS.67566c75','OS.ELEC.RED',0.373000,'OS.AGUA.ACUEDUCTO',0.000100,'OS.LENA',0.000010,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 13:03:42','2026-01-29 13:03:42','Generado PHP| 2026-01-29 13:03:42 | larevo1111@gmail.com'),
(359,'OS.337144347','Ori_Sil_2','','OS.260129011','OS.RhVmFsuyQ','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA',1,10,'kg','','PP.NORMAL',4.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(360,'OS.238185252','Ori_Sil_2','','OS.260129011','OS.rolmslLm3','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA',2,10,'kg','','PP.NORMAL',10.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(361,'OS.474092334','Ori_Sil_2','','OS.260129011','OS.CViUjxJ3M','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs',1,10,'Und','','PP.NORMAL',20.0000,212.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(362,'OS.393203732','Ori_Sil_2','','OS.260129011','OS.3YCQjKXWi','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS',2,10,'Und','','PP.NORMAL',70.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(363,'OS.600713071','Ori_Sil_2','','OS.260129011','OS.Jhr2hJY5I','PPPt__ENSCAS_7a','ENSA CASCARILLA',2,10,'kg','','PP.NORMAL',5.0000,30826.6041,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(364,'OS.887896823','Ori_Sil_2','','OS.260129011','OS.XrCqP7jJg','MP_SalA_Bicxgra_12','Bicarbonato x gramo',1,10,'g','','PP.NORMAL',230.0000,15.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(365,'OS.337940940','Ori_Sil_2','','OS.260129011','OS.A5SPblMXA','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD',4,10,'und','','PP.NORMAL',40.0000,1000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(366,'OS.721343105','Ori_Sil_2','','OS.260129011','OS.D02RlEB2g','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA',2,10,'und','','PP.NORMAL',18.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(367,'OS.233261881','Ori_Sil_2','','OS.260129011','OS.9m0QboU5K','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG',2,10,'kg','','PP.NORMAL',10.0000,20000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(368,'OS.477198579','Ori_Sil_2','','OS.260129011','OS.2iyFNV7bX','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad',4,10,'und','','PP.NORMAL',20.0000,1125.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(369,'OS.585923678','Ori_Sil_2','','OS.260129011','OS.he6aMKfYE','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL',2,10,'kg','','PP.NORMAL',4.3000,21000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(370,'OS.657555951','Ori_Sil_2','','OS.260129011','OS.53IDH9Wod','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds',2,10,'Und','','PP.NORMAL',30.0000,650000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(371,'OS.351521709','Ori_Sil_2','','OS.260129011','OS.auZMUhbNp','C_P_Serdepap_15','Servilletas de papel',2,10,'cm','','PP.NORMAL',50.0000,3.4800,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(372,'OS.218732182','Ori_Sil_2','','OS.260129011','OS.eIIW1xSlT','C_P_Serdepap_15','Servilletas de papel',4,10,'cm','','PP.NORMAL',75.0000,3.4800,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(373,'OS.658257909','Ori_Sil_2','','OS.260129011','OS.PKIkqGDjL','C_L_JabNeu_16','Jabon Neutro',4,10,'ml','','PP.NORMAL',25.0000,10.2600,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(374,'OS.289715211','Ori_Sil_2','','OS.260129011','OS.7i9YSOhhw','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS',4,10,'Und','','PP.NORMAL',10.0000,19300.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(375,'OS.306271749','Ori_Sil_2','','OS.260129011','OS.1OUC7FPlE','Selo_Dom_02','Domicilio',4,10,'Und','','PP.NORMAL',2.7868,8000.0000,139.3375,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(376,'OS.849019427','Ori_Sil_2','','OS.260129011','OS.MDLNGUbnn','MOin_MOIntNiv1_12','MO Interna Nivel 1',1,10,'Hora','','PP.NORMAL',5.5000,10000.0000,328.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(377,'OS.678567010','Ori_Sil_2','','OS.260129011','OS.ZEG9NzhSw','MOin_MOIntNiv1_12','MO Interna Nivel 1',2,10,'Hora','','PP.NORMAL',6.0000,10000.0000,360.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(378,'OS.833581536','Ori_Sil_2','','OS.260129011','OS.3IPmtoK3g','Selo_FleMer_07','Flete Mercadolibre',2,10,'Und','','PP.NORMAL',6.0000,910000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(379,'OS.935847462','Ori_Sil_2','','OS.260129011','OS.xovFOXtYr','MOex_MOExtNiv1_09','MO Externa Nivel 1',2,10,'Hora','','PP.NORMAL',10.0000,10000.0000,600.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(380,'OS.825762527','Ori_Sil_2','','OS.260129011','OS.OiRHYtYjO','AP_Moldemaiele_16','Molino de maiz electrico',2,10,'hora','','PP.NORMAL',20.0000,700.0000,1200.0000,0.8681,2,'1','OS.ELEC.RED',0.950000,'OS.AGUA.ACUEDUCTO',0.000100,'OS.LENA',0.000010,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 19:59:16','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(381,'OS.267970981','Ori_Sil_2','','OS.260129011','OS.g3FDl5YaC','AP_ConNevPeq_30','Congelador Nevera Pequeña',1,10,'minuto','','PP.NORMAL',6.0000,0.0000,6.0000,1.0417,1,'1','OS.ELEC.RED',0.001000,'OS.AGUA.ACUEDUCTO',0.000010,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(382,'OS.820679641','Ori_Sil_2','','OS.260129011','OS.ZrsiNj9iY','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA',3,10,'NA_20','','PP.NORMAL',0.0000,0.0000,25.2500,0.0579,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(383,'OS.588664159','Ori_Sil_2','','OS.260129011','OS.K4q328NUP','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)',3,10,'NA_20','','PP.NORMAL',10.0000,0.0000,20.0000,0.6510,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(384,'OS.846079794','Ori_Sil_2','','OS.260129011','OS.m9DAKcGve','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1',3,10,'hora','','PP.NORMAL',30.0000,160.0000,1800.0000,7.5955,3,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:28:56','2026-01-29 16:28:56','COPY DETALLES PHP | 2026-01-29 16:28:56 | sistemasyo'),
(385,'OS.856552262','Ori_Sil_2','','OS.260129010','OS.5V2il5EIF','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA',1,10,'kg','','PP.NORMAL',40.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(386,'OS.985050675','Ori_Sil_2','','OS.260129010','OS.wiLAEAQYN','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA',2,10,'kg','','PP.NORMAL',100.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(387,'OS.588870207','Ori_Sil_2','','OS.260129010','OS.yYiE0ilvq','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs',1,10,'Und','','PP.NORMAL',200.0000,212.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(388,'OS.182454188','Ori_Sil_2','','OS.260129010','OS.en8jfYOJx','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS',2,10,'Und','','PP.NORMAL',700.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(389,'OS.949855069','Ori_Sil_2','','OS.260129010','OS.GqlF1EiQZ','PPPt__ENSCAS_7a','ENSA CASCARILLA',2,10,'kg','','PP.NORMAL',50.0000,30826.6041,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(390,'OS.646236809','Ori_Sil_2','','OS.260129010','OS.wBdO530SA','MP_SalA_Bicxgra_12','Bicarbonato x gramo',1,10,'g','','PP.NORMAL',2300.0000,15.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(391,'OS.840256780','Ori_Sil_2','','OS.260129010','OS.Jcxxgb7FW','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD',4,10,'und','','PP.NORMAL',400.0000,1000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(392,'OS.378507034','Ori_Sil_2','','OS.260129010','OS.6wGkQAoLv','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA',2,10,'und','','PP.NORMAL',180.0000,0.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(393,'OS.543038131','Ori_Sil_2','','OS.260129010','OS.PBy2eh0uL','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG',2,10,'kg','','PP.NORMAL',100.0000,20000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(394,'OS.944691237','Ori_Sil_2','','OS.260129010','OS.RhWqKV9DD','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad',4,10,'und','','PP.NORMAL',200.0000,1125.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(395,'OS.994636307','Ori_Sil_2','','OS.260129010','OS.vP6vZl9HC','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL',2,10,'kg','','PP.NORMAL',43.0000,21000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(396,'OS.462281083','Ori_Sil_2','','OS.260129010','OS.eM5TqPUUm','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds',2,10,'Und','','PP.NORMAL',300.0000,650000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(397,'OS.377083795','Ori_Sil_2','','OS.260129010','OS.s5zbg9v5n','C_P_Serdepap_15','Servilletas de papel',2,10,'cm','','PP.NORMAL',500.0000,3.4800,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(398,'OS.424745932','Ori_Sil_2','','OS.260129010','OS.MXyUavsF4','C_P_Serdepap_15','Servilletas de papel',4,10,'cm','','PP.NORMAL',750.0000,3.4800,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(399,'OS.644432097','Ori_Sil_2','','OS.260129010','OS.Iw4pRSiKN','C_L_JabNeu_16','Jabon Neutro',4,10,'ml','','PP.NORMAL',250.0000,10.2600,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(400,'OS.264753373','Ori_Sil_2','','OS.260129010','OS.BHtzOdyCZ','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS',4,10,'Und','','PP.NORMAL',100.0000,19300.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(401,'OS.702900880','Ori_Sil_2','','OS.260129010','OS.eetWJLXBW','Selo_Dom_02','Domicilio',4,10,'Und','','PP.NORMAL',11.0943,8000.0000,554.7126,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(402,'OS.732838909','Ori_Sil_2','','OS.260129010','OS.VGBj9T5I5','MOin_MOIntNiv1_12','MO Interna Nivel 1',1,10,'Hora','','PP.NORMAL',55.0000,10000.0000,3280.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(403,'OS.141582511','Ori_Sil_2','','OS.260129010','OS.QvFXZ3SqU','MOin_MOIntNiv1_12','MO Interna Nivel 1',2,10,'Hora','','PP.NORMAL',60.0000,10000.0000,3600.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(404,'OS.907514392','Ori_Sil_2','','OS.260129010','OS.dBWB0ptNw','Selo_FleMer_07','Flete Mercadolibre',2,10,'Und','','PP.NORMAL',60.0000,910000.0000,0.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(405,'OS.961163682','Ori_Sil_2','','OS.260129010','OS.C0Aar2HTQ','MOex_MOExtNiv1_09','MO Externa Nivel 1',2,10,'Hora','','PP.NORMAL',100.0000,10000.0000,6000.0000,0.0000,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(406,'OS.323121659','Ori_Sil_2','','OS.260129010','OS.hlrV78FUM','AP_Moldemaiele_16','Molino de maiz electrico',2,10,'hora','','PP.NORMAL',200.0000,700.0000,12000.0000,0.8681,2,'1','OS.ELEC.RED',0.373000,'OS.AGUA.ACUEDUCTO',0.000100,'OS.LENA',0.000010,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(407,'OS.173611089','Ori_Sil_2','','OS.260129010','OS.5q5C9AIix','AP_ConNevPeq_30','Congelador Nevera Pequeña',1,10,'minuto','','PP.NORMAL',60.0000,0.0000,60.0000,1.0417,1,'1','OS.ELEC.RED',0.001000,'OS.AGUA.ACUEDUCTO',0.000010,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(408,'OS.502372413','Ori_Sil_2','','OS.260129010','OS.Iq1EOleU6','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA',3,10,'NA_20','','PP.NORMAL',0.0000,0.0000,252.5000,0.0579,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 20:18:50','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(409,'OS.698162954','Ori_Sil_2','','OS.260129010','OS.8cPZE3gJz','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)',3,10,'NA_20','','PP.NORMAL',100.0000,0.0000,200.0000,0.6510,1,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com'),
(410,'OS.267418399','Ori_Sil_2','','OS.260129010','OS.Us4Rarsco','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1',3,10,'hora','','PP.NORMAL',300.0000,160.0000,18000.0000,7.5955,3,'1','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:37:00','2026-01-29 16:37:00','COPY DETALLES PHP | 2026-01-29 16:37:00 | larevo1111@gmail.com');
/*!40000 ALTER TABLE `prod_ordenes_consumos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `prod_ordenes_detalles`
--

LOCK TABLES `prod_ordenes_detalles` WRITE;
/*!40000 ALTER TABLE `prod_ordenes_detalles` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `prod_ordenes_detalles` VALUES
(24,'94664a90','Ori_Sil_2',NULL,'OP25-1101-0027-26','Consumibles','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds','1',1.0000,'Und','',30.0000,650.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-06 22:12:54','2025-11-06 22:12:54',''),
(25,'fcb9ac9a','Ori_Sil_2',NULL,'OP25-1101-0027-26','Consumibles','C_E_CosdeFibmed_13','Costal de Fibra mediano','2',2.0000,'und','',50.0000,2000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-06 22:12:54','2025-11-06 22:12:54',''),
(26,'3b77c633','Ori_Sil_2',NULL,'OP25-1101-0027-26','Consumibles','C_E_VinAnc30c_14','Vinipel Ancho 30cm','4',3.0000,'mt','',30.0000,37.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'fasdfads','larevo1111@gmail.com','larevo1111@gmail.com','2025-11-06 22:12:54','2025-11-06 22:12:54',''),
(27,'d8c97495','Ori_Sil_2',NULL,'OP25-1101-0027-26','MP - Insumos','I_Envyt_TAPMETB.6XUNI_78','TAPA METALICA B.63 X UNIDAD','3',1.0000,'und','',120.0000,370.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-06 22:12:54','2025-11-06 22:12:54',''),
(28,'66342750','Ori_Sil_2',NULL,'OP25-1101-0027-26','MP - Insumos','I_Envyt_BOLTRAVALDOYPAC10X_02','BOLSA TRANSP VALVULA DOY PACK 10 X 18 + FFA 6cms 200 - 300 GRS (CERRADA) Bolsa transparente con tapa pequeña ALICO','4',2.0000,'und','',120.0000,345.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'mpes','larevo1111@gmail.com','larevo1111@gmail.com','2025-11-06 22:12:54','2025-11-06 22:12:54',''),
(29,'fe97ec93','Ori_Sil_2',NULL,'OP25-1101-0027-26','Producto Proceso','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA','2',1.0000,'kg','',10.0000,31000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-06 22:12:54','2025-11-06 22:12:54',''),
(30,'0defb62b','Ori_Sil_2',NULL,'OP25-1101-0027-26','Producto Proceso','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS','2',2.0000,'Und','',70.0000,677.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-06 22:12:54','2025-11-06 22:12:55',''),
(31,'4df69ebc','Ori_Sil_2',NULL,'OP25-1101-0027-26','Herramientas - Activos productivos','Ma_TER_17','TERMOMIX','2',1.0000,'dia','',40.0000,677.0000,57600.0000,4.0000,3,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-06 22:12:54','2025-11-06 22:12:55',''),
(32,'92def10e','Ori_Sil_2',NULL,'OP25-1101-0027-26','Herramientas - Activos productivos','He_BowMetde32c_05','Bowld Metálico 32cms','3',2.0000,'NA_20','',40.0000,14.0000,450.0000,0.0482,15,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-06 22:12:54','2025-11-06 22:12:55',''),
(33,'3167431b','Ori_Sil_2',NULL,'OP25-1101-0027-26','Mano de Obra y Servicios','MOex_MOExtNiv1_09','MO Externa Nivel 1','2',1.0000,'Hora','',10.0000,6500.0000,600.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-06 22:12:54','2025-11-06 22:12:55',''),
(34,'0812b0b6','Ori_Sil_2',NULL,'OP25-1101-0027-26','Mano de Obra y Servicios','MOex_MOExtNiv1_09','MO Externa Nivel 1','2',2.0000,'Hora','',5.0000,10000.0000,300.0000,0.0000,0,'MO est 1 -2','',0.000000,'',0.000000,'',0.000000,'gfgdsf','larevo1111@gmail.com','larevo1111@gmail.com','2025-11-06 22:12:54','2025-11-06 22:12:55',''),
(35,'7b07a77b','Ori_Sil_2',NULL,'O2511071509ad','Consumibles','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds','1',1.0000,'Und','',75.0000,650.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-12 15:06:38','2025-11-12 15:06:38',''),
(36,'84cfd583','Ori_Sil_2',NULL,'O2511071509ad','Consumibles','C_E_CosdeFibmed_13','Costal de Fibra mediano','2',2.0000,'und','',125.0000,2000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-12 15:06:38','2025-11-12 15:06:38',''),
(37,'de3fff3f','Ori_Sil_2',NULL,'O2511071509ad','Consumibles','C_E_VinAnc30c_14','Vinipel Ancho 30cm','4',3.0000,'mt','',75.0000,37.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'fasdfads','larevo1111@gmail.com','larevo1111@gmail.com','2025-11-12 15:06:38','2025-11-12 15:06:38',''),
(38,'49bdb205','Ori_Sil_2',NULL,'O2511071509ad','MP - Insumos','I_Envyt_TAPMETB.6XUNI_78','TAPA METALICA B.63 X UNIDAD','3',1.0000,'und','',300.0000,370.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-12 15:06:38','2025-11-12 15:06:38',''),
(39,'b5f4ee3d','Ori_Sil_2',NULL,'O2511071509ad','MP - Insumos','I_Envyt_BOLTRAVALDOYPAC10X_02','BOLSA TRANSP VALVULA DOY PACK 10 X 18 + FFA 6cms 200 - 300 GRS (CERRADA) Bolsa transparente con tapa pequeña ALICO','4',2.0000,'und','',300.0000,345.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'mpes','larevo1111@gmail.com','larevo1111@gmail.com','2025-11-12 15:06:38','2025-11-12 15:06:38',''),
(40,'670b35a5','Ori_Sil_2',NULL,'O2511071509ad','Producto Proceso','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA','2',1.0000,'kg','',25.0000,31000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-12 15:06:38','2025-11-12 15:06:38',''),
(41,'0de37e50','Ori_Sil_2',NULL,'O2511071509ad','Producto Proceso','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS','2',2.0000,'Und','',175.0000,677.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-12 15:06:38','2025-11-12 15:06:38',''),
(42,'3f4f026d','Ori_Sil_2',NULL,'O2511071509ad','Herramientas - Activos productivos','Ma_TER_17','TERMOMIX','2',1.0000,'dia','',100.0000,677.0000,144000.0000,4.0000,3,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-12 15:06:38','2025-11-12 15:06:38',''),
(43,'ed5d7f29','Ori_Sil_2',NULL,'O2511071509ad','Herramientas - Activos productivos','He_BowMetde32c_05','Bowld Metálico 32cms','3',2.0000,'NA_20','',100.0000,14.0000,1125.0000,0.0482,15,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-12 15:06:38','2025-11-12 15:06:38',''),
(44,'5c6874ce','Ori_Sil_2',NULL,'O2511071509ad','Mano de Obra y Servicios','MOex_MOExtNiv1_09','MO Externa Nivel 1','2',1.0000,'Hora','',25.0000,6500.0000,1500.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-12 15:06:38','2025-11-12 15:06:38',''),
(45,'cee99069','Ori_Sil_2',NULL,'O2511071509ad','Mano de Obra y Servicios','MOex_MOExtNiv1_09','MO Externa Nivel 1','2',2.0000,'Hora','',12.5000,10000.0000,750.0000,0.0000,0,'MO est 1 -2','',0.000000,'',0.000000,'',0.000000,'gfgdsf','larevo1111@gmail.com','larevo1111@gmail.com','2025-11-12 15:06:38','2025-11-12 15:06:38',''),
(46,'c2c6eabc','Ori_Sil_2',NULL,'O2511071509ad','Herramientas - Activos productivos','AP_PALACRTRA_28','PALA ACRILICA TRANSPARENTE','99',4.0000,'','',NULL,NULL,NULL,NULL,NULL,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-14 17:18:07','2025-11-14 17:18:07',''),
(47,'b3312241','Ori_Sil_2',NULL,'O2511071509ad','Consumibles','C_E_VinAnc30c_14','Vinipel Ancho 30cm','99',5.0000,'mt','',NULL,37.0000,NULL,0.0000,1,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-14 23:08:51','2025-11-14 23:08:51',''),
(48,'2bbc25b4','Ori_Sil_2',NULL,'251127013','MP - Insumos','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG','2',1.0000,'kg','',15.0000,20000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 14:37:53','2025-11-27 14:37:53',''),
(49,'90b55e0d','Ori_Sil_2',NULL,'251127013','Herramientas - Activos productivos','AP_Horpeq2ban_15','Horno pequeño 2 bandejas','2',1.0000,'hora','',8.7000,700.0000,525.0000,0.0000,1,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 14:37:53','2025-11-27 14:37:53',''),
(50,'d28c1ec2','Ori_Sil_2',NULL,'251127013','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','2',1.0000,'Hora','',4.9500,10000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'- Incluye alistamiento y lavado de utencilios','larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 14:37:53','2025-11-27 14:37:53',''),
(51,'3e3976ee','Ori_Sil_2',NULL,'25112702c','Consumibles','C_P_Serdepap_15','Servilletas de papel','2',1.0000,'cm','',75.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 15:35:47','2025-11-27 15:35:47',''),
(52,'614691ba','Ori_Sil_2',NULL,'25112702c','Consumibles','C_L_JabNeu_16','Jabon Neutro','2',2.0000,'ml','',25.0000,10.2600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 15:35:47','2025-11-27 15:35:47',''),
(53,'d5b26426','Ori_Sil_2',NULL,'25112702c','Producto Proceso','PPNiv2_NIBDECACLT_80','NIBS DE CACAO LT','2',1.0000,'kg','',10.0000,42080.6100,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 15:35:47','2025-11-27 15:35:47',''),
(54,'2833ca2a','Ori_Sil_2',NULL,'25112702c','Herramientas - Activos productivos','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)','2',1.0000,'NA_20','',0.0000,0.0000,10.0000,0.2900,1,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 15:35:47','2025-11-27 15:35:47',''),
(55,'f5417d80','Ori_Sil_2',NULL,'25112702c','Herramientas - Activos productivos','AP_BowMet27c_17','Bowld Metálico 27cms','2',2.0000,'NA_20','',0.0000,14.0000,10.0000,0.0400,1,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 15:35:47','2025-11-27 15:35:47',''),
(56,'ba05566e','Ori_Sil_2',NULL,'25112702c','Herramientas - Activos productivos','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1','2',5.0000,'hora','',60.0000,160.0000,3600.0000,3.3800,1,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 15:35:47','2025-11-27 15:35:47',''),
(57,'dba46737','Ori_Sil_2',NULL,'25112702c','Herramientas - Activos productivos','AP_Moldemaiele_16','Molino de maiz electrico','2',3.0000,'hora','',2.0000,700.0000,130.0000,0.3900,1,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 15:35:47','2025-11-27 15:35:47',''),
(58,'70743fb0','Ori_Sil_2',NULL,'25112702c','Herramientas - Activos productivos','AP_EspMet_26','Espatula Metalica','2',4.0000,'NA_20','',0.0000,NULL,0.0000,0.0000,1,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 15:35:47','2025-11-27 15:35:47',''),
(59,'4a0c9a0a','Ori_Sil_2',NULL,'25112702c','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','2',1.0000,'Hora','',7.5000,10000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Alistamiento y montaje de nibs en refinadora','larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 15:35:47','2025-11-27 15:35:47',''),
(60,'762191f7','Ori_Sil_2',NULL,'25112702c','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','2',2.0000,'Hora','',3.3000,10000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Bajar chocolate','larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 15:35:47','2025-11-27 15:35:47',''),
(100,'LsbOMzay6ZWrH8Dc','Ori_Sil_2',NULL,'25121501d','MP - Insumos','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG','2',400.0000,'kg','',6.0000,20000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-16 03:02:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 03:02:47','2025-12-17 00:40:07',''),
(101,'245qdeQW46UvbU85','Ori_Sil_2',NULL,'25121501d','MP - Insumos','MP_SalA_Bicxgra_12','Bicarbonato x gramo','1',100.0000,'g','',138.0000,15.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-16 03:02:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 03:02:47','2025-12-17 00:39:11',''),
(102,'hsxIxOjFVsYYHfFl','Ori_Sil_2',NULL,'25121501d','MP - Insumos','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD','4',3.0000,'und','',24.0000,1000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-16 03:02:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 03:02:47','2025-12-16 03:02:47',''),
(103,'FRiioNav1GGIjhGK','Ori_Sil_2',NULL,'25121501d','Consumibles','C_P_Serdepap_15','Servilletas de papel','2',500.0000,'cm','',45655656.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-16 03:02:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 03:02:47','2025-12-17 00:40:00',''),
(104,'K38PBVIzPiQYL84r','Ori_Sil_2',NULL,'25121501d','Consumibles','C_L_JabNeu_16','Jabon Neutro','2',100.0000,'ml','',15.0000,10.2600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-16 03:02:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 03:02:47','2025-12-17 00:40:27',''),
(105,'l4ebpqzsBAOorzjk','Ori_Sil_2',NULL,'25121501d','Consumibles','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS','4',3.0000,'Und','',6.0000,19300.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-16 03:02:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 03:02:47','2025-12-16 03:02:47',''),
(106,'FlOjiQ3ngGKx271A','Ori_Sil_2',NULL,'25121501d','Mano de Obra y Servicios','Selo_Dom_02','Domicilio','4',1.0000,'Und','',4.2000,8000.0000,210.0000,0.0000,0,'dmici','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-16 03:02:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 03:02:47','2025-12-16 03:02:47',''),
(107,'jxMtqMEPj4bqeLbp','Ori_Sil_2',NULL,'25121501d','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','1',200.0000,'Hora','',3.3000,10000.0000,196.8000,0.0000,0,'mo int al','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-16 03:02:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 03:02:47','2025-12-17 00:39:09',''),
(108,'Ywt8Dr3BXnyiE21x','Ori_Sil_2',NULL,'25121501d','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','2',600.0000,'Hora','',3.6000,10000.0000,216.0000,0.0000,0,'mo 1 2','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-16 03:02:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 03:02:47','2025-12-16 03:02:47',''),
(109,'DTTSARQ6WP2wOzkh','Ori_Sil_2',NULL,'25121501d','Herramientas - Activos productivos','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1','3',2.0000,'hora','',18.0000,160.0000,1080.0000,4.2197,3,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-16 03:02:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 03:02:47','2025-12-16 03:02:47',''),
(110,'OFt2Zvf85U51RwaC','Ori_Sil_2',NULL,'25121501d','Herramientas - Activos productivos','AP_Moldemaiele_16','Molino de maiz electrico','2',300.0000,'hora','',12.0000,700.0000,720.0000,0.4823,2,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-16 03:02:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 03:02:47','2025-12-17 00:39:40',''),
(111,'jYZN0dRBvmOGB1NL','Ori_Sil_2',NULL,'25121501d','Producto Proceso','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS','2',200.0000,'Und','',42.0000,677.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-16 03:02:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 03:02:47','2025-12-17 00:40:21',''),
(112,'259Dnehe2FopIgPT','Ori_Sil_2',NULL,'25121501d','Producto Proceso','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA','1',150.0000,'kg','',2.4000,31000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-16 03:02:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-16 03:02:47','2025-12-17 00:41:02',''),
(113,'sDxAkjvZIG4eFNB0','Ori_Sil_2',NULL,'251217017','Producto Proceso','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA','1',100.0000,'kg','',4.0000,31000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 05:42:39',''),
(114,'umvYhUhN7QPuglVK','Ori_Sil_2',NULL,'251217017','Producto Proceso','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA','2',200.0000,'kg','',10.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 05:42:39',''),
(115,'33PRc0797PN7fYTd','Ori_Sil_2',NULL,'251217017','Producto Proceso','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs','1',300.0000,'Und','',20.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 05:42:39',''),
(116,'r8sPYZJSdHwSHZch','Ori_Sil_2',NULL,'251217017','Producto Proceso','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS','2',100.0000,'Und','',70.0000,677.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 00:49:53',''),
(117,'DkB3ASuAOoIIAzmj','Ori_Sil_2',NULL,'251217017','Producto Proceso','PPPt__ENSCAS_7a','ENSA CASCARILLA','2',500.0000,'kg','',5.0000,470108.8600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 05:42:39',''),
(118,'YhFqEj9EgbJ1L3Um','Ori_Sil_2',NULL,'251217017','MP - Insumos','MP_SalA_Bicxgra_12','Bicarbonato x gramo','1',50.0000,'g','',230.0000,15.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 00:49:36',''),
(119,'jVDEfnW87JnkUOW3','Ori_Sil_2',NULL,'251217017','MP - Insumos','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA','2',700.0000,'und','',18.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 05:42:39',''),
(120,'m3c0b85mWb2W6qmx','Ori_Sil_2',NULL,'251217017','MP - Insumos','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD','4',250.0000,'und','',40.0000,1000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 00:49:18',''),
(121,'rJ3rQYsr8Cfp5gUX','Ori_Sil_2',NULL,'251217017','MP - Insumos','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG','2',350.0000,'kg','',10.0000,20000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 00:49:57',''),
(122,'V8dVkNCl9X9hjU9O','Ori_Sil_2',NULL,'251217017','MP - Insumos','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad','4',150.0000,'und','',20.0000,1125.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 00:49:46',''),
(123,'9HxkiLtndqffDClL','Ori_Sil_2',NULL,'251217017','MP - Insumos','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL','2',1100.0000,'kg','',4.3000,21000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 05:42:39',''),
(124,'98bS3I63qS4vO4Aj','Ori_Sil_2',NULL,'251217017','Consumibles','C_P_Serdepap_15','Servilletas de papel','4',1.5625,'cm','',75.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 00:50:27',''),
(125,'idgx1YaShqynblk1','Ori_Sil_2',NULL,'251217017','Consumibles','C_L_JabNeu_16','Jabon Neutro','4',3.1250,'ml','',25.0000,10.2600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 00:50:17',''),
(126,'GflX36dQzyUEjXYj','Ori_Sil_2',NULL,'251217017','Consumibles','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds','2',1400.0000,'Und','',30.0000,650.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 05:42:39',''),
(127,'RFLUs3ZRM9zd1xLM','Ori_Sil_2',NULL,'251217017','Consumibles','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS','4',12.5000,'Und','',10.0000,19300.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 00:49:43',''),
(128,'EwecPgJcuqosHCH6','Ori_Sil_2',NULL,'251217017','Consumibles','C_P_Serdepap_15','Servilletas de papel','2',1600.0000,'cm','',50.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 05:42:39',''),
(129,'kIdrVrjmpZ5zFRWF','Ori_Sil_2',NULL,'251217017','Mano de Obra y Servicios','Selo_Dom_02','Domicilio','4',200.0000,'Und','',7.0000,8000.0000,350.0000,0.0000,0,'dmici','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 00:49:48',''),
(130,'1l0lwsBFLjx9DkpV','Ori_Sil_2',NULL,'251217017','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','1',1800.0000,'Hora','',5.5000,10000.0000,328.0000,0.0000,0,'mo int al','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 05:42:39',''),
(131,'mZpIgCPmmujDS2I4','Ori_Sil_2',NULL,'251217017','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','2',1900.0000,'Hora','',6.0000,10000.0000,360.0000,0.0000,0,'mo 1 2','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 05:42:39',''),
(132,'6GZ8nq3BdQCOsCrf','Ori_Sil_2',NULL,'251217017','Mano de Obra y Servicios','Selo_FleMer_07','Flete Mercadolibre','2',2000.0000,'Und','',6.0000,9100.0000,0.0000,0.0000,0,'tres','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 05:42:39',''),
(133,'BQWQUHQrlP3oCkOX','Ori_Sil_2',NULL,'251217017','Mano de Obra y Servicios','MOex_MOExtNiv1_09','MO Externa Nivel 1','2',2100.0000,'Hora','',10.0000,10000.0000,600.0000,0.0000,0,'dos','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 05:42:39',''),
(134,'1A4JYDfhMjz357p7','Ori_Sil_2',NULL,'251217017','Herramientas - Activos productivos','AP_Moldemaiele_16','Molino de maiz electrico','2',2200.0000,'hora','',20.0000,700.0000,1200.0000,0.4823,2,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 05:42:39',''),
(135,'YXFTrY3ZWtBNhQN4','Ori_Sil_2',NULL,'251217017','Herramientas - Activos productivos','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA','3',2300.0000,'NA_20','',0.0000,NULL,20.0000,0.0322,1,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 05:42:39',''),
(136,'gVAn9D9AKOlH4NvH','Ori_Sil_2',NULL,'251217017','Herramientas - Activos productivos','AP_ConNevPeq_30','Congelador Nevera Pequeña','1',1050.0000,'minuto','',6.0000,NULL,6.0000,0.5787,1,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 00:49:40',''),
(137,'BxkiPpBvqyhoHc7t','Ori_Sil_2',NULL,'251217017','Herramientas - Activos productivos','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)','3',2500.0000,'NA_20','',10.0000,0.0000,20.0000,0.3617,1,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 05:42:39',''),
(138,'zOTH1c37dIDn8CJM','Ori_Sil_2',NULL,'251217017','Herramientas - Activos productivos','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1','3',2600.0000,'hora','',30.0000,160.0000,1800.0000,4.2197,3,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 05:42:39 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 05:42:39','2025-12-17 05:42:39',''),
(195,'DrzbTfd99f2CRtHO','Ori_Sil_2',NULL,'251217029','Producto Proceso','PPPP__CHOLT100-REF24H_2c','CHOCOLATE LT 100% - REFINADO 24H','2',100.0000,'kg','',10.0000,55254.5600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 07:36:09 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 07:36:09','2025-12-17 07:36:09',''),
(196,'Zoa6HKA2D99BWW3B','Ori_Sil_2',NULL,'251217029','Consumibles','C_P_Serdepap_15','Servilletas de papel','4',200.0000,'cm','',75.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 07:36:09 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 07:36:09','2025-12-17 07:36:09',''),
(197,'KaGArYVtgXTbpDxj','Ori_Sil_2',NULL,'251217029','Consumibles','C_L_JabNeu_16','Jabon Neutro','4',300.0000,'ml','',25.0000,10.2600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 07:36:09 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 07:36:09','2025-12-17 07:36:09',''),
(198,'bNuI5EGRiPwlX797','Ori_Sil_2',NULL,'251217029','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','1',400.0000,'Hora','',0.6250,10000.0000,37.5000,0.0000,0,'Alistamiento para enmoldar','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 07:36:09 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 07:36:09','2025-12-17 07:36:09',''),
(199,'0xYfHxxzKtWOHxPD','Ori_Sil_2',NULL,'251217029','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','2',500.0000,'Hora','',3.3000,10000.0000,198.0000,0.0000,0,'Enmoldado','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 07:36:09 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 07:36:09','2025-12-17 07:36:09',''),
(200,'IxBdTGa3wW9ztJ6D','Ori_Sil_2',NULL,'251217029','Mano de Obra y Servicios','S_M_TiedeRep_16','Tiempo de Reposo','3',600.0000,'hora','',70.0000,NULL,4200.0000,0.0000,0,'Tiempo de chocolate en moldes','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 07:36:09 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 07:36:09','2025-12-17 07:36:09',''),
(201,'5C5tg7WxfFEKktfa','Ori_Sil_2',NULL,'251217029','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','4',700.0000,'Hora','',0.6500,10000.0000,39.0000,0.0000,0,'Aseo','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 07:36:09 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 07:36:09','2025-12-17 07:36:09',''),
(202,'dG91iyNTPF2g0otU','Ori_Sil_2',NULL,'251217029','Herramientas - Activos productivos','AP_EmbDos_29','Embudo Dosificador','2',800.0000,'NA_20','',0.0000,NULL,60.0000,0.0772,1,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 07:36:09 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 07:36:09','2025-12-17 07:36:09',''),
(203,'9FRJdHrPnxZggFHj','Ori_Sil_2',NULL,'251217029','Herramientas - Activos productivos','Mo_MOLPOLAMAFIG9-12g_08','MOLDE POLICARBONATO AMAZON FIGURAS 9 - 12g X UNIDAD','2',900.0000,'NA_20','',40.0000,0.0000,0.0000,720.0000,1,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 07:36:09 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 07:36:09','2025-12-17 07:36:09',''),
(204,'Tg5Y32h4N4RV2Tx5','Ori_Sil_2',NULL,'251217029','Herramientas - Activos productivos','AP_ConNevPeq_30','Congelador Nevera Pequeña','3',1000.0000,'minuto','',100.0000,NULL,100.0000,0.5787,1,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 07:36:09 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 07:36:09','2025-12-17 07:36:09',''),
(205,'YeeYJQjAwFeH3N05','Ori_Sil_2',NULL,'251217029','Herramientas - Activos productivos','AP_EstdeGas3Pue_31','Estufa de Gas 3 Puestos','4',1100.0000,'minuto','',40.0000,15.0000,40.0000,0.4823,1,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 07:36:09 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 07:36:09','2025-12-17 07:36:09',''),
(206,'rDUkg3qxE4f5e92S','Ori_Sil_2',NULL,'251217029','Herramientas - Activos productivos','AP_ZondeLav_32','Zona de Lavado','4',1200.0000,'minuto','',50.0000,28.0000,50.0000,0.1929,1,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 07:36:09 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 07:36:09','2025-12-17 07:36:09',''),
(241,'j0VKsB6diq4FqC86','Ori_Sil_2',NULL,'251217046','MP - Insumos','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL','2',100.0000,'kg','',20.0000,21000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 08:21:03 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 08:21:03','2025-12-17 08:21:03',''),
(242,'HQGEn0ukmIufxQrc','Ori_Sil_2',NULL,'251217046','Consumibles','C_E_CosdeFibmed_13','Costal de Fibra mediano','2',200.0000,'und','',0.6000,2000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 08:21:03 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 08:21:03','2025-12-17 08:21:03',''),
(243,'DNcdc5owR3x3Nj0h','Ori_Sil_2',NULL,'251217046','Consumibles','C_E_VinAnc30c_14','Vinipel Ancho 30cm','2',300.0000,'mt','',120.0000,37.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 08:21:03 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 08:21:03','2025-12-17 08:21:03',''),
(244,'OO6SSbaPfqReO6Az','Ori_Sil_2',NULL,'251217046','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','2',400.0000,'Hora','',0.2000,10000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 08:21:03 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 08:21:03','2025-12-17 08:21:03',''),
(245,'AFBHrbd7KxI8ajJ4','Ori_Sil_2',NULL,'251217046','Mano de Obra y Servicios','Selo_FLEBUCMAQCAC_06','FLETE BUCARAMANGA MAQUILA CACAO','2',500.0000,'kg','',20.0000,1100.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 08:21:03 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 08:21:03','2025-12-17 08:21:03',''),
(246,'x81lPufKbbZYNd3w','Ori_Sil_2',NULL,'251217046','Mano de Obra y Servicios','Mapr_MAQOBTDENIBDECAC_08','MAQUILA OBTENCION DE NIBS DE CACAO','2',600.0000,'kg','',20.0000,4845.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 08:21:03 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 08:21:03','2025-12-17 08:21:03',''),
(247,'RtowawKtPoGcDGmY','Ori_Sil_2',NULL,'251217046','Mano de Obra y Servicios','Selo_FLEBUCMAQCAC_06','FLETE BUCARAMANGA MAQUILA CACAO','2',700.0000,'kg','',20.0000,1100.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 08:21:03 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 08:21:03','2025-12-17 08:21:03',''),
(248,'0W9Ka2zqr0g12U0T','Ori_Sil_2',NULL,'251217046','Mano de Obra y Servicios','S_S_LogInt_15','Logistica Interna','2',800.0000,'hora','',0.8000,25000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-17 08:21:03 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 08:21:03','2025-12-17 08:21:03',''),
(275,'VuQ0gEYjOa2LUcUL','Ori_Sil_2',NULL,'25121703e','Producto Proceso','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA','1',100.0000,'kg','',4.0000,31000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(276,'NSFm2VEBiTbGgc70','Ori_Sil_2',NULL,'25121703e','Producto Proceso','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA','2',200.0000,'kg','',10.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(277,'W7Aa4FSmHa1YG2mi','Ori_Sil_2',NULL,'25121703e','Producto Proceso','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs','1',300.0000,'Und','',20.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(278,'pT804qKKtGTwnp3n','Ori_Sil_2',NULL,'25121703e','Producto Proceso','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS','2',400.0000,'Und','',70.0000,677.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(279,'2qKhOOWZOgIB0Eld','Ori_Sil_2',NULL,'25121703e','Producto Proceso','PPPt__ENSCAS_7a','ENSA CASCARILLA','2',500.0000,'kg','',5.0000,470108.8600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(280,'61U7hcpPHK91vO3O','Ori_Sil_2',NULL,'25121703e','MP - Insumos','MP_SalA_Bicxgra_12','Bicarbonato x gramo','1',600.0000,'g','',230.0000,15.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(281,'zwiqafX7n09L7vLF','Ori_Sil_2',NULL,'25121703e','MP - Insumos','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA','2',700.0000,'und','',18.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(282,'pWo2yVvzqoZvI7BV','Ori_Sil_2',NULL,'25121703e','MP - Insumos','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD','4',800.0000,'und','',40.0000,1000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(283,'Ia5uzkXg9gVCxIb1','Ori_Sil_2',NULL,'25121703e','MP - Insumos','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG','2',900.0000,'kg','',10.0000,20000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(284,'pBAxM27FKEqyKtOD','Ori_Sil_2',NULL,'25121703e','MP - Insumos','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad','4',1000.0000,'und','',20.0000,1125.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(285,'jMPH2DdhafQxhg8u','Ori_Sil_2',NULL,'25121703e','MP - Insumos','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL','2',1100.0000,'kg','',4.3000,21000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(286,'KhLN3cdPljpWqEDO','Ori_Sil_2',NULL,'25121703e','Consumibles','C_P_Serdepap_15','Servilletas de papel','4',1200.0000,'cm','',75.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(287,'OqKy9Vy9fn3hRCwm','Ori_Sil_2',NULL,'25121703e','Consumibles','C_L_JabNeu_16','Jabon Neutro','4',1300.0000,'ml','',25.0000,10.2600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(288,'DVj3eN4wki0Hi6m0','Ori_Sil_2',NULL,'25121703e','Consumibles','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds','2',1400.0000,'Und','',30.0000,650.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(289,'RGD1kDLaN58opJm3','Ori_Sil_2',NULL,'25121703e','Consumibles','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS','4',1500.0000,'Und','',10.0000,19300.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(290,'50r0m2nbzyQ7eKha','Ori_Sil_2',NULL,'25121703e','Consumibles','C_P_Serdepap_15','Servilletas de papel','2',1600.0000,'cm','',50.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(291,'k2SUwbkfGqCo5J2a','Ori_Sil_2',NULL,'25121703e','Mano de Obra y Servicios','Selo_Dom_02','Domicilio','4',1700.0000,'Und','',7.0000,8000.0000,350.0000,0.0000,0,'dmici','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(292,'3elQ08ZvnEo8fPtp','Ori_Sil_2',NULL,'25121703e','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','1',1800.0000,'Hora','',5.5000,10000.0000,328.0000,0.0000,0,'mo int al','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(293,'MeJgcf3310aYxzFl','Ori_Sil_2',NULL,'25121703e','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','2',1900.0000,'Hora','',6.0000,10000.0000,360.0000,0.0000,0,'mo 1 2','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(294,'HEMgXGhnsvASR4YW','Ori_Sil_2',NULL,'25121703e','Mano de Obra y Servicios','Selo_FleMer_07','Flete Mercadolibre','2',2000.0000,'Und','',6.0000,9100.0000,0.0000,0.0000,0,'tres','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(295,'huzjUB6GomY0CtSW','Ori_Sil_2',NULL,'25121703e','Mano de Obra y Servicios','MOex_MOExtNiv1_09','MO Externa Nivel 1','2',2100.0000,'Hora','',10.0000,10000.0000,600.0000,0.0000,0,'dos','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(296,'eanxiKpCRMNWnHBc','Ori_Sil_2',NULL,'25121703e','Herramientas - Activos productivos','AP_Moldemaiele_16','Molino de maiz electrico','2',2200.0000,'hora','',20.0000,700.0000,1200.0000,0.4823,2,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(297,'XuePSRaXlLJahiA7','Ori_Sil_2',NULL,'25121703e','Herramientas - Activos productivos','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA','3',2300.0000,'NA_20','',0.0000,NULL,20.0000,0.0322,1,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(298,'IOH6hARCPGi67hgh','Ori_Sil_2',NULL,'25121703e','Herramientas - Activos productivos','AP_ConNevPeq_30','Congelador Nevera Pequeña','1',2400.0000,'minuto','',6.0000,NULL,6.0000,0.5787,1,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(299,'a1auF1gF6ll2ftpD','Ori_Sil_2',NULL,'25121703e','Herramientas - Activos productivos','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)','3',2500.0000,'NA_20','',10.0000,0.0000,20.0000,0.3617,1,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(300,'l5jgtpH2yCBcKKsr','Ori_Sil_2',NULL,'25121703e','Herramientas - Activos productivos','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1','3',2600.0000,'hora','',30.0000,160.0000,1800.0000,4.2197,3,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 00:14:47 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 00:14:47','2025-12-19 00:14:47',''),
(312,'8Zr8o5G1ob7qWwDe','Ori_Sil_2',NULL,'251218014','Producto Proceso','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA','2',100.0000,'kg','',14.5000,31000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 03:47:03 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 03:47:03','2025-12-19 03:47:03',''),
(313,'1jKOo9WYt2UhTCcT','Ori_Sil_2',NULL,'251218014','Mano de Obra y Servicios','MOex_MOExtNiv1_09','MO Externa Nivel 1','2',200.0000,'Hora','',14.5000,6500.0000,870.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-19 03:47:03 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-19 03:47:03','2025-12-19 03:47:03',''),
(340,'8RHzaS7RVOutWwrT','Ori_Sil_2',NULL,'OS.251227017','Producto Proceso','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA','1',100.0000,'kg','',40.0000,31000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(341,'O041ShnBRHcOF512','Ori_Sil_2',NULL,'OS.251227017','Producto Proceso','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA','2',200.0000,'kg','',100.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(342,'HD2f0RAY5hxFH0Dr','Ori_Sil_2',NULL,'OS.251227017','Producto Proceso','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs','1',300.0000,'Und','',200.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(343,'VoeqXFH1O0sAQY8x','Ori_Sil_2',NULL,'OS.251227017','Producto Proceso','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS','2',400.0000,'Und','',700.0000,677.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(344,'oNN83AKkZEo9mQOB','Ori_Sil_2',NULL,'OS.251227017','Producto Proceso','PPPt__ENSCAS_7a','ENSA CASCARILLA','2',500.0000,'kg','',50.0000,470108.8600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(345,'uOyxsoQ4lWJPGGgI','Ori_Sil_2',NULL,'OS.251227017','MP - Insumos','MP_SalA_Bicxgra_12','Bicarbonato x gramo','1',600.0000,'g','',2300.0000,15.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(346,'ou0mO8U8Z3OatcPw','Ori_Sil_2',NULL,'OS.251227017','MP - Insumos','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD','4',700.0000,'und','',400.0000,1000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(347,'wY8fMVPjri72AxZH','Ori_Sil_2',NULL,'OS.251227017','MP - Insumos','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA','2',800.0000,'und','',180.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(348,'6Ten0jqtstzP65lW','Ori_Sil_2',NULL,'OS.251227017','MP - Insumos','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG','2',900.0000,'kg','',100.0000,20000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(349,'f8W6hZPykKSQtfa3','Ori_Sil_2',NULL,'OS.251227017','MP - Insumos','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad','4',1000.0000,'und','',200.0000,1125.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(350,'BsEpReLfb4hmcOYz','Ori_Sil_2',NULL,'OS.251227017','MP - Insumos','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL','2',1100.0000,'kg','',43.0000,21000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(351,'hXOAbHOjuG1VHvAv','Ori_Sil_2',NULL,'OS.251227017','Consumibles','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds','2',1200.0000,'Und','',300.0000,650.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(352,'yadZpoPG5NPLd4Jr','Ori_Sil_2',NULL,'OS.251227017','Consumibles','C_P_Serdepap_15','Servilletas de papel','2',1300.0000,'cm','',500.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(353,'0MnwNF9eYGdNuAYR','Ori_Sil_2',NULL,'OS.251227017','Consumibles','C_P_Serdepap_15','Servilletas de papel','4',1400.0000,'cm','',750.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(354,'DqNSTTu1USFFCCM8','Ori_Sil_2',NULL,'OS.251227017','Consumibles','C_L_JabNeu_16','Jabon Neutro','4',1500.0000,'ml','',250.0000,10.2600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(355,'wAa6CtN9cz6eD4bS','Ori_Sil_2',NULL,'OS.251227017','Consumibles','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS','4',1600.0000,'Und','',100.0000,19300.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(356,'LyMDEsTGt3gVBxML','Ori_Sil_2',NULL,'OS.251227017','Mano de Obra y Servicios','Selo_Dom_02','Domicilio','4',1700.0000,'Und','',70.0000,8000.0000,3500.0000,0.0000,0,'domi','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(357,'o8xNlUuzBAegIMQG','Ori_Sil_2',NULL,'OS.251227017','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','1',1800.0000,'Hora','',55.0000,10000.0000,3280.0000,0.0000,0,'mo int al','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(358,'ts3w3w8xl6MZCGcz','Ori_Sil_2',NULL,'OS.251227017','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','2',1900.0000,'Hora','',60.0000,10000.0000,3600.0000,0.0000,0,'mo 1 2','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(359,'Pub4g41isaUAFbz5','Ori_Sil_2',NULL,'OS.251227017','Mano de Obra y Servicios','Selo_FleMer_07','Flete Mercadolibre','2',2000.0000,'Und','',60.0000,9100.0000,0.0000,0.0000,0,'tres','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(360,'4XvgnHPAvhhshWme','Ori_Sil_2',NULL,'OS.251227017','Mano de Obra y Servicios','MOex_MOExtNiv1_09','MO Externa Nivel 1','2',2100.0000,'Hora','',100.0000,10000.0000,6000.0000,0.0000,0,'dos','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(361,'bOlOIIaZf1RaCTfg','Ori_Sil_2',NULL,'OS.251227017','Herramientas - Activos productivos','AP_Moldemaiele_16','Molino de maiz electrico','2',2200.0000,'hora','',200.0000,700.0000,12000.0000,0.4823,2,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(362,'89eZmA6wPo5kjR5l','Ori_Sil_2',NULL,'OS.251227017','Herramientas - Activos productivos','AP_ConNevPeq_30','Congelador Nevera Pequeña','1',2300.0000,'minuto','',60.0000,NULL,60.0000,0.5787,1,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(363,'Mqe8SbLHATIFDrl2','Ori_Sil_2',NULL,'OS.251227017','Herramientas - Activos productivos','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA','3',2400.0000,'NA_20','',0.0000,NULL,252.5000,0.0322,1,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(364,'FfY0oJfkesc0rwAS','Ori_Sil_2',NULL,'OS.251227017','Herramientas - Activos productivos','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)','3',2500.0000,'NA_20','',100.0000,0.0000,200.0000,0.3617,1,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(365,'yFiJdSiimzoIK1P2','Ori_Sil_2',NULL,'OS.251227017','Herramientas - Activos productivos','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1','3',2600.0000,'hora','',300.0000,160.0000,18000.0000,4.2197,3,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(1132,'AIuWiaq5hR1wjim2','Ori_Sil_2',NULL,'OS.26011001e','Producto Proceso','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA','1',100.0000,'kg','',4.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1133,'nJ16Lv02RIivbVml','Ori_Sil_2',NULL,'OS.26011001e','Producto Proceso','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA','2',200.0000,'kg','',10.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1134,'AZE1Ph1BKdduooLu','Ori_Sil_2',NULL,'OS.26011001e','Producto Proceso','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs','1',300.0000,'Und','',20.0000,212.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1135,'x3XnEHT3qVRUDzjt','Ori_Sil_2',NULL,'OS.26011001e','Producto Proceso','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS','2',400.0000,'Und','',70.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1136,'7BDBbjug7g9fNTcs','Ori_Sil_2',NULL,'OS.26011001e','Producto Proceso','PPPt__ENSCAS_7a','ENSA CASCARILLA','2',500.0000,'kg','',5.0000,30826.6041,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1137,'R4eGqCz7d7LmFKeg','Ori_Sil_2',NULL,'OS.26011001e','MP - Insumos','MP_SalA_Bicxgra_12','Bicarbonato x gramo','1',600.0000,'g','',230.0000,15.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1138,'ybOmr7movjIXsvcd','Ori_Sil_2',NULL,'OS.26011001e','MP - Insumos','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD','4',700.0000,'und','',40.0000,1000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1139,'H2M7ysLW4X1CsJ2n','Ori_Sil_2',NULL,'OS.26011001e','MP - Insumos','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA','2',800.0000,'und','',18.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1140,'om5wQ1AcwPbdqPt4','Ori_Sil_2',NULL,'OS.26011001e','MP - Insumos','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG','2',900.0000,'kg','',10.0000,20000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1141,'T8XYDwYjB6wPuT7Q','Ori_Sil_2',NULL,'OS.26011001e','MP - Insumos','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad','4',1000.0000,'und','',20.0000,1125.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1142,'NJDxOi8Kt9dGhcV1','Ori_Sil_2',NULL,'OS.26011001e','MP - Insumos','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL','2',1100.0000,'kg','',4.3000,21000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1143,'WLIji7402xqWixnn','Ori_Sil_2',NULL,'OS.26011001e','Consumibles','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds','2',1200.0000,'Und','',30.0000,650000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1144,'oiSjlkGw4Pq8IioB','Ori_Sil_2',NULL,'OS.26011001e','Consumibles','C_P_Serdepap_15','Servilletas de papel','2',1300.0000,'cm','',50.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1145,'eWsfP4Ga1MND8TOb','Ori_Sil_2',NULL,'OS.26011001e','Consumibles','C_P_Serdepap_15','Servilletas de papel','4',1400.0000,'cm','',75.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1146,'3peeenF0wW2NjKyc','Ori_Sil_2',NULL,'OS.26011001e','Consumibles','C_L_JabNeu_16','Jabon Neutro','4',1500.0000,'ml','',25.0000,10.2600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1147,'865hqKZVkpJXBfvf','Ori_Sil_2',NULL,'OS.26011001e','Consumibles','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS','4',1600.0000,'Und','',10.0000,19300.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1148,'T5eMysHQ2La7BkCN','Ori_Sil_2',NULL,'OS.26011001e','Mano de Obra y Servicios','Selo_Dom_02','Domicilio','4',1700.0000,'Und','',7.0000,8000.0000,350.0000,0.0000,0,'domi','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1149,'z1a9M06TWv5mGI14','Ori_Sil_2',NULL,'OS.26011001e','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','1',1800.0000,'Hora','',5.5000,10000.0000,328.0000,0.0000,0,'mo int al','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1150,'XXbz31GXoPEmRvJv','Ori_Sil_2',NULL,'OS.26011001e','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','2',1900.0000,'Hora','A',6.0000,10000.0000,360.0000,0.0000,0,'mo 1 2','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-15 18:33:17',''),
(1151,'zUhsYKJkd8swCqCN','Ori_Sil_2',NULL,'OS.26011001e','Mano de Obra y Servicios','Selo_FleMer_07','Flete Mercadolibre','2',2000.0000,'Und','',6.0000,910000.0000,0.0000,0.0000,0,'tres','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1152,'gNi7bQCT0BbuX4oa','Ori_Sil_2',NULL,'OS.26011001e','Mano de Obra y Servicios','MOex_MOExtNiv1_09','MO Externa Nivel 1','2',2100.0000,'Hora','A',10.0000,10000.0000,600.0000,0.0000,0,'dos','',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-15 18:33:39',''),
(1153,'TcWYvmFcGf0QnXz3','Ori_Sil_2',NULL,'OS.26011001e','Herramientas - Activos productivos','AP_Moldemaiele_16','Molino de maiz electrico','2',2200.0000,'hora','',20.0000,700.0000,1200.0000,0.8681,2,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1154,'N4jE8QY3qmaFKQ1Z','Ori_Sil_2',NULL,'OS.26011001e','Herramientas - Activos productivos','AP_ConNevPeq_30','Congelador Nevera Pequeña','1',2300.0000,'minuto','',6.0000,0.0000,6.0000,1.0417,1,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1155,'mMUs2eMcdoZLsD54','Ori_Sil_2',NULL,'OS.26011001e','Herramientas - Activos productivos','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA','3',2400.0000,'NA_20','',0.0000,0.0000,25.2500,0.0579,1,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1156,'Sch6ydc7ouzobs04','Ori_Sil_2',NULL,'OS.26011001e','Herramientas - Activos productivos','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)','3',2500.0000,'NA_20','',10.0000,0.0000,20.0000,0.6510,1,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1157,'i1e6EolVkx86LAj0','Ori_Sil_2',NULL,'OS.26011001e','Herramientas - Activos productivos','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1','3',2600.0000,'hora','',30.0000,160.0000,1800.0000,7.5955,3,NULL,'',0.000000,'',0.000000,'',0.000000,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(1158,'OS.13f99888','Ori_Sil_2',NULL,'O2511071509ad','Mano de Obra y Servicios','Mapr_ENVMIE_04','ENVASADO MIEL','99',105.0000,'kg','',NULL,560.0000,NULL,0.0000,1,NULL,'',0.000000,'',0.000000,'',0.000000,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-11 09:57:40','2026-01-11 09:57:40',''),
(1159,'OS.4823b60f','Ori_Sil_2','CacyCho_d0','OS.26011001e','Producto Proceso','PPNiv2_CASDECACLTxKL_09','CASCARILLA DE CACAO LT x Kg','99',NULL,'kg','',0.0000,22026.1976,0.0000,0.0000,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,'Generado PHP| 2026-01-12 01:23:40 | larevo1111@gmail.com'),
(1160,'OS.6a448b8a','Ori_Sil_2','CacyCho_d0','OS.26011001e','Consumibles','Limyase_BATDESPOLXUNI_7','BATA DESECHABLE POLIPROPILENO X UNIDAD','99',NULL,'Und','',0.0000,5090.0000,0.0000,0.0000,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,'Generado PHP| 2026-01-12 01:46:51 | larevo1111@gmail.com'),
(1161,'OS.2c18379f','Ori_Sil_2','CacyCho_d0','OS.26011001e','MP - Insumos','I_Eti_EtiOriSiltap_90','Etiqueta Origen Silvestre tapa','99',NULL,'und','',0.0000,390.0000,0.0000,0.0000,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,'Generado PHP| 2026-01-12 01:52:58 | larevo1111@gmail.com'),
(1162,'OS.13b9b097','Ori_Sil_2','CacyCho_d0','OS.26011001e','Mano de Obra y Servicios','Selo_FLEBUCMAQCAC_06','FLETE BUCARAMANGA MAQUILA CACAO','99',NULL,'kg','',0.0000,1000.0000,0.0000,0.0000,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,'Generado PHP| 2026-01-12 02:05:32 | larevo1111@gmail.com'),
(1163,'OS.c9316e30','Ori_Sil_2','CacyCho_d0','OS.26011001e','Mano de Obra y Servicios','Mapr_MAQOBTDENIBDECAC_08','MAQUILA OBTENCION DE NIBS DE CACAO','99',NULL,'kg','',0.0000,4845.0000,0.0000,0.0000,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,'Generado PHP| 2026-01-12 02:14:47 | larevo1111@gmail.com'),
(1166,'Ori_Sil_2.DET123ABC','Ori_Sil_2','CacyCho_d0','OS.26011001e','Herramientas - Activos productivos','AP_Seldebolaped_14','Selladora de bolsas a pedal','99',NULL,'segundo','',0.0000,0.0900,0.0000,1.3755,1,'','',0.000000,'',0.000000,'',0.000000,'','ensayosky','ensayosky',NULL,NULL,'Generado PHP| 2026-01-12 02:51:45 | ensayosky'),
(1167,'OS.4ca041f6','Ori_Sil_2','CacyCho_d0','OS.26011001e','Herramientas - Activos productivos','AP_Horpeq2ban_15','Horno pequeño 2 bandejas','99',NULL,'hora','',0.0000,700.0000,0.0000,0.2170,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,'Generado PHP| 2026-01-12 02:52:59 | larevo1111@gmail.com'),
(1168,'OS.fec943a8','Ori_Sil_2','CacyCho_d0','OS.26011001e','Mano de Obra y Servicios','S_S_LogInt_15','Logistica Interna','99',NULL,'hora','',0.0000,25000.0000,0.0000,0.0000,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,'Generado PHP| 2026-01-12 03:06:54 | larevo1111@gmail.com'),
(1169,'OS.58f8e4cf','Ori_Sil_2','CacyCho_d0','OS.26011001e','Consumibles','Limyase_AmoCuaxlit(Liydes_6','Amonio Cuaternario x litro (Limpieza y desinfección)','99',NULL,'Und','',0.0000,12700.0000,0.0000,0.0000,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,'EXECUTION_ID=run_696468e326a151.14563070 | Generado PHP| 2026-01-12 03:22:11 | larevo1111@gmail.com'),
(1170,'OS.e570d1e9','Ori_Sil_2','CacyCho_d0','OS.26011001e','MP - Insumos','I_Envyt_EnvVidR267Fli230B.6_87','Envase Vidrio R 2670 Flint, 230cc, B.63, C Tapa UNICOR','99',NULL,'und','',0.0000,1060.0000,0.0000,0.0000,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,'EXECUTION_ID=run_69646b803acae4.47596851 | Generado PHP| 2026-01-12 03:33:20 | larevo1111@gmail.com'),
(1171,'OS.dbbee95d','Ori_Sil_2','CacyCho_d0','OS.26011001e','Producto Proceso','PPNiv3_CREDEMAN_41','CREMA DE MANI','99',NULL,'kg','',0.0000,0.0000,0.0000,0.0000,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,'Generado PHP| 2026-01-12 03:35:24 | larevo1111@gmail.com'),
(1172,'REV1WNzw83jOjMYP','Ori_Sil_2',NULL,'OS.26011101b','Producto Proceso','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA','1',100.0000,'kg','',400.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1173,'PxYyjWzo7Tq0z3J9','Ori_Sil_2',NULL,'OS.26011101b','Producto Proceso','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA','2',200.0000,'kg','',1000.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1174,'qbqcEHIfrIh5As1r','Ori_Sil_2',NULL,'OS.26011101b','Producto Proceso','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs','1',300.0000,'Und','',2000.0000,212.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1175,'uHD45SgVtg0yQDx7','Ori_Sil_2',NULL,'OS.26011101b','Producto Proceso','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS','2',400.0000,'Und','',7000.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1176,'5v8NOPIWsMFCpTss','Ori_Sil_2',NULL,'OS.26011101b','Producto Proceso','PPPt__ENSCAS_7a','ENSA CASCARILLA','2',500.0000,'kg','',500.0000,30826.6041,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1177,'p9ktNUtIeS8SiF8J','Ori_Sil_2',NULL,'OS.26011101b','MP - Insumos','MP_SalA_Bicxgra_12','Bicarbonato x gramo','1',600.0000,'g','',23000.0000,15.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1178,'ZPsXQfryDdHObdZB','Ori_Sil_2',NULL,'OS.26011101b','MP - Insumos','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD','4',700.0000,'und','',4000.0000,1000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1179,'K03cXUdxPKeBkppB','Ori_Sil_2',NULL,'OS.26011101b','MP - Insumos','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA','2',800.0000,'und','',1800.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1180,'Cmc6CpTpAZGB0ntD','Ori_Sil_2',NULL,'OS.26011101b','MP - Insumos','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG','2',900.0000,'kg','',1000.0000,20000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1181,'TElH6OIAeUtKFSWy','Ori_Sil_2',NULL,'OS.26011101b','MP - Insumos','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad','4',1000.0000,'und','',2000.0000,1125.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1182,'jlLy6esXPILyldjg','Ori_Sil_2',NULL,'OS.26011101b','MP - Insumos','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL','2',1100.0000,'kg','',430.0000,21000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1183,'JqiqpVqTYg4zNHFV','Ori_Sil_2',NULL,'OS.26011101b','Consumibles','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds','2',1200.0000,'Und','',3000.0000,650000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1184,'uvzAYaxCxh5Uo3n2','Ori_Sil_2',NULL,'OS.26011101b','Consumibles','C_P_Serdepap_15','Servilletas de papel','2',1300.0000,'cm','',5000.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1185,'eJJDeWJXnNDVQbsw','Ori_Sil_2',NULL,'OS.26011101b','Consumibles','C_P_Serdepap_15','Servilletas de papel','4',1400.0000,'cm','',7500.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1186,'5lxbcQ5Q1zZYs3X6','Ori_Sil_2',NULL,'OS.26011101b','Consumibles','C_L_JabNeu_16','Jabon Neutro','4',1500.0000,'ml','',2500.0000,10.2600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1187,'YK2hC0yHNHQQPdLT','Ori_Sil_2',NULL,'OS.26011101b','Consumibles','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS','4',1600.0000,'Und','',1000.0000,19300.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1188,'vOhuccSwwBQAu8xj','Ori_Sil_2',NULL,'OS.26011101b','Mano de Obra y Servicios','Selo_Dom_02','Domicilio','4',1700.0000,'Und','',700.0000,8000.0000,35000.0000,0.0000,0,'domi','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1189,'6y8yOHKgxKLOQ07y','Ori_Sil_2',NULL,'OS.26011101b','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','1',1800.0000,'Hora','',550.0000,10000.0000,32800.0000,0.0000,0,'mo int al','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1190,'BtVVEMZFpUlNcCgU','Ori_Sil_2',NULL,'OS.26011101b','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','2',1900.0000,'Hora','',600.0000,10000.0000,36000.0000,0.0000,0,'mo 1 2','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1191,'JNqD7TYnATMSgFxr','Ori_Sil_2',NULL,'OS.26011101b','Mano de Obra y Servicios','Selo_FleMer_07','Flete Mercadolibre','2',2000.0000,'Und','',600.0000,910000.0000,0.0000,0.0000,0,'tres','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1192,'iNotUukLGAUghCQ0','Ori_Sil_2',NULL,'OS.26011101b','Mano de Obra y Servicios','MOex_MOExtNiv1_09','MO Externa Nivel 1','2',2100.0000,'Hora','',1000.0000,10000.0000,60000.0000,0.0000,0,'dos','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1193,'CHDE8R0B1QeZBjH1','Ori_Sil_2',NULL,'OS.26011101b','Herramientas - Activos productivos','AP_Moldemaiele_16','Molino de maiz electrico','2',2200.0000,'hora','',2000.0000,700.0000,120000.0000,0.8681,2,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1194,'sMd3h5rggNVCqXLV','Ori_Sil_2',NULL,'OS.26011101b','Herramientas - Activos productivos','AP_ConNevPeq_30','Congelador Nevera Pequeña','1',2300.0000,'minuto','',600.0000,0.0000,600.0000,1.0417,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1195,'xphgupJU9hyllLqe','Ori_Sil_2',NULL,'OS.26011101b','Herramientas - Activos productivos','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA','3',2400.0000,'NA_20','',0.0000,0.0000,2525.0000,0.0579,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1196,'3zJVb0UStQnzzLbP','Ori_Sil_2',NULL,'OS.26011101b','Herramientas - Activos productivos','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)','3',2500.0000,'NA_20','',1000.0000,0.0000,2000.0000,0.6510,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1197,'KVBQ4jI05qC3Ke8V','Ori_Sil_2',NULL,'OS.26011101b','Herramientas - Activos productivos','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1','3',2600.0000,'hora','',3000.0000,160.0000,180000.0000,7.5955,3,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(1198,'CMcWzzTYIenwTFb5','Ori_Sil_2',NULL,'OS.26011201b','Producto Proceso','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA','2',100.0000,'kg','',100.0000,31000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 13:54:49','2026-01-12 13:54:49','Generado automáticamente | 2026-01-12 13:54:49 | larevo1111@gmail.com'),
(1199,'3K7KPwMq1YgOcP8i','Ori_Sil_2',NULL,'OS.26011201b','Mano de Obra y Servicios','MOex_MOExtNiv1_09','MO Externa Nivel 1','2',200.0000,'Hora','',100.0000,10000.0000,6000.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 13:54:49','2026-01-12 13:54:49','Generado automáticamente | 2026-01-12 13:54:49 | larevo1111@gmail.com'),
(1200,'OS.e406da55','Ori_Sil_2','CacyCho_d0','OS.26011001e','Herramientas - Activos productivos','He_REJCOC_15','REJILLA COCINA','99',NULL,'cm3','',0.0000,99.0000,0.0000,0.0000,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,'Generado PHP| 2026-01-12 14:19:37 | larevo1111@gmail.com'),
(1201,'OS.c66a217e','Ori_Sil_2','CacyCho_d0','OS.26011001e','Herramientas - Activos productivos','AP_REFCHOPRE10L2_24','REFINADORA CHOCOLATE PREMIER 10LB 2','99',NULL,'hora','',0.0000,160.0000,0.0000,7.5955,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com',NULL,NULL,'Generado PHP| 2026-01-12 18:22:18 | larevo1111@gmail.com'),
(1202,'OS.8706c0d2','Ori_Sil_2','CacyCho_d0','OS.26011101b','Consumibles','Limyase_GUADENITTALMCAJX50PAR_9','GUANTES DE NITRILO TALLA M CAJA X 50 PARES','99',NULL,'Und','',0.0000,33000.0000,0.0000,0.0000,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 19:45:38','2026-01-12 19:45:38','Generado PHP| 2026-01-12 19:45:38 | larevo1111@gmail.com'),
(1203,'OS.f20ad0b8','Ori_Sil_2','CacyCho_d0','OS.26011101b','Mano de Obra y Servicios','Selo_FLEBUCMAQCAC_06','FLETE BUCARAMANGA MAQUILA CACAO','99',NULL,'kg','',0.0000,1000.0000,0.0000,0.0000,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 19:52:06','2026-01-12 19:52:06','Generado PHP| 2026-01-12 19:52:06 | larevo1111@gmail.com'),
(1204,'OS.tmp1','Ori_Sil_2','CacyCho_d0','OS.26011101b','Mano de Obra y Servicios','S_M_TiedeRep_16','Tiempo de Reposo','99',100.0000,'hora','',0.0000,0.0000,0.0000,0.0000,1,'','',0.000000,'',0.000000,'',0.000000,'','ensayosky','ensayosky','2026-01-12 20:25:08','2026-01-12 20:25:08','Generado PHP| 2026-01-12 20:25:08 | ensayosky'),
(1205,'OS.479f609d','Ori_Sil_2','CacyCho_d0','OS.26011101b','Mano de Obra y Servicios','S_M_TiedeRep_16','Tiempo de Reposo','99',200.0000,'hora','',0.0000,0.0000,0.0000,0.0000,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 20:37:19','2026-01-12 20:37:19','Generado PHP| 2026-01-12 20:37:19 | larevo1111@gmail.com'),
(1284,'OS.RkfRZoQ2h','Ori_Sil_2',NULL,'OS.260112016','Producto Proceso','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA','1',1.0000,'kg','',400.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1285,'OS.r0OoYvaNv','Ori_Sil_2',NULL,'OS.260112016','Producto Proceso','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA','2',100.0000,'kg','',1000.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1286,'OS.5hdSHwJgu','Ori_Sil_2',NULL,'OS.260112016','Producto Proceso','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs','1',101.0000,'Und','',2000.0000,212.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1287,'OS.uptLtz0Jm','Ori_Sil_2',NULL,'OS.260112016','Producto Proceso','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS','2',200.0000,'Und','',7000.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1288,'OS.NKyRJfsoI','Ori_Sil_2',NULL,'OS.260112016','Producto Proceso','PPPt__ENSCAS_7a','ENSA CASCARILLA','2',300.0000,'kg','',500.0000,30826.6041,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1289,'OS.MxGefGX97','Ori_Sil_2',NULL,'OS.260112016','MP - Insumos','MP_SalA_Bicxgra_12','Bicarbonato x gramo','1',2.0000,'g','',23000.0000,15.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1290,'OS.FI7Ezuz5m','Ori_Sil_2',NULL,'OS.260112016','MP - Insumos','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD','4',50.0000,'und','',4000.0000,1000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1291,'OS.MjGMDaPhM','Ori_Sil_2',NULL,'OS.260112016','MP - Insumos','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA','2',50.0000,'und','',1800.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1292,'OS.3a5O3C5LV','Ori_Sil_2',NULL,'OS.260112016','MP - Insumos','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG','2',100.0000,'kg','',1000.0000,20000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1293,'OS.s2ABZX0rA','Ori_Sil_2',NULL,'OS.260112016','MP - Insumos','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad','4',100.0000,'und','',2000.0000,1125.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1294,'OS.2vm4S8V4K','Ori_Sil_2',NULL,'OS.260112016','MP - Insumos','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL','2',200.0000,'kg','',430.0000,21000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1295,'OS.zw7dkTXaO','Ori_Sil_2',NULL,'OS.260112016','Consumibles','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds','2',25.0000,'Und','',3000.0000,650000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1296,'OS.YMMeXUWJZ','Ori_Sil_2',NULL,'OS.260112016','Consumibles','C_P_Serdepap_15','Servilletas de papel','2',50.0000,'cm','',5000.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1297,'OS.PPcZKWQNY','Ori_Sil_2',NULL,'OS.260112016','Consumibles','C_P_Serdepap_15','Servilletas de papel','4',100.0000,'cm','',7500.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1298,'OS.rC2QkbRiP','Ori_Sil_2',NULL,'OS.260112016','Consumibles','C_L_JabNeu_16','Jabon Neutro','4',200.0000,'ml','',2500.0000,10.2600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1299,'OS.UFCfkIQQE','Ori_Sil_2',NULL,'OS.260112016','Consumibles','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS','4',300.0000,'Und','',1000.0000,19300.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1300,'OS.6CtDgNUWn','Ori_Sil_2',NULL,'OS.260112016','Mano de Obra y Servicios','Selo_Dom_02','Domicilio','4',1.0000,'Und','',700.0000,8000.0000,35000.0000,0.0000,0,'domi','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1301,'OS.wjzUpFNNz','Ori_Sil_2',NULL,'OS.260112016','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','1',2.0000,'Hora','',550.0000,10000.0000,32800.0000,0.0000,0,'mo int al','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1302,'OS.FZS6NBRjK','Ori_Sil_2',NULL,'OS.260112016','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','2',100.0000,'Hora','',600.0000,10000.0000,36000.0000,0.0000,0,'mo 1 2','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1303,'OS.kYoY73D6L','Ori_Sil_2',NULL,'OS.260112016','Mano de Obra y Servicios','Selo_FleMer_07','Flete Mercadolibre','2',200.0000,'Und','',600.0000,910000.0000,0.0000,0.0000,0,'tres','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1304,'OS.GKLi29Dyu','Ori_Sil_2',NULL,'OS.260112016','Mano de Obra y Servicios','MOex_MOExtNiv1_09','MO Externa Nivel 1','2',300.0000,'Hora','',1000.0000,10000.0000,60000.0000,0.0000,0,'dos','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1305,'OS.PnIo7p4eN','Ori_Sil_2',NULL,'OS.260112016','Herramientas - Activos productivos','AP_Moldemaiele_16','Molino de maiz electrico','2',1.0000,'hora','',2000.0000,700.0000,120000.0000,0.8681,2,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1306,'OS.xtf7p4Bkz','Ori_Sil_2',NULL,'OS.260112016','Herramientas - Activos productivos','AP_ConNevPeq_30','Congelador Nevera Pequeña','1',100.0000,'minuto','',600.0000,0.0000,600.0000,1.0417,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1307,'OS.CH1L7wcsx','Ori_Sil_2',NULL,'OS.260112016','Herramientas - Activos productivos','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA','3',100.0000,'NA_20','',0.0000,0.0000,2525.0000,0.0579,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1308,'OS.jGufjlcMC','Ori_Sil_2',NULL,'OS.260112016','Herramientas - Activos productivos','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)','3',150.0000,'NA_20','',1000.0000,0.0000,2000.0000,0.6510,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1309,'OS.chuy3duEe','Ori_Sil_2',NULL,'OS.260112016','Herramientas - Activos productivos','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1','3',200.0000,'hora','',3000.0000,160.0000,180000.0000,7.5955,3,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(1414,'OS.FyJfqnyHy','Ori_Sil_2','','OS.260115011','Producto Proceso','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA','1',1.0000,'kg','',40.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1415,'OS.zSG8lwIsz','Ori_Sil_2','','OS.260115011','Producto Proceso','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA','2',100.0000,'kg','',100.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1416,'OS.RESOG1LsB','Ori_Sil_2','','OS.260115011','Producto Proceso','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs','1',101.0000,'Und','',200.0000,212.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1417,'OS.ndXGHcv32','Ori_Sil_2','','OS.260115011','Producto Proceso','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS','2',200.0000,'Und','',700.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1418,'OS.InXJhziPm','Ori_Sil_2','','OS.260115011','Producto Proceso','PPPt__ENSCAS_7a','ENSA CASCARILLA','2',300.0000,'kg','',50.0000,30826.6041,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1419,'OS.4U62BAWLD','Ori_Sil_2','','OS.260115011','MP - Insumos','MP_SalA_Bicxgra_12','Bicarbonato x gramo','1',2.0000,'g','',2300.0000,15.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1420,'OS.5MCoZNQrY','Ori_Sil_2','','OS.260115011','MP - Insumos','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD','4',50.0000,'und','',400.0000,1000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1421,'OS.lRVqATf79','Ori_Sil_2','','OS.260115011','MP - Insumos','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA','2',50.0000,'und','',180.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1422,'OS.iUQKFzHJv','Ori_Sil_2','','OS.260115011','MP - Insumos','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG','2',100.0000,'kg','',100.0000,20000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1423,'OS.QWgE8zRsK','Ori_Sil_2','','OS.260115011','MP - Insumos','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad','4',100.0000,'und','',200.0000,1125.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1424,'OS.Cl8xZ3KJg','Ori_Sil_2','','OS.260115011','MP - Insumos','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL','2',200.0000,'kg','',43.0000,21000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1425,'OS.ZQkkH7Yoe','Ori_Sil_2','','OS.260115011','Consumibles','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds','2',25.0000,'Und','',300.0000,650000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1426,'OS.FsamCz7nL','Ori_Sil_2','','OS.260115011','Consumibles','C_P_Serdepap_15','Servilletas de papel','2',50.0000,'cm','',500.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1427,'OS.H0aD1Je4o','Ori_Sil_2','','OS.260115011','Consumibles','C_P_Serdepap_15','Servilletas de papel','4',100.0000,'cm','',750.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1428,'OS.YRLK6Pmaf','Ori_Sil_2','','OS.260115011','Consumibles','C_L_JabNeu_16','Jabon Neutro','4',200.0000,'ml','',250.0000,10.2600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1429,'OS.kGN05sZa5','Ori_Sil_2','','OS.260115011','Consumibles','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS','4',300.0000,'Und','',100.0000,19300.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1430,'OS.C3oKYt10P','Ori_Sil_2','','OS.260115011','Mano de Obra y Servicios','Selo_Dom_02','Domicilio','4',1.0000,'Und','A',11.0943,8000.0000,554.7126,0.0000,0,'domi','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1431,'OS.eddSzsb0H','Ori_Sil_2','','OS.260115011','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','1',2.0000,'Hora','A',55.0000,10000.0000,3280.0000,0.0000,0,'mo int al','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1432,'OS.5hwfOTAYG','Ori_Sil_2','','OS.260115011','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','2',100.0000,'Hora','',60.0000,10000.0000,3600.0000,0.0000,0,'mo 1 2','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1433,'OS.MelEXDHte','Ori_Sil_2','','OS.260115011','Mano de Obra y Servicios','Selo_FleMer_07','Flete Mercadolibre','2',200.0000,'Und','',60.0000,910000.0000,0.0000,0.0000,0,'tres','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1434,'OS.GkvIb2euJ','Ori_Sil_2','','OS.260115011','Mano de Obra y Servicios','MOex_MOExtNiv1_09','MO Externa Nivel 1','2',300.0000,'Hora','',100.0000,10000.0000,6000.0000,0.0000,0,'dos','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1435,'OS.pHLnuxHOA','Ori_Sil_2','','OS.260115011','Herramientas - Activos productivos','AP_Moldemaiele_16','Molino de maiz electrico','2',1.0000,'hora','',200.0000,700.0000,12000.0000,0.8681,2,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1436,'OS.6w8t1tdjH','Ori_Sil_2','','OS.260115011','Herramientas - Activos productivos','AP_ConNevPeq_30','Congelador Nevera Pequeña','1',100.0000,'minuto','',60.0000,0.0000,60.0000,1.0417,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1437,'OS.Znb2jNHOJ','Ori_Sil_2','','OS.260115011','Herramientas - Activos productivos','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA','3',100.0000,'NA_20','',0.0000,0.0000,252.5000,0.0579,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1438,'OS.kyOykzDvT','Ori_Sil_2','','OS.260115011','Herramientas - Activos productivos','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)','3',150.0000,'NA_20','',100.0000,0.0000,200.0000,0.6510,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1439,'OS.tONca6yBF','Ori_Sil_2','','OS.260115011','Herramientas - Activos productivos','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1','3',200.0000,'hora','',300.0000,160.0000,18000.0000,7.5955,3,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(1466,'OS.K3mRPd5tW','Ori_Sil_2','','OS.260116015','Producto Proceso','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA','1',1.0000,'kg','',0.8000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1467,'OS.wtEx0zWOU','Ori_Sil_2','','OS.260116015','Producto Proceso','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA','2',100.0000,'kg','',2.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1468,'OS.1ynHyHWVg','Ori_Sil_2','','OS.260116015','Producto Proceso','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs','1',101.0000,'Und','',4.0000,212.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1469,'OS.XPFRZNybG','Ori_Sil_2','','OS.260116015','Producto Proceso','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS','2',200.0000,'Und','',14.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1470,'OS.FRwkgXQf9','Ori_Sil_2','','OS.260116015','Producto Proceso','PPPt__ENSCAS_7a','ENSA CASCARILLA','2',300.0000,'kg','',1.0000,30826.6041,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1471,'OS.nqKRYB7q8','Ori_Sil_2','','OS.260116015','MP - Insumos','MP_SalA_Bicxgra_12','Bicarbonato x gramo','1',2.0000,'g','',46.0000,15.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1472,'OS.oBlZVdGIl','Ori_Sil_2','','OS.260116015','MP - Insumos','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD','4',50.0000,'und','',8.0000,1000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1473,'OS.5rg804mSd','Ori_Sil_2','','OS.260116015','MP - Insumos','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA','2',50.0000,'und','',3.6000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1474,'OS.oEqrrzGHF','Ori_Sil_2','','OS.260116015','MP - Insumos','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG','2',100.0000,'kg','',2.0000,20000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1475,'OS.2NDa4RWRX','Ori_Sil_2','','OS.260116015','MP - Insumos','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad','4',100.0000,'und','',4.0000,1125.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1476,'OS.fdcp4WWWo','Ori_Sil_2','','OS.260116015','MP - Insumos','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL','2',200.0000,'kg','',0.8600,21000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1477,'OS.W7nESFGGe','Ori_Sil_2','','OS.260116015','Consumibles','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds','2',25.0000,'Und','',6.0000,650000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1478,'OS.xLIUuD224','Ori_Sil_2','','OS.260116015','Consumibles','C_P_Serdepap_15','Servilletas de papel','2',50.0000,'cm','',10.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1479,'OS.aNz5Xw01a','Ori_Sil_2','','OS.260116015','Consumibles','C_P_Serdepap_15','Servilletas de papel','4',100.0000,'cm','',15.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1480,'OS.VXHlCTctf','Ori_Sil_2','','OS.260116015','Consumibles','C_L_JabNeu_16','Jabon Neutro','4',200.0000,'ml','',5.0000,10.2600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1481,'OS.kEjPW19LH','Ori_Sil_2','','OS.260116015','Consumibles','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS','4',300.0000,'Und','',2.0000,19300.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1482,'OS.d3fqrx4ir','Ori_Sil_2','','OS.260116015','Mano de Obra y Servicios','Selo_Dom_02','Domicilio','4',1.0000,'Und','A',1.0610,8000.0000,53.0501,0.0000,0,'domi','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1483,'OS.OEBWw346q','Ori_Sil_2','','OS.260116015','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','1',2.0000,'Hora','A',1.1000,10000.0000,65.6000,0.0000,0,'mo int al','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1484,'OS.xJ2AaTokU','Ori_Sil_2','','OS.260116015','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','2',100.0000,'Hora','',1.2000,10000.0000,72.0000,0.0000,0,'mo 1 2','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1485,'OS.FWuRkCH1k','Ori_Sil_2','','OS.260116015','Mano de Obra y Servicios','Selo_FleMer_07','Flete Mercadolibre','2',200.0000,'Und','',1.2000,910000.0000,0.0000,0.0000,0,'tres','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1486,'OS.3VvFPsofP','Ori_Sil_2','','OS.260116015','Mano de Obra y Servicios','MOex_MOExtNiv1_09','MO Externa Nivel 1','2',300.0000,'Hora','',2.0000,10000.0000,120.0000,0.0000,0,'dos','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1487,'OS.l5l2xMUzQ','Ori_Sil_2','','OS.260116015','Herramientas - Activos productivos','AP_Moldemaiele_16','Molino de maiz electrico','2',1.0000,'hora','',4.0000,700.0000,240.0000,0.8681,2,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1488,'OS.GNjVI8Kwh','Ori_Sil_2','','OS.260116015','Herramientas - Activos productivos','AP_ConNevPeq_30','Congelador Nevera Pequeña','1',100.0000,'minuto','',1.2000,0.0000,1.2000,1.0417,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1489,'OS.5ly4IHgcE','Ori_Sil_2','','OS.260116015','Herramientas - Activos productivos','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA','3',100.0000,'NA_20','',0.0000,0.0000,5.0500,0.0579,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1490,'OS.SMeITuKCI','Ori_Sil_2','','OS.260116015','Herramientas - Activos productivos','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)','3',150.0000,'NA_20','',2.0000,0.0000,4.0000,0.6510,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1491,'OS.ziy3DhKE5','Ori_Sil_2','','OS.260116015','Herramientas - Activos productivos','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1','3',200.0000,'hora','',6.0000,160.0000,360.0000,7.5955,3,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(1492,'OS.3284d2c2','Ori_Sil_2','CacyCho_d0','OS.260116015','MP - Insumos','I_Envyt_TAPMETB.6XUNI_78','TAPA METALICA B.63 X UNIDAD','99',100.0000,'und','',0.0000,370.0000,0.0000,0.0000,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:28:09','2026-01-16 21:28:09','Generado PHP| 2026-01-16 21:28:09 | larevo1111@gmail.com'),
(1493,'OS.86enwUN1n','Ori_Sil_2','','OS.260122011','Producto Proceso','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA','1',1.0000,'kg','',4.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1494,'OS.u6sZf8e9Q','Ori_Sil_2','','OS.260122011','Producto Proceso','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA','2',100.0000,'kg','',10.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1495,'OS.Q5ANjzRUe','Ori_Sil_2','','OS.260122011','Producto Proceso','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs','1',101.0000,'Und','',20.0000,212.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1496,'OS.ExufACvoH','Ori_Sil_2','','OS.260122011','Producto Proceso','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS','2',200.0000,'Und','',70.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1497,'OS.befPdOMds','Ori_Sil_2','','OS.260122011','Producto Proceso','PPPt__ENSCAS_7a','ENSA CASCARILLA','2',300.0000,'kg','',5.0000,30826.6041,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1498,'OS.5rxIWSZZ4','Ori_Sil_2','','OS.260122011','MP - Insumos','MP_SalA_Bicxgra_12','Bicarbonato x gramo','1',2.0000,'g','',230.0000,15.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1499,'OS.UXMWhlVXC','Ori_Sil_2','','OS.260122011','MP - Insumos','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD','4',50.0000,'und','',40.0000,1000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1500,'OS.XL4Vy62hN','Ori_Sil_2','','OS.260122011','MP - Insumos','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA','2',50.0000,'und','',18.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1501,'OS.JlmRfwp8l','Ori_Sil_2','','OS.260122011','MP - Insumos','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG','2',100.0000,'kg','',10.0000,20000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1502,'OS.jZRVD5Ro7','Ori_Sil_2','','OS.260122011','MP - Insumos','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad','4',100.0000,'und','',20.0000,1125.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1503,'OS.2oUIxuEvC','Ori_Sil_2','','OS.260122011','MP - Insumos','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL','2',200.0000,'kg','',4.3000,21000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1504,'OS.t4sbIGKZM','Ori_Sil_2','','OS.260122011','Consumibles','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds','2',25.0000,'Und','',30.0000,650000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1505,'OS.FyZkZ2905','Ori_Sil_2','','OS.260122011','Consumibles','C_P_Serdepap_15','Servilletas de papel','2',50.0000,'cm','',50.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1506,'OS.lYRwPp8Wc','Ori_Sil_2','','OS.260122011','Consumibles','C_P_Serdepap_15','Servilletas de papel','4',100.0000,'cm','',75.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1507,'OS.UQR5Fdtex','Ori_Sil_2','','OS.260122011','Consumibles','C_L_JabNeu_16','Jabon Neutro','4',75.0000,'ml','',25.0000,10.2600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-23 17:14:41','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1508,'OS.1JbKYHMeB','Ori_Sil_2','','OS.260122011','Consumibles','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS','4',300.0000,'Und','',10.0000,19300.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1509,'OS.StZTRp0xY','Ori_Sil_2','','OS.260122011','Mano de Obra y Servicios','Selo_Dom_02','Domicilio','4',1.0000,'Und','A',2.7868,8000.0000,139.3375,0.0000,0,'domi','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1510,'OS.yLIUgCGKf','Ori_Sil_2','','OS.260122011','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','1',2.0000,'Hora','A',5.5000,10000.0000,328.0000,0.0000,0,'mo int al','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1511,'OS.7bnkCRDBO','Ori_Sil_2','','OS.260122011','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','2',100.0000,'Hora','',6.0000,10000.0000,360.0000,0.0000,0,'mo 1 2','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1512,'OS.CxLhakX73','Ori_Sil_2','','OS.260122011','Mano de Obra y Servicios','Selo_FleMer_07','Flete Mercadolibre','2',200.0000,'Und','',6.0000,910000.0000,0.0000,0.0000,0,'tres','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1513,'OS.4GFBSyklW','Ori_Sil_2','','OS.260122011','Mano de Obra y Servicios','MOex_MOExtNiv1_09','MO Externa Nivel 1','2',300.0000,'Hora','',10.0000,10000.0000,600.0000,0.0000,0,'dos','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1514,'OS.fSOtIK6p9','Ori_Sil_2','','OS.260122011','Herramientas - Activos productivos','AP_Moldemaiele_16','Molino de maiz electrico','2',1.0000,'hora','',20.0000,700.0000,1200.0000,0.8681,2,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1515,'OS.OfOpkqXPY','Ori_Sil_2','','OS.260122011','Herramientas - Activos productivos','AP_ConNevPeq_30','Congelador Nevera Pequeña','1',100.0000,'minuto','',6.0000,0.0000,6.0000,1.0417,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1516,'OS.SKEXanON8','Ori_Sil_2','','OS.260122011','Herramientas - Activos productivos','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA','3',100.0000,'NA_20','',0.0000,0.0000,25.2500,0.0579,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1517,'OS.SoYQOhxDx','Ori_Sil_2','','OS.260122011','Herramientas - Activos productivos','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)','3',150.0000,'NA_20','',10.0000,0.0000,20.0000,0.6510,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1518,'OS.7Cq10in4z','Ori_Sil_2','','OS.260122011','Herramientas - Activos productivos','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1','3',200.0000,'hora','',30.0000,160.0000,1800.0000,7.5955,3,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(1519,'OS.46aadddf','Ori_Sil_2','CacyCho_d0','OS.260122011','Herramientas - Activos productivos','He_TAPSIL_16','TAPETE SILICONA','99',100.0000,'NA_20','',0.0000,0.0000,0.0000,0.0000,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:50:29','2026-01-22 11:50:29','Generado PHP| 2026-01-22 11:50:29 | larevo1111@gmail.com'),
(1520,'OS.0657105d','Ori_Sil_2','Api_5a','OS.26011201b','Herramientas - Activos productivos','AP_Seldebolaped_14','Selladora de bolsas a pedal','99',100.0000,'segundo',NULL,99.0000,0.0900,0.0000,1.3755,NULL,NULL,'',0.000000,'',0.000000,'',0.000000,'ensey','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-23 17:12:45','2026-01-23 17:12:45',NULL),
(1521,'OS.d9603628','Ori_Sil_2','CacyCho_d0','OS.260122011','Mano de Obra y Servicios','Selo_FleMer_07','Flete Mercadolibre','99',200.0000,'Und','',0.0000,9100.0000,0.0000,0.0000,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-23 17:14:03','2026-01-23 17:14:03','Generado PHP| 2026-01-23 17:14:03 | larevo1111@gmail.com'),
(1522,'OS.izS1K5yUV','Ori_Sil_2','','OS.260124017','Producto Proceso','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA','1',1.0000,'kg','',4.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1523,'OS.KccQpdQhT','Ori_Sil_2','','OS.260124017','Producto Proceso','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA','2',100.0000,'kg','',10.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1524,'OS.lnYpAk10E','Ori_Sil_2','','OS.260124017','Producto Proceso','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs','1',101.0000,'Und','',20.0000,212.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1525,'OS.C7uR6u1Gf','Ori_Sil_2','','OS.260124017','Producto Proceso','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS','2',200.0000,'Und','',70.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1526,'OS.wYRRsIahk','Ori_Sil_2','','OS.260124017','Producto Proceso','PPPt__ENSCAS_7a','ENSA CASCARILLA','2',300.0000,'kg','',5.0000,30826.6041,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1527,'OS.4f4Hmm9D4','Ori_Sil_2','','OS.260124017','MP - Insumos','MP_SalA_Bicxgra_12','Bicarbonato x gramo','1',2.0000,'g','',230.0000,15.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1528,'OS.Ie7xVrSB1','Ori_Sil_2','','OS.260124017','MP - Insumos','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD','4',50.0000,'und','',40.0000,1000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1529,'OS.a5GvYZx6E','Ori_Sil_2','','OS.260124017','MP - Insumos','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA','2',50.0000,'und','',18.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1530,'OS.itt8ZGcTj','Ori_Sil_2','','OS.260124017','MP - Insumos','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG','2',100.0000,'kg','',10.0000,20000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1531,'OS.uhkc81pvA','Ori_Sil_2','','OS.260124017','MP - Insumos','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad','4',100.0000,'und','',20.0000,1125.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1532,'OS.6caEyE2ZX','Ori_Sil_2','','OS.260124017','MP - Insumos','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL','2',200.0000,'kg','',4.3000,21000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1533,'OS.XvP1RfG9l','Ori_Sil_2','','OS.260124017','Consumibles','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds','2',25.0000,'Und','',30.0000,650000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1534,'OS.eDqQaLl9y','Ori_Sil_2','','OS.260124017','Consumibles','C_P_Serdepap_15','Servilletas de papel','2',50.0000,'cm','',50.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1535,'OS.948vemqzV','Ori_Sil_2','','OS.260124017','Consumibles','C_P_Serdepap_15','Servilletas de papel','4',100.0000,'cm','',75.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1536,'OS.ANZx49aQI','Ori_Sil_2','','OS.260124017','Consumibles','C_L_JabNeu_16','Jabon Neutro','4',200.0000,'ml','',25.0000,10.2600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1537,'OS.ef6Tz6zc5','Ori_Sil_2','','OS.260124017','Consumibles','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS','4',300.0000,'Und','',10.0000,19300.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1538,'OS.o3ZiP4xf0','Ori_Sil_2','','OS.260124017','Mano de Obra y Servicios','Selo_Dom_02','Domicilio','4',1.0000,'Und','A',2.7868,8000.0000,139.3375,0.0000,0,'domi','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1539,'OS.3gzyBjsCp','Ori_Sil_2','','OS.260124017','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','1',2.0000,'Hora','A',5.5000,10000.0000,328.0000,0.0000,0,'mo int al','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1540,'OS.K5vohTCag','Ori_Sil_2','','OS.260124017','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','2',100.0000,'Hora','',6.0000,10000.0000,360.0000,0.0000,0,'mo 1 2','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1541,'OS.fbeawlmDu','Ori_Sil_2','','OS.260124017','Mano de Obra y Servicios','Selo_FleMer_07','Flete Mercadolibre','2',200.0000,'Und','',6.0000,910000.0000,0.0000,0.0000,0,'tres','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1542,'OS.oNM56ltec','Ori_Sil_2','','OS.260124017','Mano de Obra y Servicios','MOex_MOExtNiv1_09','MO Externa Nivel 1','2',300.0000,'Hora','',10.0000,10000.0000,600.0000,0.0000,0,'dos','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1543,'OS.e18ru5pzD','Ori_Sil_2','','OS.260124017','Herramientas - Activos productivos','AP_Moldemaiele_16','Molino de maiz electrico','2',1.0000,'hora','',20.0000,700.0000,1200.0000,0.8681,2,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1544,'OS.MKFnrwqLn','Ori_Sil_2','','OS.260124017','Herramientas - Activos productivos','AP_ConNevPeq_30','Congelador Nevera Pequeña','1',100.0000,'minuto','',6.0000,0.0000,6.0000,1.0417,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1545,'OS.yu4pAKwTf','Ori_Sil_2','','OS.260124017','Herramientas - Activos productivos','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA','3',100.0000,'NA_20','',0.0000,0.0000,25.2500,0.0579,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1546,'OS.89OYajFmI','Ori_Sil_2','','OS.260124017','Herramientas - Activos productivos','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)','3',150.0000,'NA_20','',10.0000,0.0000,20.0000,0.6510,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1547,'OS.HtLPwyqJR','Ori_Sil_2','','OS.260124017','Herramientas - Activos productivos','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1','3',200.0000,'hora','',30.0000,160.0000,1800.0000,7.5955,3,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(1548,'OS.00781eda','Ori_Sil_2','CacyCho_d0','OS.260124017','Producto Proceso','PTOtr_CUCMIEMED_43','CUCHARA MIELERA MEDIANA','99',100.0000,'Und','',0.0000,0.0000,0.0000,0.0000,1,'','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:57:12','2026-01-24 20:57:12','Generado PHP| 2026-01-24 20:57:12 | larevo1111@gmail.com'),
(1575,'OS.b46047cd','Ori_Sil_2','CacyCho_d0','OS.260124017','Herramientas - Activos productivos','AP_Moldemaiele_16','Molino de maiz electrico','99',200.0000,'hora','',0.0000,700.0000,0.0000,52.0833,1,'','OS.ELEC.RED',0.373000,'OS.AGUA.ACUEDUCTO',0.000100,'OS.LENA',0.000010,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 12:46:58','2026-01-29 12:46:58','Generado PHP| 2026-01-29 12:46:58 | larevo1111@gmail.com'),
(1576,'OS.16ce40eb','Ori_Sil_2','CacyCho_d0','OS.260122011','Herramientas - Activos productivos','AP_Moldemaiele_16','Molino de maiz electrico','99',300.0000,'hora','',0.0000,700.0000,0.0000,52.0833,1,'','OS.ELEC.RED',0.373000,'OS.AGUA.ACUEDUCTO',0.000100,'OS.LENA',0.000010,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 13:03:42','2026-01-29 13:03:42','Generado PHP| 2026-01-29 13:03:42 | larevo1111@gmail.com'),
(1604,'OS.RhVmFsuyQ','Ori_Sil_2','','OS.260129011','Producto Proceso','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA','1',1.0000,'kg','',4.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1605,'OS.rolmslLm3','Ori_Sil_2','','OS.260129011','Producto Proceso','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA','2',100.0000,'kg','',10.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1606,'OS.CViUjxJ3M','Ori_Sil_2','','OS.260129011','Producto Proceso','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs','1',101.0000,'Und','',20.0000,212.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1607,'OS.3YCQjKXWi','Ori_Sil_2','','OS.260129011','Producto Proceso','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS','2',200.0000,'Und','',70.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1608,'OS.Jhr2hJY5I','Ori_Sil_2','','OS.260129011','Producto Proceso','PPPt__ENSCAS_7a','ENSA CASCARILLA','2',300.0000,'kg','',5.0000,30826.6041,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1609,'OS.XrCqP7jJg','Ori_Sil_2','','OS.260129011','MP - Insumos','MP_SalA_Bicxgra_12','Bicarbonato x gramo','1',2.0000,'g','',230.0000,15.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1610,'OS.A5SPblMXA','Ori_Sil_2','','OS.260129011','MP - Insumos','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD','4',50.0000,'und','',40.0000,1000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1611,'OS.D02RlEB2g','Ori_Sil_2','','OS.260129011','MP - Insumos','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA','2',50.0000,'und','',18.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1612,'OS.9m0QboU5K','Ori_Sil_2','','OS.260129011','MP - Insumos','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG','2',100.0000,'kg','',10.0000,20000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1613,'OS.2iyFNV7bX','Ori_Sil_2','','OS.260129011','MP - Insumos','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad','4',100.0000,'und','',20.0000,1125.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1614,'OS.he6aMKfYE','Ori_Sil_2','','OS.260129011','MP - Insumos','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL','2',200.0000,'kg','',4.3000,21000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1615,'OS.53IDH9Wod','Ori_Sil_2','','OS.260129011','Consumibles','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds','2',25.0000,'Und','',30.0000,650000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1616,'OS.auZMUhbNp','Ori_Sil_2','','OS.260129011','Consumibles','C_P_Serdepap_15','Servilletas de papel','2',50.0000,'cm','',50.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1617,'OS.eIIW1xSlT','Ori_Sil_2','','OS.260129011','Consumibles','C_P_Serdepap_15','Servilletas de papel','4',100.0000,'cm','',75.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1618,'OS.PKIkqGDjL','Ori_Sil_2','','OS.260129011','Consumibles','C_L_JabNeu_16','Jabon Neutro','4',200.0000,'ml','',25.0000,10.2600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1619,'OS.7i9YSOhhw','Ori_Sil_2','','OS.260129011','Consumibles','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS','4',300.0000,'Und','',10.0000,19300.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1620,'OS.1OUC7FPlE','Ori_Sil_2','','OS.260129011','Mano de Obra y Servicios','Selo_Dom_02','Domicilio','4',1.0000,'Und','A',2.7868,8000.0000,139.3375,0.0000,0,'domi','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1621,'OS.MDLNGUbnn','Ori_Sil_2','','OS.260129011','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','1',2.0000,'Hora','A',5.5000,10000.0000,328.0000,0.0000,0,'mo int al','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1622,'OS.ZEG9NzhSw','Ori_Sil_2','','OS.260129011','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','2',100.0000,'Hora','',6.0000,10000.0000,360.0000,0.0000,0,'mo 1 2','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1623,'OS.3IPmtoK3g','Ori_Sil_2','','OS.260129011','Mano de Obra y Servicios','Selo_FleMer_07','Flete Mercadolibre','2',200.0000,'Und','',6.0000,910000.0000,0.0000,0.0000,0,'tres','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1624,'OS.xovFOXtYr','Ori_Sil_2','','OS.260129011','Mano de Obra y Servicios','MOex_MOExtNiv1_09','MO Externa Nivel 1','2',300.0000,'Hora','',10.0000,10000.0000,600.0000,0.0000,0,'dos','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1625,'OS.OiRHYtYjO','Ori_Sil_2','','OS.260129011','Herramientas - Activos productivos','AP_Moldemaiele_16','Molino de maiz electrico','2',1.0000,'hora','',20.0000,700.0000,1200.0000,0.8681,2,NULL,'OS.ELEC.RED',0.373000,'OS.AGUA.ACUEDUCTO',0.000100,'OS.LENA',0.000010,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1626,'OS.g3FDl5YaC','Ori_Sil_2','','OS.260129011','Herramientas - Activos productivos','AP_ConNevPeq_30','Congelador Nevera Pequeña','1',100.0000,'minuto','',6.0000,0.0000,6.0000,1.0417,1,NULL,'OS.ELEC.RED',0.001000,'OS.AGUA.ACUEDUCTO',0.000010,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1627,'OS.ZrsiNj9iY','Ori_Sil_2','','OS.260129011','Herramientas - Activos productivos','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA','3',100.0000,'NA_20','',0.0000,0.0000,25.2500,0.0579,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1628,'OS.K4q328NUP','Ori_Sil_2','','OS.260129011','Herramientas - Activos productivos','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)','3',150.0000,'NA_20','',10.0000,0.0000,20.0000,0.6510,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1629,'OS.m9DAKcGve','Ori_Sil_2','','OS.260129011','Herramientas - Activos productivos','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1','3',200.0000,'hora','',30.0000,160.0000,1800.0000,7.5955,3,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(1630,'OS.5V2il5EIF','Ori_Sil_2','','OS.260129010','Producto Proceso','PPPt__ENSALMTOS_f2','ENSA ALMENDRAS TOSTA','1',1.0000,'kg','',40.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1631,'OS.wiLAEAQYN','Ori_Sil_2','','OS.260129010','Producto Proceso','PPNiv1_MIELTFIL_56','MIEL LT FILTRADA','2',100.0000,'kg','',100.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1632,'OS.yYiE0ilvq','Ori_Sil_2','','OS.260129010','Producto Proceso','PTProapi_MieOsVid640grs_75','Miel Os Vidrio 640 grs','1',101.0000,'Und','',200.0000,212.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1633,'OS.en8jfYOJx','Ori_Sil_2','','OS.260129010','Producto Proceso','PTCre_CHOOS90GRS_12','CHOCOBEETAL OS 90 GRS','2',200.0000,'Und','',700.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1634,'OS.GqlF1EiQZ','Ori_Sil_2','','OS.260129010','Producto Proceso','PPPt__ENSCAS_7a','ENSA CASCARILLA','2',300.0000,'kg','',50.0000,30826.6041,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1635,'OS.wBdO530SA','Ori_Sil_2','','OS.260129010','MP - Insumos','MP_SalA_Bicxgra_12','Bicarbonato x gramo','1',2.0000,'g','',2300.0000,15.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1636,'OS.Jcxxgb7FW','Ori_Sil_2','','OS.260129010','MP - Insumos','I_Eti_ETIMAR100DELXUNI_01','ETIQUETA MARAÑON 100G DELANTERA X UNIDAD','4',50.0000,'und','',400.0000,1000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1637,'OS.6wGkQAoLv','Ori_Sil_2','','OS.260129010','MP - Insumos','I_Envyt_BOLDOYPACPETSINIMPTRA_39','BOLSA DOY PACK PET/FLEXIBLE SIN IMPRESION TRANSPARENTE 7.0 X 8.0 80 MICRAS CON VALVULA','2',50.0000,'und','',180.0000,0.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1638,'OS.PBy2eh0uL','Ori_Sil_2','','OS.260129010','MP - Insumos','MP_Frus_ALMSINTOSKG_16','ALMENDRAS SIN TOSTAR KG','2',100.0000,'kg','',100.0000,20000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1639,'OS.RhWqKV9DD','Ori_Sil_2','','OS.260129010','MP - Insumos','I_Eti_EtiCho500graDelxuni_76','Etiquetas Chocolate 500g granulado Delantera x unidad','4',100.0000,'und','',200.0000,1125.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1640,'OS.vP6vZl9HC','Ori_Sil_2','','OS.260129010','MP - Insumos','MP_Gras_CACLTALMKL_55','CACAO LT ALMENDRA KL','2',200.0000,'kg','',43.0000,21000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1641,'OS.eM5TqPUUm','Ori_Sil_2','','OS.260129010','Consumibles','Pro_PapKra120corTamcarplix9ud_2','Papel Kraf 120g cortado Tamaño carta pliego x 9uds','2',25.0000,'Und','',300.0000,650000.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1642,'OS.s5zbg9v5n','Ori_Sil_2','','OS.260129010','Consumibles','C_P_Serdepap_15','Servilletas de papel','2',50.0000,'cm','',500.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1643,'OS.MXyUavsF4','Ori_Sil_2','','OS.260129010','Consumibles','C_P_Serdepap_15','Servilletas de papel','4',100.0000,'cm','',750.0000,3.4800,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1644,'OS.Iw4pRSiKN','Ori_Sil_2','','OS.260129010','Consumibles','C_L_JabNeu_16','Jabon Neutro','4',200.0000,'ml','',250.0000,10.2600,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1645,'OS.BHtzOdyCZ','Ori_Sil_2','','OS.260129010','Consumibles','Limyase_GORDESBLAX100UNI_8','GORRO DESECHABLE BLANCO X 100 UNIDADS','4',300.0000,'Und','',100.0000,19300.0000,0.0000,0.0000,0,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1646,'OS.eetWJLXBW','Ori_Sil_2','','OS.260129010','Mano de Obra y Servicios','Selo_Dom_02','Domicilio','4',1.0000,'Und','A',11.0943,8000.0000,554.7126,0.0000,0,'domi','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1647,'OS.VGBj9T5I5','Ori_Sil_2','','OS.260129010','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','1',2.0000,'Hora','A',55.0000,10000.0000,3280.0000,0.0000,0,'mo int al','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1648,'OS.QvFXZ3SqU','Ori_Sil_2','','OS.260129010','Mano de Obra y Servicios','MOin_MOIntNiv1_12','MO Interna Nivel 1','2',100.0000,'Hora','',60.0000,10000.0000,3600.0000,0.0000,0,'mo 1 2','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1649,'OS.dBWB0ptNw','Ori_Sil_2','','OS.260129010','Mano de Obra y Servicios','Selo_FleMer_07','Flete Mercadolibre','2',200.0000,'Und','',60.0000,910000.0000,0.0000,0.0000,0,'tres','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1650,'OS.C0Aar2HTQ','Ori_Sil_2','','OS.260129010','Mano de Obra y Servicios','MOex_MOExtNiv1_09','MO Externa Nivel 1','2',300.0000,'Hora','',100.0000,10000.0000,6000.0000,0.0000,0,'dos','',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1651,'OS.hlrV78FUM','Ori_Sil_2','','OS.260129010','Herramientas - Activos productivos','AP_Moldemaiele_16','Molino de maiz electrico','2',1.0000,'hora','',200.0000,700.0000,12000.0000,0.8681,2,NULL,'OS.ELEC.RED',0.373000,'OS.AGUA.ACUEDUCTO',0.000100,'OS.LENA',0.000010,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1652,'OS.5q5C9AIix','Ori_Sil_2','','OS.260129010','Herramientas - Activos productivos','AP_ConNevPeq_30','Congelador Nevera Pequeña','1',100.0000,'minuto','',60.0000,0.0000,60.0000,1.0417,1,NULL,'OS.ELEC.RED',0.001000,'OS.AGUA.ACUEDUCTO',0.000010,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1653,'OS.Iq1EOleU6','Ori_Sil_2','','OS.260129010','Herramientas - Activos productivos','AP_EMBGRABOCANC_27','EMBUDO GRANDE BOCA ANCHA','3',100.0000,'NA_20','',0.0000,0.0000,252.5000,0.0579,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1654,'OS.8cPZE3gJz','Ori_Sil_2','','OS.260129010','Herramientas - Activos productivos','AP_GraMed(ha30kil_23','Gramera Mediana (hasta 30 kilos)','3',150.0000,'NA_20','',100.0000,0.0000,200.0000,0.6510,1,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(1655,'OS.Us4Rarsco','Ori_Sil_2','','OS.260129010','Herramientas - Activos productivos','Ma_REFCHOPRE_14','REFINADORA CHOCOLATE PREMIER 10LB 1','3',200.0000,'hora','',300.0000,160.0000,18000.0000,7.5955,3,NULL,'',0.000000,'',0.000000,'',0.000000,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com');
/*!40000 ALTER TABLE `prod_ordenes_detalles` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `prod_ordenes_encabezados`
--

LOCK TABLES `prod_ordenes_encabezados` WRITE;
/*!40000 ALTER TABLE `prod_ordenes_encabezados` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `prod_ordenes_encabezados` VALUES
(1,'OP25-1028-1900-ff','Ori_Sil_2',NULL,NULL,'','3',0,NULL,'',NULL,NULL,NULL,'- Precalentar siempre el horno antes de ingresar el cacao.\n- No sobrepasar los 170g rados centigrados.\n- Tiempo maximo 25 minutos\n- Cortar el calentamiento, es decir sacar del horno apenas se cumpla el tiempo\n- Distribuir las almendras en una sola capa, sin amontonarlas.\n- Revolver/intercambiar bandejas a mitad del proceso para lograr un tostado parejo.\n- Dejar reposar antes de empacar para estabilizar aroma y humedad.','- Precalentar el horno de convección a 150 °C.\n- Extender las almendras de cacao en bandejas (máx. 500 g por bandeja).\n- Tostar a 150–160 °C durante 20–25 minutos.\n- A los 10 min: revolver.\n- A los 15 min: intercambiar bandejas (arriba ↔ abajo).\n- Continuar hasta completar el tiempo.\n- Reposar las almendras 10 minutos a temperatura ambiente.\n- Empacar en bolsas herméticas (ziploc o válvula).','2025-10-28 19:13:39',NULL,'amaragonzalez21valen@gmail.com','rialgar82@gmail.com','1','Media',NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.000000,0.000000,'ERROR: Parámetros incompletos',NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-10-28 19:00:07','2026-01-24 19:01:21',NULL),
(2,'OP25-1101-0027-26','Ori_Sil_2','PRO_ENSNIBPRO_44',NULL,'1','5',1,' - OP pausada por SYSOP (larevo1111@gmail.com), en 07-dic.-252025 - 02:37','',10.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','Media',NULL,NULL,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.000000,0.000000,NULL,NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-01 00:27:31','2025-12-07 02:37:45',NULL),
(3,'O2511071509ad','Ori_Sil_2','PRO_ENSNIBPRO_44',NULL,'1','3',0,NULL,'',25.0000,2250.0000,2550.0000,NULL,NULL,NULL,NULL,NULL,NULL,'1','Media','1','1',NULL,0.0000,3649913.3750,893475.0000,214500.0000,301525.0000,287500.0000,1952913.3750,5899913.3750,893475.0000,214500.0000,2287500.0000,551525.0000,1952913.3750,0.0000,0.000000,0.000000,NULL,NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-07 15:09:04','2026-01-15 20:19:14',NULL),
(4,'251107011','Ori_Sil_2','PRO_BORENS_9c','CacyCho_d0','1','1',0,NULL,'',2.0000,NULL,NULL,NULL,NULL,NULL,NULL,'ssierra047@gmail.com',NULL,'1',NULL,'1','1',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.000000,0.000000,'tempo-PRO_BORENS_9c-larevo1111@gmail.com',NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-07 21:21:07','2025-12-11 22:40:41',NULL),
(5,'251107027','Ori_Sil_2','PRO_BORENS_9c',NULL,'1','2',0,NULL,'',1.0000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,'1','1',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.000000,0.000000,NULL,NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-07 21:22:08','2025-11-26 22:35:42',NULL),
(6,'251127013','Ori_Sil_2','PRO_Tosalmdecac_10','CacyCho_d0','1','3',0,NULL,'kg',15.0000,NULL,NULL,'- Precalentar siempre el horno antes de ingresar el cacao.\n- No sobrepasar los 170g rados centigrados.\n- Tiempo maximo 25 minutos\n- Cortar el calentamiento, es decir sacar del horno apenas se cumpla el tiempo\n- Distribuir las almendras en una sola capa, sin amontonarlas.\n- Revolver/intercambiar bandejas a mitad del proceso para lograr un tostado parejo.\n- Dejar reposar antes de empacar para estabilizar aroma y humedad.','- Precalentar el horno de convección a 150 °C.\n- Extender las almendras de cacao en bandejas (máx. 500 g por bandeja).\n- Tostar a 150–160 °C durante 20–25 minutos.\n- A los 10 min: revolver.\n- A los 15 min: intercambiar bandejas (arriba ↔ abajo).\n- Continuar hasta completar el tiempo.\n- Reposar las almendras 10 minutos a temperatura ambiente.\n- Empacar en bolsas herméticas (ziploc o válvula).',NULL,NULL,'jennifercanogarcia@gmail.com','ssierra047@gmail.com','1','Media','1','1',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.000000,0.000000,NULL,NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 14:34:13','2025-11-27 14:51:46',NULL),
(7,'25112702c','Ori_Sil_2','PRO_Refdenib24hor_5a','CacyCho_d0','1','1',1,' - OP pausada por SYSOP (larevo1111@gmail.com), en 04-dic.-252025 - 22:57','kg',10.0000,NULL,NULL,NULL,'1. Alistamiento\n\nRevisar que las refinadoras estén limpias, secas y en buen estado.\nAlistar bowls, espátulas, moldes y gramera.\n\n⚖️ 2. Pesaje\n\nPesar 4 kg de nibs por refinadora a usar.\n\n 3. Pre-molienda (Molino de maíz eléctrico)\n\n⚠️ ADVERTENCIA:\n Por ningún motivo meter la mano en la tolva. Tener cuidado.\n✅ Siempre agregar los ingredientes con dosificadora.\n\nSi el molino se frena:\n\nApagarlo.\n\nAflojar la mariposa frontal para darle más espacio al paso de los nibs.\n\nSi persiste, vaciar y volver a pasar.\n\n Pasar las tandas lentamente, sin llenar la tolva al inicio para no forzar el molino.\nUna vez avance el proceso, se puede aumentar la cantidad agregada.\nPasar dos veces por el molino.\n\n Tip: En la segunda pasada, ayudar con la espátula metálica empujando los nibs, ya que al volverse pasta les cuesta más pasar.\n\n 4. Carga a refinadora\n\n Antes de comenzar a refinar, aflojar la tuerca central para evitar que se frene.\nCuando ya esté cargada la refinadora con los 4 kg y funcione correctamente, se puede apretar la tuerca.\n\nA medida que va saliendo la pasta del molino en la segunda pasada, se va agregando directamente a la refinadora.\nEmpezar con presión mínima y aumentar gradualmente, vigilando que la máquina no se fuerce.\n\n⏱️ 5. Refinado\n\nDejar 24 horas continuas de refinación.\n\n 6. Bajado del chocolate\n\nApagar la refinadora.\n\nMedir la temperatura y registrarla en la bitácora.\n\nPresionar el botón al lado izquierdo de la refinadora para poder girar el tambor.\n\nColocar el recipiente donde se va a bajar el chocolate en una mesa más baja que la refinadora.\n\nDescargar suavemente para evitar regueros.\n\nLimpiar bien las paredes y piedras con espátula de silicona para aprovechar el producto restante.\n\n Alistar los recipientes o moldes limpios y secos.\n\n Nota\n\nPara bloques de chocolate, se puede enmoldar directamente en bandejas.\n\nPara enmoldado de bombones, descargar primero en bowl.\n\nSi se va a continuar con cobertura, retirar la cantidad correspondiente (2.380 g) y dejar el excedente.\n(La diferencia entre 4.000 g y 2.380 g será el chocolate restante).\n\n⚠️ Puntos Críticos\n\n La pre-molienda debe quedar en pasta, no con granos sueltos.\n⚙️ La alimentación de la refinadora debe hacerse sin forzarla.\n️ Antes de desmontar, tomar y registrar la temperatura.\nSi supera los 45 °C, registrar como dificultad y dejar en observación.\n Respetar las 24 horas completas de refinado.',NULL,NULL,'larevo1111@gmail.com',NULL,'1','Media','1','1',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.000000,0.000000,NULL,NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 15:35:08','2025-12-04 22:57:58',NULL),
(8,'25121501d','Ori_Sil_2','PRO_EnsProOps1_74','CacyCho_d0','1','1',0,NULL,'meses',6.0000,NULL,NULL,'Este es un primer ensato y estos son kos tips','Estas son las isntruccones del procedimiento',NULL,NULL,'ssierra047@gmail.com','doblessas@gmail.com','1','Media','1','1','ALIRIO 1',0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.000000,0.000000,'Detalles generados correctamente | Total registros: 13',NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-12-15 18:23:38','2025-12-15 22:02:47',NULL),
(9,'251217017','Ori_Sil_2','PRO_EnsProOps1_74','CacyCho_d0','1','1',0,NULL,'meses',10.0000,NULL,NULL,'Este es un primer ensato y estos son kos tips','Estas son las isntruccones del procedimiento',NULL,NULL,'ssierra047@gmail.com','larevo1111@gmail.com','1','Media','1','1',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.000000,0.000000,'Detalles generados correctamente | Total registros: 26',NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 00:41:27','2025-12-17 05:42:39',NULL),
(10,'251217029','Ori_Sil_2','PRO_Enmbom_3a','CacyCho_d0','1','1',0,NULL,'kg',10.0000,NULL,NULL,NULL,'1️⃣  Alistamiento de Moldes\n\nAsegurarse de que los moldes estén limpios, secos y sin residuos grasos.\n\nLimpiar con paño de microfibra.\n\nDisponer los moldes juntos sobre una mesa grande.\n\n2️⃣  Fundido del Chocolate\n\nSi el chocolate está en la refinadora, verter en un bowl grande.\n\nSi el chocolate está en bloque, fundir previamente a unos 40 °C.\n\nSe recomienda tener baño maría listo, por si se empieza a espesar o empastar.\n\n3️⃣  Vertido y Distribución en Moldes\n\nVerter el licor de cacao caliente en el embudo metálico dosificador (capacidad de 1 kg).\n\nUsar espátula metálica para esparcir el chocolate en los moldes.\n\nVaciar los excesos nuevamente al bowl grande.\n\n4️⃣  Vibrado\n\nRealizar vibrado inmediato para retirar burbujas de aire.\n\n5️⃣ ️ Solidificación\n\nDejar reposar los moldes al aire libre hasta que el chocolate solidifique.\n\n6️⃣ ❄️ Desmoldado\n\nAntes de desmoldar, colocar los moldes en el congelador durante 10 minutos para facilitar el proceso.\n\nRealizar movimientos suaves de torsión del molde.\n\nVoltear sobre un tapete de silicona y dar golpes suaves pero secos en las uniones del molde.\n\n7️⃣  Recolección para Empaque\n\nRecolectar el chocolate en un recipiente seco, listo para su empaque.',NULL,NULL,'larevo1111@gmail.com',NULL,'1','Media','1','1',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.000000,0.000000,'Detalles generados correctamente | Total registros: 12',NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 00:50:41','2025-12-17 02:36:09',NULL),
(11,'25121703e','Ori_Sil_2','PRO_EnsProOps1_74','CacyCho_d0','1','1',0,NULL,'meses',10.0000,NULL,NULL,'Este es un primer ensato y estos son kos tips','Estas son las isntruccones del procedimiento',NULL,NULL,'larevo1111@gmail.com',NULL,'1','Media','1','1',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.000000,0.000000,NULL,NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 01:53:23','2025-12-19 00:36:41',NULL),
(12,'251217046','Ori_Sil_2','PRO_MaqTosyDesdeCac_bc','CacyCho_d0','1','1',0,NULL,'kg',20.0000,NULL,NULL,'El proveedor actual es arbol de cacao\nSe deben enviar minimo 50 kilos de almendra de cacao','1. Empacar las almendras de cacao en costales de maximo 50kilos cada uno\n2. Sellar completamente cada costal con vinipel.\n3. Poner la etiqueta de despacho con cinta  gestionar la llevada a la transportadora ( normalmente se hace con envia colvanes y cuesta 1.100 pesos por kilo el envío)\n4. El maquilador, se demora aprox 10 dias procesando, y normalmente envía los nibs y la cascarilla por Veloenvios, se recoge en la sede de Veloenvios de itagui. asegurarse de que el maquilar envie el producto bien sellado, ya sea con vinipel o bolsa plastica.\n5. Se reciben aproximadamente 70% de nibs de cacao y 30% de cascarilla y un desperdicio entre un 2 y 5%.',NULL,NULL,'ssierra047@gmail.com',NULL,'1','Media','1','1',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.000000,0.000000,'regenerando',NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-12-17 03:19:48','2025-12-17 08:32:42',NULL),
(13,'251218014','Ori_Sil_2','PRO_ENSNIBPRO_44','Api_5a , CacyCho_d0','1','1',0,NULL,'kg',14.5000,NULL,NULL,NULL,NULL,NULL,NULL,'amaragonzalez21valen@gmail.com',NULL,'1','Media','1','1',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.000000,0.000000,NULL,NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-12-18 20:07:54','2025-12-19 03:47:09',NULL),
(14,'OS.251227017','Ori_Sil_2','PRO_EnsProOps1_74','CacyCho_d0','1','3',0,NULL,'meses',100.0000,16380.0000,16380.0000,'Este es un primer ensato y estos son kos tips','Estas son las isntruccones del procedimiento',NULL,NULL,'ssierra047@gmail.com',NULL,'1','Media','1','1',NULL,0.0000,34833312.1925,25219343.0000,3562500.0000,2131915.0000,3256000.0000,663554.1925,34833312.1925,25219343.0000,3562500.0000,3256000.0000,2131915.0000,663554.1925,0.0000,0.000000,0.000000,NULL,NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 08:25:17','2026-01-23 02:10:50','||PHP C OK | consumos_insertados=26 | uid_orden=OS.251227017 - 01/22/2026 21:04:06 ||PHP C OK | lotes_insertados=3 | uid_orden=OS.251227017 - 01/22/2026 21:07:55 ||PHP L.AD OK | uid_orden=OS.251227017 | producto_adicional= - 01/22/2026 21:10:50'),
(15,'OS.26011001e','Ori_Sil_2','PRO_EnsProOps1_74','CacyCho_d0','1','3',0,NULL,'meses',10.0000,1278.0000,0.0000,'Este es un primer ensato y estos son kos tips','Estas son las isntruccones del procedimiento',NULL,NULL,'doblessas@gmail.com',NULL,'1','Media','OS.67566c75','1',NULL,26024834.3927,26024834.3927,158373.0205,356250.0000,19693691.5000,5731000.0000,85519.8722,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.000000,0.000000,NULL,NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 14:15:58','2026-01-15 18:34:04','|| ERROR: Parámetros incompletos - 01/11/2026 20:46:54 || ERROR: Parámetros incompletos - 01/11/2026 20:53:01 || ERROR: Parámetros incompletos 33 - 01/11/2026 21:05:37 || ERROR: Falta parametro nombre_recurso - 01/11/2026 21:12:48 || ERROR: Falta parametro nombre_recurso - 01/11/2026 21:13:59 || ERROR: Falta parametro nombre_recurso - 01/11/2026 21:14:51 || ERROR: Falta parametro nombre_recurso - 01/11/2026 21:24:33 || ERROR: Falta parametro nombre_recurso - 01/11/2026 21:53:03 || ERROR: Falta parametro nombre_recurso (VACIO) | valor=\'\' | RAW=empresa=Ori_Sil_2&usuario=larevo1111%40gmail.com&uid_orden=OS.26011001e&uid_detalle=OS.1aec30e0&uid_consumo=OS.1aec30e0&nombre_recurso=&tipo_recurso= - 01/11/2026 22:06:58 || ERROR: Falta parametro nombre_recurso (VACIO) | valor=\'\' | RAW=empresa=Ori_Sil_2&usuario=larevo1111%40gmail.com&uid_orden=OS.26011001e&uid_detalle=OS.956c1d35&uid_consumo=OS.956c1d35&nombre_recurso=&tipo_recurso= - 01/11/2026 22:22:15 || OK | detalle=OS.e570d1e9 | consumo=OS.e570d1e9 - 01/11/2026 22:33:20 || OK | detalle=OS.dbbee95d | consumo=OS.dbbee95d - 01/11/2026 22:35:24 ||PHP C.AD OK | detalle=OS.e406da55 | consumo=OS.e406da55 - 01/12/2026 09:19:37 ||PHP L.AD OK | uid_orden=OS.26011001e | producto_adicional= - 01/12/2026 10:12:30 ||PHP L.AD OK | uid_orden=OS.26011001e | producto_adicional= - 01/12/2026 10:29:24 ||PHP C.AD OK | detalle=OS.c66a217e | consumo=OS.c66a217e - 01/12/2026 18:22:18'),
(16,'OS.26011101b','Ori_Sil_2','PRO_EnsProOps1_74','CacyCho_d0','1','3',0,NULL,'meses',1000.0000,NULL,NULL,'Este es un primer ensato y estos son kos tips','Estas son las isntruccones del procedimiento',NULL,NULL,'larevo1111@gmail.com',NULL,'1','Media','1','OS.67566c75',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.000000,0.000000,NULL,NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-11 23:10:42','2026-01-12 20:39:33','||PHP L.AD ERROR: Falta siglas - 01/12/2026 19:00:08 ||PHP L.AD OK | uid_orden=OS.26011101b | producto_adicional= - 01/12/2026 19:04:46 ||PHP L.AD OK | uid_orden=OS.26011101b | producto_adicional= - 01/12/2026 19:23:36 ||PHP L.AD OK | uid_orden=OS.26011101b | producto_adicional= - 01/12/2026 19:30:31 ||PHP C.AD OK | detalle=OS.8706c0d2 | consumo=OS.8706c0d2 - 01/12/2026 19:45:38 ||PHP C.AD OK | detalle=OS.f20ad0b8 | consumo=OS.f20ad0b8 - 01/12/2026 19:52:06 ||PHP C.AD OK | detalle=OS.479f609d | consumo=OS.479f609d - 01/12/2026 20:37:19 ||PHP L.AD OK | uid_orden=OS.26011101b | producto_adicional= - 01/12/2026 20:39:33'),
(17,'OS.26011201b','Ori_Sil_2','PRO_ENSNIBPRO_44',NULL,'1','1',0,NULL,'kg',100.0000,6000.0000,0.0000,NULL,NULL,NULL,NULL,'larevo1111@gmail.com',NULL,'1','Media','1','1',NULL,4100000.0007,4100008.9100,3100000.0000,0.0000,0.0000,1000000.0000,8.9100,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.000000,0.000000,'ejecutada crear detalles 12/01/2026 8:54:49',NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 08:54:18','2026-01-23 17:13:18',' ||PHP DYR OK | Detalles=2 | Resultantes=2 | uid_orden=OS.26011201b | empresa=Ori_Sil_2 | uid_proc=PRO_ENSNIBPRO_44 - 01/12/2026 08:54:49'),
(18,'OS.260112016','Ori_Sil_2','PRO_EnsProOps1_74','CacyCho_d0','1','3',0,NULL,'meses',1000.0000,NULL,NULL,'Este es un primer ensato y estos son kos tips','Estas son las isntruccones del procedimiento',NULL,NULL,'larevo1111@gmail.com',NULL,'1','Media','OS.67566c75','OS.67566c75',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.000000,0.000000,'ejecutada crear detalles 12/01/2026 22:05:43',NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 21:44:43','2026-01-12 22:08:46',' ||PHP DYR OK | Detalles=26 | Resultantes=3 | uid_orden=OS.260112016 | empresa=Ori_Sil_2 | uid_proc=PRO_EnsProOps1_74 - 01/12/2026 21:56:30 ||PHP DYR OK | Detalles=26 | Resultantes=3 | uid_orden=OS.260112016 | empresa=Ori_Sil_2 | uid_proc=PRO_EnsProOps1_74 - 01/12/2026 21:57:12 ||PHP DYR OK | Detalles=26 | Resultantes=3 | uid_orden=OS.260112016 | empresa=Ori_Sil_2 | uid_proc=PRO_EnsProOps1_74 - 01/12/2026 22:05:44'),
(19,'OS.260115011','Ori_Sil_2','PRO_EnsProOps1_74','CacyCho_d0','1','3',0,NULL,'meses',100.0000,12880.0000,12880.0000,'Este es un primer ensato y estos son kos tips','Estas son las isntruccones del procedimiento',NULL,NULL,'larevo1111@gmail.com',NULL,'1','Media','1','1',NULL,260248343.9265,259777098.3268,1583730.2050,3562500.0000,196936915.0000,56838754.4000,855198.7218,259777098.3268,1583730.2050,3562500.0000,56838754.4000,196936915.0000,855198.7218,0.0000,0.000000,0.000000,'01/16/2026 22:20:35',NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 11:55:42','2026-01-16 22:20:35',' ||PHP DYR OK | Detalles=26 | Resultantes=3 | uid_orden=OS.260115011 | empresa=Ori_Sil_2 | uid_proc=PRO_EnsProOps1_74 - 01/15/2026 12:15:01 ||PHP DYR OK | Detalles=26 | Resultantes=3 | uid_orden=OS.260115011 | empresa=Ori_Sil_2 | uid_proc=PRO_EnsProOps1_74 - 01/15/2026 12:22:35 ||PHP DYR OK | Detalles=26 | Resultantes=3 | uid_orden=OS.260115011 | empresa=Ori_Sil_2 | uid_proc=PRO_EnsProOps1_74 - 01/15/2026 20:54:53 ||PHP DYR OK | Detalles=26 | Resultantes=3 | uid_orden=OS.260115011 | empresa=Ori_Sil_2 | uid_proc=PRO_EnsProOps1_74 - 01/15/2026 20:57:14 ||PHP DYR OK | Detalles=26 | Resultantes=3 | uid_orden=OS.260115011 | empresa=Ori_Sil_2 | uid_proc=PRO_EnsProOps1_74 - 01/15/2026 21:00:11 ||PHP C OK | consumos_insertados=26 | uid_orden=OS.260115011 - 01/16/2026 12:47:30 ||PHP C OK | lotes_insertados=3 | uid_orden=OS.260115011 - 01/16/2026 22:20:35'),
(20,'OS.260116015','Ori_Sil_2','PRO_EnsProOps1_74','CacyCho_d0','1','3',0,NULL,'meses',2.0000,257.6000,257.6000,'Este es un primer ensato y estos son kos tips','Estas son las isntruccones del procedimiento',NULL,NULL,'larevo1111@gmail.com',NULL,'1','Media','1','1',NULL,5204966.8785,5202254.8785,31674.6041,71250.0000,3938738.3000,1143488.0000,17103.9744,5202254.8785,31674.6041,71250.0000,1143488.0000,3938738.3000,17103.9744,0.0000,0.000000,0.000000,'01/22/2026 11:39:48',NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 20:56:36','2026-01-22 21:10:42',' ||PHP DYR OK | Detalles=26 | Resultantes=3 | uid_orden=OS.260116015 | empresa=Ori_Sil_2 | uid_proc=PRO_EnsProOps1_74 - 01/16/2026 20:58:03 ||PHP DYR OK | Detalles=26 | Resultantes=3 | uid_orden=OS.260116015 | empresa=Ori_Sil_2 | uid_proc=PRO_EnsProOps1_74 - 01/16/2026 21:00:44 ||PHP C OK | consumos_insertados=26 | uid_orden=OS.260116015 - 01/16/2026 21:01:43 ||PHP C OK | consumos_insertados=26 | uid_orden=OS.260116015 - 01/16/2026 21:06:29 ||PHP C OK | consumos_insertados=26 | uid_orden=OS.260116015 - 01/16/2026 21:13:03 ||PHP C OK | consumos_insertados=26 | uid_orden=OS.260116015 - 01/16/2026 21:15:37 ||PHP C.AD OK | detalle=OS.3284d2c2 | consumo=OS.3284d2c2 - 01/16/2026 21:28:09 ||PHP C OK | lotes_insertados=3 | uid_orden=OS.260116015 - 01/22/2026 11:39:48'),
(21,'OS.260122011','Ori_Sil_2','PRO_EnsProOps1_74','CacyCho_d0','1','3',0,NULL,'meses',10.0000,1288.0000,1288.0000,'Este es un primer ensato y estos son kos tips','Estas son las isntruccones del procedimiento',NULL,NULL,'doblessas@gmail.com',NULL,'1','Media','OS.67566c75','OS.67566c75',NULL,26024834.3927,25991128.7927,158373.0205,356250.0000,19693691.5000,5697294.4000,85519.8722,45491328.7927,158373.0205,356250.0000,5697294.4000,39193691.5000,85719.8722,0.0000,0.000000,0.000000,NULL,NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:40:26','2026-02-05 19:36:44','||PHP DYR OK | Detalles=26 | Resultantes=3 | uid_orden=OS.260122011 | empresa=Ori_Sil_2 | uid_proc=PRO_EnsProOps1_74 - 01/22/2026 11:41:29 ||PHP C OK | consumos_insertados=26 | uid_orden=OS.260122011 - 01/22/2026 11:42:33 ||PHP C OK | lotes_insertados=3 | uid_orden=OS.260122011 - 01/22/2026 11:43:19 ||PHP L.AD OK | uid_orden=OS.260122011 | producto_adicional= - 01/22/2026 11:48:23 ||PHP C.AD OK | detalle=OS.46aadddf | consumo=OS.46aadddf - 01/22/2026 11:50:29 ||PHP C.AD OK | detalle=OS.d9603628 | consumo=OS.d9603628 - 01/23/2026 17:14:03 ||PHP C.AD OK | detalle=OS.16ce40eb | consumo=OS.16ce40eb - 01/29/2026 13:03:42'),
(22,'OS.260124012','Ori_Sil_2','PRO_Refdenib24hor_5a','CacyCho_d0','1','1',0,NULL,'kg',1.0000,0.0000,0.0000,NULL,'1. Alistamiento\n\nRevisar que las refinadoras estén limpias, secas y en buen estado.\nAlistar bowls, espátulas, moldes y gramera.\n\n⚖️ 2. Pesaje\n\nPesar 4 kg de nibs por refinadora a usar.\n\n 3. Pre-molienda (Molino de maíz eléctrico)\n\n⚠️ ADVERTENCIA:\n Por ningún motivo meter la mano en la tolva. Tener cuidado.\n✅ Siempre agregar los ingredientes con dosificadora.\n\nSi el molino se frena:\n\nApagarlo.\n\nAflojar la mariposa frontal para darle más espacio al paso de los nibs.\n\nSi persiste, vaciar y volver a pasar.\n\n Pasar las tandas lentamente, sin llenar la tolva al inicio para no forzar el molino.\nUna vez avance el proceso, se puede aumentar la cantidad agregada.\nPasar dos veces por el molino.\n\n Tip: En la segunda pasada, ayudar con la espátula metálica empujando los nibs, ya que al volverse pasta les cuesta más pasar.\n\n 4. Carga a refinadora\n\n Antes de comenzar a refinar, aflojar la tuerca central para evitar que se frene.\nCuando ya esté cargada la refinadora con los 4 kg y funcione correctamente, se puede apretar la tuerca.\n\nA medida que va saliendo la pasta del molino en la segunda pasada, se va agregando directamente a la refinadora.\nEmpezar con presión mínima y aumentar gradualmente, vigilando que la máquina no se fuerce.\n\n⏱️ 5. Refinado\n\nDejar 24 horas continuas de refinación.\n\n 6. Bajado del chocolate\n\nApagar la refinadora.\n\nMedir la temperatura y registrarla en la bitácora.\n\nPresionar el botón al lado izquierdo de la refinadora para poder girar el tambor.\n\nColocar el recipiente donde se va a bajar el chocolate en una mesa más baja que la refinadora.\n\nDescargar suavemente para evitar regueros.\n\nLimpiar bien las paredes y piedras con espátula de silicona para aprovechar el producto restante.\n\n Alistar los recipientes o moldes limpios y secos.\n\n Nota\n\nPara bloques de chocolate, se puede enmoldar directamente en bandejas.\n\nPara enmoldado de bombones, descargar primero en bowl.\n\nSi se va a continuar con cobertura, retirar la cantidad correspondiente (2.380 g) y dejar el excedente.\n(La diferencia entre 4.000 g y 2.380 g será el chocolate restante).\n\n⚠️ Puntos Críticos\n\n La pre-molienda debe quedar en pasta, no con granos sueltos.\n⚙️ La alimentación de la refinadora debe hacerse sin forzarla.\n️ Antes de desmontar, tomar y registrar la temperatura.\nSi supera los 45 °C, registrar como dificultad y dejar en observación.\n Respetar las 24 horas completas de refinado.',NULL,NULL,'larevo1111@gmail.com',NULL,'1','Media','1','1',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.000000,0.000000,NULL,NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 14:10:07','2026-01-24 14:10:07',NULL),
(23,'OS.260124017','Ori_Sil_2','PRO_EnsProOps1_74','CacyCho_d0','1','3',0,NULL,'meses',10.0000,1288.0000,1288.0000,'Este es un primer ensato y estos son kos tips','Estas son las isntruccones del procedimiento',NULL,NULL,'larevo1111@gmail.com',NULL,'1','Media','1','1',NULL,26024834.3927,25991128.7927,158373.0205,356250.0000,19693691.5000,5697294.4000,85519.8722,25991128.7927,158373.0205,356250.0000,5697294.4000,19693691.5000,85519.8722,0.0000,0.000000,0.000030,'01/29/2026 20:39:41',NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:00','2026-01-29 20:39:41',' ||PHP DYR OK | Detalles=26 | Resultantes=3 | uid_orden=OS.260124017 | empresa=Ori_Sil_2 | uid_proc=PRO_EnsProOps1_74 - 01/24/2026 20:54:26 ||PHP C OK | consumos_insertados=26 | uid_orden=OS.260124017 - 01/24/2026 20:54:46 ||PHP C OK | consumos_insertados=26 | uid_orden=OS.260124017 - 01/24/2026 20:56:25 ||PHP C.AD OK | detalle=OS.00781eda | consumo=OS.00781eda - 01/24/2026 20:57:12 ||PHP C OK | lotes_insertados=3 | uid_orden=OS.260124017 - 01/24/2026 21:12:59 ||PHP C.AD OK | detalle=OS.b46047cd | consumo=OS.b46047cd - 01/29/2026 12:46:58'),
(24,'OS.260129011','Ori_Sil_2','PRO_EnsProOps1_74','CacyCho_d0','1','3',0,NULL,'meses',10.0000,1288.0000,1288.0000,'Este es un primer ensato y estos son kos tips','Estas son las isntruccones del procedimiento',NULL,NULL,'larevo1111@gmail.com',NULL,'1','Media','1','1',NULL,26024834.3927,25991128.7927,158373.0205,356250.0000,19693691.5000,5697294.4000,85519.8722,25993828.7927,158373.0205,356250.0000,5697294.4000,19693691.5000,85519.8722,2700.0000,376.028592,1012.644592,'02/12/2026 08:32:09',NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 10:19:00','2026-02-12 08:32:09',' ||PHP DYR OK | Detalles=26 | Resultantes=3 | uid_orden=OS.260129011 | empresa=Ori_Sil_2 | uid_proc=PRO_EnsProOps1_74 - 01/29/2026 16:19:14'),
(25,'OS.260129010','Ori_Sil_2','PRO_EnsProOps1_74','CacyCho_d0','1','3',0,NULL,'meses',100.0000,12880.0000,12880.0000,'Este es un primer ensato y estos son kos tips','Estas son las isntruccones del procedimiento',NULL,NULL,'larevo1111@gmail.com',NULL,'1','Media','1','1',NULL,260248343.9265,259777098.3268,1583730.2050,3562500.0000,196936915.0000,56838754.4000,855198.7218,259777098.3268,1583730.2050,3562500.0000,56838754.4000,196936915.0000,855198.7218,0.0000,3760.285920,3760.285920,'01/29/2026 20:43:13',NULL,NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:35:50','2026-01-29 20:43:13',' ||PHP DYR OK | Detalles=26 | Resultantes=3 | uid_orden=OS.260129010 | empresa=Ori_Sil_2 | uid_proc=PRO_EnsProOps1_74 - 01/29/2026 16:36:11 ||PHP C OK | consumos_insertados=26 | uid_orden=OS.260129010 - 01/29/2026 16:37:00');
/*!40000 ALTER TABLE `prod_ordenes_encabezados` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `prod_ordenes_lotes`
--

LOCK TABLES `prod_ordenes_lotes` WRITE;
/*!40000 ALTER TABLE `prod_ordenes_lotes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `prod_ordenes_lotes` VALUES
(3,'O2511071509ad15','Ori_Sil_2','O2511071509ad',NULL,'PPPt__ENSCAS_7a','14','kg',7.7500,'1',0.0000,'',NULL,'',NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-14 23:26:34','2025-11-29 04:13:04',''),
(4,'O2511071509ad22','Ori_Sil_2','O2511071509ad',NULL,'PPPt__ENSNIB_00','16','kg',17.2250,'1',0.0000,'larevo1111@gmail.com',NULL,'',NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-14 23:26:34','2025-11-29 03:36:14',''),
(5,'25112701310','Ori_Sil_2','251127013','CacyCho_d0','PPNiv1_ALMDECACTOS_04','15','kg',0.0000,'1',23706.0000,'larevo1111@gmail.com','Lote aprobado por SYSOP (larevo1111@gmail.com) — ernesrtooo','',NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 14:53:35','2025-12-04 21:52:24',''),
(16,'OP25-1101-0027-2617','Ori_Sil_2','OP25-1101-0027-26',NULL,'PPPt__ENSCAS_7a','15','kg',3.1000,NULL,470108.8600,'',NULL,'',NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-29 00:38:46','2025-11-29 01:36:18',''),
(17,'OP25-1101-0027-2620','Ori_Sil_2','OP25-1101-0027-26',NULL,'PPPt__ENSNIB_00','14','kg',6.8900,NULL,211884.7700,'',NULL,'',NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-29 00:38:46','2025-12-04 21:08:21',''),
(18,'O2511071509ad38','Ori_Sil_2','O2511071509ad',NULL,'PPPt__ENSNIB_00','14','kg',35.0000,'1',211884.7700,'',NULL,'',NULL,'nuevo lote','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-07 03:31:54','2025-12-07 03:32:59',''),
(19,'LLCl2L1OhPhi8AdQ','Ori_Sil_2','OS.26011001e','','PTCre_CHOOS230GRS_11','Creado','Und',0.0000,'1',0.0000,'','','',NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 15:12:26','2026-01-12 15:12:26','Generado PHP| 2026-01-12 15:12:26 | larevo1111@gmail.com'),
(20,'Zd3JGdmN3L9QSNmL','Ori_Sil_2','OS.26011001e','','PTOtr_CUCMIEGRA_42','13','Und',0.0000,'1',0.0000,'','','',NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 15:29:19','2026-01-12 15:29:19','Generado PHP| 2026-01-12 10:29:19 | larevo1111@gmail.com'),
(21,'OS.26011101b1','Ori_Sil_2','OS.26011101b','','PTProapi_POLDEABEOS80g_84','13','Und',0.0000,'OS.67566c75',0.0000,'','','',NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-13 00:04:44','2026-01-13 00:04:44','Generado PHP| 2026-01-12 19:04:44 | larevo1111@gmail.com'),
(22,'OS.26011101b2','Ori_Sil_2','OS.26011101b','','PTProapi_PROOS600grs_88','13','Und',0.0000,'OS.67566c75',0.0000,'','','',NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-13 00:23:33','2026-01-13 00:23:33','Generado PHP| 2026-01-12 19:23:33 | larevo1111@gmail.com'),
(23,'OS.26011101b3','Ori_Sil_2','OS.26011101b','','PPPt__ENSALMTOS_f2','13','kg',0.0000,'OS.67566c75',0.0000,'','','',NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 19:30:26','2026-01-12 19:30:26','Generado PHP| 2026-01-12 19:30:26 | larevo1111@gmail.com'),
(24,'OS.26011101b4','Ori_Sil_2','OS.26011101b','','PPNiv1_INFDECACOSCONMENY_54','13','kg',0.0000,'OS.67566c75',0.0000,'','','',NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 20:39:30','2026-01-12 20:39:30','Generado PHP| 2026-01-12 20:39:30 | larevo1111@gmail.com'),
(31,'OS.2601160151b','Ori_Sil_2','OS.260116015','OS.260116015.PRO_EnsProOps1_74.CacyCho_d0','PTFrusecygra_ALMDECACORGTOS100GRS_02','13','Und',2.2000,'1',400822.5319,'','','',NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:39:48','2026-01-22 11:39:48','CREADO DESDE RESULTANTES PHP | 2026-01-22 11:39:48 | larevo1111@gmail.com'),
(32,'OS.26011601529','Ori_Sil_2','OS.260116015','OS.260116015.PRO_EnsProOps1_74.CacyCho_d0','PPNiv6_COBCHOCPM73%OSENMX_28','13','kg',1.3000,'1',858905.4255,'','','',NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:39:48','2026-01-22 11:39:48','CREADO DESDE RESULTANTES PHP | 2026-01-22 11:39:48 | larevo1111@gmail.com'),
(33,'OS.26011601538','Ori_Sil_2','OS.260116015','OS.260116015.PRO_EnsProOps1_74.CacyCho_d0','PPNiv1_ExtdeVaienMie_51','13','kg',4.0000,'1',801645.0638,'','','',NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:39:48','2026-01-22 11:39:48','CREADO DESDE RESULTANTES PHP | 2026-01-22 11:39:48 | larevo1111@gmail.com'),
(34,'OS.2601220111f','Ori_Sil_2','OS.260122011','OS.260122011.PRO_EnsProOps1_74.CacyCho_d0','PTFrusecygra_ALMDECACORGTOS100GRS_02','13','Und',11.0000,'OS.67566c75',400822.5319,'','','',NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:43:19','2026-01-22 11:43:19','CREADO DESDE RESULTANTES PHP | 2026-01-22 11:43:19 | larevo1111@gmail.com'),
(35,'OS.2601220112c','Ori_Sil_2','OS.260122011','OS.260122011.PRO_EnsProOps1_74.CacyCho_d0','PPNiv6_COBCHOCPM73%OSENMX_28','13','kg',6.5000,'OS.67566c75',858905.4255,'','','',NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:43:19','2026-01-22 11:43:19','CREADO DESDE RESULTANTES PHP | 2026-01-22 11:43:19 | larevo1111@gmail.com'),
(36,'OS.2601220113d','Ori_Sil_2','OS.260122011','OS.260122011.PRO_EnsProOps1_74.CacyCho_d0','PPNiv1_ExtdeVaienMie_51','16','kg',20.0000,'OS.67566c75',801645.0638,'larevo1111@gmail.com','Lote rechazado por SYSOP (larevo1111@gmail.com)','PP.RECHAZADO.REPROCESABLE',1,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:43:19','2026-02-05 18:49:13','CREADO DESDE RESULTANTES PHP | 2026-01-22 11:43:19 | larevo1111@gmail.com'),
(37,'OS.2601220114','Ori_Sil_2','OS.260122011','','PPNiv4_CHOXKG_13','13','kg',0.0000,'OS.67566c75',0.0000,'','','',NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:48:19','2026-01-22 11:48:19','Generado PHP| 2026-01-22 11:48:19 | larevo1111@gmail.com'),
(39,'OS.25122701714','Ori_Sil_2','OS.251227017','OS.251227017.PRO_EnsProOps1_74.CacyCho_d0','PTFrusecygra_ALMDECACORGTOS100GRS_02','13','Und',110.0000,'1',0.0000,'','','',NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:07:55','2026-01-22 21:07:55','CREADO DESDE RESULTANTES PHP | 2026-01-22 21:07:55 | larevo1111@gmail.com'),
(40,'OS.25122701723','Ori_Sil_2','OS.251227017','OS.251227017.PRO_EnsProOps1_74.CacyCho_d0','PPNiv6_COBCHOCPM73%OSENMX_28','13','kg',65.0000,'1',0.0000,'','','',NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:07:55','2026-01-22 21:07:55','CREADO DESDE RESULTANTES PHP | 2026-01-22 21:07:55 | larevo1111@gmail.com'),
(41,'OS.25122701735','Ori_Sil_2','OS.251227017','OS.251227017.PRO_EnsProOps1_74.CacyCho_d0','PPNiv1_ExtdeVaienMie_51','13','kg',200.0000,'1',0.0000,'','','',NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:07:55','2026-01-22 21:07:55','CREADO DESDE RESULTANTES PHP | 2026-01-22 21:07:55 | larevo1111@gmail.com'),
(42,'OS.2512270174','Ori_Sil_2','OS.251227017','','PPNiv2_CASDECACLTxKL_09','13','kg',0.0000,'1',22026.1976,'','','',NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:10:47','2026-01-22 21:10:47','Generado PHP| 2026-01-22 21:10:47 | larevo1111@gmail.com'),
(43,'OS.2601240171c','Ori_Sil_2','OS.260124017','OS.260124017.PRO_EnsProOps1_74.CacyCho_d0','PTFrusecygra_ALMDECACORGTOS100GRS_02','13','Und',11.0000,'1',400822.5319,'','','',NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 21:12:59','2026-01-24 21:12:59','CREADO DESDE RESULTANTES PHP | 2026-01-24 21:12:59 | larevo1111@gmail.com'),
(44,'OS.2601240172f','Ori_Sil_2','OS.260124017','OS.260124017.PRO_EnsProOps1_74.CacyCho_d0','PPNiv6_COBCHOCPM73%OSENMX_28','13','kg',6.5000,'1',858905.4255,'','','',NULL,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 21:12:59','2026-01-24 21:12:59','CREADO DESDE RESULTANTES PHP | 2026-01-24 21:12:59 | larevo1111@gmail.com'),
(45,'OS.2601240173c','Ori_Sil_2','OS.260124017','OS.260124017.PRO_EnsProOps1_74.CacyCho_d0','PPNiv1_ExtdeVaienMie_51','14','kg',20.0000,'1',801645.0638,'',NULL,NULL,1,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 21:12:59','2026-01-24 22:19:55','CREADO DESDE RESULTANTES PHP | 2026-01-24 21:12:59 | larevo1111@gmail.com');
/*!40000 ALTER TABLE `prod_ordenes_lotes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `prod_ordenes_residuos`
--

LOCK TABLES `prod_ordenes_residuos` WRITE;
/*!40000 ALTER TABLE `prod_ordenes_residuos` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `prod_ordenes_residuos` VALUES
(1,'OS.7eb01dc0','Ori_Sil_2','OS.260129011','OS.e74944bc',20.0000,10.0000,'OS.DEST.RECICLAJE_EXTERNO',17,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-02-04 09:15:57','2026-02-05 21:34:18'),
(2,'OS.3922a1b1','Ori_Sil_2','OS.260129011','OS.0d5b3f97',25.0000,100.0000,'OS.DEST.VALORIZACION_EXTERNA',17,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-02-04 09:23:58','2026-02-12 09:25:38'),
(3,'OS.18af30b5','Ori_Sil_2','OS.260129011','OS.fb5c756b',0.0000,0.0000,'OS.DEST.INCINERACION',17,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2026-02-05 17:44:53','2026-02-05 21:34:46');
/*!40000 ALTER TABLE `prod_ordenes_residuos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `prod_ordenes_resultantes`
--

LOCK TABLES `prod_ordenes_resultantes` WRITE;
/*!40000 ALTER TABLE `prod_ordenes_resultantes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `prod_ordenes_resultantes` VALUES
(3,'a8f6e888','Ori_Sil_2','OP25-1028-1900-ff','PPNiv1_ALMDECACTOS_04',0.000,0.0000,'kg','Principal',1,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-01 00:56:12','2025-11-01 05:56:16',''),
(4,'2b32ba1d','Ori_Sil_2','OP25-1101-0027-26','PPPt__ENSCAS_7a',3.100,0.0000,'kg','Principal',1,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-01 02:45:13','2025-11-01 07:45:22',''),
(5,'d5b61fea','Ori_Sil_2','OP25-1101-0027-26','PPPt__ENSNIB_00',6.890,0.0000,'kg','Principal',2,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-01 02:45:13','2025-11-01 07:45:23',''),
(6,'4c051aee','Ori_Sil_2','O2511071509ad','PPPt__ENSCAS_7a',7.750,0.0000,'kg','Principal',1,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-12 15:06:29','2025-11-12 20:06:34',''),
(7,'cc709b98','Ori_Sil_2','O2511071509ad','PPPt__ENSNIB_00',17.225,0.0000,'kg','Principal',2,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-12 15:06:29','2025-11-12 20:06:35',''),
(8,'ca1a8958','Ori_Sil_2','O2511071509ad','PTOtr_CUCMIEPEQ_44',0.000,0.0000,'Und','Adicional',3,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-14 23:56:50','2025-11-14 23:56:50',''),
(9,'7cd298ba','Ori_Sil_2','O2511071509ad','PTProapi_POLDEABEOS150grs_81',0.000,0.0000,'Und','Adicional',4,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-15 00:02:23','2025-11-15 00:02:23',''),
(10,'8c35b61c','Ori_Sil_2','251127013','PPNiv1_ALMDECACTOS_04',0.000,0.0000,'kg','Principal',1,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-11-27 14:37:45','2025-11-27 19:37:48',''),
(11,'3bb5ed03','Ori_Sil_2','25121703e','PPNiv6_COBCHOCPM73%OSENMX_28',6.500,0.0000,'meses','Principal',1,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-12-18 19:36:35','2025-12-19 00:36:39',''),
(12,'4f9a5f91','Ori_Sil_2','25121703e','PPNiv1_ExtdeVaienMie_51',20.000,0.0000,'meses','Principal',2,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-12-18 19:36:35','2025-12-19 00:36:40',''),
(18,'8q9lDoONnJ3qKoDq','Ori_Sil_2','OS.251227017','PTFrusecygra_ALMDECACORGTOS100GRS_02',110.000,0.0000,'Und','Principal',100,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(19,'MCJ4g0tHe1Cqc4bc','Ori_Sil_2','OS.251227017','PPNiv6_COBCHOCPM73%OSENMX_28',65.000,0.0000,'kg','Principal',200,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(20,'tEzwiapxHwxzdu6X','Ori_Sil_2','OS.251227017','PPNiv1_ExtdeVaienMie_51',200.000,0.0000,'kg','Principal',300,'Generado automáticamente | 2025-12-27 13:38:46 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-27 13:38:46','2025-12-27 13:38:46',''),
(27,'q9jFCUSIffnVRKeZ','Ori_Sil_2','OS.26011001e','PTFrusecygra_ALMDECACORGTOS100GRS_02',11.000,400822.5319,'Und','Principal',100,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(28,'ttMHUnIdHoHqpFoT','Ori_Sil_2','OS.26011001e','PPNiv6_COBCHOCPM73%OSENMX_28',6.500,858905.4255,'kg','Principal',200,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(29,'ANqlBFw4lojI3IY1','Ori_Sil_2','OS.26011001e','PPNiv1_ExtdeVaienMie_51',20.000,801645.0638,'kg','Principal',300,'Generado automáticamente | 2026-01-10 20:56:56 | larevo1111@gmail.com','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-10 20:56:56','2026-01-10 20:56:56',''),
(30,'VQfF7MZWKgba7ICW','Ori_Sil_2','OS.26011101b','PTFrusecygra_ALMDECACORGTOS100GRS_02',1100.000,400822.5319,'Und','Principal',100,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(31,'dQrighzqwoEmgqZB','Ori_Sil_2','OS.26011101b','PPNiv6_COBCHOCPM73%OSENMX_28',650.000,858905.4255,'kg','Principal',200,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(32,'Q981ofddjqavOStv','Ori_Sil_2','OS.26011101b','PPNiv1_ExtdeVaienMie_51',2000.000,801645.0638,'kg','Principal',300,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 04:11:41','2026-01-12 04:11:41','Generado automáticamente | 2026-01-12 04:11:41 | larevo1111@gmail.com'),
(33,'7D9QfZ39sG0L4IPf','Ori_Sil_2','OS.26011201b','PPPt__ENSNIB_00',68.900,45623.3741,'kg','Principal',100,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 13:54:49','2026-01-12 13:54:49','Generado automáticamente | 2026-01-12 13:54:49 | larevo1111@gmail.com'),
(34,'VoqbcARhvcdKztzz','Ori_Sil_2','OS.26011201b','PPPt__ENSCAS_7a',31.030,30826.6041,'kg','Principal',200,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 13:54:49','2026-01-12 13:54:49','Generado automáticamente | 2026-01-12 13:54:49 | larevo1111@gmail.com'),
(35,'eaKBYegmvYtKtVbo','Ori_Sil_2','OS.26011001e','PTCre_CHOOS230GRS_11',0.000,0.0000,'Und','Principal',400,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 15:12:26',NULL,'Generado PHP| 2026-01-12 15:12:26 | larevo1111@gmail.com'),
(36,'VDRpzkUHBe17EJxm','Ori_Sil_2','OS.26011001e','PTOtr_CUCMIEGRA_42',0.000,0.0000,'Und','Principal',500,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 15:29:19',NULL,'Generado PHP| 2026-01-12 10:29:19 | larevo1111@gmail.com'),
(37,'OS.20260112_190444_373','Ori_Sil_2','OS.26011101b','PTProapi_POLDEABEOS80g_84',0.000,0.0000,'Und','Principal',400,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-13 00:04:44',NULL,'Generado PHP| 2026-01-12 19:04:44 | larevo1111@gmail.com'),
(38,'OS.20260112_192333_7D1','Ori_Sil_2','OS.26011101b','PTProapi_PROOS600grs_88',0.000,0.0000,'Und','Principal',500,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-13 00:23:33','2026-01-13 00:23:33','Generado PHP| 2026-01-12 19:23:33 | larevo1111@gmail.com'),
(39,'OS.20260112_193026_4BC','Ori_Sil_2','OS.26011101b','PPPt__ENSALMTOS_f2',0.000,0.0000,'kg','Principal',600,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 19:30:26','2026-01-12 19:30:26','Generado PHP| 2026-01-12 19:30:26 | larevo1111@gmail.com'),
(40,'OS.20260112_203930_E87','Ori_Sil_2','OS.26011101b','PPNiv1_INFDECACOSCONMENY_54',0.000,0.0000,'kg','Principal',700,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 20:39:30','2026-01-12 20:39:30','Generado PHP| 2026-01-12 20:39:30 | larevo1111@gmail.com'),
(50,'OS.mngKwsWmN','Ori_Sil_2','OS.260112016','PTFrusecygra_ALMDECACORGTOS100GRS_02',1100.000,400822.5319,'Und','Principal',100,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(51,'OS.L3K6nCbmi','Ori_Sil_2','OS.260112016','PPNiv6_COBCHOCPM73%OSENMX_28',650.000,858905.4255,'kg','Principal',200,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(52,'OS.5iltqNCoG','Ori_Sil_2','OS.260112016','PPNiv1_ExtdeVaienMie_51',2000.000,801645.0638,'kg','Principal',300,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-12 22:05:44','2026-01-12 22:05:44','Generado automáticamente PHP | 2026-01-12 22:05:44 | larevo1111@gmail.com'),
(65,'OS.di9IQzO4D','Ori_Sil_2','OS.260115011','PTFrusecygra_ALMDECACORGTOS100GRS_02',110.000,400822.5319,'Und','Principal',100,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(66,'OS.C1yS9IySa','Ori_Sil_2','OS.260115011','PPNiv6_COBCHOCPM73%OSENMX_28',65.000,858905.4255,'kg','Principal',200,'1','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-16 19:38:54','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(67,'OS.8cH9vtjMG','Ori_Sil_2','OS.260115011','PPNiv1_ExtdeVaienMie_51',200.000,801645.0638,'kg','Principal',300,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-15 21:00:11','2026-01-15 21:00:11','Generado automáticamente PHP | 2026-01-15 21:00:11 | larevo1111@gmail.com'),
(71,'OS.keZkQki6Z','Ori_Sil_2','OS.260116015','PTFrusecygra_ALMDECACORGTOS100GRS_02',2.200,400822.5319,'Und','Principal',100,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(72,'OS.rCCOGIpvK','Ori_Sil_2','OS.260116015','PPNiv6_COBCHOCPM73%OSENMX_28',1.300,858905.4255,'kg','Principal',200,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(73,'OS.IgcvhsllU','Ori_Sil_2','OS.260116015','PPNiv1_ExtdeVaienMie_51',4.000,801645.0638,'kg','Principal',300,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-16 21:00:44','2026-01-16 21:00:44','Generado automáticamente PHP | 2026-01-16 21:00:44 | larevo1111@gmail.com'),
(74,'OS.WL2pdtuJQ','Ori_Sil_2','OS.260122011','PTFrusecygra_ALMDECACORGTOS100GRS_02',11.000,400822.5319,'Und','Principal',100,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(75,'OS.A6wwtscId','Ori_Sil_2','OS.260122011','PPNiv6_COBCHOCPM73%OSENMX_28',6.500,858905.4255,'kg','Principal',200,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(76,'OS.327VdnrpA','Ori_Sil_2','OS.260122011','PPNiv1_ExtdeVaienMie_51',20.000,801645.0638,'kg','Principal',300,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:41:29','2026-01-22 11:41:29','Generado automáticamente PHP | 2026-01-22 11:41:29 | larevo1111@gmail.com'),
(77,'OS.20260122_114819_5A2','Ori_Sil_2','OS.260122011','PPNiv4_CHOXKG_13',0.000,0.0000,'kg','Principal',400,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 11:48:19','2026-01-22 11:48:19','Generado PHP| 2026-01-22 11:48:19 | larevo1111@gmail.com'),
(78,'OS.20260122_211047_668','Ori_Sil_2','OS.251227017','PPNiv2_CASDECACLTxKL_09',0.300,22026.1976,'kg','Principal',400,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-22 21:10:47','2026-01-22 21:10:47','Generado PHP| 2026-01-22 21:10:47 | larevo1111@gmail.com'),
(79,'OS.bZhWaq6GP','Ori_Sil_2','OS.260124017','PTFrusecygra_ALMDECACORGTOS100GRS_02',11.000,400822.5319,'Und','Principal',100,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(80,'OS.nbtgdXfsZ','Ori_Sil_2','OS.260124017','PPNiv6_COBCHOCPM73%OSENMX_28',6.500,858905.4255,'kg','Principal',200,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(81,'OS.XL3nVajK3','Ori_Sil_2','OS.260124017','PPNiv1_ExtdeVaienMie_51',20.000,801645.0638,'kg','Principal',300,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-24 20:54:26','2026-01-24 20:54:26','Generado automáticamente PHP | 2026-01-24 20:54:26 | larevo1111@gmail.com'),
(88,'OS.xMaxzx3JF','Ori_Sil_2','OS.260129011','PTFrusecygra_ALMDECACORGTOS100GRS_02',11.000,400822.5319,'Und','Principal',100,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(89,'OS.6iQavjrU4','Ori_Sil_2','OS.260129011','PPNiv6_COBCHOCPM73%OSENMX_28',6.500,858905.4255,'kg','Principal',200,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(90,'OS.Fc8x5YjyP','Ori_Sil_2','OS.260129011','PPNiv1_ExtdeVaienMie_51',20.000,801645.0638,'kg','Principal',300,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:19:14','2026-01-29 16:19:14','Generado automáticamente PHP | 2026-01-29 16:19:14 | larevo1111@gmail.com'),
(91,'OS.d3inU1xnA','Ori_Sil_2','OS.260129010','PTFrusecygra_ALMDECACORGTOS100GRS_02',110.000,400822.5319,'Und','Principal',100,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(92,'OS.riHZxZHep','Ori_Sil_2','OS.260129010','PPNiv6_COBCHOCPM73%OSENMX_28',65.000,858905.4255,'kg','Principal',200,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com'),
(93,'OS.e1DM1qt6p','Ori_Sil_2','OS.260129010','PPNiv1_ExtdeVaienMie_51',200.000,801645.0638,'kg','Principal',300,'','larevo1111@gmail.com','larevo1111@gmail.com','2026-01-29 16:36:11','2026-01-29 16:36:11','Generado automáticamente PHP | 2026-01-29 16:36:11 | larevo1111@gmail.com');
/*!40000 ALTER TABLE `prod_ordenes_resultantes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `prod_ordenes_trazabilidad`
--

LOCK TABLES `prod_ordenes_trazabilidad` WRITE;
/*!40000 ALTER TABLE `prod_ordenes_trazabilidad` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `prod_ordenes_trazabilidad` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `prod_tipos_orden`
--

LOCK TABLES `prod_tipos_orden` WRITE;
/*!40000 ALTER TABLE `prod_tipos_orden` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `prod_tipos_orden` VALUES
('1',1,'Ori_Sil_2','Producción Normal','Orden estándar de fabricación según procedimientos aprobados. Mueve SAL de MP/consumibles y ENT de producto terminado. Ej.: producir miel 500 g o tabletas estándar.',1,'Activo','ssierra047@gmail.com','larevo1111@gmail.com','2025-11-06 00:00:00','2026-01-24 16:13:14'),
('10',2,'Ori_Sil_2','Ajuste: Dar de baja producto dañado','Baja definitiva de inventario por daño, contaminación o vencimiento (PT o MP). Ej.: frascos rotos, chocolate con humedad.',0,'Activo','ssierra047@gmail.com','ssierra047@gmail.com','2025-11-06 00:00:00','2025-12-26 08:00:08'),
('11',3,'Ori_Sil_2','Ajuste: Merma o pérdida operativa','Registrar pérdidas naturales o residuos de proceso. Ej.: evaporación, adherencias en equipos, residuos en mezcladoras.',0,'Activo','ssierra047@gmail.com','ssierra047@gmail.com','2025-11-06 00:00:00','2025-12-26 08:00:11'),
('12',4,'Ori_Sil_2','Ajuste: Reingreso o reutilización','Devolver a inventario materiales o productos previamente dados de baja o sobrantes de una orden. Ej.: MP no utilizada que regresa a bodega.',0,'Activo','ssierra047@gmail.com','ssierra047@gmail.com','2025-11-06 00:00:00','2025-12-26 08:00:15'),
('13',5,'Ori_Sil_2','Ajuste: Inventario general','Ajuste administrativo para cuadrar saldos con conteo físico o contabilidad. No corresponde a un proceso productivo. Ej.: carga inicial o corrección de diferencias.',0,'Activo','ssierra047@gmail.com','ssierra047@gmail.com','2025-11-06 00:00:00','2025-12-26 08:00:18'),
('2',6,'Ori_Sil_2','Subcontratación o maquila','Proceso realizado por un tercero (aliado/maquilador). Controla materiales enviados y productos recibidos. Ej.: templado o envasado externo.',0,'Activo','ssierra047@gmail.com','ssierra047@gmail.com','2025-11-06 00:00:00','2025-12-26 08:00:20'),
('3',7,'Ori_Sil_2','Desarrollo experimental o I+D','Pruebas de receta o validación de procesos, no producción comercial. Ej.: nueva proporción de cacao o mezcla experimental.',0,'Activo','ssierra047@gmail.com','ssierra047@gmail.com','2025-11-06 00:00:00','2025-12-26 08:00:24'),
('4',8,'Ori_Sil_2','Muestras físicas o degustaciones','Producción/salida destinada a pruebas, degustaciones o eventos. Puede no considerarse stock comercial. Ej.: frascos pequeños para ferias.',0,'Activo','ssierra047@gmail.com','ssierra047@gmail.com','2025-11-06 00:00:00','2025-12-26 08:00:27'),
('5',9,'Ori_Sil_2','Mantenimiento o limpieza','Consumo de insumos/tiempo para mantener equipos y áreas. No genera producto. Ej.: alcohol, detergentes, grasas, mano de obra de mantenimiento.',0,'Activo','ssierra047@gmail.com','ssierra047@gmail.com','2025-11-06 00:00:00','2025-12-26 08:00:29'),
('6',10,'Ori_Sil_2','Reproceso A: No reprocesable (baja)','Producto dañado, contaminacion, o riesgo de contaminacion, producto sin sello de integridad)',0,'Activo','ssierra047@gmail.com','larevo1111@gmail.com','2025-11-06 00:00:00','2025-12-26 08:00:32'),
('7',11,'Ori_Sil_2','Reproceso B: reproceso directo','Productos deformados, derretidos, con fat bloom, etc. Productos que se pueden ya sea reprocesar directamente en el envase o integrar facilmente a produccion.',0,'Activo','ssierra047@gmail.com','larevo1111@gmail.com','2025-11-06 00:00:00','2025-12-26 08:00:34'),
('8',12,'Ori_Sil_2','Reproceso C: Desarrollos/invalidos en baja proporción','Incorporar lotes pequeños o desarrollos no válidos dentro de un lote correcto en baja proporción para no desperdiciar. Ej.: mezclar poca miel con sabor alterado en un lote estándar.',0,'Activo','ssierra047@gmail.com','larevo1111@gmail.com','2025-11-06 00:00:00','2025-12-26 08:00:38'),
('9',13,'Ori_Sil_2','Reproceso D: Re-etiquetable, re-empacable','Producto intacto, dañs en etiquetas o empaque',0,'Activo','ssierra047@gmail.com','larevo1111@gmail.com','2025-11-06 00:00:00','2026-01-24 16:13:14');
/*!40000 ALTER TABLE `prod_tipos_orden` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `sys_acciones`
--

LOCK TABLES `sys_acciones` WRITE;
/*!40000 ALTER TABLE `sys_acciones` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sys_acciones` VALUES
(1,'costos_categorias','Exportar a CVS'),
(2,'costos_categorias','Add'),
(3,'costos_categorias','Compose Email (usuario_ult_modificacion)'),
(4,'costos_categorias','Delete'),
(5,'costos_categorias','Edit'),
(6,'costos_categorias','View Ref (Empresa)'),
(8,'costos_consumibles','Copiar maestra consumible'),
(9,'costos_consumibles','Exportar a CVS 2'),
(10,'costos_consumibles','Add'),
(11,'costos_consumibles','Compose Email (usuario_ult_modificacion)'),
(12,'costos_consumibles','Delete'),
(13,'costos_consumibles','Edit'),
(14,'costos_consumibles','Open File (Archivo_1)'),
(15,'costos_consumibles','Open File (Archivo_2)'),
(16,'costos_consumibles','Open File (Archivo_3)'),
(17,'costos_consumibles','View Ref (categoria)'),
(18,'costos_consumibles','View Ref (empresa)'),
(19,'costos_consumibles','View Ref (unidad)'),
(20,'costos_encabezados_productos','asignar grupo'),
(21,'costos_encabezados_productos','Copiar Encabezados Productos'),
(22,'costos_encabezados_productos','Copiar formulas grupo'),
(23,'costos_encabezados_productos','copiar formulas limpiar de todos'),
(24,'costos_encabezados_productos','copiar formulas limpiar este row'),
(25,'costos_encabezados_productos','Copiar formulas producto'),
(26,'costos_encabezados_productos','Copiar proc grupo'),
(27,'costos_encabezados_productos','Copiar proc producto'),
(28,'costos_encabezados_productos','Exportar a CVS 3'),
(29,'costos_encabezados_productos','Add'),
(30,'costos_encabezados_productos','Compose Email (Usuario_aprobador_prod)'),
(31,'costos_encabezados_productos','Compose Email (usuario_ult_modificacion)'),
(32,'costos_encabezados_productos','Delete'),
(33,'costos_encabezados_productos','Edit'),
(34,'costos_encabezados_productos','Open File (archivo_1)'),
(35,'costos_encabezados_productos','Open File (archivo_2)'),
(36,'costos_encabezados_productos','Open File (archivo_3)'),
(37,'costos_encabezados_productos','Open Url (video_1)'),
(38,'costos_encabezados_productos','Open Url (video_2)'),
(39,'costos_encabezados_productos','Open Url (video_3)'),
(40,'costos_encabezados_productos','View Ref (Categoria)'),
(41,'costos_encabezados_productos','View Ref (Empresa)'),
(42,'costos_encabezados_productos','View Ref (Grupo)'),
(43,'costos_encabezados_productos','View Ref (Unidad)'),
(44,'costos_etiquetas','Add'),
(45,'costos_etiquetas','Compose Email (usuario_ult_modificacion)'),
(46,'costos_etiquetas','Delete'),
(47,'costos_etiquetas','Edit'),
(48,'costos_fases','Add'),
(49,'costos_fases','Delete'),
(50,'costos_fases','Edit'),
(51,'costos_fases','View Ref (empresa)'),
(52,'costos_formulas','Abrir artículo'),
(53,'costos_formulas','Actualizar este Vlr Un formulas'),
(54,'costos_formulas','Actualizar todos los Vlr Un formulas'),
(55,'costos_formulas','Actualizar todos los Vlr Un formulas 2'),
(56,'costos_formulas','Copiar esta fórmula al destino'),
(57,'costos_formulas','Exportar a CVS 4'),
(58,'costos_formulas','o.aumentar.acciones'),
(59,'costos_formulas','o.aumentar.set.rows'),
(60,'costos_formulas','o.disminuir.acciones'),
(61,'costos_formulas','o.disminuir.col.mas'),
(62,'costos_formulas','o.disminuir.col.menos'),
(63,'costos_formulas','o.disminuir.set.rows'),
(64,'costos_formulas','Ver Articulo'),
(65,'costos_formulas','Add'),
(66,'costos_formulas','Compose Email (usuario_creador)'),
(67,'costos_formulas','Compose Email (usuario_ult_actualizacion)'),
(68,'costos_formulas','Delete'),
(69,'costos_formulas','Edit'),
(70,'costos_formulas','View Ref (Empresa)'),
(71,'costos_formulas','View Ref (uid_producto_resultante)'),
(72,'costos_formulas','View Ref (unidad)'),
(73,'costos_grupos_productos','Agregar Productos a Grupo'),
(74,'costos_grupos_productos','asignar grupo a productos'),
(75,'costos_grupos_productos','Exportar a CVS 5'),
(76,'costos_grupos_productos','limpiar agregar productos'),
(77,'costos_grupos_productos','limpiar agregar productos todos'),
(78,'costos_grupos_productos','Add'),
(79,'costos_grupos_productos','Compose Email (usuario_creador)'),
(80,'costos_grupos_productos','Compose Email (usuario_ult_modificacion)'),
(81,'costos_grupos_productos','Delete'),
(82,'costos_grupos_productos','Edit'),
(83,'costos_grupos_productos','Open File (archivo_1)'),
(84,'costos_grupos_productos','Open File (archivo_2)'),
(85,'costos_grupos_productos','Open File (archivo_3)'),
(86,'costos_grupos_productos','View Ref (Empresa)'),
(87,'costos_herramientas','Copiar maestra herramientas'),
(88,'costos_herramientas','Exportar a CVS 6'),
(89,'costos_herramientas','Add'),
(90,'costos_herramientas','Compose Email (usuario_creador)'),
(91,'costos_herramientas','Compose Email (usuario_ult_modificacion)'),
(92,'costos_herramientas','Delete'),
(93,'costos_herramientas','Edit'),
(94,'costos_herramientas','Open File (archivo1)'),
(95,'costos_herramientas','Open File (archivo2)'),
(96,'costos_herramientas','Open File (archivo3)'),
(97,'costos_herramientas','View Ref (categoria)'),
(98,'costos_herramientas','View Ref (Empresa)'),
(99,'costos_herramientas','View Ref (responsable)'),
(100,'costos_herramientas','View Ref (unidad_consumo)'),
(101,'costos_mp_insumos','Copiar maestra mp insumos'),
(102,'costos_mp_insumos','Exportar a CVS 7'),
(103,'costos_mp_insumos','Add'),
(104,'costos_mp_insumos','Compose Email (usuario_creador)'),
(105,'costos_mp_insumos','Compose Email (usuario_ult_modificacion)'),
(106,'costos_mp_insumos','Delete'),
(107,'costos_mp_insumos','Edit'),
(108,'costos_mp_insumos','Open File (archivo1)'),
(109,'costos_mp_insumos','Open File (archivo2)'),
(110,'costos_mp_insumos','Open File (archivo3)'),
(111,'costos_mp_insumos','View Ref (categoria)'),
(112,'costos_mp_insumos','View Ref (Empresa)'),
(113,'costos_mp_insumos','View Ref (unidad)'),
(114,'costos_procedimientos','Copiar Encabezados Procedimientos'),
(115,'costos_procedimientos','Copiar proc consum grupo'),
(116,'costos_procedimientos','copiar proc consum limpiar de todos'),
(117,'costos_procedimientos','copiar proc consum limpiar est row'),
(118,'costos_procedimientos','Copiar proc consum procedimiento'),
(119,'costos_procedimientos','Copiar proc hmtas grupo'),
(120,'costos_procedimientos','Copiar proc hmtas procedimiento'),
(121,'costos_procedimientos','Copiar proc img grupo'),
(122,'costos_procedimientos','Copiar proc img procedimiento'),
(123,'costos_procedimientos','Copiar proc mp grupo'),
(124,'costos_procedimientos','Copiar proc mp procedimiento'),
(125,'costos_procedimientos','Copiar proc pp grupo'),
(126,'costos_procedimientos','Copiar proc pp procedimiento'),
(127,'costos_procedimientos','Copiar proc serv grupo'),
(128,'costos_procedimientos','Copiar proc serv procedimiento'),
(129,'costos_procedimientos','Copiar proc TODO grupo'),
(130,'costos_procedimientos','Exportar a CVS 8'),
(131,'costos_procedimientos','Add'),
(132,'costos_procedimientos','Compose Email (usuario_creador)'),
(133,'costos_procedimientos','Compose Email (usuario_ult_modificacion)'),
(134,'costos_procedimientos','Delete'),
(135,'costos_procedimientos','Edit'),
(136,'costos_procedimientos','Open File (video_ppal)'),
(137,'costos_procedimientos','View Ref (Copiar_de)'),
(138,'costos_procedimientos','View Ref (Empresa)'),
(139,'costos_procedimientos','View Ref (Tipo_Procedimiento)'),
(140,'costos_procedimientos','View Ref (unidad)'),
(141,'costos_procedimientos_consumibles','Actualizar este Vlr Un 2'),
(142,'costos_procedimientos_consumibles','Actualizar todos los Vlr Un 2'),
(143,'costos_procedimientos_consumibles','Actualizar todos los Vlr Un 10'),
(144,'costos_procedimientos_consumibles','Copiar esta proc consum al destino'),
(145,'costos_procedimientos_consumibles','det copiar consumible a ordenes'),
(146,'costos_procedimientos_consumibles','Exportar a CVS 9'),
(147,'costos_procedimientos_consumibles','o.disminuir.acciones pconsum'),
(148,'costos_procedimientos_consumibles','o.disminuir.col.mas pconsum'),
(149,'costos_procedimientos_consumibles','o.disminuir.col.menos pconsum'),
(150,'costos_procedimientos_consumibles','o.disminuir.set.rows pconsum'),
(151,'costos_procedimientos_consumibles','Ver consumible'),
(152,'costos_procedimientos_consumibles','Add'),
(153,'costos_procedimientos_consumibles','Compose Email (usuario_creador)'),
(154,'costos_procedimientos_consumibles','Compose Email (usuario_ult_modificacion)'),
(155,'costos_procedimientos_consumibles','Delete'),
(156,'costos_procedimientos_consumibles','Edit'),
(157,'costos_procedimientos_consumibles','View Ref (Empresa)'),
(158,'costos_procedimientos_consumibles','View Ref (fase)'),
(159,'costos_procedimientos_consumibles','View Ref (uid_consumible)'),
(160,'costos_procedimientos_consumibles','View Ref (uid_procedimiento)'),
(161,'costos_procedimientos_consumibles','View Ref (Unidad del procedimiento)'),
(162,'costos_procedimientos_consumibles','View Ref (unidad)'),
(163,'costos_procedimientos_herramientas','Actualizar este Vlr Un 3'),
(164,'costos_procedimientos_herramientas','Actualizar todos los Vlr Un 3'),
(165,'costos_procedimientos_herramientas','Actualizar todos los Vlr Un 6'),
(166,'costos_procedimientos_herramientas','Copiar esta proc hmtas al destino'),
(167,'costos_procedimientos_herramientas','det copiar hmta a ordenes'),
(168,'costos_procedimientos_herramientas','Exportar a CVS 10'),
(169,'costos_procedimientos_herramientas','o.disminuir.acciones phmtas'),
(170,'costos_procedimientos_herramientas','o.disminuir.col.mas phmtas'),
(171,'costos_procedimientos_herramientas','o.disminuir.col.menos phmtas'),
(172,'costos_procedimientos_herramientas','o.disminuir.set.rows phmtas'),
(173,'costos_procedimientos_herramientas','Ver herramienta'),
(174,'costos_procedimientos_herramientas','Add'),
(175,'costos_procedimientos_herramientas','Compose Email (usuario_creador)'),
(176,'costos_procedimientos_herramientas','Compose Email (usuario_ult_modificacion)'),
(177,'costos_procedimientos_herramientas','Delete'),
(178,'costos_procedimientos_herramientas','Edit'),
(179,'costos_procedimientos_herramientas','View Ref (Empresa)'),
(180,'costos_procedimientos_herramientas','View Ref (fase)'),
(181,'costos_procedimientos_herramientas','View Ref (uid_herramienta)'),
(182,'costos_procedimientos_herramientas','View Ref (uid_procedimiento)'),
(183,'costos_procedimientos_herramientas','View Ref (Unidad Base)'),
(184,'costos_procedimientos_herramientas','View Ref (Unidad del Procedimiento)'),
(185,'costos_procedimientos_herramientas','View Ref (unidad_consumo)'),
(186,'costos_procedimientos_imag_vid','Copiar esta proc img al destino'),
(187,'costos_procedimientos_imag_vid','Exportar a CVS 11'),
(188,'costos_procedimientos_imag_vid','Add'),
(189,'costos_procedimientos_imag_vid','Compose Email (usuario_ult_modificacion)'),
(190,'costos_procedimientos_imag_vid','Delete'),
(191,'costos_procedimientos_imag_vid','Edit'),
(192,'costos_procedimientos_imag_vid','Open File (archivo)'),
(193,'costos_procedimientos_imag_vid','Open File (video)'),
(194,'costos_procedimientos_imag_vid','Open Url (url_general)'),
(195,'costos_procedimientos_imag_vid','Open Url (url_video)'),
(196,'costos_procedimientos_imag_vid','View Ref (Empresa)'),
(197,'costos_procedimientos_imag_vid','View Ref (fase)'),
(198,'costos_procedimientos_imag_vid','View Ref (uid_procedimiento)'),
(199,'costos_procedimientos_mp_insumos','Actualizar este Vlr Un'),
(200,'costos_procedimientos_mp_insumos','Actualizar todos los Vlr Un'),
(201,'costos_procedimientos_mp_insumos','Actualizar todos los Vlr Un 7'),
(202,'costos_procedimientos_mp_insumos','Copiar esta proc mp al destino'),
(203,'costos_procedimientos_mp_insumos','det copiar mp a ordenes 2'),
(204,'costos_procedimientos_mp_insumos','Exportar a CVS 12'),
(205,'costos_procedimientos_mp_insumos','o.disminuir.acciones pmp'),
(206,'costos_procedimientos_mp_insumos','o.disminuir.col.mas cmp'),
(207,'costos_procedimientos_mp_insumos','o.disminuir.col.menos pmp'),
(208,'costos_procedimientos_mp_insumos','o.disminuir.set.rows pmp'),
(209,'costos_procedimientos_mp_insumos','Ver mp_insumo'),
(210,'costos_procedimientos_mp_insumos','Add'),
(211,'costos_procedimientos_mp_insumos','Compose Email (usuario_creador)'),
(212,'costos_procedimientos_mp_insumos','Compose Email (usuario_ult_modificacion)'),
(213,'costos_procedimientos_mp_insumos','Delete'),
(214,'costos_procedimientos_mp_insumos','Edit'),
(215,'costos_procedimientos_mp_insumos','View Ref (Empresa)'),
(216,'costos_procedimientos_mp_insumos','View Ref (fase)'),
(217,'costos_procedimientos_mp_insumos','View Ref (uid_mp_insumo)'),
(218,'costos_procedimientos_mp_insumos','View Ref (uid_procedimiento)'),
(219,'costos_procedimientos_mp_insumos','View Ref (Unidad del Procedimiento)'),
(220,'costos_procedimientos_mp_insumos','View Ref (unidad)'),
(221,'costos_procedimientos_pp','Actualizar este Vlr Un 4'),
(222,'costos_procedimientos_pp','Actualizar todos los Vlr Un 4'),
(223,'costos_procedimientos_pp','Actualizar todos los Vlr Un 8'),
(224,'costos_procedimientos_pp','Copiar esta proc pp al destino'),
(225,'costos_procedimientos_pp','det copiar pp a ordenes'),
(226,'costos_procedimientos_pp','Exportar a CVS 13'),
(227,'costos_procedimientos_pp','o.disminuir.acciones pprodproc'),
(228,'costos_procedimientos_pp','o.disminuir.col.mas pprodproc'),
(229,'costos_procedimientos_pp','o.disminuir.col.menos pprodproc'),
(230,'costos_procedimientos_pp','o.disminuir.set.rows pprodproc'),
(231,'costos_procedimientos_pp','Ver procedimiento pp'),
(232,'costos_procedimientos_pp','Add'),
(233,'costos_procedimientos_pp','Compose Email (usuario_creador)'),
(234,'costos_procedimientos_pp','Compose Email (usuario_ult_modificacion)'),
(235,'costos_procedimientos_pp','Delete'),
(236,'costos_procedimientos_pp','Edit'),
(237,'costos_procedimientos_pp','View Ref (Empresa)'),
(238,'costos_procedimientos_pp','View Ref (fase)'),
(239,'costos_procedimientos_pp','View Ref (uid_procedimiento)'),
(240,'costos_procedimientos_pp','View Ref (uid_producto_pp)'),
(241,'costos_procedimientos_pp','View Ref (Unidad procedimiento)'),
(242,'costos_procedimientos_pp','View Ref (unidad)'),
(243,'costos_procedimientos_servicios_mo','Actualizar este Vlr Un 5'),
(244,'costos_procedimientos_servicios_mo','Actualizar todos los Vlr Un 5'),
(245,'costos_procedimientos_servicios_mo','Actualizar todos los Vlr Un 9'),
(246,'costos_procedimientos_servicios_mo','Copiar esta proc serv al destino'),
(247,'costos_procedimientos_servicios_mo','det copiar mo a ordenes'),
(248,'costos_procedimientos_servicios_mo','Exportar a CVS 14'),
(249,'costos_procedimientos_servicios_mo','o.disminuir.acciones pmo'),
(250,'costos_procedimientos_servicios_mo','o.disminuir.col.mas pmo'),
(251,'costos_procedimientos_servicios_mo','o.disminuir.col.menos pmo'),
(252,'costos_procedimientos_servicios_mo','o.disminuir.set.rows pmo'),
(253,'costos_procedimientos_servicios_mo','Ver Servicio MO'),
(254,'costos_procedimientos_servicios_mo','Add'),
(255,'costos_procedimientos_servicios_mo','Compose Email (usuario_creador)'),
(256,'costos_procedimientos_servicios_mo','Compose Email (usuario_ult_modificacion)'),
(257,'costos_procedimientos_servicios_mo','Delete'),
(258,'costos_procedimientos_servicios_mo','Edit'),
(259,'costos_procedimientos_servicios_mo','View Ref (Empresa)'),
(260,'costos_procedimientos_servicios_mo','View Ref (fase)'),
(261,'costos_procedimientos_servicios_mo','View Ref (uid_procedimiento)'),
(262,'costos_procedimientos_servicios_mo','View Ref (uid_servicio_mo)'),
(263,'costos_procedimientos_servicios_mo','View Ref (Unidad Base)'),
(264,'costos_procedimientos_servicios_mo','View Ref (Unidad del Procedimiento)'),
(265,'costos_procedimientos_servicios_mo','View Ref (unidad)'),
(266,'costos_producto_procedimientos','Copiar este procedimiento a destino'),
(267,'costos_producto_procedimientos','Exportar a CVS 15'),
(268,'costos_producto_procedimientos','o.disminuir.acciones cpp'),
(269,'costos_producto_procedimientos','o.disminuir.col.mas cpp'),
(270,'costos_producto_procedimientos','o.disminuir.col.menos cpp'),
(271,'costos_producto_procedimientos','o.disminuir.set.rows cpp'),
(272,'costos_producto_procedimientos','result copiar producto a ordenes'),
(273,'costos_producto_procedimientos','Ver Procedimiento'),
(274,'costos_producto_procedimientos','Ver Procedimiento 2'),
(275,'costos_producto_procedimientos','Ver Producto'),
(276,'costos_producto_procedimientos','Ver Producto 2'),
(277,'costos_producto_procedimientos','Add'),
(278,'costos_producto_procedimientos','Compose Email (usuario_creador)'),
(279,'costos_producto_procedimientos','Compose Email (usuario_ult_modificacion)'),
(280,'costos_producto_procedimientos','Delete'),
(281,'costos_producto_procedimientos','Edit'),
(282,'costos_producto_procedimientos','View Ref (Empresa)'),
(283,'costos_producto_procedimientos','View Ref (uid_procedimiento)'),
(284,'costos_producto_procedimientos','View Ref (uid_producto)'),
(285,'costos_producto_procedimientos','View Ref (unidad)'),
(286,'costos_servicios_mo','Copiar maestra mo servicios'),
(287,'costos_servicios_mo','Exportar a CVS 16'),
(288,'costos_servicios_mo','Add'),
(289,'costos_servicios_mo','Compose Email (usuario_ult_modificacion)'),
(290,'costos_servicios_mo','Delete'),
(291,'costos_servicios_mo','Edit'),
(292,'costos_servicios_mo','View Ref (categoria)'),
(293,'costos_servicios_mo','View Ref (Empresa)'),
(294,'costos_servicios_mo','View Ref (unidad)'),
(295,'costos_tipos_procedimientos','Exportar a CVS 17'),
(296,'costos_tipos_procedimientos','Add'),
(297,'costos_tipos_procedimientos','Compose Email (usuario_ult_modificacion)'),
(298,'costos_tipos_procedimientos','Delete'),
(299,'costos_tipos_procedimientos','Edit'),
(300,'costos_tipos_procedimientos','View Ref (Empresa)'),
(301,'costos_unidades','Exportar a CVS 18'),
(302,'costos_unidades','Add'),
(303,'costos_unidades','Compose Email (usuario_ult_modificacion)'),
(304,'costos_unidades','Delete'),
(305,'costos_unidades','Edit'),
(306,'costos_unidades','View Ref (Empresa)'),
(307,'costos_unidades','View Ref (tipo_unidad)'),
(308,'costos_unidades_tipos','Add'),
(309,'costos_unidades_tipos','Compose Email (usuario_ult_modificacion)'),
(310,'costos_unidades_tipos','Delete'),
(311,'costos_unidades_tipos','Edit'),
(312,'costos_unidades_tipos','View Ref (empresa)'),
(313,'costos_unidades_tipos','View Ref (unidad_estandar)'),
(314,'inv_bodegas','Add'),
(315,'inv_bodegas','Compose Email (usuario_ult_modificacion)'),
(316,'inv_bodegas','Delete'),
(317,'inv_bodegas','Edit'),
(318,'inv_bodegas','View Ref (empresa)'),
(319,'inv_bodegas','View Ref (responsable)'),
(320,'menu_ppal','Add'),
(321,'menu_ppal','Delete'),
(322,'menu_ppal','Edit'),
(323,'menu_ppal','Go to App Link (link item)'),
(324,'prod_estados_op','Add'),
(325,'prod_estados_op','Compose Email (usuario_ult_modificacion)'),
(326,'prod_estados_op','Delete'),
(327,'prod_estados_op','Edit'),
(328,'prod_estados_op','View Ref (Empresa)'),
(329,'prod_ordenes_consumos','Avanzar Estado Consumo'),
(330,'prod_ordenes_consumos','Avanzar Estado Consumo retro'),
(331,'prod_ordenes_consumos','Delete 4'),
(332,'prod_ordenes_consumos','est cambiar estado consumo'),
(333,'prod_ordenes_consumos','Add'),
(334,'prod_ordenes_consumos','Compose Email (usuario_ult_modificacion)'),
(335,'prod_ordenes_consumos','Delete'),
(336,'prod_ordenes_consumos','Edit'),
(337,'prod_ordenes_consumos','View Ref (bodega)'),
(338,'prod_ordenes_consumos','View Ref (empresa)'),
(339,'prod_ordenes_consumos','View Ref (estado_consumo)'),
(340,'prod_ordenes_consumos','View Ref (Fase)'),
(341,'prod_ordenes_consumos','View Ref (Procedimiento Base)'),
(342,'prod_ordenes_consumos','View Ref (uid_detalle)'),
(343,'prod_ordenes_consumos','View Ref (uid_orden)'),
(344,'prod_ordenes_consumos','View Ref (Unidad base Tiempo)'),
(345,'prod_ordenes_consumos','View Ref (Unidad)'),
(346,'prod_ordenes_detalles','consum copiar detalle a consumos'),
(347,'prod_ordenes_detalles','Delete 3'),
(348,'prod_ordenes_detalles','reemplazar uid_orden det'),
(349,'prod_ordenes_detalles','Add'),
(350,'prod_ordenes_detalles','Compose Email (usuario_creador)'),
(351,'prod_ordenes_detalles','Compose Email (usuario_ult_modificacion)'),
(352,'prod_ordenes_detalles','Delete'),
(353,'prod_ordenes_detalles','Edit'),
(354,'prod_ordenes_detalles','View Ref (empresa)'),
(355,'prod_ordenes_detalles','View Ref (fase)'),
(356,'prod_ordenes_detalles','View Ref (Procedimiento Base)'),
(357,'prod_ordenes_detalles','View Ref (uid_orden)'),
(358,'prod_ordenes_detalles','View Ref (Unidad base de Tiempo)'),
(359,'prod_ordenes_detalles','View Ref (unidad)'),
(360,'prod_ordenes_encabezados','Adicionar Lote'),
(361,'prod_ordenes_encabezados','borrar consumo y lote adicional'),
(362,'prod_ordenes_encabezados','borrar consumos y lotes adicionales'),
(363,'prod_ordenes_encabezados','Cancelar OP'),
(364,'prod_ordenes_encabezados','consum borrar consumos actuales'),
(365,'prod_ordenes_encabezados','consum Crear consumos'),
(366,'prod_ordenes_encabezados','consum crear consumos en op'),
(367,'prod_ordenes_encabezados','Consumo Adicional crear'),
(368,'prod_ordenes_encabezados','Consumo Adicional grupo'),
(369,'prod_ordenes_encabezados','Consumo Adicional reestablecer'),
(370,'prod_ordenes_encabezados','det borrar copiar_de'),
(371,'prod_ordenes_encabezados','det borrar detalles actuales'),
(372,'prod_ordenes_encabezados','det Crear detalles'),
(373,'prod_ordenes_encabezados','det crear detalles consum en op'),
(374,'prod_ordenes_encabezados','det crear detalles hmtas en op'),
(375,'prod_ordenes_encabezados','det crear detalles mo en op'),
(376,'prod_ordenes_encabezados','det crear detalles mp en op'),
(377,'prod_ordenes_encabezados','det crear detalles pp en op'),
(378,'prod_ordenes_encabezados','det poner flag copiar_de'),
(379,'prod_ordenes_encabezados','det poner uid_orden en detalles'),
(380,'prod_ordenes_encabezados','est Avanzar Estado grupo'),
(381,'prod_ordenes_encabezados','est cambiar estado op'),
(382,'prod_ordenes_encabezados','est estados consumos'),
(383,'prod_ordenes_encabezados','est estados lotes'),
(384,'prod_ordenes_encabezados','lot borrar lotes actuales'),
(385,'prod_ordenes_encabezados','lot Crear lotes'),
(386,'prod_ordenes_encabezados','lot crear lotes en op'),
(387,'prod_ordenes_encabezados','lote Adicional crear'),
(388,'prod_ordenes_encabezados','lote Adicional grupo'),
(389,'prod_ordenes_encabezados','lote Adicional reestablecer'),
(390,'prod_ordenes_encabezados','Pausar OP'),
(391,'prod_ordenes_encabezados','Pausar Reanudar OP'),
(392,'prod_ordenes_encabezados','Rechazar OP'),
(393,'prod_ordenes_encabezados','result crear resultantes en op'),
(394,'prod_ordenes_encabezados','result poner uid_orden en result antes'),
(395,'prod_ordenes_encabezados','result borrar copiar_de'),
(396,'prod_ordenes_encabezados','result borrar resultantes actuales'),
(397,'prod_ordenes_encabezados','result Crear Resultantes'),
(398,'prod_ordenes_encabezados','result poner flag copiar_de'),
(399,'prod_ordenes_encabezados','Add'),
(400,'prod_ordenes_encabezados','Compose Email (usuario_creador)'),
(401,'prod_ordenes_encabezados','Compose Email (usuario_ult_modificacion)'),
(402,'prod_ordenes_encabezados','Delete'),
(403,'prod_ordenes_encabezados','Edit'),
(404,'prod_ordenes_encabezados','View Ref (area)'),
(405,'prod_ordenes_encabezados','View Ref (bodega_consumos)'),
(406,'prod_ordenes_encabezados','View Ref (bodega_lotes)'),
(407,'prod_ordenes_encabezados','View Ref (empresa)'),
(408,'prod_ordenes_encabezados','View Ref (estado)'),
(409,'prod_ordenes_encabezados','View Ref (lote_producto_adicional)'),
(410,'prod_ordenes_encabezados','View Ref (responsable_auxiliar)'),
(411,'prod_ordenes_encabezados','View Ref (responsable_principal)'),
(412,'prod_ordenes_encabezados','View Ref (tipo_op)'),
(413,'prod_ordenes_encabezados','View Ref (uid_procedimiento_base)'),
(414,'prod_ordenes_encabezados','View Ref (Unidad)'),
(415,'prod_ordenes_lotes','Avanzar Estado lote'),
(416,'prod_ordenes_lotes','Avanzar Estado lote aprobar'),
(417,'prod_ordenes_lotes','Avanzar Estado lote rechazar'),
(418,'prod_ordenes_lotes','Avanzar Estado lote retro'),
(419,'prod_ordenes_lotes','Avanzar Estado lote reversar aprobación'),
(420,'prod_ordenes_lotes','Delete lot'),
(421,'prod_ordenes_lotes','est cambiar estado lote'),
(422,'prod_ordenes_lotes','Add'),
(423,'prod_ordenes_lotes','Compose Email (responsable_revision)'),
(424,'prod_ordenes_lotes','Compose Email (usuario_ult_modificacion)'),
(425,'prod_ordenes_lotes','Delete'),
(426,'prod_ordenes_lotes','Edit'),
(427,'prod_ordenes_lotes','View Ref (bodega_destino)'),
(428,'prod_ordenes_lotes','View Ref (empresa)'),
(429,'prod_ordenes_lotes','View Ref (estado_lote)'),
(430,'prod_ordenes_lotes','View Ref (uid_orden)'),
(431,'prod_ordenes_lotes','View Ref (uid_producto)'),
(432,'prod_ordenes_resultantes','Delete 2'),
(433,'prod_ordenes_resultantes','lot copiar resultantes a lotes'),
(434,'prod_ordenes_resultantes','reemplazar uid_orden'),
(435,'prod_ordenes_resultantes','Add'),
(436,'prod_ordenes_resultantes','Compose Email (usuario_ult_modificacion)'),
(437,'prod_ordenes_resultantes','Delete'),
(438,'prod_ordenes_resultantes','Edit'),
(439,'prod_ordenes_resultantes','View Ref (empresa)'),
(440,'prod_ordenes_resultantes','View Ref (uid_orden)'),
(441,'prod_ordenes_resultantes','View Ref (uid_producto)'),
(442,'prod_ordenes_resultantes','View Ref (unidad)'),
(443,'prod_ordenes_trazabilidad','Add'),
(444,'prod_ordenes_trazabilidad','Delete'),
(445,'prod_ordenes_trazabilidad','Edit'),
(446,'prod_ordenes_trazabilidad','View Ref (empresa)'),
(447,'prod_ordenes_trazabilidad','View Ref (uid_orden)'),
(448,'prod_tipos_orden','Add'),
(449,'prod_tipos_orden','Compose Email (usuario_creador)'),
(450,'prod_tipos_orden','Compose Email (usuario_ult_modificacion)'),
(451,'prod_tipos_orden','Delete'),
(452,'prod_tipos_orden','Edit'),
(453,'prod_tipos_orden','View Ref (empresa)'),
(454,'sys_areas','Add'),
(455,'sys_areas','Compose Email (usuario_ult_modificacion)'),
(456,'sys_areas','Delete'),
(457,'sys_areas','Edit'),
(458,'sys_empresa','Exportar a CVS 19'),
(459,'sys_empresa','Add'),
(460,'sys_empresa','Compose Email (email)'),
(461,'sys_empresa','Compose Email (usuario_ult_modificacion)'),
(462,'sys_empresa','Delete'),
(463,'sys_empresa','Edit'),
(464,'sys_permisos','Add'),
(465,'sys_permisos','Delete'),
(466,'sys_permisos','Edit'),
(467,'sys_permisos_campos','Add'),
(468,'sys_permisos_campos','Compose Email (usuario_ult_modificacion)'),
(469,'sys_permisos_campos','Delete'),
(470,'sys_permisos_campos','Edit'),
(471,'sys_permisos_campos','View Ref (empresa)'),
(472,'sys_usuarios','Actualizar'),
(473,'sys_usuarios','Actualizar 1'),
(474,'sys_usuarios','Actualizar 2'),
(475,'sys_usuarios','Exportar a CVS 21'),
(476,'sys_usuarios','Add'),
(477,'sys_usuarios','Compose Email (Email)'),
(478,'sys_usuarios','Compose Email (usuario_ult_modificacion)'),
(479,'sys_usuarios','Delete'),
(480,'sys_usuarios','Edit'),
(481,'sys_usuarios','View Ref (ultima_empresa)'),
(482,'sys_usuarios_empresas','Exportar a CVS 22'),
(483,'sys_usuarios_empresas','Add'),
(484,'sys_usuarios_empresas','Compose Email (usuario_ult_modificacion)'),
(485,'sys_usuarios_empresas','Delete'),
(486,'sys_usuarios_empresas','Edit'),
(487,'sys_usuarios_empresas','View Ref (empresa)'),
(488,'sys_usuarios_empresas','View Ref (usuario)');
/*!40000 ALTER TABLE `sys_acciones` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `sys_areas`
--

LOCK TABLES `sys_areas` WRITE;
/*!40000 ALTER TABLE `sys_areas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sys_areas` VALUES
('1','Ori_Sil_2','Producción','Operativa','Procesos de transformación de materias primas en productos terminados',1,NULL,'Activa','','larevo1111@gmail.com','2025-10-20 18:56:01','2026-01-24 14:18:52'),
('10','Ori_Sil_2','Finanzas y Contabilidad','Administrativa','Control financiero y registros contables',0,NULL,'Activa','','','2025-10-20 18:56:01','2025-10-20 18:56:01'),
('2','Ori_Sil_2','Empaque y Etiquetado','Operativa','Empaque, etiquetado y control de presentación final de los productos',0,NULL,'Activa','','','2025-10-20 18:56:01','2025-10-20 18:56:01'),
('3','Ori_Sil_2','Control de Calidad','Operativa','Verificación de estándares, inocuidad y cumplimiento de procedimientos',0,NULL,'Activa','','','2025-10-20 18:56:01','2025-10-20 18:56:01'),
('4','Ori_Sil_2','Mantenimiento de Equipos','Soporte','Mantenimiento preventivo y correctivo de maquinaria y herramientas',0,NULL,'Activa','','','2025-10-20 18:56:01','2025-10-20 18:56:01'),
('5','Ori_Sil_2','Limpieza y Sanitación','Soporte','Limpieza y desinfección de áreas, utensilios y equipos',0,NULL,'Activa','','','2025-10-20 18:56:01','2025-10-20 18:56:01'),
('6','Ori_Sil_2','Inventarios y Bodega','Logística','Gestión de materias primas, insumos y productos terminados',0,NULL,'Activa','','','2025-10-20 18:56:01','2025-10-20 18:56:01'),
('7','Ori_Sil_2','Logística y Despacho','Logística','Transporte, despacho y recepción de productos',0,NULL,'Activa','','','2025-10-20 18:56:01','2025-10-20 18:56:01'),
('8','Ori_Sil_2','Comercial y Ventas','Administrativa','Gestión de clientes, pedidos y distribución',0,NULL,'Activa','','','2025-10-20 18:56:01','2025-10-20 18:56:01'),
('9','Ori_Sil_2','Compras y Proveedores','Administrativa','Abastecimiento y relación con proveedores',0,NULL,'Activa','','','2025-10-20 18:56:01','2025-10-20 18:56:01');
/*!40000 ALTER TABLE `sys_areas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `sys_banderas`
--

LOCK TABLES `sys_banderas` WRITE;
/*!40000 ALTER TABLE `sys_banderas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sys_banderas` VALUES
('7225f627','sys_permisos_campos','Generar registros campos','ejecutada'),
('SB_MAESTRA_CONSUMIBLES','costos_consumibles','ACTUALIZAR_COSTOS_MAESTRA_CONSUMIBLES',NULL),
('SB_MAESTRA_HERRAMIENTAS','costos_herramientas','ACTUALIZAR_COSTOS_MAESTRA_HERRAMIENTAS','IDLE'),
('SB_MAESTRA_MP','costos_mp_insumos','ACTUALIZAR_COSTOS_MAESTRA_MP','IDLE'),
('SB_MAESTRA_PRODUCTOS','costos_encabezados_productos','ACTUALIZAR_COSTOS_MAESTRA_PRODUCTOS','IDLE'),
('SB_MAESTRA_SERVICIOS','costos_servicios_mo','ACTUALIZAR_COSTOS_MAESTRA_SERVICIOS','IDLE'),
('SB_MAESTRAS_TODAS','maestras_costos_todas','ACTUALIZAR_COSTOS_MAESTRAS_TODAS','IDLE'),
('SB_PROCEDIMIENTO','costos_procedimientos','ACTUALIZAR_COSTOS_PROCEDIMIENTO','IDLE');
/*!40000 ALTER TABLE `sys_banderas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `sys_empresa`
--

LOCK TABLES `sys_empresa` WRITE;
/*!40000 ALTER TABLE `sys_empresa` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sys_empresa` VALUES
('La_Tie_3','La Tierrita',NULL,NULL,'LT','',NULL,NULL,NULL,'PRODUCTIVA',NULL,NULL,NULL,NULL,'',0,0,0,0,0,0,0,0,'larevo1111@gmail.com','larevo1111@gmail.com','2025-08-12 21:05:58','2025-08-12 21:05:58'),
('Ori_Sil_2','Origen Silvestre','NIT','901753603-0','OS','origensilvestre.col@gmail.com','3214550933','Medellin',NULL,'TRANSFORMADORA',NULL,NULL,'Activa',NULL,NULL,0,0,0,0,0,0,0,0,'larevo1111@gmail.com','larevo1111@gmail.com','2025-08-12 14:02:46','2025-08-12 19:12:08');
/*!40000 ALTER TABLE `sys_empresa` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `sys_permisos`
--

LOCK TABLES `sys_permisos` WRITE;
/*!40000 ALTER TABLE `sys_permisos` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sys_permisos` VALUES
('PRODUCCION_CALIDAD','CALIDAD','PRODUCCION',0,1,NULL),
('PRODUCCION_CONSULTA','CONSULTA','PRODUCCION',0,1,NULL),
('PRODUCCION_OPERADOR','OPERADOR','PRODUCCION',0,1,NULL),
('PRODUCCION_SUPERUSUARIO','SUPERUSUARIO','PRODUCCION',1,1,NULL),
('PRODUCCION_SUPERVISOR','SUPERVISOR','PRODUCCION',0,1,NULL);
/*!40000 ALTER TABLE `sys_permisos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `sys_permisos_acciones`
--

LOCK TABLES `sys_permisos_acciones` WRITE;
/*!40000 ALTER TABLE `sys_permisos_acciones` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sys_permisos_acciones` VALUES
('02bWJ50pWvUbiBG9','costos_procedimientos_consumibles','o.disminuir.set.rows pconsum','costos_procedimientos_consumibles||o.disminuir.set.rows pconsum','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('0hqthcTKkzCO4vhU','costos_herramientas','View Ref (Empresa)','costos_herramientas||View Ref (Empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('0oeQ2hqmjGLDnEUE','costos_formulas','o.aumentar.acciones','costos_formulas||o.aumentar.acciones','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('0rrPPabEtUUJkRwg','costos_grupos_productos','Agregar Productos a Grupo','costos_grupos_productos||Agregar Productos a Grupo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('0U0I5s4zbpoDU66F','costos_encabezados_productos','Open File (archivo_3)','costos_encabezados_productos||Open File (archivo_3)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('0XWtt57S2T7Uuht0','costos_encabezados_productos','asignar grupo','costos_encabezados_productos||asignar grupo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('0zKTMDtdoMIklG7k','costos_procedimientos_consumibles','View Ref (Empresa)','costos_procedimientos_consumibles||View Ref (Empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('0ZlH7xmQ57Xrh7Hp','costos_mp_insumos','View Ref (Empresa)','costos_mp_insumos||View Ref (Empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('10oIR3Pj1yIwGHSG','prod_estados_op','Edit','prod_estados_op||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('1cE6XZC75kCsqinx','costos_procedimientos_consumibles','Actualizar todos los Vlr Un 2','costos_procedimientos_consumibles||Actualizar todos los Vlr Un 2','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('1DKx5MDMXoxPSKDY','sys_permisos_campos','Add','sys_permisos_campos||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('1dq0zRsWBz1x4UJk','costos_procedimientos_servicios_mo','o.disminuir.col.menos pmo','costos_procedimientos_servicios_mo||o.disminuir.col.menos pmo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('1eEBENwQTdurXknm','costos_procedimientos_consumibles','Delete','costos_procedimientos_consumibles||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('1iI91ed3jzuuTL1R','costos_encabezados_productos','Open Url (video_2)','costos_encabezados_productos||Open Url (video_2)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('1mc8GQmKMSac7VPl','sys_usuarios_empresas','Compose Email (usuario_ult_modificacion)','sys_usuarios_empresas||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('1p9TQ8wuMpXE25Lr','prod_ordenes_lotes','View Ref (bodega_destino)','prod_ordenes_lotes||View Ref (bodega_destino)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('1qoE14l4nTfSFJkU','costos_unidades','Delete','costos_unidades||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('1ZrU1qibTlnSsab6','costos_categorias','Add','costos_categorias||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:05:47','2025-12-13 06:05:47',NULL,NULL),
('23Ky5qsWrpQun6jS','sys_areas','Edit','sys_areas||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('241ylx8B4fam9Y4C','costos_formulas','Exportar a CVS 4','costos_formulas||Exportar a CVS 4','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('2C1w93x8XRyw7ROx','costos_procedimientos_herramientas','Compose Email (usuario_creador)','costos_procedimientos_herramientas||Compose Email (usuario_creador)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('2hgeSCv6L99BHmy8','prod_ordenes_encabezados','View Ref (lote_producto_adicional)','prod_ordenes_encabezados||View Ref (lote_producto_adicional)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('2i4eekIL8B5zlfNI','prod_ordenes_encabezados','lote Adicional crear','prod_ordenes_encabezados||lote Adicional crear','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('2jaI0XhLILjpR3rC','costos_procedimientos_herramientas','Actualizar todos los Vlr Un 3','costos_procedimientos_herramientas||Actualizar todos los Vlr Un 3','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('2jBFalrYj1XNUPcx','costos_procedimientos_consumibles','View Ref (uid_consumible)','costos_procedimientos_consumibles||View Ref (uid_consumible)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('2JDuUo4AidTGi6n7','prod_ordenes_encabezados','result borrar resultantes actuales','prod_ordenes_encabezados||result borrar resultantes actuales','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('2KbaE3Q1w7Sye2RG','costos_producto_procedimientos','result copiar producto a ordenes','costos_producto_procedimientos||result copiar producto a ordenes','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('2ndnMOJ7E1QJgFb0','prod_ordenes_consumos','View Ref (Unidad)','prod_ordenes_consumos||View Ref (Unidad)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('2osugPdmWpr3SB02','costos_formulas','View Ref (uid_producto_resultante)','costos_formulas||View Ref (uid_producto_resultante)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('2RzPR0vl6cD3j1Gh','costos_mp_insumos','Open File (archivo3)','costos_mp_insumos||Open File (archivo3)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('2tGrxh7JEbaly7DD','costos_herramientas','Delete','costos_herramientas||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('39aadam0QeujqoC9','costos_fases','Add','costos_fases||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('3EMUOZmSW2dfk9E1','costos_fases','Delete','costos_fases||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('3J9sGiYa7ISqPXhM','sys_usuarios','View Ref (ultima_empresa)','sys_usuarios||View Ref (ultima_empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('3sjCl8327cT4F1Mg','costos_formulas','Copiar esta fórmula al destino','costos_formulas||Copiar esta fórmula al destino','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('43EE5vpempLpc9xI','prod_ordenes_trazabilidad','Edit','prod_ordenes_trazabilidad||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('467DNIwn7DkfuXCw','costos_procedimientos_servicios_mo','View Ref (Empresa)','costos_procedimientos_servicios_mo||View Ref (Empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('467Wb1Ukc05gIcs0','costos_producto_procedimientos','Ver Procedimiento','costos_producto_procedimientos||Ver Procedimiento','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('4AabgImrecQMijaS','prod_estados_op','View Ref (Empresa)','prod_estados_op||View Ref (Empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('4BPgj89iSlmfsSSC','costos_producto_procedimientos','o.disminuir.col.menos cpp','costos_producto_procedimientos||o.disminuir.col.menos cpp','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('4hJXNCB7geNdZltm','prod_ordenes_encabezados','det Crear detalles','prod_ordenes_encabezados||det Crear detalles','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('4iO8ymbdTL4AYiJb','prod_ordenes_detalles','consum copiar detalle a consumos','prod_ordenes_detalles||consum copiar detalle a consumos','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('4lJYEYLPeQtA8XW8','prod_ordenes_detalles','View Ref (empresa)','prod_ordenes_detalles||View Ref (empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('4qjyV859wqzCS5Tn','prod_ordenes_encabezados','result poner uid_orden en result antes','prod_ordenes_encabezados||result poner uid_orden en result antes','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('4RZ1NvRMhvRZuJCU','costos_procedimientos_mp_insumos','Compose Email (usuario_ult_modificacion)','costos_procedimientos_mp_insumos||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('4SirIZ6jhJ06GrIY','costos_formulas','o.disminuir.col.menos','costos_formulas||o.disminuir.col.menos','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('58aBR2LKzC4peRAW','costos_procedimientos_imag_vid','View Ref (uid_procedimiento)','costos_procedimientos_imag_vid||View Ref (uid_procedimiento)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('5Box1PAuyVqoCkbr','costos_procedimientos_mp_insumos','Compose Email (usuario_creador)','costos_procedimientos_mp_insumos||Compose Email (usuario_creador)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('5ERAyDXWV3EcBhcJ','costos_unidades_tipos','Delete','costos_unidades_tipos||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('5KN1tpNpZeqYu0bh','costos_producto_procedimientos','Add','costos_producto_procedimientos||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('5PE8P4lUDxiatt76','costos_producto_procedimientos','o.disminuir.col.mas cpp','costos_producto_procedimientos||o.disminuir.col.mas cpp','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('5qA0hgjPNdmsySfW','costos_procedimientos_pp','Actualizar este Vlr Un 4','costos_procedimientos_pp||Actualizar este Vlr Un 4','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('5vE2Vznao6tvKuvx','prod_ordenes_encabezados','det crear detalles consum en op','prod_ordenes_encabezados||det crear detalles consum en op','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('5zAxBX99bF42dlGv','costos_herramientas','Compose Email (usuario_creador)','costos_herramientas||Compose Email (usuario_creador)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('638lwgAm1t3qgL7I','costos_unidades','Add','costos_unidades||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('68gKxDOTriaHz5SO','prod_ordenes_consumos','View Ref (uid_detalle)','prod_ordenes_consumos||View Ref (uid_detalle)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('6f1aDlvEtoM15TXI','sys_permisos_campos','View Ref (empresa)','sys_permisos_campos||View Ref (empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('6GhIxOKgsO0Eppna','costos_tipos_procedimientos','Compose Email (usuario_ult_modificacion)','costos_tipos_procedimientos||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('6HljmJbbmnXxTrT3','costos_tipos_procedimientos','View Ref (Empresa)','costos_tipos_procedimientos||View Ref (Empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('6qLNJBvzcd2MQ5EE','prod_ordenes_consumos','View Ref (bodega)','prod_ordenes_consumos||View Ref (bodega)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('6RHLZKipXASmAnkW','prod_ordenes_encabezados','result crear resultantes en op','prod_ordenes_encabezados||result crear resultantes en op','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('6VgAEgHcMeb9TRZs','costos_consumibles','Exportar a CVS 2','costos_consumibles||Exportar a CVS 2','PRODUCCION_CONSULTA','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:54:06',NULL,NULL),
('6XpyBxbzBh17GhIW','costos_tipos_procedimientos','Edit','costos_tipos_procedimientos||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('6yIgQfipnQ6HofKq','costos_encabezados_productos','Copiar proc producto','costos_encabezados_productos||Copiar proc producto','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('70aYlZarz9EjiucY','costos_grupos_productos','Edit','costos_grupos_productos||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('73slnNti4LTer1ln','costos_procedimientos_herramientas','Actualizar todos los Vlr Un 6','costos_procedimientos_herramientas||Actualizar todos los Vlr Un 6','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('7Ajpo8tL8Jj2TAKO','prod_ordenes_encabezados','Edit','prod_ordenes_encabezados||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('7hXVZtX0BOyYDTpG','prod_ordenes_detalles','Delete 3','prod_ordenes_detalles||Delete 3','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('7jf2iTEbsTrHhXpU','costos_procedimientos_consumibles','o.disminuir.col.menos pconsum','costos_procedimientos_consumibles||o.disminuir.col.menos pconsum','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('7jGxJGFRl5vC4XZE','prod_ordenes_detalles','View Ref (fase)','prod_ordenes_detalles||View Ref (fase)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('7KDafkc9t8QQCVVi','costos_consumibles','Compose Email (usuario_ult_modificacion)','costos_consumibles||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('7KIhoKaOZ30D9GnV','costos_encabezados_productos','Open File (archivo_2)','costos_encabezados_productos||Open File (archivo_2)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('7PxTc2xFvFM9GhKz','prod_ordenes_encabezados','Consumo Adicional reestablecer','prod_ordenes_encabezados||Consumo Adicional reestablecer','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('8ALEa0C8OH9z2XaO','costos_procedimientos_herramientas','det copiar hmta a ordenes','costos_procedimientos_herramientas||det copiar hmta a ordenes','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('8ejLTl9QPDKdBVS1','costos_procedimientos_herramientas','Delete','costos_procedimientos_herramientas||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('8ErXbfiEISMlJwy8','prod_ordenes_encabezados','View Ref (bodega_lotes)','prod_ordenes_encabezados||View Ref (bodega_lotes)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('8hBNWm4F7EvKFzOt','costos_procedimientos_mp_insumos','Add','costos_procedimientos_mp_insumos||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('8JQgSxYOPwksixKP','costos_encabezados_productos','Exportar a CVS 3','costos_encabezados_productos||Exportar a CVS 3','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('8tjn4Wo7HPXrSAT1','costos_procedimientos','Copiar proc pp procedimiento','costos_procedimientos||Copiar proc pp procedimiento','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('93yiYHQjpdrIk8Gk','costos_consumibles','Open File (Archivo_3)','costos_consumibles||Open File (Archivo_3)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('9aa0e95a','costos_categorias','Compose Email (usuario_ult_modificacion)','costos_categorias||Compose Email (usuario_ult_modificacion)','PRODUCCION_CONSULTA','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 01:05:22','2025-12-13 06:54:06','VisibleIF acciones copiado (3) - 13/12/2025 1:54:06','costos_consumibles||Add , costos_consumibles||Delete , costos_consumibles||Exportar a CVS 2'),
('9BSH56AHdnqaZLca','costos_procedimientos_pp','o.disminuir.col.menos pprodproc','costos_procedimientos_pp||o.disminuir.col.menos pprodproc','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('9LAO5OHRGgr8gF3Z','costos_procedimientos_mp_insumos','Exportar a CVS 12','costos_procedimientos_mp_insumos||Exportar a CVS 12','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('9lQ22MoXX4WoI2wR','costos_formulas','Edit','costos_formulas||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('9PRZPA2hAxhqEsNy','prod_ordenes_lotes','View Ref (empresa)','prod_ordenes_lotes||View Ref (empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('9tMaG1F2A7wkqtZg','costos_consumibles','Edit','costos_consumibles||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('A9QfCxh785DmugGh','costos_procedimientos_imag_vid','Delete','costos_procedimientos_imag_vid||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('AaSMimmwJDF1mDU4','costos_grupos_productos','Open File (archivo_1)','costos_grupos_productos||Open File (archivo_1)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('abFQAUJyo89QymGs','costos_formulas','Delete','costos_formulas||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('acm2Ik9H7DEsvnxk','costos_procedimientos_consumibles','Compose Email (usuario_creador)','costos_procedimientos_consumibles||Compose Email (usuario_creador)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('aEF129iadRQDHmJc','costos_procedimientos_servicios_mo','det copiar mo a ordenes','costos_procedimientos_servicios_mo||det copiar mo a ordenes','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('AePrvRx9TRSOjNLD','inv_bodegas','View Ref (responsable)','inv_bodegas||View Ref (responsable)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Af6ctyoRagwNVrKN','prod_ordenes_lotes','Delete lot','prod_ordenes_lotes||Delete lot','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('aGHDUOxbaPXGGvE5','costos_encabezados_productos','Copiar Encabezados Productos','costos_encabezados_productos||Copiar Encabezados Productos','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('AHevEyGmlMXNVPkV','sys_permisos_campos','Compose Email (usuario_ult_modificacion)','sys_permisos_campos||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ak24tPlLNJmuRU3h','costos_mp_insumos','View Ref (categoria)','costos_mp_insumos||View Ref (categoria)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('alOpieQG2IlGCqJL','prod_ordenes_consumos','Compose Email (usuario_ult_modificacion)','prod_ordenes_consumos||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('AMSXxeHM5blkQ1aF','prod_ordenes_encabezados','lote Adicional reestablecer','prod_ordenes_encabezados||lote Adicional reestablecer','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('AO3WffBbJ3k3Zt55','sys_usuarios','Compose Email (usuario_ult_modificacion)','sys_usuarios||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('AooxBX8bBZwybN4P','costos_encabezados_productos','View Ref (Empresa)','costos_encabezados_productos||View Ref (Empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('apWlBMW1hvjpTS45','costos_procedimientos_consumibles','det copiar consumible a ordenes','costos_procedimientos_consumibles||det copiar consumible a ordenes','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('aq6BzdA2JYtPOhtx','costos_procedimientos_pp','Compose Email (usuario_creador)','costos_procedimientos_pp||Compose Email (usuario_creador)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('aqfiEcLHfC3EFN7b','costos_procedimientos','Copiar proc img grupo','costos_procedimientos||Copiar proc img grupo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ayXNAKPt17PaRrlT','costos_procedimientos_servicios_mo','Compose Email (usuario_creador)','costos_procedimientos_servicios_mo||Compose Email (usuario_creador)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('b6cfevf7jUU20HAD','costos_herramientas','Exportar a CVS 6','costos_herramientas||Exportar a CVS 6','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('bBS5pLtoT7h4VqTL','prod_ordenes_encabezados','View Ref (responsable_auxiliar)','prod_ordenes_encabezados||View Ref (responsable_auxiliar)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Bd0czqFaCPORsGxI','prod_ordenes_resultantes','Delete','prod_ordenes_resultantes||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('BGa1w7YYhFdAKiP2','costos_procedimientos_herramientas','Ver herramienta','costos_procedimientos_herramientas||Ver herramienta','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('BmPHVIJ7ICdHLAHj','prod_ordenes_encabezados','View Ref (tipo_op)','prod_ordenes_encabezados||View Ref (tipo_op)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('BnonkfPH2xjsAGJf','sys_usuarios_empresas','Edit','sys_usuarios_empresas||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Bo4JrbzZfUSWUnYp','costos_producto_procedimientos','Compose Email (usuario_creador)','costos_producto_procedimientos||Compose Email (usuario_creador)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('BpBS2QUrsM9N0o32','costos_procedimientos_servicios_mo','o.disminuir.set.rows pmo','costos_procedimientos_servicios_mo||o.disminuir.set.rows pmo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('bQKbxzSAmLmt7opE','costos_procedimientos_mp_insumos','Actualizar este Vlr Un','costos_procedimientos_mp_insumos||Actualizar este Vlr Un','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('BQXZlF5naVtwrlCi','prod_ordenes_encabezados','Adicionar Lote','prod_ordenes_encabezados||Adicionar Lote','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('BUBY0Qrd5yTap6rn','costos_encabezados_productos','Compose Email (Usuario_aprobador_prod)','costos_encabezados_productos||Compose Email (Usuario_aprobador_prod)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('bUGVL7m7mfnHpg4U','costos_procedimientos_consumibles','View Ref (unidad)','costos_procedimientos_consumibles||View Ref (unidad)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Bvs5b1JxrTwycfnR','costos_procedimientos','Compose Email (usuario_creador)','costos_procedimientos||Compose Email (usuario_creador)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('bvyzmPCbAXmjKvva','costos_procedimientos_servicios_mo','Ver Servicio MO','costos_procedimientos_servicios_mo||Ver Servicio MO','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('bWLqQrblrOTlX5Lu','sys_usuarios_empresas','Delete','sys_usuarios_empresas||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('BxEkW8OTvQpjBUCe','costos_servicios_mo','Compose Email (usuario_ult_modificacion)','costos_servicios_mo||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('c3Pg83xirrCIfRrC','prod_ordenes_encabezados','View Ref (bodega_consumos)','prod_ordenes_encabezados||View Ref (bodega_consumos)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ceDcB2p7kPoXE4by','prod_ordenes_resultantes','reemplazar uid_orden','prod_ordenes_resultantes||reemplazar uid_orden','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('CfSoqGvBh9EPV3Os','costos_encabezados_productos','Edit','costos_encabezados_productos||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('CguDQuRieiDzdGXC','costos_procedimientos_pp','Actualizar todos los Vlr Un 8','costos_procedimientos_pp||Actualizar todos los Vlr Un 8','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('CgypPndugOiL6wQX','costos_servicios_mo','View Ref (categoria)','costos_servicios_mo||View Ref (categoria)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Cjnrm3PPJYM6Ngzr','prod_estados_op','Compose Email (usuario_ult_modificacion)','prod_estados_op||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('cmDzal4vtB0Z8DwC','costos_procedimientos_servicios_mo','Edit','costos_procedimientos_servicios_mo||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('CMRPJuFXyUsyKw5R','prod_ordenes_encabezados','borrar consumo y lote adicional','prod_ordenes_encabezados||borrar consumo y lote adicional','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('coRyq5uBj6vctqpy','costos_procedimientos','Open File (video_ppal)','costos_procedimientos||Open File (video_ppal)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('coZy4uxsSvyCPbPL','prod_ordenes_encabezados','det borrar detalles actuales','prod_ordenes_encabezados||det borrar detalles actuales','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Cp9mUiARZVGDxad1','costos_unidades','View Ref (tipo_unidad)','costos_unidades||View Ref (tipo_unidad)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('CRyvm5ZMCcU6T1Yu','prod_ordenes_consumos','View Ref (empresa)','prod_ordenes_consumos||View Ref (empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('CwkmfqOmlSpJoM77','prod_ordenes_detalles','reemplazar uid_orden det','prod_ordenes_detalles||reemplazar uid_orden det','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('cWV3PKvCcf9C5RWt','costos_encabezados_productos','Open File (archivo_1)','costos_encabezados_productos||Open File (archivo_1)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('cZRahcgfHLiIdM8M','costos_procedimientos_servicios_mo','View Ref (uid_servicio_mo)','costos_procedimientos_servicios_mo||View Ref (uid_servicio_mo)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('D04cERB4Ijxv3tR4','prod_ordenes_consumos','Delete','prod_ordenes_consumos||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('D2cemD8ytOIeidMt','costos_grupos_productos','limpiar agregar productos','costos_grupos_productos||limpiar agregar productos','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('DAssLYdW6gqyQ341','sys_usuarios_empresas','Exportar a CVS 22','sys_usuarios_empresas||Exportar a CVS 22','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('DI6ERW1Olb2yUB8f','costos_procedimientos_imag_vid','View Ref (fase)','costos_procedimientos_imag_vid||View Ref (fase)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('dJvG4EwCpW7nJiBN','sys_areas','Compose Email (usuario_ult_modificacion)','sys_areas||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('dk4df4Fgl2RDw2ag','costos_procedimientos_imag_vid','Open Url (url_video)','costos_procedimientos_imag_vid||Open Url (url_video)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Dl3taPdxaoeWonfM','costos_grupos_productos','Delete','costos_grupos_productos||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('DnLJOxlPi9Zq4pEb','costos_encabezados_productos','View Ref (Grupo)','costos_encabezados_productos||View Ref (Grupo)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('DQ9Vp1jYTNgu4Ln5','costos_procedimientos_servicios_mo','Actualizar este Vlr Un 5','costos_procedimientos_servicios_mo||Actualizar este Vlr Un 5','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('DqeDlBFuhkrMfbfq','costos_encabezados_productos','Copiar formulas producto','costos_encabezados_productos||Copiar formulas producto','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('DRv2SJC3abGoox6R','prod_ordenes_lotes','Edit','prod_ordenes_lotes||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('dUXFlTs9NGNCP8C1','prod_ordenes_encabezados','View Ref (uid_procedimiento_base)','prod_ordenes_encabezados||View Ref (uid_procedimiento_base)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Dw9zrfMFJ2Xcjshl','costos_procedimientos_mp_insumos','View Ref (Empresa)','costos_procedimientos_mp_insumos||View Ref (Empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('DXpkxVO4glKGuxWC','costos_procedimientos_consumibles','o.disminuir.col.mas pconsum','costos_procedimientos_consumibles||o.disminuir.col.mas pconsum','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('DyXlo9QUmWhVZlJs','prod_ordenes_consumos','Delete 4','prod_ordenes_consumos||Delete 4','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('E630WYCJWVNrybLt','prod_ordenes_lotes','Avanzar Estado lote retro','prod_ordenes_lotes||Avanzar Estado lote retro','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('EHYil0GEmzuT8PqR','costos_herramientas','Copiar maestra herramientas','costos_herramientas||Copiar maestra herramientas','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ei7ECFTYOF6PIrlz','costos_procedimientos_servicios_mo','o.disminuir.acciones pmo','costos_procedimientos_servicios_mo||o.disminuir.acciones pmo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ej6N6feYJ6FF2CUn','costos_unidades','Edit','costos_unidades||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ESJdcSXrDXSGz7ky','costos_grupos_productos','asignar grupo a productos','costos_grupos_productos||asignar grupo a productos','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('EtQyTpCoGrNhZ5Tu','costos_herramientas','Edit','costos_herramientas||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('evAHiGty2Fk7Iepi','costos_procedimientos_pp','Ver procedimiento pp','costos_procedimientos_pp||Ver procedimiento pp','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('EYo6QiYZixYdo6gO','prod_ordenes_resultantes','Add','prod_ordenes_resultantes||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ezOaFni5Jpy1MPDi','sys_usuarios','Delete','sys_usuarios||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('f0EBo18aSOfsZDYt','prod_ordenes_encabezados','View Ref (estado)','prod_ordenes_encabezados||View Ref (estado)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('FdxS7C6afiKTui8F','prod_tipos_orden','View Ref (empresa)','prod_tipos_orden||View Ref (empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('fEeMmzRA8Mpp7aNP','prod_ordenes_detalles','Delete','prod_ordenes_detalles||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('fGaHXzl9bIkwDIoX','sys_empresa','Edit','sys_empresa||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('fJFmeSndG545ahCD','costos_procedimientos','Copiar proc serv grupo','costos_procedimientos||Copiar proc serv grupo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('fLtoWDX0rXGXfybq','menu_ppal','Go to App Link (link item)','menu_ppal||Go to App Link (link item)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('FP6MCpeaY1hMWSed','prod_ordenes_encabezados','borrar consumos y lotes adicionales','prod_ordenes_encabezados||borrar consumos y lotes adicionales','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('fSZC2MpQeCGVdjkE','costos_procedimientos_consumibles','Ver consumible','costos_procedimientos_consumibles||Ver consumible','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('G0ddjdxWw7ZZ3oLs','costos_herramientas','Open File (archivo1)','costos_herramientas||Open File (archivo1)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('g0J4WtCKUSQcaQMb','prod_tipos_orden','Compose Email (usuario_creador)','prod_tipos_orden||Compose Email (usuario_creador)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('g2bXdY7ONey5syQd','costos_procedimientos_imag_vid','Edit','costos_procedimientos_imag_vid||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('GDj80HxUDOLAjAV6','costos_procedimientos_consumibles','Add','costos_procedimientos_consumibles||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('gePEdCrGGgPR2XrO','prod_ordenes_encabezados','est cambiar estado op','prod_ordenes_encabezados||est cambiar estado op','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('GLeKCrKACNoxMS4P','costos_procedimientos_pp','Edit','costos_procedimientos_pp||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('govUVRMlUAvRlKfp','sys_permisos','Edit','sys_permisos||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('GpfO2wveh5WIajGt','costos_procedimientos_pp','View Ref (Empresa)','costos_procedimientos_pp||View Ref (Empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('gt6h6DINiTZDoOX3','costos_procedimientos_imag_vid','Open File (archivo)','costos_procedimientos_imag_vid||Open File (archivo)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('gt8QJIH0T4LrOIgW','costos_procedimientos_pp','View Ref (fase)','costos_procedimientos_pp||View Ref (fase)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('gTLTIY1dT4WFq6Nz','costos_etiquetas','Delete','costos_etiquetas||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('gVaHD5pxQgLfgpx3','prod_ordenes_resultantes','View Ref (empresa)','prod_ordenes_resultantes||View Ref (empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('gwZRsUAtktSfmp0b','sys_empresa','Compose Email (usuario_ult_modificacion)','sys_empresa||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('H096soAvcGFkPpQS','costos_procedimientos_herramientas','View Ref (unidad_consumo)','costos_procedimientos_herramientas||View Ref (unidad_consumo)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('h0kYUCtHJqQDa6is','costos_encabezados_productos','Delete','costos_encabezados_productos||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('h5A2c3Lc3PtKhVmm','costos_procedimientos_pp','o.disminuir.set.rows pprodproc','costos_procedimientos_pp||o.disminuir.set.rows pprodproc','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('hatGQHa1Cbkg2X0j','costos_formulas','Actualizar todos los Vlr Un formulas','costos_formulas||Actualizar todos los Vlr Un formulas','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Hc7p6rLZY6HO07zP','costos_procedimientos_mp_insumos','o.disminuir.acciones pmp','costos_procedimientos_mp_insumos||o.disminuir.acciones pmp','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('hD9bytNUNTyBYPtF','sys_empresa','Delete','sys_empresa||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('HfgqNavQVqxLEN5c','prod_ordenes_consumos','View Ref (Procedimiento Base)','prod_ordenes_consumos||View Ref (Procedimiento Base)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('hjgo1coMQUObxQ2u','costos_encabezados_productos','copiar formulas limpiar este row','costos_encabezados_productos||copiar formulas limpiar este row','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('hjxZ3dWlEWw9l3Dj','prod_tipos_orden','Edit','prod_tipos_orden||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('hmSk4vLkyjJJheDd','inv_bodegas','Edit','inv_bodegas||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('hOo3b2Lxbet7O5l7','inv_bodegas','View Ref (empresa)','inv_bodegas||View Ref (empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('hZUUyoCSDG1zLn3R','prod_ordenes_trazabilidad','Add','prod_ordenes_trazabilidad||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('I0uMQN3VpsGcNTvy','costos_procedimientos_imag_vid','Add','costos_procedimientos_imag_vid||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('i4bA4apnljpYzJoX','costos_formulas','o.disminuir.set.rows','costos_formulas||o.disminuir.set.rows','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('idWlVmz7fa7Zvbo9','costos_procedimientos_pp','Copiar esta proc pp al destino','costos_procedimientos_pp||Copiar esta proc pp al destino','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('iFN0eDF2NqflfpL6','costos_procedimientos','Copiar proc pp grupo','costos_procedimientos||Copiar proc pp grupo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('iG1pEG5LADC1GK03','costos_procedimientos_mp_insumos','View Ref (unidad)','costos_procedimientos_mp_insumos||View Ref (unidad)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('IGltdYVK8dJDEiw4','sys_permisos','Delete','sys_permisos||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ik2FPGSSCXWV96yp','costos_mp_insumos','Compose Email (usuario_ult_modificacion)','costos_mp_insumos||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('iMFu1S1q9fkjLT9t','prod_ordenes_encabezados','Consumo Adicional grupo','prod_ordenes_encabezados||Consumo Adicional grupo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('IMZEK387w8iKz9qG','costos_procedimientos_consumibles','Edit','costos_procedimientos_consumibles||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('inpA1lEzIJUHdedC','costos_procedimientos_mp_insumos','o.disminuir.col.mas cmp','costos_procedimientos_mp_insumos||o.disminuir.col.mas cmp','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ISgEZ3A9Toyz4Uk8','prod_ordenes_consumos','Avanzar Estado Consumo retro','prod_ordenes_consumos||Avanzar Estado Consumo retro','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('IWGXtJkqVeZ9VC3y','sys_usuarios','Add','sys_usuarios||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('IYevkMijYaB4rvAM','costos_procedimientos_mp_insumos','View Ref (uid_mp_insumo)','costos_procedimientos_mp_insumos||View Ref (uid_mp_insumo)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('IYvkanwSvCCgbLr9','costos_herramientas','View Ref (responsable)','costos_herramientas||View Ref (responsable)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('j0OscIL0fKM5ht0I','prod_ordenes_lotes','Delete','prod_ordenes_lotes||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('J7LgC0g2qEcFzqr1','costos_procedimientos','Copiar proc img procedimiento','costos_procedimientos||Copiar proc img procedimiento','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('JDe1LaygaTtUUtoy','prod_ordenes_trazabilidad','View Ref (empresa)','prod_ordenes_trazabilidad||View Ref (empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('jDn7inUSoJYnTfb0','sys_usuarios_empresas','View Ref (empresa)','sys_usuarios_empresas||View Ref (empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('JEKRfCSlD5vhZowk','costos_procedimientos_mp_insumos','Edit','costos_procedimientos_mp_insumos||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Jg4z2cniSa7DOAvl','costos_mp_insumos','Delete','costos_mp_insumos||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('JGTo6sKoJMeVLcw0','costos_formulas','View Ref (Empresa)','costos_formulas||View Ref (Empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Jhrn9fXZvp0QsjXJ','costos_grupos_productos','Compose Email (usuario_creador)','costos_grupos_productos||Compose Email (usuario_creador)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('jk3CibYD1Omp5gdI','costos_procedimientos','Exportar a CVS 8','costos_procedimientos||Exportar a CVS 8','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('JknTai8UNHY3PJ25','costos_procedimientos_servicios_mo','Add','costos_procedimientos_servicios_mo||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('jqfNOA1xrN0tO6XN','costos_servicios_mo','View Ref (unidad)','costos_servicios_mo||View Ref (unidad)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('JsrEckytLIomx6ON','costos_herramientas','Open File (archivo2)','costos_herramientas||Open File (archivo2)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Jt6nOz9ixwUAzgl1','costos_producto_procedimientos','View Ref (uid_producto)','costos_producto_procedimientos||View Ref (uid_producto)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('JTFQquFX032tEqcM','costos_procedimientos_herramientas','o.disminuir.set.rows phmtas','costos_procedimientos_herramientas||o.disminuir.set.rows phmtas','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('JvudkpWWml0R9koB','costos_encabezados_productos','View Ref (Unidad)','costos_encabezados_productos||View Ref (Unidad)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('JVxeb94GaM7leGnA','prod_ordenes_encabezados','lot Crear lotes','prod_ordenes_encabezados||lot Crear lotes','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('jWxF2QHjc4FirF9J','costos_unidades_tipos','View Ref (unidad_estandar)','costos_unidades_tipos||View Ref (unidad_estandar)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('k1BafepeJfjfg7am','costos_procedimientos','View Ref (Empresa)','costos_procedimientos||View Ref (Empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('K1uIvHQshvOKVenS','costos_mp_insumos','Edit','costos_mp_insumos||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('K2nwPYbNvg0l3W2Z','costos_procedimientos_pp','View Ref (unidad)','costos_procedimientos_pp||View Ref (unidad)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('K7HdTZiy8Un7iehO','prod_ordenes_encabezados','det crear detalles pp en op','prod_ordenes_encabezados||det crear detalles pp en op','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('K7mZYeZxcLmLVpYU','sys_usuarios','Actualizar 1','sys_usuarios||Actualizar 1','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('k7tKm53PZmSFSLTt','costos_producto_procedimientos','Ver Procedimiento 2','costos_producto_procedimientos||Ver Procedimiento 2','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('kcU017LrYjnRPSqF','prod_ordenes_encabezados','det crear detalles mo en op','prod_ordenes_encabezados||det crear detalles mo en op','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('KCWmOJFecBUzgZO7','costos_grupos_productos','limpiar agregar productos todos','costos_grupos_productos||limpiar agregar productos todos','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('kD2L0a0Yz3q3fzoK','costos_procedimientos_pp','View Ref (uid_producto_pp)','costos_procedimientos_pp||View Ref (uid_producto_pp)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('kD4oBWrGvLTXlvLt','costos_mp_insumos','View Ref (unidad)','costos_mp_insumos||View Ref (unidad)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ki0AtohBFx0AGgPa','costos_procedimientos_pp','o.disminuir.col.mas pprodproc','costos_procedimientos_pp||o.disminuir.col.mas pprodproc','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Kj7oWQpNdytSE3E7','inv_bodegas','Compose Email (usuario_ult_modificacion)','inv_bodegas||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('KJAscvOYoGNMhI19','costos_procedimientos','Compose Email (usuario_ult_modificacion)','costos_procedimientos||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('kn8gGQbxy5qcrTky','prod_ordenes_encabezados','View Ref (Unidad)','prod_ordenes_encabezados||View Ref (Unidad)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('KPW89tuiLNM8koLW','costos_procedimientos','Edit','costos_procedimientos||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('kq4ySJG2b2TaaQO4','prod_ordenes_encabezados','Consumo Adicional crear','prod_ordenes_encabezados||Consumo Adicional crear','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('KSCixP1hFhnvwHwG','costos_procedimientos_pp','Exportar a CVS 13','costos_procedimientos_pp||Exportar a CVS 13','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('KUmDivNqVHb51F6r','prod_ordenes_resultantes','View Ref (unidad)','prod_ordenes_resultantes||View Ref (unidad)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('kwhsxq6MuhGl2tIe','prod_ordenes_lotes','View Ref (uid_orden)','prod_ordenes_lotes||View Ref (uid_orden)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('L1eDUZtmOpk0IAmc','prod_estados_op','Delete','prod_estados_op||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('l8MsLPsJ9RZCZKj1','costos_procedimientos_pp','o.disminuir.acciones pprodproc','costos_procedimientos_pp||o.disminuir.acciones pprodproc','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('L8z0dOtNUrL8cj6P','prod_ordenes_encabezados','det crear detalles hmtas en op','prod_ordenes_encabezados||det crear detalles hmtas en op','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('LeF5YtzA00zhFdtH','costos_encabezados_productos','Copiar formulas grupo','costos_encabezados_productos||Copiar formulas grupo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('leha8E1dBxDpY57s','costos_consumibles','Open File (Archivo_1)','costos_consumibles||Open File (Archivo_1)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('lh6Xd1eAnrL8lLnV','costos_procedimientos_servicios_mo','o.disminuir.col.mas pmo','costos_procedimientos_servicios_mo||o.disminuir.col.mas pmo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('lkdzpHxiYIPs1W3q','costos_encabezados_productos','View Ref (Categoria)','costos_encabezados_productos||View Ref (Categoria)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Ll6aHDVxeRHCooIj','costos_servicios_mo','View Ref (Empresa)','costos_servicios_mo||View Ref (Empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('LNYYKZwqC8Hc6257','costos_producto_procedimientos','Ver Producto','costos_producto_procedimientos||Ver Producto','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('lpWO8UGF20hosMeq','prod_ordenes_encabezados','Add','prod_ordenes_encabezados||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('LQyglPXbL3DbCmyh','costos_encabezados_productos','Add','costos_encabezados_productos||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('LswmUbjXFxSOmUvc','costos_procedimientos_pp','Actualizar todos los Vlr Un 4','costos_procedimientos_pp||Actualizar todos los Vlr Un 4','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ltzPiLg94Qj7CQCC','prod_ordenes_consumos','Edit','prod_ordenes_consumos||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('LvkVvb5Kzn5QhpGG','prod_ordenes_encabezados','lote Adicional grupo','prod_ordenes_encabezados||lote Adicional grupo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('lX1mudqyDyB2f3DI','costos_procedimientos_mp_insumos','Actualizar todos los Vlr Un','costos_procedimientos_mp_insumos||Actualizar todos los Vlr Un','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('m2mUJntIpWAQpFoy','costos_encabezados_productos','Compose Email (usuario_ult_modificacion)','costos_encabezados_productos||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('M634SYuVjBubnKHg','costos_procedimientos_consumibles','View Ref (uid_procedimiento)','costos_procedimientos_consumibles||View Ref (uid_procedimiento)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('M6Ax3ssVfdNRoqgy','costos_procedimientos','Copiar proc mp procedimiento','costos_procedimientos||Copiar proc mp procedimiento','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('M7juiw4UP1yxZ6vx','costos_mp_insumos','Copiar maestra mp insumos','costos_mp_insumos||Copiar maestra mp insumos','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('m7xOJQIPNrCH2A6U','costos_procedimientos_imag_vid','Copiar esta proc img al destino','costos_procedimientos_imag_vid||Copiar esta proc img al destino','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('MAH8bp7dSmCLwvRX','costos_producto_procedimientos','Delete','costos_producto_procedimientos||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('mAiP2NSE0TtweFVq','costos_procedimientos_pp','Delete','costos_procedimientos_pp||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('MAK0JAl18p9BKKKJ','costos_procedimientos_pp','View Ref (Unidad procedimiento)','costos_procedimientos_pp||View Ref (Unidad procedimiento)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('mcKmcOf2NZfF9rxn','costos_fases','View Ref (empresa)','costos_fases||View Ref (empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('MCSqk9hmGVP7sCwm','costos_procedimientos_herramientas','View Ref (uid_procedimiento)','costos_procedimientos_herramientas||View Ref (uid_procedimiento)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('mdIAhV0imKGsp9RS','sys_usuarios','Compose Email (Email)','sys_usuarios||Compose Email (Email)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('MGbObpSuESBPhyzM','costos_procedimientos_herramientas','o.disminuir.col.mas phmtas','costos_procedimientos_herramientas||o.disminuir.col.mas phmtas','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('mitNTkyFza84SWNe','costos_procedimientos','copiar proc consum limpiar est row','costos_procedimientos||copiar proc consum limpiar est row','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('mJlvZcxpyAKodnOw','costos_procedimientos_imag_vid','Open File (video)','costos_procedimientos_imag_vid||Open File (video)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('mkzfDvTei7NvpPWm','sys_areas','Add','sys_areas||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Ml7oWdBCywT7Sbhs','costos_herramientas','Open File (archivo3)','costos_herramientas||Open File (archivo3)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('mL7ZQ8OhBfyPT7SD','costos_mp_insumos','Compose Email (usuario_creador)','costos_mp_insumos||Compose Email (usuario_creador)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('MlHOlP3OobGf4us4','costos_formulas','Compose Email (usuario_creador)','costos_formulas||Compose Email (usuario_creador)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('mO0jlqhAHbBR3krP','prod_ordenes_encabezados','Compose Email (usuario_creador)','prod_ordenes_encabezados||Compose Email (usuario_creador)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('MoZapgc0Bol8wGJu','costos_procedimientos_consumibles','Exportar a CVS 9','costos_procedimientos_consumibles||Exportar a CVS 9','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('mPAVxrdvM9Df6EjL','prod_ordenes_encabezados','Compose Email (usuario_ult_modificacion)','prod_ordenes_encabezados||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('mqmnBt9BJ9lE0aTm','costos_producto_procedimientos','View Ref (Empresa)','costos_producto_procedimientos||View Ref (Empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('MqsaBOX7r6uX4hjW','costos_formulas','Compose Email (usuario_ult_actualizacion)','costos_formulas||Compose Email (usuario_ult_actualizacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('mRfTOq297gI9vUJu','costos_procedimientos_herramientas','o.disminuir.col.menos phmtas','costos_procedimientos_herramientas||o.disminuir.col.menos phmtas','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('MT4VLC0xm3YPPDtT','costos_unidades_tipos','View Ref (empresa)','costos_unidades_tipos||View Ref (empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('MUp4lLBqR4SgC8fw','costos_procedimientos_mp_insumos','View Ref (Unidad del Procedimiento)','costos_procedimientos_mp_insumos||View Ref (Unidad del Procedimiento)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('n3KPloeiXXrVoKsb','costos_procedimientos_consumibles','Compose Email (usuario_ult_modificacion)','costos_procedimientos_consumibles||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('n8kt4P5lEGoom9M7','costos_formulas','o.disminuir.col.mas','costos_formulas||o.disminuir.col.mas','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('NaRrbAeAx4pPewfB','costos_procedimientos_servicios_mo','Exportar a CVS 14','costos_procedimientos_servicios_mo||Exportar a CVS 14','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('NDmDckpgm9hrJWL6','costos_procedimientos','Copiar proc TODO grupo','costos_procedimientos||Copiar proc TODO grupo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('NF7PcsqGjXPuOHtr','costos_procedimientos_herramientas','Edit','costos_procedimientos_herramientas||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('NGJck2Y6kQG6CQFl','costos_procedimientos_consumibles','View Ref (fase)','costos_procedimientos_consumibles||View Ref (fase)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('NgUy684DlGbb6IUM','sys_empresa','Add','sys_empresa||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('NhirUQaDAObL5zSc','prod_ordenes_lotes','View Ref (estado_lote)','prod_ordenes_lotes||View Ref (estado_lote)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('njAnt9wbo6FIYs3e','costos_procedimientos_consumibles','View Ref (Unidad del procedimiento)','costos_procedimientos_consumibles||View Ref (Unidad del procedimiento)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('nkb1kpf1NCQLwyZU','sys_empresa','Compose Email (email)','sys_empresa||Compose Email (email)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('NkBa2WkEXsIXRVOH','costos_procedimientos_imag_vid','Compose Email (usuario_ult_modificacion)','costos_procedimientos_imag_vid||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('NmzQ3474aRLnPKqx','costos_procedimientos','View Ref (Tipo_Procedimiento)','costos_procedimientos||View Ref (Tipo_Procedimiento)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Nnmxwdy2qbHaL5f1','prod_ordenes_consumos','View Ref (estado_consumo)','prod_ordenes_consumos||View Ref (estado_consumo)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('noEoCxJWa0mct7sd','menu_ppal','Add','menu_ppal||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('NPIq4ONDkx31ZZeZ','prod_ordenes_lotes','Compose Email (responsable_revision)','prod_ordenes_lotes||Compose Email (responsable_revision)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('nrhtjAGrqGFixt5y','costos_procedimientos_servicios_mo','View Ref (Unidad Base)','costos_procedimientos_servicios_mo||View Ref (Unidad Base)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('nSxJejC3dM01gjum','costos_procedimientos_pp','Add','costos_procedimientos_pp||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('NtITepQQq3NwsffE','costos_formulas','Ver Articulo','costos_formulas||Ver Articulo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('NUQxKzi74RjvDm6P','costos_procedimientos_herramientas','Copiar esta proc hmtas al destino','costos_procedimientos_herramientas||Copiar esta proc hmtas al destino','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('NUUwphsxTfx5Dq7y','costos_servicios_mo','Copiar maestra mo servicios','costos_servicios_mo||Copiar maestra mo servicios','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('nWRgj0FjhwtHw1TJ','costos_procedimientos_herramientas','Actualizar este Vlr Un 3','costos_procedimientos_herramientas||Actualizar este Vlr Un 3','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('o8mVZEgnoFMy3gl2','costos_procedimientos_herramientas','Compose Email (usuario_ult_modificacion)','costos_procedimientos_herramientas||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('O9zyBa7sdzP8mvoQ','prod_estados_op','Add','prod_estados_op||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Odhq1vBOWeOdDI0l','costos_formulas','View Ref (unidad)','costos_formulas||View Ref (unidad)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('oG18Dx8st5r4Gccx','prod_ordenes_encabezados','Rechazar OP','prod_ordenes_encabezados||Rechazar OP','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('OMZZHUMVMmL6bJqJ','costos_procedimientos_herramientas','Add','costos_procedimientos_herramientas||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('onHlJBV4DMgkQOfw','costos_procedimientos_mp_insumos','View Ref (fase)','costos_procedimientos_mp_insumos||View Ref (fase)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ONkv9eoJwqj6suTa','costos_categorias','Delete','costos_categorias||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:05:47','2025-12-13 06:05:47',NULL,NULL),
('onpy2RkL1qEnlouI','costos_procedimientos_herramientas','View Ref (Unidad del Procedimiento)','costos_procedimientos_herramientas||View Ref (Unidad del Procedimiento)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('OnTFHMfv6aktrLI8','prod_tipos_orden','Delete','prod_tipos_orden||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ORb00jNRM0yk5fB2','sys_permisos_campos','Delete','sys_permisos_campos||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('oSFxP6l3x2PFYUKp','costos_formulas','Abrir artículo','costos_formulas||Abrir artículo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('oSgLAk8WOAzxYBnq','prod_ordenes_encabezados','est estados consumos','prod_ordenes_encabezados||est estados consumos','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('oX073iJTSgYskf34','costos_procedimientos','Copiar proc hmtas grupo','costos_procedimientos||Copiar proc hmtas grupo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('oY4jbkBSk7nINoYR','costos_procedimientos_mp_insumos','View Ref (uid_procedimiento)','costos_procedimientos_mp_insumos||View Ref (uid_procedimiento)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('OYMFjW2ZnwSuH3N2','menu_ppal','Edit','menu_ppal||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ozkdvtZ3zNj6mPRg','prod_ordenes_encabezados','det crear detalles mp en op','prod_ordenes_encabezados||det crear detalles mp en op','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('P1jDZApBhajuJUUK','prod_ordenes_encabezados','View Ref (responsable_principal)','prod_ordenes_encabezados||View Ref (responsable_principal)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('p37yPizh23tYHMQw','prod_ordenes_lotes','Avanzar Estado lote aprobar','prod_ordenes_lotes||Avanzar Estado lote aprobar','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('P3mR03PWeivLhERD','costos_procedimientos_mp_insumos','Delete','costos_procedimientos_mp_insumos||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('P6yCuFye9hGvACje','costos_etiquetas','Edit','costos_etiquetas||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('paIsz2c0h9dYAVle','costos_procedimientos_imag_vid','Exportar a CVS 11','costos_procedimientos_imag_vid||Exportar a CVS 11','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('pBuEdkVLqYjo8wJl','costos_herramientas','View Ref (categoria)','costos_herramientas||View Ref (categoria)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Pdnk5yPhiEs7YcJL','costos_procedimientos_herramientas','View Ref (fase)','costos_procedimientos_herramientas||View Ref (fase)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('pHUfmxdQzQe8sCDz','prod_ordenes_detalles','View Ref (uid_orden)','prod_ordenes_detalles||View Ref (uid_orden)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('PHV18AbuRRDx9LNN','costos_grupos_productos','Exportar a CVS 5','costos_grupos_productos||Exportar a CVS 5','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('pjzHA65khE7QDfP6','costos_servicios_mo','Exportar a CVS 16','costos_servicios_mo||Exportar a CVS 16','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('plOqcuxMia1ESK2N','prod_ordenes_consumos','View Ref (Unidad base Tiempo)','prod_ordenes_consumos||View Ref (Unidad base Tiempo)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('pMpI76JHmeSDbNdz','costos_herramientas','Compose Email (usuario_ult_modificacion)','costos_herramientas||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('poV3L2RLDRV7Ol3n','costos_procedimientos_herramientas','o.disminuir.acciones phmtas','costos_procedimientos_herramientas||o.disminuir.acciones phmtas','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('PPy83PZW4xGIgcr4','prod_ordenes_encabezados','consum crear consumos en op','prod_ordenes_encabezados||consum crear consumos en op','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('PUWBiBifGFgFU8Bo','costos_procedimientos_mp_insumos','Copiar esta proc mp al destino','costos_procedimientos_mp_insumos||Copiar esta proc mp al destino','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('pYMcxPsjQ1gCXMhd','costos_formulas','Actualizar este Vlr Un formulas','costos_formulas||Actualizar este Vlr Un formulas','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Q3GVhgAbtW7ammGR','costos_servicios_mo','Edit','costos_servicios_mo||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Q4FhZNQXMHNNEMvA','prod_ordenes_detalles','Compose Email (usuario_creador)','prod_ordenes_detalles||Compose Email (usuario_creador)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('q4ujLOqbMlE6e0Oj','prod_ordenes_lotes','Add','prod_ordenes_lotes||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('qaA0P9bfu2iSmxtk','costos_consumibles','Delete','costos_consumibles||Delete','PRODUCCION_CONSULTA','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:54:06',NULL,NULL),
('QaD6cvjgtLEY7kIi','sys_usuarios_empresas','Add','sys_usuarios_empresas||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('qboakGRDU3C2Xuwb','costos_procedimientos','Copiar proc consum procedimiento','costos_procedimientos||Copiar proc consum procedimiento','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('qBVyMfXw00AARtVO','costos_procedimientos_pp','Compose Email (usuario_ult_modificacion)','costos_procedimientos_pp||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Qchtudeg6jylgRUs','costos_consumibles','View Ref (unidad)','costos_consumibles||View Ref (unidad)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('qClvZ5jOwIqEryeo','prod_ordenes_detalles','View Ref (unidad)','prod_ordenes_detalles||View Ref (unidad)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Qdym0xKV21fKtxJ1','costos_producto_procedimientos','o.disminuir.acciones cpp','costos_producto_procedimientos||o.disminuir.acciones cpp','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('qEH64HhKvtSDqqSp','costos_herramientas','Add','costos_herramientas||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('qKZffl2OOiw0kj9R','prod_ordenes_encabezados','consum Crear consumos','prod_ordenes_encabezados||consum Crear consumos','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('QNTOHNwBaRwQZyFd','costos_mp_insumos','Open File (archivo2)','costos_mp_insumos||Open File (archivo2)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('QS9Kl730PY76OHzL','prod_ordenes_encabezados','result poner flag copiar_de','prod_ordenes_encabezados||result poner flag copiar_de','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('QtYY5Y5D3OLJfifZ','prod_ordenes_encabezados','est estados lotes','prod_ordenes_encabezados||est estados lotes','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('QutUl1YsCMP5btl8','costos_grupos_productos','View Ref (Empresa)','costos_grupos_productos||View Ref (Empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('r8A8ok58YW3e1D7J','costos_procedimientos_consumibles','Actualizar todos los Vlr Un 10','costos_procedimientos_consumibles||Actualizar todos los Vlr Un 10','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('r9hWOGNcy7EpjNqg','costos_procedimientos_servicios_mo','View Ref (unidad)','costos_procedimientos_servicios_mo||View Ref (unidad)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('rcjHhCJBe9n2Byyq','costos_procedimientos_imag_vid','Open Url (url_general)','costos_procedimientos_imag_vid||Open Url (url_general)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('RgiRw5MIyRIZOVJm','menu_ppal','Delete','menu_ppal||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('RIazJW1YdmAfCUbJ','sys_permisos','Add','sys_permisos||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('rK5hIKimPQMuudPA','prod_ordenes_encabezados','Delete','prod_ordenes_encabezados||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('rKXNOCiffZJaLreB','costos_procedimientos_servicios_mo','Compose Email (usuario_ult_modificacion)','costos_procedimientos_servicios_mo||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Rnps1QHqaLghbKn3','costos_servicios_mo','Delete','costos_servicios_mo||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('RO2ca0ZYE8MSiNbS','costos_encabezados_productos','Copiar proc grupo','costos_encabezados_productos||Copiar proc grupo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('rqC7KTo0t98CbuMF','costos_consumibles','Copiar maestra consumible','costos_consumibles||Copiar maestra consumible','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('rQS0f6Iv8rhOdJPH','prod_ordenes_lotes','Avanzar Estado lote rechazar','prod_ordenes_lotes||Avanzar Estado lote rechazar','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('RwqQKmSJo7sKFcHo','costos_procedimientos_servicios_mo','View Ref (uid_procedimiento)','costos_procedimientos_servicios_mo||View Ref (uid_procedimiento)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('rXG1XFHiLoXkPWx1','costos_producto_procedimientos','o.disminuir.set.rows cpp','costos_producto_procedimientos||o.disminuir.set.rows cpp','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('RXVBmJDGfLrWQZpN','costos_consumibles','Add','costos_consumibles||Add','PRODUCCION_CONSULTA','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:54:06',NULL,NULL),
('rxW8AV6YRXoqLSOg','prod_ordenes_encabezados','est Avanzar Estado grupo','prod_ordenes_encabezados||est Avanzar Estado grupo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('s4XE8UWhi7VFrfZ8','costos_procedimientos','Delete','costos_procedimientos||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('S55sL5CruCxzJNhf','sys_usuarios_empresas','View Ref (usuario)','sys_usuarios_empresas||View Ref (usuario)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('s6apwnEYmqLiWBFy','costos_producto_procedimientos','Ver Producto 2','costos_producto_procedimientos||Ver Producto 2','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('S7XIF21qVh5bVMhr','costos_procedimientos_servicios_mo','View Ref (Unidad del Procedimiento)','costos_procedimientos_servicios_mo||View Ref (Unidad del Procedimiento)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('sBXVHFCgiIqauaCG','costos_unidades_tipos','Compose Email (usuario_ult_modificacion)','costos_unidades_tipos||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('sC4cJnhr1OsmnDc1','costos_mp_insumos','Open File (archivo1)','costos_mp_insumos||Open File (archivo1)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('scd2tcl4lBmk5rxU','prod_ordenes_encabezados','Cancelar OP','prod_ordenes_encabezados||Cancelar OP','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('sgjRQbgq49gypvku','costos_mp_insumos','Exportar a CVS 7','costos_mp_insumos||Exportar a CVS 7','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Sheysa1KRcI0o1js','costos_unidades','Exportar a CVS 18','costos_unidades||Exportar a CVS 18','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ShN4XvRIetw6GC86','costos_grupos_productos','Add','costos_grupos_productos||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('shv9C3oBWCvpzzHC','prod_ordenes_encabezados','det borrar copiar_de','prod_ordenes_encabezados||det borrar copiar_de','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('SlV3KdCoaY2CLYRr','prod_ordenes_lotes','View Ref (uid_producto)','prod_ordenes_lotes||View Ref (uid_producto)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('SMJw3SDMKtj5lzt5','costos_encabezados_productos','copiar formulas limpiar de todos','costos_encabezados_productos||copiar formulas limpiar de todos','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('SMsSN2sz7RwezJBp','costos_procedimientos_mp_insumos','Actualizar todos los Vlr Un 7','costos_procedimientos_mp_insumos||Actualizar todos los Vlr Un 7','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('soTck9LFX28wYYGl','prod_ordenes_detalles','View Ref (Procedimiento Base)','prod_ordenes_detalles||View Ref (Procedimiento Base)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('St3pgtUAixOjGCJs','prod_ordenes_detalles','Edit','prod_ordenes_detalles||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Svl1IXGuxoWmh8Ir','costos_fases','Edit','costos_fases||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('SxVrONsvyqVICChV','prod_ordenes_encabezados','det poner uid_orden en detalles','prod_ordenes_encabezados||det poner uid_orden en detalles','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('SYGT7uGI1A17TxTA','costos_formulas','o.aumentar.set.rows','costos_formulas||o.aumentar.set.rows','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('t5oc6pZaZloLTxNn','prod_ordenes_trazabilidad','View Ref (uid_orden)','prod_ordenes_trazabilidad||View Ref (uid_orden)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('t8kjENbR9PkIuy4M','prod_ordenes_resultantes','Edit','prod_ordenes_resultantes||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('T8QkOs4ABWcCRkRc','costos_procedimientos','Copiar proc consum grupo','costos_procedimientos||Copiar proc consum grupo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('t9g6ZIMevCBXK7Fd','costos_etiquetas','Compose Email (usuario_ult_modificacion)','costos_etiquetas||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('tbIAWwgrIveux9kR','costos_consumibles','Open File (Archivo_2)','costos_consumibles||Open File (Archivo_2)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('tC8iuHAInD20bbzs','prod_ordenes_consumos','View Ref (uid_orden)','prod_ordenes_consumos||View Ref (uid_orden)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('tHUepUTVc5jG583m','costos_procedimientos_servicios_mo','View Ref (fase)','costos_procedimientos_servicios_mo||View Ref (fase)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('TiW99BzSmaozzFhS','prod_ordenes_resultantes','Delete 2','prod_ordenes_resultantes||Delete 2','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('tK7tzOrqnyE8l2kE','costos_grupos_productos','Open File (archivo_3)','costos_grupos_productos||Open File (archivo_3)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('TKwjvCPcDuNRkGPW','prod_ordenes_resultantes','Compose Email (usuario_ult_modificacion)','prod_ordenes_resultantes||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('tLxWZnPwEU10GkLA','costos_procedimientos','Add','costos_procedimientos||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('tsI7NCjJhNUE2fHV','sys_empresa','Exportar a CVS 19','sys_empresa||Exportar a CVS 19','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('tSjqtN4lOxuLNUjb','costos_encabezados_productos','Open Url (video_3)','costos_encabezados_productos||Open Url (video_3)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('tyeLJqFVM2XsHqQZ','costos_producto_procedimientos','Copiar este procedimiento a destino','costos_producto_procedimientos||Copiar este procedimiento a destino','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('u0HarHYyQ8ZdP4WA','costos_unidades_tipos','Add','costos_unidades_tipos||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('U3Aljm3uXN5BwDX8','prod_ordenes_trazabilidad','Delete','prod_ordenes_trazabilidad||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('UcUbgdgSPxwMStEk','costos_procedimientos_servicios_mo','Actualizar todos los Vlr Un 5','costos_procedimientos_servicios_mo||Actualizar todos los Vlr Un 5','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('UEiSFX6Dg6yAbInn','costos_unidades_tipos','Edit','costos_unidades_tipos||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('UI4cPd74GO8MyUIK','prod_ordenes_encabezados','Pausar OP','prod_ordenes_encabezados||Pausar OP','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('uJs6Bjl4NmZ0TI0W','costos_procedimientos','Copiar proc mp grupo','costos_procedimientos||Copiar proc mp grupo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('UKpLlHlmWKB4EfFa','costos_encabezados_productos','Open Url (video_1)','costos_encabezados_productos||Open Url (video_1)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('uLCTVWO6MzBico1n','costos_procedimientos_mp_insumos','det copiar mp a ordenes 2','costos_procedimientos_mp_insumos||det copiar mp a ordenes 2','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('UPnbH8YEATWhbodJ','costos_unidades','Compose Email (usuario_ult_modificacion)','costos_unidades||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ure1Jn7pTphzqPkE','prod_ordenes_encabezados','View Ref (empresa)','prod_ordenes_encabezados||View Ref (empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('URxDqCpedgZhmby8','costos_etiquetas','Add','costos_etiquetas||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('usa0ISgGT0TdXOAq','prod_ordenes_encabezados','result Crear Resultantes','prod_ordenes_encabezados||result Crear Resultantes','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('uve5CDjH7Rcxa8Ky','costos_procedimientos_consumibles','o.disminuir.acciones pconsum','costos_procedimientos_consumibles||o.disminuir.acciones pconsum','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('uVPeRiZZZFXjXyk2','costos_categorias','Exportar a CVS','costos_categorias||Exportar a CVS','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:05:47','2025-12-13 06:05:47',NULL,NULL),
('uYZ1qDf7wfxcQc20','inv_bodegas','Delete','inv_bodegas||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('UzU7ViBISviGgArN','costos_producto_procedimientos','Compose Email (usuario_ult_modificacion)','costos_producto_procedimientos||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('v1OJYpvmPApwsJPA','costos_formulas','o.disminuir.acciones','costos_formulas||o.disminuir.acciones','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('v3CSVhe5dH81sWVq','costos_categorias','Edit','costos_categorias||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:05:47','2025-12-13 06:05:47',NULL,NULL),
('vCI2ULAa9gfxiAKI','prod_ordenes_lotes','Avanzar Estado lote','prod_ordenes_lotes||Avanzar Estado lote','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('VekxjTlj10u2tI9n','costos_procedimientos','Copiar Encabezados Procedimientos','costos_procedimientos||Copiar Encabezados Procedimientos','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('VgTSfU7yEVuBCmgt','costos_procedimientos_mp_insumos','Ver mp_insumo','costos_procedimientos_mp_insumos||Ver mp_insumo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('VnW6p9aufowI8Tkd','prod_ordenes_encabezados','consum borrar consumos actuales','prod_ordenes_encabezados||consum borrar consumos actuales','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('VoVPor8aJKgQ7YRU','costos_mp_insumos','Add','costos_mp_insumos||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('vpH7qJfE2BTeRbzu','costos_procedimientos','copiar proc consum limpiar de todos','costos_procedimientos||copiar proc consum limpiar de todos','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('vqrQn68aXlek3iEd','costos_consumibles','View Ref (categoria)','costos_consumibles||View Ref (categoria)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('vse8NfgnhgS94WrP','prod_ordenes_lotes','Compose Email (usuario_ult_modificacion)','prod_ordenes_lotes||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('vtWYerLpzKKvBZTk','prod_ordenes_resultantes','lot copiar resultantes a lotes','prod_ordenes_resultantes||lot copiar resultantes a lotes','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('vv2jW6TduInAwtt1','costos_consumibles','View Ref (empresa)','costos_consumibles||View Ref (empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Vy7cmMt6jC1TC2Ar','prod_ordenes_lotes','est cambiar estado lote','prod_ordenes_lotes||est cambiar estado lote','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('vyDOmqUwpWLKUuQA','costos_procedimientos_servicios_mo','Copiar esta proc serv al destino','costos_procedimientos_servicios_mo||Copiar esta proc serv al destino','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('vYPWJwqStFseUqV1','sys_usuarios','Actualizar 2','sys_usuarios||Actualizar 2','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('vZGy8R55NPxxHDtn','prod_ordenes_consumos','View Ref (Fase)','prod_ordenes_consumos||View Ref (Fase)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('w3mI1xKpDA1x3BFH','sys_usuarios','Exportar a CVS 21','sys_usuarios||Exportar a CVS 21','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('W4q47r1u00IJ7I6y','costos_producto_procedimientos','View Ref (unidad)','costos_producto_procedimientos||View Ref (unidad)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('W6QUJUEUKRP4YdHK','costos_producto_procedimientos','Edit','costos_producto_procedimientos||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('w738OFMr9D3q7RVT','costos_procedimientos','View Ref (Copiar_de)','costos_procedimientos||View Ref (Copiar_de)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('wCNoNK70TWSXBNeL','costos_procedimientos','View Ref (unidad)','costos_procedimientos||View Ref (unidad)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('WhuUoum0cWOz2ugm','prod_tipos_orden','Add','prod_tipos_orden||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('WJ2yUsjjraOBilnR','costos_procedimientos_herramientas','Exportar a CVS 10','costos_procedimientos_herramientas||Exportar a CVS 10','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('wlO7nPkXE5nb1Bke','prod_ordenes_encabezados','det poner flag copiar_de','prod_ordenes_encabezados||det poner flag copiar_de','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('WlPjCFrPBQrAB1ot','costos_grupos_productos','Open File (archivo_2)','costos_grupos_productos||Open File (archivo_2)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('wmZXRDOU7xAEfNim','costos_procedimientos_mp_insumos','o.disminuir.col.menos pmp','costos_procedimientos_mp_insumos||o.disminuir.col.menos pmp','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('WNovLE3a7ela9J0q','costos_procedimientos','Copiar proc hmtas procedimiento','costos_procedimientos||Copiar proc hmtas procedimiento','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('wNx61rRmaODMpYkH','costos_procedimientos_herramientas','View Ref (Unidad Base)','costos_procedimientos_herramientas||View Ref (Unidad Base)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('wQTmwDfAqfRJZuzA','costos_procedimientos_mp_insumos','o.disminuir.set.rows pmp','costos_procedimientos_mp_insumos||o.disminuir.set.rows pmp','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('WSafBbjXrwAHVxSN','costos_formulas','Actualizar todos los Vlr Un formulas 2','costos_formulas||Actualizar todos los Vlr Un formulas 2','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('WsZ5sc9QOlPO7Sjc','sys_permisos_campos','Edit','sys_permisos_campos||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('WZzlJrEkM7JEFEWT','prod_ordenes_consumos','est cambiar estado consumo','prod_ordenes_consumos||est cambiar estado consumo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('x0GwgLWxyFRIzdBY','prod_ordenes_resultantes','View Ref (uid_producto)','prod_ordenes_resultantes||View Ref (uid_producto)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('X8QwFzsujvHaZSa7','prod_ordenes_encabezados','Pausar Reanudar OP','prod_ordenes_encabezados||Pausar Reanudar OP','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('XFx6HRnB1mqKuCWS','costos_unidades','View Ref (Empresa)','costos_unidades||View Ref (Empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('xHPftTEmQ45meqiZ','costos_procedimientos_herramientas','View Ref (Empresa)','costos_procedimientos_herramientas||View Ref (Empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('xJP4zpvHTyvGe3MI','prod_ordenes_consumos','Add','prod_ordenes_consumos||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('xmKbZjCQU4QDm11h','sys_usuarios','Actualizar','sys_usuarios||Actualizar','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('XNdvTptcSPuEQBqK','prod_ordenes_lotes','Avanzar Estado lote reversar aprobación','prod_ordenes_lotes||Avanzar Estado lote reversar aprobación','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('XPcJwDZKBjzWu3zd','costos_procedimientos_consumibles','Copiar esta proc consum al destino','costos_procedimientos_consumibles||Copiar esta proc consum al destino','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('xqms9PHhbDjPDZaL','prod_ordenes_detalles','Compose Email (usuario_ult_modificacion)','prod_ordenes_detalles||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('xrB8bsa7J03y3T89','prod_ordenes_detalles','Add','prod_ordenes_detalles||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Y3n5pFnvY9pWtN8g','prod_ordenes_encabezados','lot crear lotes en op','prod_ordenes_encabezados||lot crear lotes en op','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('y4505avxGoYejlSx','costos_procedimientos','Copiar proc serv procedimiento','costos_procedimientos||Copiar proc serv procedimiento','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Y7Oar9ZLwMdhyvYB','costos_tipos_procedimientos','Exportar a CVS 17','costos_tipos_procedimientos||Exportar a CVS 17','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Y7zHBOWpsvXClEuC','costos_procedimientos_servicios_mo','Actualizar todos los Vlr Un 9','costos_procedimientos_servicios_mo||Actualizar todos los Vlr Un 9','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('y84Eqa6Htm75Nfqg','costos_producto_procedimientos','View Ref (uid_procedimiento)','costos_producto_procedimientos||View Ref (uid_procedimiento)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('y8f2n87YEWn7NptH','prod_ordenes_encabezados','lot borrar lotes actuales','prod_ordenes_encabezados||lot borrar lotes actuales','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('y96Om2sGzzPwyLSr','costos_formulas','Add','costos_formulas||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('YAE1tNMEw3KwwmSo','prod_tipos_orden','Compose Email (usuario_ult_modificacion)','prod_tipos_orden||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('YaYEqKrnGepYqIQe','costos_servicios_mo','Add','costos_servicios_mo||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('YGbJuEPz9rkDZpU3','prod_ordenes_resultantes','View Ref (uid_orden)','prod_ordenes_resultantes||View Ref (uid_orden)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ygp019uNvLYzI7n2','costos_procedimientos_pp','View Ref (uid_procedimiento)','costos_procedimientos_pp||View Ref (uid_procedimiento)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('YiAea2m5cSJA5Rm7','sys_areas','Delete','sys_areas||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('yk0XRRLvrnWg7xxU','inv_bodegas','Add','inv_bodegas||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('YKKv73mxV1SE39UZ','costos_tipos_procedimientos','Delete','costos_tipos_procedimientos||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('YQPR1HAuuBcJ3Cxu','costos_grupos_productos','Compose Email (usuario_ult_modificacion)','costos_grupos_productos||Compose Email (usuario_ult_modificacion)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Yvre1Xz1aA5hGLXg','costos_procedimientos_servicios_mo','Delete','costos_procedimientos_servicios_mo||Delete','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('YVTrHHMhKK8IqQSI','prod_ordenes_encabezados','View Ref (area)','prod_ordenes_encabezados||View Ref (area)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('yXyC2UgPQI5NsJgD','costos_categorias','View Ref (Empresa)','costos_categorias||View Ref (Empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:05:47','2025-12-13 06:05:47',NULL,NULL),
('Yya8yk6qk6zYUzmi','costos_procedimientos_imag_vid','View Ref (Empresa)','costos_procedimientos_imag_vid||View Ref (Empresa)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Z2xasQPQCqU6bWf7','prod_ordenes_consumos','Avanzar Estado Consumo','prod_ordenes_consumos||Avanzar Estado Consumo','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('z3Pidz44DXoLrlMS','costos_procedimientos_consumibles','Actualizar este Vlr Un 2','costos_procedimientos_consumibles||Actualizar este Vlr Un 2','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('z73WK76MxavvxDei','costos_procedimientos_pp','det copiar pp a ordenes','costos_procedimientos_pp||det copiar pp a ordenes','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('zAtoT8EJP58gdq6d','prod_ordenes_encabezados','result borrar copiar_de','prod_ordenes_encabezados||result borrar copiar_de','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('Zcx8HqCiJJAFH9kA','costos_producto_procedimientos','Exportar a CVS 15','costos_producto_procedimientos||Exportar a CVS 15','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('zEfcWT1xlfqtA0n1','costos_procedimientos_herramientas','View Ref (uid_herramienta)','costos_procedimientos_herramientas||View Ref (uid_herramienta)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('zf2s8jLzwElf6wv5','sys_usuarios','Edit','sys_usuarios||Edit','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ZhpWhHOBMMlZy88e','costos_herramientas','View Ref (unidad_consumo)','costos_herramientas||View Ref (unidad_consumo)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ZicORffsQUg423dW','costos_tipos_procedimientos','Add','costos_tipos_procedimientos||Add','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL),
('ZpIQYP777l1vqnki','prod_ordenes_detalles','View Ref (Unidad base de Tiempo)','prod_ordenes_detalles||View Ref (Unidad base de Tiempo)','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:15:02','2025-12-13 06:15:02',NULL,NULL);
/*!40000 ALTER TABLE `sys_permisos_acciones` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `sys_permisos_campos`
--

LOCK TABLES `sys_permisos_campos` WRITE;
/*!40000 ALTER TABLE `sys_permisos_campos` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sys_permisos_campos` VALUES
('0n2Ro9OWhHTJeb9T','costos_categorias','id','costos_categorias||id','','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:26:06','2025-12-13 06:26:06',NULL,NULL),
('6164a712','costos_categorias','descripcion','costos_categorias||descripcion','PRODUCCION_OPERADOR',NULL,'Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 01:25:25','2025-12-13 06:26:06','Permisos campos tabla costos_categorias (9) - 13/12/2025 1:26:06',NULL),
('g0ekYK9Wo9KZxTIo','costos_categorias','tipo','costos_categorias||tipo','','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:26:06','2025-12-13 06:26:06',NULL,NULL),
('j0fT0AvSrl3clCaS','costos_categorias','usuario_creador','costos_categorias||usuario_creador','','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:26:06','2025-12-13 06:26:06',NULL,NULL),
('JGch4XMYjUhNHQBd','costos_categorias','fecha_ult_modificacion','costos_categorias||fecha_ult_modificacion','','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:26:06','2025-12-13 06:26:06',NULL,NULL),
('KP9OFzqcKqrgPVCK','costos_categorias','uid','costos_categorias||uid','','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:26:06','2025-12-13 06:26:06',NULL,NULL),
('ss5suMYQGMRnPJbx','costos_categorias','Empresa','costos_categorias||Empresa','','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:26:06','2025-12-13 06:26:06',NULL,NULL),
('Wicm9rPk51P5dHZn','costos_categorias','fecha_matricula','costos_categorias||fecha_matricula','','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:26:06','2025-12-13 06:26:06',NULL,NULL),
('WzTeRqqOCmCOXKU3','costos_categorias','categoria','costos_categorias||categoria','','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:26:06','2025-12-13 06:26:06',NULL,NULL),
('z8WNISJuM0zBCle0','costos_categorias','usuario_ult_modificacion','costos_categorias||usuario_ult_modificacion','','','Ori_Sil_2','larevo1111@gmail.com','larevo1111@gmail.com','2025-12-13 06:26:06','2025-12-13 06:26:06',NULL,NULL);
/*!40000 ALTER TABLE `sys_permisos_campos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `sys_roles`
--

LOCK TABLES `sys_roles` WRITE;
/*!40000 ALTER TABLE `sys_roles` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sys_roles` VALUES
('abastecimiento','Abastecimiento / Procurement','Abastecimiento estratégico de materiales',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('admin_sistema','Administrador del Sistema','Administración total del sistema y control maestro',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('auditoria','Auditoría','Auditoría interna y controles especiales',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('bodega_mp','Bodega – Materias Primas','Gestión y entrega de materias primas',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('bodega_pp','Bodega – Producto en Proceso','Administración y control de productos intermedios',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('bodega_pt','Bodega – Producto Terminado','Administración de inventario final y despachos internos',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('compras','Compras','Gestión de compras y proveedores',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('contabilidad','Contabilidad','Gestión contable general',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('control_calidad','Control de Calidad','Revisión, aprobación y rechazo de lotes y consumos',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('costos','Costos y Presupuestos','Análisis de costos productivos y financieros',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('cuentas_cobrar','Cuentas por Cobrar','Gestión de facturación y recaudo',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('cuentas_pagar','Cuentas por Pagar','Gestión de obligaciones y pagos',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('dir_operaciones','Director de Operaciones','Dirección y supervisión de todas las áreas operativas',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('externo_cliente','Externo – Cliente','Acceso limitado para clientes',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('externo_proveedor','Externo – Proveedor','Acceso limitado para proveedores',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('inventarios','Inventarios','Control y auditoría de inventarios',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('lectura','Solo Lectura','Permisos únicamente de visualización',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('logistica_despachos','Logística y Despachos','Preparación de pedidos y despachos externos',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('mantenimiento','Mantenimiento','Mantenimiento preventivo y correctivo de equipos',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('operaciones_produccion','Operaciones – Producción','Ejecución y registro de la producción y consumos',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('operaciones_servicios','Operaciones – Servicios / MO','Registro de mano de obra y servicios operativos',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('planeacion_produccion','Planeación de Producción','Planificación de órdenes y programación del trabajo',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('propietario_general','Propietario / Dirección General','Control total de la empresa y decisiones estratégicas',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('recursos_humanos','Recursos Humanos','Gestión de personal, nómina y procesos de RRHH',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('seguridad_sst','Seguridad y Salud en el Trabajo','Supervisión de seguridad industrial y SST',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('servicio_cliente','Servicio al Cliente','Atención y soporte al cliente',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('tesoreria','Tesorería','Gestión de caja, bancos y flujo financiero',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00'),
('ventas','Ventas / Comercial','Gestión de ventas y clientes',NULL,'Activo','Ori_Sil_2','system','system','2025-01-01 00:00:00','2025-01-01 00:00:00');
/*!40000 ALTER TABLE `sys_roles` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `sys_usuarios`
--

LOCK TABLES `sys_usuarios` WRITE;
/*!40000 ALTER TABLE `sys_usuarios` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sys_usuarios` VALUES
('amaragonzalez21valen@gmail.com','Deivy Gonzales',3,'PRODUCCION',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Activo',NULL,'',NULL,'larevo1111@gmail.com','2025-08-13 00:59:37','2025-12-05 06:35:02'),
('doblessas@gmail.com','Doble S',3,NULL,NULL,NULL,'Otro',NULL,'7777777',NULL,NULL,NULL,NULL,NULL,NULL,'','Activo',NULL,NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-12-08 00:50:26','2025-12-12 04:14:23'),
('jennifercanogarcia@gmail.com','Jenifer Cano',5,'COMERCIAL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Activo',NULL,'Ori_Sil_2',NULL,'larevo1111@gmail.com','2025-08-13 00:59:37','2025-12-05 06:35:08'),
('larevo1111@gmail.com','SYSOP',9,'DIRECCION GENERAL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Activo',NULL,'Ori_Sil_2',NULL,'larevo1111@gmail.com','2025-08-13 00:59:37','2025-12-06 06:31:05'),
('rialgar82@gmail.com','Ricardo Garcia',3,'PRODUCCION',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Activo',NULL,'',NULL,NULL,'2025-08-13 00:59:37','2025-12-05 06:35:30'),
('ssierra047@gmail.com','Santiago Sierra',9,'DIRECCION GENERAL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Activo',NULL,'',NULL,'larevo1111@gmail.com','2025-08-13 00:59:37','2025-12-05 06:35:24');
/*!40000 ALTER TABLE `sys_usuarios` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `sys_usuarios_empresas`
--

LOCK TABLES `sys_usuarios_empresas` WRITE;
/*!40000 ALTER TABLE `sys_usuarios_empresas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sys_usuarios_empresas` VALUES
('AMA_ORI_351','amaragonzalez21valen@gmail.com','Ori_Sil_2',3,'EDI-003',NULL,'Activo',NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-09-23 11:16:27','2025-09-23 11:16:27','amaragonzalez21valen@gmail.com||Ori_Sil_2'),
('DOB_ORI_099','doblessas@gmail.com','Ori_Sil_2',3,NULL,'PRODUCCION_OPERADOR','Activo',NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-12-08 00:51:49','2025-12-08 00:52:50','doblessas@gmail.com||Ori_Sil_2'),
('JEN_ORI_92E','jennifercanogarcia@gmail.com','Ori_Sil_2',5,'ADM-002',NULL,'Activo',NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-09-23 11:15:49','2025-09-23 11:15:49','jennifercanogarcia@gmail.com||Ori_Sil_2'),
('larevo1_2','larevo1111@gmail.com','Ori_Sil_2',9,'Admon','PRODUCCION_SUPERUSUARIO','Activo',NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-08-12 21:16:22','2025-12-05 04:36:38','larevo1111@gmail.com||Ori_Sil_2'),
('larevo1_La_Ti2','larevo1111@gmail.com','La_Tie_3',9,'admon',NULL,'Activo',NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-08-12 21:23:25','2025-08-12 21:23:25','larevo1111@gmail.com||La_Tie_3'),
('SSI_ORI_17B','ssierra047@gmail.com','Ori_Sil_2',7,'PRO-001','PRODUCCION_CALIDAD , PRODUCCION_CONSULTA , PRODUCCION_OPERADOR , PRODUCCION_SUPERUSUARIO','Activo',NULL,'larevo1111@gmail.com','larevo1111@gmail.com','2025-08-15 12:32:29','2025-12-05 03:09:26','ssierra047@gmail.com||Ori_Sil_2');
/*!40000 ALTER TABLE `sys_usuarios_empresas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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

-- Dump completed on 2026-02-27 21:41:54
