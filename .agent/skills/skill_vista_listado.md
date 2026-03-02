---
description: Reglas y convenciones para implementar listados y catálogos en el ERP (la primera de las 3 vistas).
---

# 📋 Skill: Vista de Listado / Catálogo

## Propósito
El Listado es la primera de las **3 vistas obligatorias** de todo módulo del ERP. Muestra todos los registros en una tabla con filtros básicos y acciones por fila.

## Ruta y Componente
- **URL**: `/comercial/productos` (patrón: `/:modulo/:entidades`)
- **Nombre de ruta**: `catalogo-productos` (patrón: `catalogo-[entidades]`)
- **Componente**: `CatalogoProductos.vue` (patrón: `Catalogo[Entidades].vue`)

## Estructura Obligatoria de Cada Fila
Cada fila de la tabla DEBE tener exactamente 2 botones de acción (en ese orden):
```html
<q-btn icon="visibility" @click="verProducto(uid)" />   <!-- 👁 Ver Detalle -->
<q-btn icon="edit"       @click="editarProducto(uid)" /> <!-- ✏️ Editar -->
```
Y el nombre del registro al hacer clic va al Detalle (`ver-[entidad]`), NO al formulario.

## SQL para Listados: Reglas Críticas
- Seleccionar **solo columnas explícitas** de la tabla principal (NO `SELECT *`)
- NUNCA usar subqueries a tablas auxiliares (multimedia, relaciones) — causa HTTP 500 si la tabla/columna no existe
- Filtrar siempre por `empresa = :empresa` (multi-tenancy)
- Ordenar por `fecha_creacion DESC`, LIMIT por defecto 50

```php
// ✅ CORRECTO
$sql = "SELECT p.uid, p.nombre, p.categoria, p.precio_regular, p.estado
        FROM com_productos p WHERE p.empresa = :empresa ORDER BY fecha_creacion DESC LIMIT 50";

// ❌ MAL — si com_productos_multimedia no tiene url_publica → HTTP 500
$sql = "SELECT p.*, (SELECT url_publica FROM com_productos_multimedia WHERE ...) FROM com_productos p ...";
```

## Problemas Conocidos
- **HTTP 500 con "Column not found"**: Subquery al listado referenciando columna que no existe. Eliminar la subquery y cargar multimedia solo en `obtener_producto`.
- **Formulario vacío al editar**: `cargarProducto()` era un TODO. Siempre implementar la llamada real a `obtener_producto` en `onMounted`.
