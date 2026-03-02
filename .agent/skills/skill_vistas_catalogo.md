---
description: Reglas y patrones para construir vistas de catálogo (listados), vistas de detalle y formularios de edición en el ERP.
---

# 📋 Skill: Vistas de Catálogo y Listados

## 1. La Política de las 3 Vistas (LEY DEL ERP)

Todo módulo del ERP que administre registros **DEBE** tener exactamente estas 3 vistas — igual que AppSheet, Shopify y todo ERP profesional:

| # | Tipo | Nombre Router | URL | Componente |
|---|---|---|---|---|
| 1 | **Listado/Catálogo** | `catalogo-productos` | `/comercial/productos` | `CatalogoProductos.vue` |
| 2 | **Detalle** (solo lectura) | `ver-producto` | `/comercial/producto/:uid/ver` | `DetalleProducto.vue` |
| 3 | **Formulario** (editar/crear) | `editar-producto` | `/comercial/producto/:uid` | `FormularioProducto.vue` |

### Reglas de Navegación:
- **Clic en el nombre** del registro en el listado → abre la **Vista Detalle** (`ver-producto`)
- **Botón ojo** (👁) en la fila del listado → abre la **Vista Detalle** (`ver-producto`)
- **Botón lápiz** (✏️) en la fila del listado → abre el **Formulario de Edición** (`editar-producto`)
- **Botón "+ Nuevo"** en la cabecera del listado → abre el **Formulario de Creación** (`nuevo-producto`)
- Desde la **Vista Detalle**, el botón principal naranja **"Editar [item]"** → lleva al **Formulario de Edición**

### Estructura del Listado (CatalogoProductos.vue):
```html
<!-- Cada fila de la tabla tiene 2 botones de acción -->
<q-btn icon="visibility" @click="verProducto(uid)" />  <!-- Ver Detalle -->
<q-btn icon="edit"       @click="editarProducto(uid)" /> <!-- Editar -->
```

### ¿Cuándo aplica esta política?
Para TODO módulo nuevo se deben crear los 3 componentes y las 3 rutas. Nunca colapsar detalle y edición en el mismo componente accedido por el mismo gesto del usuario.


## 2. Consulta SQL para Listados: Reglas Estrictas

### ✅ Lo que SÍ hacer:
- Seleccionar SOLO las columnas que se mostrarán en la tabla de la UI.
- Filtrar siempre por `empresa = :empresa` (multi-tenancy obligatorio).
- Ordenar por `fecha_creacion DESC`.
- Usar LIMIT (50 por defecto).

### ❌ Lo que NO hacer:
- **NUNCA** usar subqueries en los listados a menos que hayas confirmado que la tabla referenciada existe en TODOS los ambientes (local, staging, producción). Un error "Column not found" o "Table doesn't exist" en una subquery tumba TODO el listado con HTTP 500.
- No usar `SELECT *` en listados — solo columnas explícitas.
- No intentar cargar multimedia o relaciones en el listado (eso va en `obtener_producto`).

### Ejemplo Correcto de SQL para Listado:
```php
$sql = "SELECT p.uid, p.nombre, p.categoria, p.marca, p.precio_regular, 
        p.estado, p.estado_publicacion, p.producto_principal_variacion,
        p.empresa, p.fecha_creacion
        FROM com_productos p 
        WHERE p.empresa = :empresa";
```

### Ejemplo INCORRECTO (causa HTTP 500):
```php
// MAL: Si com_productos_multimedia no existe o url_publica no es un campo, revienta TODO
$sql = "SELECT p.*, 
        (SELECT url_publica FROM com_productos_multimedia WHERE uid_producto = p.uid LIMIT 1) as url_portada
        FROM com_productos p WHERE p.empresa = :empresa";
```

## 3. Frontend: Carga del Detalle del Producto

La función `cargarProducto` en el formulario Vue **DEBE** llamar al endpoint `obtener_producto` cuando hay un UID en la ruta.

### Patrón Correcto (Vue 3):
```javascript
onMounted(async () => {
  await consultarDependencias() // carga selectores: marcas, costos, etc.
  
  const uid = route.params.uid  // viene del router /editar/:uid
  if (uid) {
    await cargarProducto(uid)   // rellena el formulario con datos reales
  }
})

async function cargarProducto(uid) {
  try {
    const respuesta = await llamar('comercial', 'productos', 'obtener_producto', { uid })
    if (respuesta?.producto) {
      Object.assign(producto.value, respuesta.producto)   // poblar formulario
      multimedia.value  = respuesta.multimedia  || []     // cargar imágenes
      variaciones.value = respuesta.variaciones || []     // cargar variaciones
    }
  } catch (error) {
    $q.notify({ type: 'negative', message: `Error al cargar: ${error.message}` })
  }
}
```

### Error Típico — Función placeholder vacía:
Si `cargarProducto` solo tiene un `console.log` pero **no llama** a la API, el formulario siempre aparecerá en blanco aunque el producto exista en la BD.

## 4. Problemas Conocidos y Soluciones

- **Error HTTP 500 en el listado con mensaje `Column not found`**
  **Causa**: La consulta SQL del listado tenía una subquery que referenciaba una tabla o columna que no existe en ese ambiente de base de datos.
  **Solución**: Eliminar la subquery y usar solo columnas explícitas de la tabla principal. Las imágenes de portada solo se recuperan en la vista de detalle (`obtener_producto`).

- **El formulario de edición aparece vacío al abrir un producto existente**
  **Causa**: Las funciones `cargarProducto`, `cargarMultimedia` y `cargarVariaciones` en el componente Vue eran placeholders (`TODO`) que nunca hacían ninguna llamada al API.
  **Solución**: Implementar `cargarProducto` para que llame a `obtener_producto` y luego use `Object.assign(producto.value, respuesta.producto)` para poblar el formulario con los datos.
