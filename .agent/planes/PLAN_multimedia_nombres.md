# Plan: Nombres de Archivos Multimedia, Previews y Sugerencias IA

## Objetivo
Cumplir los requisitos de WooCommerce y mejorar la experiencia visual en el ERP agregando un campo `nombre_archivo` editable a todos los adjuntos (imágenes, videos, documentos), permitiendo previsualizar videos directamente en el navegador, y usando IA para sugerir nombres SEO amigables.

## Cambios Propuestos

### 1. Base de Datos
- [x] Ejecutado en local: `ALTER TABLE com_productos_multimedia ADD COLUMN nombre_archivo VARCHAR(255) NULL AFTER tipo_archivo;`
- [ ] Actualizar el script de respaldo `inicializacion.sql` con el nuevo esquema de la tabla.

### 2. Backend (PHP)
- **SubirMultimedia.php**: 
  - Extraer el nombre original del archivo (sin extensión), limpiarlo, y guardarlo por defecto en la nueva columna `nombre_archivo`.
- **ActualizarNombreMultimedia.php (NUEVO)**: 
  - Crear este nuevo caso de uso para permitir que el frontend actualice en tiempo real el nombre de un archivo específico.
- **ProductoController.php**: 
  - Registrar la acción `actualizar_nombre_multimedia`.

### 3. Frontend (Vue)
- **FormularioProducto.vue**:
  - Reemplazar el ícono genérico de cámara de los videos por la etiqueta nativa `<video src="..." autoplay loop muted>` para que se vea la preview real.
  - Agregar un campo de texto pequeño y minimalista debajo de cada archivo ("galeria__item") unido por v-model a `archivo.nombre_archivo`.
  - Agregar un botón `blur` o evento `change` que dispare el guardado silencioso contra el backend (`ActualizarNombreMultimedia`).
  - Agregar un botón de "Sugerir IA" (✨) pequeñito al lado del nombre que llame al Asistente Comercial para generar un nombre optimizado para WooCommerce y SEO (ej: `miel-silvestre-pura-500g-frente`).
- **DetalleProducto.vue**:
  - Reemplazar el ícono genérico de cámara de los videos por la etiqueta `<video>`.
  - Mostrar debajo de cada miniatura el `nombre_archivo` con estilo elegante y tipografía pequeña (#7A7A7A).

## Plan de Verificación
1. **Prueba Visual**: Entrar al Formulario ➔ Subir un video MP4 y un documento PDF ➔ Comprobar que el video se reproduce en silencio y el documento muestra el ícono.
2. **Prueba de Edición**: Editar el nombre que aparece debajo de la foto ➔ Recargar la página ➔ Confirmar que el nombre persistió.
3. **Prueba de IA**: Hacer clic en el ✨ del nombre del archivo ➔ Confirmar que la IA propone un buen nombre basado en el título del producto.
4. **Prueba de Detalle**: Entrar al Detalle del producto ➔ Confirmar que el texto se lee bien y el diseño se mantiene minimalista y pulcro.
