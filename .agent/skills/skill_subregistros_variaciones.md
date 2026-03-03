---
description: Reglas y estándares lógicos para el manejo de subregistros (ej. Variaciones) y su edición aislada sin corromper el producto maestro.
---

# 📋 Skill: Edición y Manejo Lógico de Subregistros / Variaciones — PATRÓN OFICIAL

## 1. Independencia Visual en la Edición

Cuando un entorno de negocio permite que un **Producto Maestro** tenga Subregistros o hijos (como es el caso de las Variaciones de WooCommerce o combos), estos subregistros generalmente poseen su propio ciclo de vida e identificador (UID).

**Error Común Lógico Lógico**:  
Abrir el modo de edición del "Producto Maestro" en el fondo, solo para lanzar un *Popup/Modal* que edite la Variación. 
El usuario percibirá (y con razón) que esto no tiene sentido. *¿Por qué entrar al Formulario del Padre (Maestro) si solo quiero editar un hijo independiente?*

## 2. Solución Oficial: Edición *In-Situ* (Dentro de Popups)

Para editar información sencilla de un subregistro, **NO** saques al usuario de la vista del Maestro. Lo correcto es utilizar una modificación *In-Situ* en el mismo modal/popup donde está visualizando la información.

- **Vista Detalle (Padre)**: Al abrir la Vista Detalle (`DetalleProducto.vue`), el usuario puede ver la lista de sus Variaciones.
- **Visualización (Popup)**: Si hace click en una variación, el sistema muestra un `q-dialog` (Modal) con la información de la hija. 
- **Modo Edición del Popup**: Ese mismo popup debe contar con un botón "Editar". Al presionarlo, el popup oculta las etiquetas de sololectura (`<span>` o `<div>`) y muestra `q-inputs` con los valores reactivos.
- **Guardado Independiente**: El botón "Guardar" del popup llama al API usando el UID de esa Variación específica, guarda en segundo plano, retorna al modo lectura y actualiza la lista visual inferior sin recargar el Maestro.

```vue
<!-- ✅ CORRECTO (Vue In-Situ) -->
<q-card-section>
  <div v-if="!editando">
    {{ variacion.nombre }}
  </div>
  <q-input v-else v-model="variacion.nombre" label="Nombre" />
</q-card-section>
<q-card-actions>
  <q-btn v-if="!editando" label="Editar" @click="editando = true" />
  <q-btn v-else label="Guardar" @click="guardarVariacionInline" />
</q-card-actions>
```

**❌ LO INCORRECTO Y REDUNDANTE (Lo que evitaremos)**
No debemos obligar al usuario a abandonar la Vista Detalle del maestro, ni llevarlo a la página gigante del formulario del subregistro, ni mucho menos cargar el "Modo de edición" del producto maestro por debajo solo para editar un precio. La edición atómica *in-situ* dentro del modal es el mejor flujo de UI para ERPs rápidos.

## 3. Comportamiento en Vistas Formularios (El "Modo Express")

A pesar del punto 2, si un usuario **ya está explícitamente dentro del modo de edición** del "Producto Maestro", allí SÍ es válido ofrecer un panel inferior rápido con las variaciones que dispare popups de guardado exprés.  
Pero siempre respetando que esa vía es solo un atajo estético dentro un formulario padre ya abierto voluntariamente; no debe ser la **ruta principal** heredada desde un panel de Detalles o Listado.

## Resumen de UX
* **Lápices de edición**: No deben repetirse. Si una tabla/lista de lectura ya tiene una cabecera, **no se le debe colocar un botón universal "editar todo"** a la lista si de todas maneras requerirá seleccionar las filas. Los lápices van siempre al lado (o adentro) del registro atómico o la celda que se planea afectar.
* **Componentización**: Utiliza siempre popups para vistas de solo-lectura sobre un Detalle, y formularios totales para la alteración, manteniendo un solo registro activo a la vez para no entorpecer la atención del director de sistema.

## 4. Estructura del Panel Lateral de Subregistros (Aprobado 2026-03-02)

Cada variación (o subregistro) listado en el panel lateral debe tener:
- Thumbnail de **40x40** a la izquierda con `object-fit: cover` (ver `skill_diseno_ui_ux.md`)
- Bloque de texto: nombre, atributo y precio
- Toda la fila es clickeable y muestra un popup

El listado genera las miniaturas desde el endpoint `listar_productos` que ya devuelve `miniatura_url`
(calculada con la ruta del archivo de uso='Variacion').

## 5. Popup de Variación — Dos Modos Aprobados

### MODO LECTURA (default al hacer click en la lista)
- Thumbnail grande de **80x80** (`variacion-popup-thumb`) a la izquierda
- Nombre, atributo, valor y precios en columna a la derecha
- Botón `Cerrar` + botón `Editar esta variación` en la parte inferior (naranja)

### MODO EDICIóN (al darle a "Editar")
- El MISMO popup cambia de modo. No se abre otro dialog ni otra página.
- Título cambia a: **"Edición Variación"**
- Muestra: selector Producto de Costos, Nombre, Tipo de Atributo, Valor, Precios x4, y miniatura de imagen (thumbnail clickeable para reemplazar)
- Botón `Cancelar` (gris) + `Guardar variación` (naranja tierra `color="orange-9"`)
- Al guardar: llama a `guardar_producto` con el UID de la Variación, sube imagen si hay nueva, refresca el Detalle en segundo plano sin mover al usuario de la vista.

