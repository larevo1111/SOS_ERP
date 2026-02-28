# skill_entorno_espejo.md

## Para qué sirve
Este skill define los protocolos para mantener la paridad absoluta entre las estaciones de trabajo locales (Windows/Ubuntu) y el servidor de producción Hostinger. Es una guía de **Infraestructura**.

## Reglas que nunca se rompen
1. **MariaDB 11.8**: Prohibido usar MySQL 8 o versiones inferiores en local.
2. **PHP Espejo**: Validar extensiones `zip`, `gd`, `soap`, `sockets`, `ftp` y `gmp` en el `php.ini` local.
3. **Memoria**: `memory_limit=2048M` obligatorio en todas las estaciones.

## Problemas conocidos y soluciones
- **Bloqueo 65002/3306**: Cloudflare WARP o Firewalls locales deben tener reglas de excepción para estos puertos.
- **Diferencia de Collation**: Si los motores no coinciden, fallarán las importaciones de base de datos.

## Ejemplos de comandos
Verificar módulos: `php -m`
Verificar límites: `php -i | findstr "memory_limit"`
