# Bitácora de Errores y Lecciones: SOS ERP

Este archivo registra los incidentes técnicos, su proceso de resolución y las lecciones aprendidas para alimentar el Manifiesto y los Skills.

## Protocolo de Registro

1.  **Agente Instructor/Constructor**: Reporta el error, su causa raíz y la solución implementada.
2.  **Arquitecta (AntiGravity)**: Revisa la bitácora periódicamente y decide si la solución debe institucionalizarse en el `MANIFESTO.md` o en un `Skill`.

---

## Registro de Incidentes

| Fecha | Error / Incidente | Responsable | Solución | Estado | Skill/Manifiesto |
|---|---|---|---|---|---|
| 2026-02-27 | Error 1364: `url_producto` sin valor default | AntiGravity | Se estandarizó la tabla con un valor DEFAULT '' vía ALTER TABLE. | ✅ Resuelto | skill_acceso_datos_php |
| 2026-02-27 | Error de parámetros SQL en `prueba_estres.php` | AntiGravity | Corregido mapeo de variables en el `execute` de PDO. | ✅ Resuelto | skill_acceso_datos_php |
| 2026-02-27 | Bloqueo SSH puerto 65002 (Cloudflare WARP) | AntiGravity | Desactivar WARP y crear regla de salida en Firewall. | ✅ Resuelto | skill_entorno_espejo |
| 2026-02-27 | Incompatibilidad MySQL 8 con MariaDB 11 (TEXT DEFAULT) | AntiGravity | Instalación de MariaDB 11.8.3 local en Laragon. | ✅ Resuelto | skill_entorno_espejo |
| 2026-02-27 | Error sintaxis `Conexion.php` (Constant PDO) | AntiGravity | Corregido typo `ATTR_ERR_MODE` a `ATTR_ERRMODE`. | ✅ Resuelto | skill_acceso_datos_php |
| 2026-02-27 | Falta de extensiones PHP espejo (zip, gd, etc) | AntiGravity | Activación manual en `php.ini` local. | ✅ Resuelto | skill_entorno_espejo |

---

## Cómo usar esta bitácora
Cuando encuentres un error:
- Agrega una fila al inicio de la tabla (debajo del encabezado).
- Describe brevemente el problema y cómo lo arreglaste.
- Marca como ✅ Resuelto.
- El Arquitecto marcará la última columna si la solución se vuelve doctrina oficial.
