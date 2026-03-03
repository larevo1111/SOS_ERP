---
description: Reglas y convenciones para implementar la vista de detalle (solo lectura) de un registro en el ERP.
---

# 🔍 Skill: Vista de Detalle (Solo Lectura)

## Propósito
La Vista de Detalle es la segunda de las **3 vistas obligatorias** de todo módulo del ERP. Permite ver toda la información de un registro sin posibilidad de editar directamente.

## Ruta y Componente
- **URL**: `/comercial/producto/:uid/ver` (patrón: `/:modulo/:entidad/:uid/ver`)
- **Nombre de ruta**: `ver-producto` (patrón: `ver-[entidad]`)
- **Componente**: `DetalleProducto.vue` (patrón: `Detalle[Entidad].vue`)

## Qué debe incluir
1. **Cabecera** con migas de navegación, nombre del registro, chips de estado y botón "Editar [entidad]" (naranja)
2. **Secciones de información** en tarjetas (`.card-detalle`): solo texto, no inputs
3. **Galería de imágenes** (si el módulo tiene multimedia) con botón de agregar que valida que el producto esté guardado
4. **Panel lateral** con variaciones/relaciones y datos de auditoría (UID, empresa, fechas)

## Política Oficial de Migas de Navegación (Breadcrumb)

> [!IMPORTANT]
> La miga siempre debe coincidir EXACTAMENTE con el nombre del ítem de menú real (`sys_menu_v2`), no con el nombre interno de la entidad.

**Estructura obligatoria:**
`[Módulo] > [Nombre ítem del menú] > [Nombre del Registro] — [Modo]`

| Nivel | Ejemplo Comercial |
|---|---|
| Módulo | `Comercial` |
| Ítem del menú | `Catálogo Comercial` (NO "Productos") |
| Registro + Modo | `CHOCOBEETAL OS 90 GRS — Detalle` |

**Modos aceptados:** `— Detalle`, `— Edición`, o nada (para Nuevo Registro).

Al crear la miga, verificar el nombre del ítem contra la tabla `sys_menu_v2` o el componente `LayoutPrincipal.vue` antes de hardcodear el texto.

## Galería en Vista de Detalle
La vista de detalle puede permitir subir multimedia, pero **con la misma validación** que el formulario de edición: el producto debe existir en BD (tener UID) antes de subir archivos.

**Acceso a la galería desde el detalle** → Botón "Ir a Galería" que redirige al formulario de edición en la pestaña Galería, o implementar miniupload directo.

## Navegación desde esta vista
- **Botón "Volver"** → Listado (`catalogo-[entidad]`)
- **Botón "Editar [entidad]"** → Formulario de edición (`editar-[entidad]`)
- **Clic en variaciones** → Detalle de la variación (`ver-[entidad]` con su UID)

## Schema de Multimedia (com_productos_multimedia)
⚠️ Usar SIEMPRE los nombres de columna reales verificados (2026-03-01):
- `archivo_local` → nombre original del archivo (NO `nombre_archivo`, NO `ruta_archivo`)
- `archivo_woocommerce` → URL pública de R2/WooCommerce (NO `url_publica`)
- `uso` ENUM: `'Principal'` para portada (NO `'Portada'`), `'Galeria'`, `'Variacion'`, etc.

Ejemplo correcto en Vue:
```html
<img :src="archivo.archivo_woocommerce || archivo.archivo_local" />
<div :class="{ 'portada': archivo.uso === 'Principal' }">
```

## Problemas Conocidos
- **`Unknown column 'nombre_archivo' in INSERT INTO`**: La tabla `com_productos_multimedia` usa `archivo_local` (nombre) y `archivo_woocommerce` (URL). Los nombres `nombre_archivo`, `ruta_archivo`, `url_publica` no existen en la BD real.
- **Error al filtrar portada**: Usar `archivo.uso === 'Principal'` (no `'Portada'`).
