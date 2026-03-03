# Plan de Conexión: El Gran Cableado (Fase 3)

Este plan detalla cómo uniremos el frontend con la API backend para que el **Módulo Comercial** sea 100% funcional.

## Proposed Changes

### [Frontend - Comunicación]

#### [NEW] [apiService.js](file:///home/osserver/Proyectos_Antigravity/SOS_ERP/erp/frontend/src/servicios/apiService.js)
*   **Gestor Central**: Clase o módulo literal para realizar peticiones `POST` al ERP.
*   **Seguridad**: Inyectará automáticamente el `token` de seguridad en cada petición (obtenido de una constante global).
*   **Enrutamiento**: Manejará la URL base `/api/` de forma dinámica.

### [Frontend - Formulario de Producto]

#### [MODIFICAR] [FormularioProducto.vue](file:///home/osserver/Proyectos_Antigravity/SOS_ERP/erp/frontend/src/modulos/comercial/FormularioProducto.vue)
*   **Carga Inicial**: Si hay un `uid` en la URL, solicitar los datos del producto a la API.
*   **Acción Guardar**: 
    1. Recopilar datos de todas las pestañas.
    2. Llamar a `guardar_producto`.
    3. Si es exitoso, actualizar el `uid` en la URL (si era nuevo).
*   **Multimedia (Nivel Experto)**:
    1. Implementar la subida secuencial de archivos al R2 vía `subir_multimedia`.
    2. Vincular los registros resultantes con el producto.
*   **Feedback 5S**: Usar `q.notify` de Quasar para mostrar estados de carga y confirmaciones elegantes.

## Verification Plan

### Manual Verification
1.  **Creación**: Llenar un producto nuevo, subir una foto y guardar. Verificar que aparezca en la BD y en Cloudflare.
2.  **Edición**: Cambiar el precio de un producto existente y verificar la actualización.
3.  **Variación**: Guardar un producto marcado como "Daughter" y verificar que se vincule al Maestro.
