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

#### [MODIFICAR] [FormularioProducto.vue](file:///home/osserver/.gemini/antigravity/scratch/SOS_ERP/erp/frontend/src/modulos/comercial/FormularioProducto.vue)
*   **Limpieza de Pestañas**: Eliminar las pestañas `Variación` y `Precios`. Las pestañas quedarán reducidas a: **General, Contenido, Multimedia, Auditoría**.
*   **Pestaña General Integrada**:
    *   **Identificación Central**: Reubicar el buscador `q-select` de Maestro de Costos (`uid_producto_padre`). El selector de Quasar retendrá internamente el `UID` de AppSheet, pero visualmente mostrará la etiqueta ("Nombre del Miel de Costos").
    *   **Sección Precios**: Traer los campos de `precio_regular` y `precio_oferta` (con sus fechas) a esta misma vista, justo debajo de la clasificación.
    *   **Sección de Variaciones**: Insertar al fondo de la pestaña General un bloque expansible o apartado claro.
        *   Si el producto cargado es una "Variación" (su campo `producto_principal_variacion` está lleno), esta sección se oculta (las variaciones no tienen meta-variaciones).
        *   Tendrá una lista que lee las variaciones existentes (llamada API que busca productos cuyo `producto_principal_variacion` = UID_Actual).
        *   Integra un componente `<q-dialog>` (Modal) para crear rápidamente un hijo-variación y asignarle de inmediato su enlace a Costos, Precio, y Atributos.

### [Backend - API]

#### [MODIFICAR] [ProductoController.php](file:///home/osserver/.gemini/antigravity/scratch/SOS_ERP/erp/modulos/comercial/controladores/ProductoController.php)
*   **Nueva Acción `listar_variaciones`**: Acción súper ligera que reciba el `uid_maestro` y devuelva el listado de subproductos asociados (`SELECT id, uid, nombre, estado, precio_regular, nombre_atributo_variacion, valor_atributo_variacion FROM com_productos WHERE producto_principal_variacion = ?`). Esto alimenta la lista de Variaciones de la vista General.
*   **Nueva Acción `guardar_variacion_express`**: Un endpoint simplificado (o reusar `guardar_producto`) que recibe Nombre, Precio, Atributo, Id de Costos y UID Padre Maestro, para guardar y asegurar la vinculación padre-hijo correctamente.
