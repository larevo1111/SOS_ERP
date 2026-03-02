# Contexto Activo del Proyecto

> Este archivo es la primera parada de cualquier agente antes de trabajar.
> Siempre refleja el estado real y actualizado del proyecto.
> Quien complete una tarea, actualiza este archivo antes de cerrar.

---

## Estado actual

**Módulo en construcción:** Módulo Comercial — UX de Vistas de Producto
**Fase:** Ronda de mejoras UX completada. Pendiente: verificación visual y despliegue.
**Última tarea completada:** Claude Code: DetalleProducto con tabs+lightbox+hero, CatalogoProductos con thumbnail, contextos IA enriquecidos por campo, pre-fill nombre variación, IA en todos los campos de contenido.
**Madrina a cargo:** Santi (verificación visual pendiente)
**Próximo paso:** Verificar visualmente en `http://localhost:5173` y hacer git push + despliegue si todo OK.
**Fecha de última actualización:** 2026-03-02

---

## ✅ TAREA COMPLETADA (2026-03-02)

### Galería reorganizada por secciones de `uso` — `FormularioProducto.vue`

**Implementado por:** Claude Code

**Cambios realizados en `erp/frontend/src/modulos/comercial/FormularioProducto.vue`:**

| Sección de la UI | `uso` | Estado |
|---|---|---|
| **Pestaña General** → card Foto Principal | `Principal` | ✅ Implementado |
| **Popup de Variación** → zona imagen | `Variacion` | ✅ Implementado |
| **Pestaña Galería** → Sección 1 (Galería) | `Galeria` | ✅ Implementado |
| **Pestaña Galería** → Sección 2 (Galería secundaria) | `Galeria secundaria` | ✅ Implementado |

**Bugs corregidos en el proceso:**
- `'Portada'` → `'Principal'` en `procesarArchivos` (valor incorrecto no existía en ENUM)
- `urlArchivo()` ahora usa `url_publica_calculada` según `skill_multimedia_r2.md §5.3`

**TODO pendientes en el código (no son bloqueantes):**
- `PATCH /api/comercial/multimedia/:uid` para persistir cambio de `uso` al reemplazar Principal
- `DELETE /api/comercial/multimedia/:uid` para eliminar archivo de R2 al borrar
- `PATCH /api/comercial/multimedia/reordenar` para persistir orden arrastrado

---

## 📚 Referencias Obligatorias

- 🎨 **Diseño**: [.agent/diseno/GUIA_ESTILOS.md](file:///home/osserver/.gemini/antigravity/scratch/SOS_ERP/.agent/diseno/GUIA_ESTILOS.md)
- ⚡ **Skills clave**:
  - `skill_multimedia_r2.md` — multimedia y R2
  - `skill_vista_listado.md` — vistas de catálogo
  - `skill_vista_detalle.md` — vista de detalle
  - `skill_auditoria_bd.md` — bugs conocidos de BD
  - `skill_despliegue_produccion.md` — cómo desplegar
- 📜 **Plan activo**: [.agent/planes/PLAN_refactor_producto.md](file:///home/osserver/.gemini/antigravity/scratch/SOS_ERP/.agent/planes/PLAN_refactor_producto.md)

---

## Notas y bloqueos activos

- **BD local puede tener procesos Sleep colgados**: Si el catálogo aparece vacío o la API no responde, ejecutar:
  ```bash
  mysqladmin -ularevo1111 -pEpist2487. processlist
  mysqladmin -ularevo1111 -pEpist2487. kill ID1,ID2,...
  ```
- **FK en com_productos_multimedia**: Puede estar pendiente de aplicar. Verificar con:
  ```bash
  mysql -ularevo1111 -pEpist2487. sos_erp_local -e "SHOW CREATE TABLE com_productos_multimedia\G" | grep FOREIGN
  ```
  Si no existe, aplicar:
  ```sql
  ALTER TABLE com_productos_multimedia ADD CONSTRAINT fk_multimedia_producto FOREIGN KEY (uid_producto) REFERENCES com_productos(uid) ON DELETE CASCADE ON UPDATE CASCADE;
  ```
- **Producción (erp.oscomunidad.com)**: El código local con los fixes está en GitHub (commit `91b5f3a`) pero NO se ha hecho `git pull` en Hostinger. La producción puede tener código antiguo. Para desplegar: usar el workflow `/desplegar_produccion` y leer `skill_despliegue_produccion.md` primero.

---

## Historial reciente

| Fecha | Tarea | Agente | Estado |
|---|---|---|---|
| 2026-02-28 | Fase 8: Auth, Login, JWT, multi-tenant | Codex | ✅ Completado |
| 2026-03-01 | Corrección catálogo vacío (query subquery url_publica) | AntiGravity | ✅ Completado |
| 2026-03-01 | Implementación formulario de producto con carga de datos real | AntiGravity | ✅ Completado |
| 2026-03-02 | Patrón 3 vistas: CatalogoProductos, DetalleProducto, FormularioProducto | AntiGravity | ✅ Completado |
| 2026-03-02 | Corrección upload multimedia: columnas reales (archivo_local, archivo_woocommerce) | AntiGravity | ✅ Completado |
| 2026-03-02 | Corrección opcionesUso: 'Portada' → 'Principal' | AntiGravity | ✅ Completado |
| 2026-03-02 | Nuevos skills: skill_multimedia_r2, skill_vista_detalle, skill_vista_listado | AntiGravity | ✅ Completado |
| 2026-03-02 | Manifesto actualizado: §6.11 BD-Primero, §6.12 Filosofía Almacenamiento, §6.5.2 3 Vistas | AntiGravity | ✅ Completado |
| 2026-03-02 | Git push commit 91b5f3a (75 archivos) | AntiGravity | ✅ Completado |
| 2026-03-02 | Galería por secciones en FormularioProducto (Principal, Galería, Galería sec., Variación) | Claude Code | ✅ Completado |
| 2026-03-02 | Síntesis y actualización de directivas de contexto IA en skill_agente_integrado_ia_erp.md | AntiGravity | ✅ Completado |
| 2026-03-02 | ListarProductos.php: agregar foto_principal via subquery | Claude Code | ✅ Completado |
| 2026-03-02 | DetalleProducto.vue: reescritura completa con tabs, hero image y lightbox | Claude Code | ✅ Completado |
| 2026-03-02 | CatalogoProductos.vue: columna de thumbnail foto principal | Claude Code | ✅ Completado |
| 2026-03-02 | FormularioProducto.vue: pre-fill nombre variación, contextos IA por campo, IA en contenido | Claude Code | ✅ Completado |

---

## Cómo actualizar este archivo

Al completar una tarea, el agente constructor actualiza:
- **Módulo en construcción** → si cambió
- **Última tarea completada** → nombre de la tarea del plan
- **Próximo paso** → la siguiente tarea pendiente en el plan activo
- **Fecha de última actualización** → fecha real
- **Notas y bloqueos** → agregar o limpiar según corresponda
- **Historial reciente** → agregar fila con fecha, tarea y estado
