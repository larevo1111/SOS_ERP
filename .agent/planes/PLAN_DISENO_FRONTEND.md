# PLAN DE DISEÑO Y UI: REFINAMIENTO DE MULTIMEDIA Y CATÁLOGO

**Para:** Claude Code (Ejecutor / Especialista UI-UX)
**De:** Antigravity (Arquitecta)
**Estado:** Listo para ejecución

## Contexto y Directrices
Como especialista y experto en diseño de interfaces (UI/UX) Frontend, tu misión es elevar la calidad visual del ERP `SOS_ERP`, enfocándote en el minimalismo, la elegancia tipográfica y la modernidad de las vistas, sin romper ABSOLUTAMENTE NINGUNA funcionalidad existente (especialmente las conexiones de base de datos, APIs de subida a R2, vue-router o props).

Santi (el Director del Proyecto) ha notado que, si bien la funcionalidad de guardado del `nombre_archivo` de las imágenes y videos ya funciona, el diseño se ve tosco, con "letras muy grandes, tipografía fea y un recuadro negro poco profesional".

## Tareas Específicas a Ejecutar

### 1. Refinamiento en la Galería (FormularioProducto.vue)
- En las galerías (principal y secundaria), elimina cualquier recuadro negro o diseño invasivo de los inputs de los nombres de archivo.
- Todo texto que muestre el `nombre_archivo` debajo de las imágenes/videos debe ser 100% minimalista, con una tipografía pequeña, limpia y elegante, que parezca parte natural de la tarjeta de la foto.

### 2. Inclusión del nombre_archivo en TODAS las vistas (DetalleProducto.vue)
- Actualmente el `nombre_archivo` se muestra en la Galería del formulario, pero DEBE agregarse visualmente en la **Vista de Detalle** (`DetalleProducto.vue`), debajo de TODAS las previsualizaciones de imágenes y videos.
- Esto incluye específicamente:
  - Imagen Principal.
  - Imágenes de Variaciones.
  - Galería Principal.
  - Galería Secundaria.
- El diseño debe ser consistente con la edición: súper minimalista, discreto, elegante (sin cajas negras).

### 3. Revisión Minuciosa del Estilo General (Todo el Frontend)
- Haz una revisión técnica y de diseño de los colores base, paleta de sombras y tipografía de los componentes principales (tarjetas, cabeceras de sección, botones) en `FormularioProducto.vue` y `DetalleProducto.vue`.
- Haz sugerencias y aplica pequeños retoques CSS que incrementen la sensación de ser un software "pro", moderno y premium. (Ej. suavizar bordes, ajustar letter-spacing, revisar pesos de fuente).
- **REGLA DE ORO:** NO modifiques variables reactivas (`v-model`), estructuras de datos del payload, ni la lógica profunda de Javascript. Estás operando en modo "Diseñador Senior".

### 4. Actualización del Skill de Diseño (POST-EJECUCIÓN)
- Una vez que Santi apruebe tus cambios de diseño, **DEBES** documentar los estándares que aplicaste (tipografía, colores minimalistas, cómo manejar captions de imágenes) en el skill correspondiente de frontend (ej. `skill_frontend.md` o crear uno nuevo `skill_diseño_ui.md`).

---

**Nota para Claude Code:** Santi espera que sorprendas con tu capacidad de diseño experto. Empieza revisando la estructura CSS de `.galeria-item` y `.galeria__nombre` en ambos archivos `.vue`. Sube el nivel.
