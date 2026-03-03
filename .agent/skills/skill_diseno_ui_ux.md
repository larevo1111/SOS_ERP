---
description: Reglas de diseño de interfaz de usuario para el ERP. Encuadre de imágenes, tarjetas, popups y estilos visuales consistentes en todo el sistema.
---

# 🎨 Skill: Diseño UI/UX – Reglas Visuales del ERP

## 1. Imagen de Portada / Miniatura — Encuadre Obligatorio

**REGLA INAMOVIBLE:** Toda imagen mostrada en el ERP, ya sea en una tarjeta, tabla, popup o formulario, debe estar encuadrada en un contenedor de dimensiones fijas con `object-fit: cover`. Nunca se deben distorsionar ni mostrar a pantalla completa.

### Clases CSS Reusables:
```scss
// Miniatura en listas/tablas (ej. panel de variaciones)
.variacion-item__thumb {
  width: 40px; height: 40px;
  border-radius: 8px;
  border: 1px solid #EBEBEB;
  overflow: hidden;
  display: flex; align-items: center; justify-content: center;
  background: #F7F5F2;
  img { width: 100%; height: 100%; object-fit: cover; }
}

// Thumbnail en popups (vista lectura o edición de subregistro)
.variacion-popup-thumb {
  width: 80px; height: 80px;
  border-radius: 10px;
  border: 1px solid #EBEBEB;
  overflow: hidden;
  display: flex; align-items: center; justify-content: center;
  background: #F7F5F2;
  flex-shrink: 0;
  img { width: 100%; height: 100%; object-fit: cover; }
}
```

❌ **NUNCA** mostrar imágenes en una galería o popup con `max-height: XXXpx; width: auto`, porque se ven desproporcionadas y no respetan el encuadre del contenedor. 

## 2. Reglas de Popups (Modales)

- Los popups de **solo-lectura** deben ser limpios, con la imagen de thumbnail en una esquina y los datos textuales al lado usando un layout `row no-wrap`.
- Los popups de **edición** deben verse como formularios ordenados: selector, inputs, imagen del tamaño de un thumbnail (no gigante), y botones Cancelar/Guardar al final.
- El botón de **Guardar** siempre es `color="orange-9"` (naranja tierra del ERP).
- El botón de **Cancelar** siempre es `flat color="grey-7"`.

## 3. Icono Placeholder para Imágenes

Cuando un registro no tenga imagen asignada, mostrar siempre el ícono Material `category` con `color="grey-4"` dentro del contenedor encuadrado. No dejarlo en blanco ni con texto "Sin imagen".

```html
<q-icon name="category" size="16px" color="grey-4" />
```

## 4. Panel Lateral de Subregistros (Variaciones, Items, etc.)

Cada ítem de la lista en un panel lateral debe mostrar:
1. La miniatura de 40x40 a la izquierda (con encuadre `object-fit: cover`).
2. Un bloque de texto a la derecha (nombre, atributo y precio).
3. Toda la fila debe ser clickeable y tener efecto hover con borde naranja difuminado.

```vue
<div class="variacion-item">
  <div class="variacion-item__thumb">
    <img v-if="v.miniatura_url" :src="v.miniatura_url" alt="" />
    <q-icon v-else name="category" size="16px" color="grey-4" />
  </div>
  <div class="variacion-item__info">
    <div class="variacion-item__nombre">{{ v.nombre }}</div>
    ...
  </div>
</div>
```

---

## 5. 🔠 Estándar Tipográfico: Campo Nombre de Imagen (OBLIGATORIO EN TODAS LAS VISTAS)

> [!IMPORTANT]
> LA REFERENCIA OFICIAL es la **pestaña Galería** en el Formulario de Producto. Todos los campos de nombre de imagen en TODA la aplicación (Vista Detalle, popups de variación, formularios) **DEBEN** verse idénticos a esa galería.

### Reglas de Estilo (inamovibles)
- **Sin borde del browser**: `border: none; outline: none;` — el input no debe mostrar el recuadro negro del browser.
- **Fondo transparente**: `background: transparent;`
- **Tipografía**: `font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;`
- **Tamaño de fuente**: `font-size: 10.5px;` — pequeño, como una leyenda discreta.
- **Color**: `#7A7A7A` (gris natural, nunca negro).
- **Placeholder**: `font-style: italic; font-size: 10px; color: #C8C4BE;`

### CSS estándar (copiar sin modificar a todos los componentes que lo necesiten)
```scss
.galeria__nombre {
  padding: 4px 6px;
  background: rgba(0,0,0,0.02);
  border-radius: 0 0 10px 10px;
}

.input-nombre-nativo {
  flex: 1;
  border: none;
  outline: none;
  background: transparent;
  font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
  font-size: 10.5px;
  font-weight: 500;
  color: #7A7A7A;
  letter-spacing: 0.2px;
  min-width: 0;
  padding: 0 2px;
  transition: color 0.15s;

  &::placeholder {
    color: #C8C4BE;
    font-style: italic;
    font-size: 10px;
  }

  &:focus { color: #C55E00; }
}
```

### Estructura HTML estándar
```html
<!-- Siempre envolver el input con galeria__nombre + icono IA como q-icon -->
<div class="galeria__nombre row items-center no-wrap">
  <input v-model="archivo.nombre_archivo"
    class="input-nombre-nativo col"
    placeholder="Nombre SEO"
    @blur="actualizarNombreMultimedia(archivo)"
    @keyup.enter="$event.target.blur()"
  />
  <q-icon name="auto_awesome" color="grey-5" size="14px"
    class="cursor-pointer q-ml-xs"
    @click="solicitarNombreImagenIA(archivo)" />
</div>
```
