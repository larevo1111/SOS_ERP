# skill_entorno_espejo.md

## Para qué sirve
Este skill define los protocolos para mantener la paridad absoluta entre las estaciones de trabajo locales (Windows/Ubuntu) y el servidor de producción Hostinger, evitando errores de "en mi máquina si funciona".

## Reglas que nunca se rompen
1. **MariaDB 11.8**: Prohibido usar MySQL 8 o versiones inferiores en local. La colación y tipos de datos deben ser idénticos.
2. **PHP Espejo**: Siempre validar que las extensiones `zip`, `gd`, `soap`, `sockets`, `ftp` y `gmp` estén activas en el `php.ini` local.
3. **Memoria y Post**: `memory_limit` debe estar en 2048M para soportar procesos pesados.

## Problemas conocidos y soluciones
- **Bloqueo de Puertos (SSH/Database)**: Desactivar VPNs o servicios como Cloudflare WARP que interceptan el tráfico del puerto 65002 o 3306.
- **Error 1364 (Integridad SQL)**: Las tablas heredadas pueden tener campos `NOT NULL` sin default. Se debe estandarizar la tabla con `ALTER TABLE ... DEFAULT ''` si el campo no es crítico para la inserción inicial.

## Ejemplos de código correcto
Para estandarizar un campo sin default:
```sql
ALTER TABLE com_productos MODIFY url_producto varchar(255) DEFAULT '';
```

Para verificar módulos PHP desde consola:
```bash
php -m
```
