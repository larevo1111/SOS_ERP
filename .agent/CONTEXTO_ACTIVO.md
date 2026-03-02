# Contexto Activo del Proyecto

> Este archivo es la primera parada de cualquier agente antes de trabajar.
> Siempre refleja el estado real y actualizado del proyecto.
> Quien complete una tarea, actualiza este archivo antes de cerrar.

---

## Estado actual

**Módulo en construcción:** Módulo Comercial — Galería de Productos (Siguiente tarea)
**Fase:** Patrón 3 Vistas implementado. Galería pendiente de reorganización por secciones.
**Última tarea completada:** AntiGravity: Implementación patrón 3 vistas (Listado, Detalle, Formulario), corrección de bugs críticos de BD/multimedia, actualización de skills y manifiesto. Git push commit `91b5f3a`.
**Madrina a cargo:** AntiGravity / Claude (siguiente chat)
**Próximo paso:** Reorganizar la galería del `FormularioProducto.vue` en secciones según el campo `uso`. Ver sección "Tarea pendiente" abajo.
**Fecha de última actualización:** 2026-03-02

---

## ⚡ TAREA INMEDIATA PARA EL PRÓXIMO AGENTE

### Reorganizar Galería del Formulario de Producto por Secciones de `uso`

**Contexto:** La tabla `com_productos_multimedia` tiene el campo `uso` con estos valores:
`ENUM('Principal','Galeria','Variacion','Galeria secundaria','Otro')`

**Lo que existe hoy:** La pestaña "Galería" del `FormularioProducto.vue` muestra todos los archivos mezclados en una sola sección, sin separar por tipo de `uso`. El botón "Agregar" sube con `uso='Galeria'` como default.

**Lo que debe existir** (según diseño de Santi):

| Ubicación en la UI | Sección | `uso` a enviar al API |
|---|---|---|
| **Pestaña General** (ya existe) | Zona/card para foto principal del producto | `Principal` |
| **Popup de Variación** (ya existe el popup) | Campo de imagen de la variación | `Variacion` |
| **Pestaña Galería** → Sección 1 | "Galería" — imágenes principales del producto | `Galeria` |
| **Pestaña Galería** → Sección 2 | "Galería Secundaria" — fotos adicionales | `Galeria secundaria` |

**Reglas de implementación:**
1. Verificar primero con `DESCRIBE com_productos_multimedia;` antes de tocar el backend
2. Al cargar el producto, filtrar multimedia por `uso` para mostrarla en la sección correcta
3. Al subir un archivo, enviar el `uso` correcto según la sección desde donde se hace el upload
4. La restricción "guardar primero" aplica igual en todas las secciones (ver `skill_multimedia_r2.md`)
5. En pestaña General, mostrar la imagen `Principal` existente si existe, o un dropzone si no hay
6. Si se sube una nueva `Principal`, el sistema debe cambiar la anterior a `Galeria` (solo puede haber UNA `Principal` por producto)

**Archivos a modificar:**
- `erp/frontend/src/modulos/comercial/FormularioProducto.vue` → añadir secciones por uso en pestaña Galería y card en General
- `erp/modulos/comercial/casos_de_uso/SubirMultimedia.php` → ya correcto con columnas reales
- No tocar el schema de BD

**Skills de referencia obligatorios:**
- `skill_multimedia_r2.md` — schema real y template de INSERT
- `skill_creacion_formularios.md` — convenciones de formularios Quasar
- `MANIFESTO.md §6.11` — analizar BD ANTES de codificar

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
| 2026-03-02 | **[PENDIENTE]** Galería por secciones en FormularioProducto | — | 🔲 Pendiente |

---

## Cómo actualizar este archivo

Al completar una tarea, el agente constructor actualiza:
- **Módulo en construcción** → si cambió
- **Última tarea completada** → nombre de la tarea del plan
- **Próximo paso** → la siguiente tarea pendiente en el plan activo
- **Fecha de última actualización** → fecha real
- **Notas y bloqueos** → agregar o limpiar según corresponda
- **Historial reciente** → agregar fila con fecha, tarea y estado
