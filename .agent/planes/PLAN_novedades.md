# Plan de Integración de Novedades (Menú UX, Maestros y JWT)

Basado en los lineamientos recibidos por audio y la estructura 5S.

## Fase 6: Sistema de Menús Dinámicos de 3 Niveles (`sys_menu_v2`)
- **Estado**: Base de datos lista. Tabla `sys_menu_v2` creada y datos iniciales sembrados por AntiGravity. `MenuController.php` lista.
- **[ASIGNADO A CODEX] Front UX/UI**: Modificar `LayoutPrincipal.vue` para que consuma `/api/sistema/menu` y construya el menú dinámicamente usando `q-expansion-item` anidados. Aplicar sangrías profesionales que denoten niveles de jerarquía según los estándares 5S de la Guía de Estilos.

## Fase 7: Creación Comercial basada en Maestros de Costos
- **Objetivo**: Conectar Frontend con Maestros de costo y preparar WooCommerce.
- **Esquema Esencial a consultar (`costos_encabezados_productos`)**:
  - `Id` (int)
  - **`uid`** (varchar) -> *Será usado como enlace*
  - **`Producto`** (text) -> *Nombre del producto a mostrar*
- **[ASIGNADO A CLAUDE CODE] Backend**: 
  - Crear endpoint `listar_maestros_costo` que lea `uid` y `Producto` de `costos_encabezados_productos`.
  - Diseñar estructura base de sincronización (push/pull) con la API de WooCommerce.
- **[ASIGNADO A CODEX] Frontend**:
  - Implementar UI de `q-select` en `FormularioProducto.vue` para buscar/seleccionar productos base. 
  - Al seleccionar, establecer `uid_producto_padre` con el UID seleccionado y autocompletar el nombre comercial (permitiendo que el usuario lo sobrescriba sin afectar al maestro original).
  - UI de la vista `IntegracionWooCommerce.vue` (Tabla de estado/Log).

## Fase 8: Seguridad y Autenticación
- **Estrategia JWT (Decisión de Arquitectura)**: Utilizar el paquete oficial `firebase/php-jwt` vía Composer en el backend.
- **[ASIGNADO A CLAUDE CODE] Backend**: 
  - Inicializar Composer en la carpeta `/erp` de ser necesario: `composer require firebase/php-jwt`.
  - Crear `AuthController.php` (acción `login`) verificando password (hash local o texto según `sys_usuarios`).
  - Definir `JWT_SECRET` en archivo `.env` local.
  - Implementar middleware (rutas.php u otro intermedio) para rechazar peticiones `/api/*` sin JWT válido (excepto el propio `/api/sistema/login`).
- **[ASIGNADO A CODEX] Frontend**: 
  - Crear Vista `Login.vue` con estética corporativa 5S.
  - Modificar Vue Router para requerir autenticación (`requiresAuth`).
  - Actualizar `apiService.js` para añadir el header `Authorization: Bearer <token>` globalmente.
