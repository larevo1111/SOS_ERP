# PLAN_woocommerce.md

Este plan define la hoja de ruta para la integración con WooCommerce y la estructura inicial del módulo comercial, tomando como referencia un diseño moderno y limpio.

## 1. Diseño y Estilos (Aesthetics)
- [/] Definir sistema de diseño en `/erp/frontend/src/compartido/estilos/`.
- [ ] Implementar layout base inspirado en estéticas tipo "Google" (limpio, mucha luz, micro-animaciones).
- [ ] Crear componentes base (botones, inputs, tarjetas de productos).

## 2. Configuración y Seguridad
- [ ] Implementar pantalla de "Ajustes de Sistema".
- [ ] Formulario para guardar llaves API de WooCommerce (asegurando almacenamiento cifrado o en `.env`).
- [ ] Configuración de servicios en la nube y llaves de otros agentes.
- [ ] Verificación de protocolos HTTPS/SSL para comunicación segura.

## 3. Gestión de Inventario (Módulo Comercial)
- [ ] **Formulario de Productos**: Crear interfaz para agregar productos manualmente al ERP.
- [ ] **Vista de Catálogo**: Tabla/Lista para visualizar productos existentes.
- [ ] Base de datos: Implementar tabla `com_productos` con los campos obligatorios del manifiesto.

## 4. Integración con WooCommerce
- [ ] Implementar cliente de conexión a la API de WC.
- [ ] Sincronización: Botón para importar productos desde la web.
- [ ] Registro de logs: Guardar historial de sincronización para auditoría.

---
**Agente a cargo:** AntiGravity (Madrina Arquitecta)
**Estado:** Esperando aprobación de Santi para iniciar ejecución.
