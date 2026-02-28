-- Script de Inicialización SOS ERP
-- Ambiente: Local (Windows 11 + Laragon)
-- Motor: MariaDB 11.8

CREATE DATABASE IF NOT EXISTS sos_erp_local CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE sos_erp_local;

-- Tabla de Empresas
CREATE TABLE IF NOT EXISTS sys_empresa (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    uid VARCHAR(100) UNIQUE NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    siglas VARCHAR(10) UNIQUE NOT NULL, -- Ej: 'OS'
    nit VARCHAR(20),
    empresa VARCHAR(50) NOT NULL, -- Siglas de la empresa (auditoría)
    usuario_creador VARCHAR(150) NOT NULL,
    usuario_ult_modificacion VARCHAR(150) NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_ult_modificacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Tabla de Usuarios
CREATE TABLE IF NOT EXISTS sys_usuarios (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    uid VARCHAR(100) UNIQUE NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    rol VARCHAR(50) NOT NULL DEFAULT 'usuario',
    empresa VARCHAR(50) NOT NULL,
    usuario_creador VARCHAR(150) NOT NULL,
    usuario_ult_modificacion VARCHAR(150) NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_ult_modificacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Registro inicial de empresa (Origen Silvestre)
INSERT INTO sys_empresa (uid, nombre, siglas, empresa, usuario_creador, usuario_ult_modificacion)
VALUES ('SYS-001', 'Origen Silvestre', 'OS', 'os', 'santi@origensilvestre.com', 'santi@origensilvestre.com')
ON DUPLICATE KEY UPDATE nombre=nombre;

-- Registro inicial de usuario (Santi)
INSERT INTO sys_usuarios (uid, nombre, email, password, rol, empresa, usuario_creador, usuario_ult_modificacion)
VALUES ('OS-USER-001', 'Santiago', 'santi@origensilvestre.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', 'os', 'sistema', 'sistema')
ON DUPLICATE KEY UPDATE nombre=nombre;
