# PLAN_woocommerce.md

Este plan define la hoja de ruta para la integración con WooCommerce y la estructura inicial del módulo comercial, tomando como referencia un diseño moderno y limpio.

## 1. Diseño y Estética: "Sistema Orígenes"
- [ ] **Mantra Visual**: Minimalismo elegante, 5S (Orden absoluto), Luz y Amigabilidad.
- [ ] **Paleta de Colores**:
    - `Fondo`: Off-White (#FDFDFB) para evitar fatiga visual.
    - `Primario`: Verde Bosque (#2D5A27) para botones de éxito y marca.
    - `Secundario`: Naranja Terracota (#D2691E) para acciones de WooCommerce y alertas.
    - `Estructura`: Dark Charcoal (#1A1C19) para sidebar y textos de alta jerarquía.
- [ ] **Tipografía**: Inter o Geist (Modernas y de alta legibilidad).
- [ ] **Componentes**: Glassmorphism sutil para tarjetas y micro-interacciones fluidas (hovers suaves).

## 2. Configuración y Seguridad
- [ ] Implementar pantalla de "Ajustes de Sistema".
- [ ] Formulario para guardar llaves API de WooCommerce (asegurando almacenamiento cifrado o en `.env`).
- [ ] Configuración de servicios en la nube y llaves de otros agentes.
- [ ] Verificación de protocolos HTTPS/SSL para comunicación segura.

## 3. Gestión de Inventario (Módulo Comercial)
- [ ] **Formulario "Orígenes" (Edición de Producto)**:
    - Layout de doble columna: Datos principales (izq) vs Media/Galería (der).
    - **Campos Protegidos**: Metadatos (`empresa`, fechas, autores) en un panel colapsable inferior de solo lectura.
    - **Relación con Marcas**: Selector dinámico cargado desde `com_marcas`.
- [ ] **Galería Multimedia 5S**:
    - Implementar zona de "Dropzone" para carga masiva.
    - Sincronización en tiempo real con la tabla `com_productos_multimedia`.
    - Ordenamiento por drag-and-drop (campo `orden` en BD).
- [ ] **Vista de Catálogo**: Tabla limpia con miniaturas de imágenes y estados (badge).

## 4. Integración con WooCommerce
- [ ] Implementar cliente de conexión a la API de WC.
- [ ] Sincronización: Botón para importar productos desde la web.
- [ ] Registro de logs: Guardar historial de sincronización para auditoría.

---
**Agente a cargo:** AntiGravity (Madrina Arquitecta)
**Estado:** Esperando aprobación de Santi para iniciar ejecución.
