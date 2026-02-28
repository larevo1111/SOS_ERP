---
description: Reglas y Estándares para la Creación de Formularios (Campos Relacionales)
---

# SKILL: Creación de Formularios (Reglas Estrictas)

## Para qué sirve
Garantizar que todos los formularios creados por la IA respeten las integraciones arquitectónicas nativas de la base de datos (Llaves foráneas, Maestros, Costos). Evita la asunción de campos de texto libre cuando la arquitectura exige un selector dependiente de otra tabla.

## 1. Regla Suprema de `uid_producto_padre` (Conexión con Costos)
El campo `uid_producto_padre` **JAMÁS** debe ser un campo de texto libre ni de solo lectura oculto.
- **Naturaleza Funcional:** Sirve para enlazar cualquier producto comercial con su matriz en la tabla `costos_encabezados_productos`.
- **Implementación FrontEnd Obligatoria:** Debe implementarse como un componente de Búsqueda Dinámica (Ej: `<q-select>` con búsqueda asíncrona).
- **UX Exigida:** El usuario escribe el nombre (Ej: "Miel"), el select busca en costos, le muestra "Miel Silvestre 100g", el usuario lo selecciona, y el componente **guarda silenciosamente su `uid`** en el valor (`v-model`), pero visualmente mantiene el label bonito.
- **Aplicabilidad Universal:** Esta regla aplica tanto para Productos Principales, Maestros, Simples, o **Variaciones en un Modal**. Toda variación individual DEBE tener este selector apuntando a su matriz de Costos de forma obligatoria.

## 2. Regla de "Referencias Inteligentes"
Siempre que un modelo dependa del UID de otra tabla (Ej: `marca` referenciando a `com_marcas`, o `categoria` referenciando a `sys_categorias`), **NUNCA** se debe pedir escribir el texto.
Se debe cargar la lista de la tabla de origen, presentar los nombres al usuario, y guardar el UID asociado.

## 3. Disposición UX
Los campos maestros (como el selector de Costos en productos) deben ubicarse **ARRIBA, EN LA PRIMERA POSICIÓN**, antes que el nombre, el estado o el autocompletado de IA. Esto porque de su selección depende el contexto que la inteligencia artificial utilizará para sugerir los demás campos del formulario.
