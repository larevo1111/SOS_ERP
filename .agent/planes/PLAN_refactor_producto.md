# Rediseño Integral de FormularioProducto (Lógica Centralizada 5S)

Este plan aborda la reestructuración de la vista de creación y edición de productos (`FormularioProducto.vue`) solicitada por la Dirección. El diseño anterior fragmentaba la información en diferentes pestañas asumiendo flujos ajenos a la lógica de **Origen Silvestre**.

## Fundamento de Arquitectura Comercial

1. **El Origen siempre es Costos:** **TODOS** los productos (sea un producto Simple, un producto Maestro, o una Variación) nacen de un producto maestro configurado en AppSheet (`costos_encabezados_productos`). Por ende, el campo `uid_producto_padre` (que enlaza a Costos) debe configurarse en la primera pantalla, la general.
2. **El Precio es Intrínseco:** El precio no es un módulo aparte. Todos los productos y variaciones tienen precio. Pertenece a la pestaña General.
3. **Clasificación Automática de Variaciones:**
   *   Si `producto_principal_variacion` está `VACÍO` y **NO** hay en base de datos otros productos que lo referencien -> Es un **Producto Simple**.
   *   Si `producto_principal_variacion` está `VACÍO` y **SÍ** hay otros productos que lo referencien -> Es un **Producto Variable (Maestro)**.
   *   Si `producto_principal_variacion` está `LLENO` (tiene UID) -> Es una **Variación** (apunta a su padre-maestro).
4. **Variaciones como "Hermanos en BD":** Las variaciones no viven en tablas subyacentes, viven en `com_productos`. Para mantener el flujo 5S de "No saltar de pantalla en pantalla", las variaciones de un producto se gestionarán desde una sección incrustada en su propia pestaña General.

---

## User Review Required

> [!CAUTION]
> **Santi, confirma el Flujo de Creación de Múltiples Variaciones:**
> Para cumplir con tu petición ("una sección en la misma pestaña general para poner las variaciones"), propongo esto:
> Al final de tu pestaña "General", verás un botón **[+ Agregar Variación]**. Al presionarlo, se abrirá un cajón (Modal rápido) flotante en pantalla pidiéndote los datos clave de ESA variación: 
> 1. Nombre (Ej: Miel 500g)
> 2. Selector de Costos (`uid_producto_padre` listando productos de AppSheet)
> 3. Su Precio.
> 4. Los atributos (Ej: Peso - 500g).
> 
> Al guardar esa modal flotante, el registro se graba por debajo en MySQL, se vincula a tu producto actual, y aparece ahí mismo en la listica de tu pantalla General, sin llevarte a otra página distinta. ¿Te parece Diamante este flujo?

---

## Proposed Changes

### [Frontend - Componentes]

> [!NOTE] 
> **Referencia Visual Obligatoria**: Antes de tocar el código de FormularioProducto.vue, el Constructor debe abrir y estudiar el archivo físico `.agent/bocetos/boceto_formulario_producto.png`. El código de la interfaz debe ser una representación técnica fiel de esa estructura lógica.

#### [MODIFICAR] [FormularioProducto.vue](file:///home/osserver/Proyectos_Antigravity/SOS_ERP/erp/frontend/src/modulos/comercial/FormularioProducto.vue)
*   **Alineamiento Estricto al Boceto Visual**:
    *   **Pestañas Finales**: `General`, `Contenido`, `Galeria`, `Auditoria`. (Se elimina "Precios", e "Historia/Contenido" se fusiona).
    *   **Pestaña General (Lado Izquierdo)**:
        *   **Identificación**: `Producto costos` (Selector de Costos, muestra nombre, guarda UID). `Nombre del producto` (Input con botón "✨ Sugerir" mediante IA asumiendo contexto comercial). `Estado`, `Publicación`, y **`url_producto`** (Input).
        *   **Precios**: `precio_regular`, `precio_oferta` y rango de fechas. Integrados nativamente bajo Identificación.
        *   **Clasificación**: `Categoría`, `Marca` (Implementar selector que consulte la tabla `com_marcas`, guardando el `uid` pero mostrando el nombre de la marca), `Etiquetas`.
    *   **Panel Lateral (Lado Derecho) - Variaciones**:
        *   Lista visual de variaciones registradas.
        *   Botón `[ + ]` para disparar el **"Popup Variación"** (Modal).

*   **[NUEVO] Popup Variación (Modal)**:
    *   **Bloque Principal**: **`Producto de Costos` (Selector de `uid_producto_padre` que listará Costos. DEBE SER EL CAMPO 1)**, `Nombre variacion`, `nombre_atributo_variacion`, `valor_atributo_variacion`.
    *   **Bloque "Auditoria" (Precios propios de la variación)**: `precio_regular`, `precio_oferta` y fechas de oferta.
    *   **Integración UX (IA Nativa)**: Botones de asistencia IA en los campos para autocorregir "grs" a "gramos", sugerir el nombre en base al atributo (Ej: "Miel 50g"), y prevenir que el usuario disocie el nombre del atributo padre si ya existen otras variaciones con "Peso".

### [Backend - API]

#### [MODIFICAR] [ProductoController.php](file:///home/osserver/Proyectos_Antigravity/SOS_ERP/erp/modulos/comercial/controladores/ProductoController.php)
*   **Nueva Acción `listar_variaciones`**: Acción súper ligera que reciba el `uid_maestro` y devuelva el listado de subproductos asociados (`SELECT id, uid, nombre, estado, precio_regular, nombre_atributo_variacion, valor_atributo_variacion FROM com_productos WHERE producto_principal_variacion = ?`). Esto alimenta el panel lateral.
*   **Nueva Acción `guardar_variacion_express`**: Un endpoint simplificado (o reusar `guardar_producto`) que recibe los datos provenientes del "Popup Variación", guardando y asegurando la vinculación padre-hijo correctamente bajo la misma tabla `com_productos`.
*   **[NUEVO] Controlador IA**: `AsistenteComercialController.php` (Acción: `sugerir_datos`). Recibe contexto parcial del frontend y llama a la API de **Gemini** mediante cURL para devolver sugerencias estructuradas (nombres comerciales o limpieza de atributos).
