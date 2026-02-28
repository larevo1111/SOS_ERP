# Contexto Activo del Proyecto

> Este archivo es la primera parada de cualquier agente antes de trabajar.
> Siempre refleja el estado real y actualizado del proyecto.
> Quien complete una tarea, actualiza este archivo antes de cerrar.

---

## Estado actual

**Módulo en construcción:** Comercial — Menú dinámico + Maestros de Costos
**Fase:** Fase 6 (UI) completada · Fase 7 (UI) en avance
**Última tarea completada:** Codex: Refactor de `LayoutPrincipal.vue` con menú dinámico `sys_menu_v2` + `q-select` de Maestros de Costos en `FormularioProducto.vue`
**Madrina a cargo:** AntiGravity (Arquitecta)
**Próximo paso:** [CODEX] Finalizar UI de Fase 7 (`IntegracionWooCommerce.vue`) y habilitar protección Auth JWT de Fase 8 en `apiService.js` y `Login.vue`.
**Fecha de última actualización:** 2026-02-27 (Sesión Nocturna Novedades)

---

## 📚 Referencias Obligatorias para esta Fase
- 🎨 **Diseño**: [.agent/diseno/GUIA_ESTILOS.md](file:///home/osserver/.gemini/antigravity/scratch/SOS_ERP/.agent/diseno/GUIA_ESTILOS.md)
- ⚡ **Skills**: [.agent/skills/skill_frontend_quasar.md](file:///home/osserver/.gemini/antigravity/scratch/SOS_ERP/.agent/skills/skill_frontend_quasar.md)
- 📜 **Plan Novedades (ACTIVO)**: [.agent/planes/PLAN_novedades.md](file:///home/osserver/.gemini/antigravity/scratch/SOS_ERP/.agent/planes/PLAN_novedades.md)
- 📜 **Plan Conexión**: [.agent/planes/implementation_plan_conexion.md](file:///home/osserver/.gemini/antigravity/scratch/SOS_ERP/.agent/planes/implementation_plan_conexion.md)

---

## Notas y bloqueos activos

- **Menú dinámico**: Frontend consume `/api/sistema/menu` y tiene fallback visual por si el endpoint no responde.
- **Maestros de Costos**: `q-select` ya enlaza `uid_producto_padre` y autocompleta nombre; requiere endpoint accesible (`/api/comercial/costos`, acción `listar_maestros_costo`).

---

## Historial reciente

| Fecha | Tarea | Agente | Estado |
|---|---|---|---|
| 2025-02-25 | Configuración inicial de carpeta `.agents/` | Santi | ✅ Completado |
| 2026-02-26 | Implementación de Política 5S en Manifiesto | AntiGravity | ✅ Completado |
| 2026-02-26 | Actualización de Política de Backups en Manifiesto | AntiGravity | ✅ Completado |
| 2026-02-26 | Corrección subnumeración e Identificación de Agentes | AntiGravity | ✅ Completado |
| 2026-02-26 | Documentación de protocolo de acceso SSH en Manifiesto | AntiGravity | ✅ Completado |
| 2026-02-26 | Simplificación sección 11.2 (SSH) en Manifiesto | AntiGravity | ✅ Completado |
| 2026-02-26 | Actualización motor BD (MariaDB 11.8) en Manifiesto | AntiGravity | ✅ Completado |
| 2026-02-26 | Automatización de protocolo de Backups en Manifiesto | AntiGravity | ✅ Completado |
| 2026-02-26 | Corrección de ruta de backups en Manifiesto | AntiGravity | ✅ Completado |
| 2026-02-26 | Integración de Guías de Estilo "Orígenes" en Manifiesto | AntiGravity | ✅ Completado |
| 2026-02-26 | Unificación de guías estéticas (Claude + AntiGravity) | AntiGravity | ✅ Completado |
| 2026-02-26 | Creación de estructura de carpetas /erp | AntiGravity | ✅ Completado |
| 2026-02-26 | Diseño y redacción de PLAN_woocommerce.md | AntiGravity | ✅ Completado |
| 2026-02-26 | Scaffolding Quasar + FormularioProducto.vue (Variación Representante) | Claude Code | ✅ Completado |
| 2026-02-27 | Planificación API "Una por Pantalla" & Configuración Cloudflare R2 | AntiGravity | ✅ Completado |
| 2026-02-27 | Implementación Backend API: ProductoController, GuardarProducto, SubirMultimedia, rutas.php | Claude Code | ✅ Completado |
| 2026-02-27 | Rediseño FormularioProducto.vue: maquetación, tabs custom, card-productor, merge Contenido+Historia | Claude Code | ✅ Completado |
| 2026-02-27 | Ajuste tab Contenido: sección Origen 3ra, Propuesta de valor, quitar resaltado verde | Claude Code | ✅ Completado |
| 2026-02-27 | Actualizar skill_frontend_quasar.md con learnings del primer módulo frontend | Claude Code | ✅ Completado |
| 2026-02-27 | Conexión Frontend↔API: apiService.js, guardar_producto, subir_multimedia, .env.example | Claude Code | ✅ Completado |
| 2026-02-27 | Refactorización Final 5S "Versión Diamante" del Manifiesto (Certificación Total) | AntiGravity | ✅ Completado |
| 2026-02-27 | Sincronización Hostinger -> Local & Configuración MariaDB 11.8 | AntiGravity | ✅ Completado |
| 2026-02-27 | Configuración PHP Espejo (Módulos, Memoria, Límites) | AntiGravity | ✅ Completado |
| 2026-02-27 | Creación de Bitácora de Errores y Skill de Entorno Espejo | AntiGravity | ✅ Completado |
| 2026-02-27 | Creación de Índice Maestro de Skills (README_SKILLS.md) | AntiGravity | ✅ Completado |
| 2026-02-27 | Estandarización de DB (url_producto default) y Sincronización Git | AntiGravity | ✅ Completado |
| 2026-02-27 | Corrección estructural del menú (q-expansion-item con v-slot header) | AntiGravity | ✅ Completado |
| 2026-02-27 | Activación del Catálogo Comercial API y pase a Producción Web | AntiGravity | ✅ Completado |
| 2026-02-27 | Fase 6/7 UI: menú dinámico `sys_menu_v2` + q-select Maestros de Costos en FormularioProducto | Codex | ✅ Completado |

---

## Cómo actualizar este archivo

Al completar una tarea, el agente constructor actualiza:

- **Módulo en construcción** → si cambió
- **Última tarea completada** → nombre de la tarea del plan
- **Próximo paso** → la siguiente tarea pendiente en el plan activo
- **Fecha de última actualización** → fecha real
- **Notas y bloqueos** → agregar o limpiar según corresponda
- **Historial reciente** → agregar fila con fecha, tarea y estado
