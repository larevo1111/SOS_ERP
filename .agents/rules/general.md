---
trigger: always_on
---

# PROTOCOLO OPERATIVO SOS_ERP

## 1. Mandato de Lectura (Paso Cero)
Es OBLIGATORIO leer estos archivos antes de escribir una sola línea para evitar redundancias y mantener el orden:
1. **.agent/MANIFESTO.md**: Constitución y leyes inamovibles.
2. **.agent/CONTEXTO_ACTIVO.md**: Estado real de la fase actual.
3. **.agent/skills/**: Manuales de sabiduría acumulada (R2, Sincronización, etc.).
4. **.agent/planes/**: Estrategia de la tarea asignada.

## 2. Estándares de Datos y Estructura
- **Identificadores**: `id` (PK interna MySQL) y `uid` (Identificador de negocio: SIGLAS.YYMMDDHHMMSS).
- **DB**: Mariadb Central en Hostinger (IP 109.106.250.195). Ambiente Espejo Local.
- **Seguridad**: Multi-tenant forzado. Toda lógica debe pasar por el filtro `empresa` y la tabla `sys_usuarios_empresas`.
- **Auditoría**: Inyección obligatoria de `usuario_creador`, `usuario_ult_modificacion` y timestamps.

## 3. Workflow de Ejecución
1. **Estrategia Primero**: Propón la solución estratégica y espera aprobación de Santi antes de codificar.
2. **Registro de Skills**: No se cierra una tarea compleja sin actualizar el Skill correspondiente o crear uno nuevo si se aprendió algo valioso.
3. **Verificación de Éxito**: No informes "completado" sin evidencia visual (screenshot via browser subagent) o logs de API/BD que confirmen el éxito real.
4. **Limpieza**: Una vez terminado un plan, muévelo a `.agent/historial/` para mantener el espacio de trabajo limpio.
