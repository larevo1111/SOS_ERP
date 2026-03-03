# Plan de Visualización: Listado y Detalle (Fase 4)

Este plan define la experiencia de navegación para que Santi pueda gestionar el inventario de **Origen Silvestre** de forma masiva y fluida.

## Proposed Changes

### [Backend - API]

#### [MODIFICAR] [ProductoController.php](file:///home/osserver/Proyectos_Antigravity/SOS_ERP/erp/modulos/comercial/controladores/ProductoController.php)
*   **Nueva Acción: `listar`**: Consultará la tabla `com_productos`.
*   **Filtros**: Soportará filtrado por `empresa` (obligatorio), `marca`, `categoria` y `estado`.
*   **Buscador**: Búsqueda por texto libre en el nombre del producto.

### [Frontend - Componentes]

#### [NEW] [CatalogoProductos.vue](file:///home/osserver/Proyectos_Antigravity/SOS_ERP/erp/frontend/src/modulos/comercial/CatalogoProductos.vue)
*   **Tabla Dinámica (`q-table`)**:
    *   Columnas: Miniatura (R2), Nombre, SKU/UID, Marca, Precio, Stock (futuro), Estado.
    *   **Estética 5S**: Bordes suaves, espaciado generoso, colores de la marca.
*   **Filtros Rápidos**: Una barra superior minimalista para filtrar rápidamente.
*   **Navegación**: Al hacer clic en un producto, redirigir a `/comercial/productos/editar/:uid`.

### [Frontend - Navegación]

#### [MODIFICAR] [routes.js](file:///home/osserver/Proyectos_Antigravity/SOS_ERP/erp/frontend/src/router/routes.js)
*   Vincular la ruta principal de comercial al catálogo:
    *   `/comercial/productos` → `CatalogoProductos.vue`
    *   `/comercial/productos/nuevo` → `FormularioProducto.vue`

## User Review Required

> [!TIP]
> **Vista de Detalle**: Mi propuesta es que la "Vista de Detalle" sea el mismo **FormularioProducto.vue** pero que cargue los datos del producto seleccionado. Así ahorramos código y el usuario siempre está en el mismo entorno familiar tanto para consultar como para editar.

---

## Verification Plan
1. **Consistencia**: Verificar que las miniaturas de Cloudflare R2 se vean correctamente en la tabla.
2. **Velocidad**: El listado debe cargar en < 500ms usando paginación eficiente.
