# PLAN_woocommerce.md

Este plan define la hoja de ruta para la integración con WooCommerce y la estructura inicial del módulo comercial, tomando como referencia un diseño moderno y limpio.

## 1. Diseño y Estética: "Sistema Orígenes"
- [x] **Mantra Visual**: Minimalismo elegante, 5S (Orden absoluto), Luz y Amigabilidad.
- [x] **Paleta de Colores**:
    - `Fondo`: Off-White (#FDFDFB) para evitar fatiga visual.
    - `Primario`: Verde Bosque (#2D5A27) para botones de éxito y marca.
    - `Secundario`: Naranja Terracota (#D2691E) para acciones de WooCommerce y alertas.
    - `Estructura`: Dark Charcoal (#1A1C19) para sidebar y textos de alta jerarquía.
- [x] **Tipografía**: Inter o Geist (Modernas y de alta legibilidad).
- [x] **Componentes**: Glassmorphism sutil para tarjetas y micro-interacciones fluidas (hovers suaves).

## 2. Configuración y Seguridad
- [ ] Implementar pantalla de "Ajustes de Sistema".
- [ ] Formulario para guardar llaves API de WooCommerce (asegurando almacenamiento cifrado o en `.env`).
- [ ] Configuración de servicios en la nube y llaves de otros agentes.
- [ ] Verificación de protocolos HTTPS/SSL para comunicación segura.

## 3. Gestión de Inventario y Variaciones (5S Japonés)
- [x] **Arquitectura de Variación Representante**:
    - **Registro Maestro (Principal)**: Es una variación real (ej: 640g) que porta el `nombre_grupo_catalogo`. `producto_principal_variacion = NULL`.
    - **Variaciones (Hijas)**: Registros reales que apuntan al `uid` del Maestro. `nombre_grupo_catalogo` ignorado.
    - **Vínculo de Costos**: Todo producto "real" (Maestro o Hijo) debe tener su `uid_producto_padre` vinculado a Costos.
- [x] **Formulario Dinámico "Orígenes"**:
    - [x] **Detección de Patrones**: Campo `nombre_grupo_catalogo` asistido por IA (sugerencia basada en el nombre del artículo).
    - [x] **Gestión de Variaciones**: Panel lateral para añadir variaciones rápidas vinculadas al Maestro actual. (Scaffolding Quasar listo).
- [ ] **Galería Multimedia Avanzada**:
    - **Detección Automática**: Backend identifica Tipo (Imagen/Video) vía MIME.
    - **Selector de Uso**:
        - `Principal`: Imagen única de portada (Resaltada en UI).
        - `Galería`: Carrusel general de producto.
        - `Variación`: Imagen específica vinculada a una variación del producto.
    - **Orden e Integridad**: Arrastrar para reordenar (campo `orden`) con persistencia en `com_productos_multimedia`.
- [ ] **Vista de Catálogo**: Tabla limpia con miniaturas de imágenes y estados (badge).

## 4. Integración con WooCommerce
- [ ] Implementar cliente de conexión a la API de WC.
- [ ] Sincronización: Botón para importar productos desde la web.
- [ ] Registro de logs: Guardar historial de sincronización para auditoría.

---
**Agente a cargo:** AntiGravity (Madrina Arquitecta)
**Estado:** Esperando aprobación de Santi para iniciar ejecución.
