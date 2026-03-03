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
