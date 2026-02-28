# Tareas SOS_ERP

- [x] Revisión de reglas y manifiesto
- [x] Definición de política 5S (Niveles de Aprobación)
- [x] Corregir numeración y convención de tablas en manifiesto
- [x] Corrección de subnumeración sección 11
- [x] Identificación de Agentes en Contexto
- [x] Verificación de Acceso SSH a Hostinger
- [x] Actualización de Política de Backups en Manifiesto
- [x] Documentación de Acceso SSH en Manifiesto
- [x] Simplificar sección 11.2 del Manifiesto
- [x] Actualizar motor de BD a MariaDB 11.8 en Manifiesto
- [x] Automatizar protocolo de backup en Manifiesto
- [x] Corrección de ruta de backups en Manifiesto
- [x] Crear estructura base de carpetas en `/erp`
- [x] Forzar seguimiento de carpetas vacías con `.gitkeep`
- [x] Investigación de referentes y propuesta de diseño
- [x] Unificar trabajo de Claude Code y AntiGravity en Guía de Estilos
- [x] Análisis técnico de tablas `com_` y relaciones `uid`
- [x] Documentar reglas de campos no editables en MANIFESTO.md
- [x] Diseñar lógica de Galería 5S (Uso y Tipo automático)
- [x] Analizar lógica de Variaciones (Parent/Child) y UID_Padre
- [x] Refinar `PLAN_woocommerce.md` con arquitectura de Variación Representante
- [x] Agregar campo `nombre_grupo_catalogo` a `com_productos` en BD local
- [x] Construcción de Frontend Base (Scaffolding + Formulario) por Claude Code
- [x] Auditoría de cumplimiento 5S y Guía de Estilos por AntiGravity
- [x] Previsualización del Frontend (Mesa de Revisión Visual)
- [x] Inauguración de Skills (.agent/skills/skill_frontend_quasar.md)
- [x] Certificación Final "Versión Diamante" del Manifiesto Operativo
- [x] **Fase 2: Infraestructura y Almacenamiento Global**
    - [x] Configuración de credenciales Cloudflare R2 en `.env`
    - [x] Sincronización de ambientes (PC Windows, Ubuntu, Hostinger)
    - [x] Definición de Arquitectura API: "Una API por Área/Pantalla"
    - [x] Creación de Estructura de Base de Datos Comercial (MariaDB)
    - [x] Implementación de `ProductoController.php` con Seguridad Token
    - [x] Creación de `.htaccess` para Enrutamiento API
    - [x] Actualización de Política de Skills y Validación de Skill Frontend

- [x] **Fase 3: El Gran Cableado (Conexión Frontend-Backend)** [Asignado: Claude Code]
    - [x] Diseño del Plan de Conexión (Mapeo de Datos y Multimedia)
    - [x] Implementación de `apiService.js` (Comunicación centralizada)
    - [x] Conexión de Acción "Guardar" en FormularioProducto.vue
    - [x] Conexión de Subida Multimedia (Cloudflare R2)
    - [x] Validación de Flujo Completo (Creación/Edición)

- [x] **Fase 4: Visualización (Catálogo y Detalle)** [Asignado: Codex]
    - [x] Diseño del Plan de Catálogo (Filtros y Paginación)
    - [x] Implementación de `accion: obtener_producto` en `ProductoController.php` (Por AntiGravity)
    - [x] Implementación de `accion: listar_productos` en `ProductoController.php` (Por AntiGravity)
    - [x] Creación de `CatalogoProductos.vue` (Tabla Quasar) (Por Codex)
    - [x] Integración de Filtros 5S (Marca, Categoría, Estado)

- [x] **Fase 5: Certificación y Pruebas de Carga**
    - [x] Generación de registros de ensayo complejos (Maestros + Variaciones)
    - [x] Pruebas de visualización multimedia (Portada/Galería) en Catálogo
    - [x] Verificación de integridad de datos en BD vs Vista de Edición
    - [x] Identificación y corrección de "Edge Cases" (CORS, index.php, htaccess)

- [x] **Fase 6: Menú Dinámico y Estética UX** [Madrina: AntiGravity]
    - [x] Creación de tabla `sys_menu_v2` con patrón Padre-Hijo (Adjacency List) [AntiGravity]
    - [x] Generar script de siembra (Seeder) con el menú base y módulo Comercial [AntiGravity]
    - [x] API `MenuController` para armar el árbol JSON anidado [AntiGravity]
    - [x] Refactor del Frontend `LayoutPrincipal.vue` para renderizado dinámico de 3 niveles **[Asignado: Codex]**

- [ ] **Fase 7: Integración WooCommerce (Maestros de Costos)**
    - [ ] API Endpoint `listar_maestros_costo` desde `costos_encabezados_productos` **[Asignado: Claude Code]**
    - [x] Implementar UI de `q-select` en `FormularioProducto.vue` para enlazar `uid_producto_padre` **[Asignado: Codex]**
    - [ ] Estructura base para sincronizar (push/pull) con API de WooCommerce **[Asignado: Claude Code]**
    - [ ] UI de la vista `IntegracionWooCommerce.vue` (Tabla de estado y botón Sync) **[Asignado: Codex]**

- [ ] **Fase 8: Seguridad y Autenticación**
    - [ ] API `AuthController.php` (Validación contra `sys_usuarios` y emisión de JWT) **[Asignado: Claude Code]**
    - [ ] Middlewares PHP para proteger peticiones `/api/*` exigiendo el JWT **[Asignado: Claude Code]**
    - [ ] Vista `Login.vue` con estética 5S y protección de Vue Router **[Asignado: Codex]**
    - [ ] Interceptor en `apiService.js` para adjuntar Token Bearer automáticamente **[Asignado: Codex]**
