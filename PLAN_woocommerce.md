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

## 3. Gestión de Inventario y Variaciones (5S Japonés)
- [ ] **Arquitectura de Producto**:
    - **Productos Simples**: Registros base con `producto_principal_variacion = NULL`.
    - **Productos Variables (Padre)**: Registro maestro que agrupa variaciones.
    - **Variaciones (Hijo)**: Registros dependientes vinculados mediante `producto_principal_variacion` (apunta al `uid` del padre).
    - **Vínculo de Costos**: Mantenimiento del campo `uid_padre` para sincronización con `costos_encabezados_productos`.
- [ ] **Formulario Dinámico "Orígenes"**:
    - **Modo Inteligente**: Switch para alternar entre "Simple" y "Variable".
    - **Gestión de Atributos**: Campos dinámicos para `nombre_atributo_variacion` y `valor_atributo_variacion`.
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
