# SKILL_FRONTEND_QUASAR.md
**Estado:** ✅ Validada
**Autor:** Claude Code (Constructor) + AntiGravity (Arquitecta)
**Fecha:** 2026-02-27
---

## Para qué sirve
Este skill documenta las mejores prácticas y soluciones a problemas comunes en el desarrollo del frontend del ERP usando **Vue 3, Quasar y Vite**, asegurando que la arquitectura de carpetas y alias se mantenga bajo la política 5S.

## Reglas que nunca se rompen
1. **Configuración de Alias**: Siempre usar el alias `modulos` para referenciar la carpeta `src/modulos/`. Esto evita rutas relativas largas y confusas.
2. **Placeholders de Ruta**: Nunca dejar una ruta en `routes.js` que apunte a un componente inexistente. Si el módulo no está listo, crear un componente mínimo con un mensaje de "Próximamente".
3. **Consistencia de Marca**: Usar siempre las variables de marca (`primary`, `secondary`, `positive`, etc.) definidas en `quasar.config.js` en lugar de colores hexadecimales directos en el CSS.

## Problemas conocidos y soluciones
### 1. Error de resolución de importación (Vite)
**Problema**: Vite no reconoce rutas como `modulos/comercial/...`.
**Causa**: Falta la configuración del alias en el motor de compilación.
**Solución**: Extender la configuración de Vite en `quasar.config.js`:
```javascript
// quasar.config.js
build: {
  extendViteConf (viteConf) {
    Object.assign(viteConf.resolve.alias, {
      modulos: fileURLToPath(new URL('./src/modulos', import.meta.url))
    })
  }
}
```

### 2. Error de compilación por archivos faltantes
**Problema**: La aplicación muestra una pantalla roja de error porque no encuentra un `.vue` referenciado en el router.
**Solución**: Aplicar la regla 5S de "Seiton" (Orden). Crear archivos base (Scaffolding) vacíos para todas las rutas definidas antes de intentar levantar el servidor de desarrollo.

### 3. Scaffolding manual (sin CLI de Quasar)
**Problema**: El servidor Linux no tiene Quasar CLI global. `quasar create` falla con "command not found".
**Causa**: Hostinger Shared Hosting y ambientes sin Node.js global no pueden ejecutar CLIs interactivos.
**Solución**: Crear manualmente los archivos mínimos del proyecto:
- `package.json` (con `quasar`, `@quasar/app-vite`, `vue`, `vue-router`, `@quasar/extras`, `sass`)
- `quasar.config.js` (con `defineConfig` de `#q-app/wrappers`)
- `index.html`
- `src/App.vue`, `src/router/index.js`, `src/router/routes.js`
- `src/layouts/LayoutPrincipal.vue`
- `src/css/quasar.variables.scss`, `src/css/app.scss`

### 4. Tabs personalizadas: usar `v-show`, no `q-tab-panels`
**Problema**: Se intentó usar `q-tab-panels` con una barra de tabs custom (sin `q-tabs`). Resultado: los paneles no responden porque `q-tab-panels` necesita estar vinculado a `q-tabs`.
**Solución**: Con barra de tabs custom, controlar el panel activo con `v-show`:
```vue
<!-- Tab bar custom (div, no q-tabs) -->
<div class="tabs-barra">
  <div v-for="tab in tabs" :key="tab.nombre"
    :class="['tab-item', { 'tab-item--activo': tabActiva === tab.nombre }]"
    @click="tabActiva = tab.nombre">
    {{ tab.label }}
  </div>
</div>

<!-- Paneles con v-show (no q-tab-panels) -->
<div v-show="tabActiva === 'general'"> ... </div>
<div v-show="tabActiva === 'precios'"> ... </div>
```

### 5. `v-show` vs `v-if` en tabs de formulario
**Problema**: Usar `v-if` en paneles de tabs destruye el estado del formulario cada vez que el usuario cambia de pestaña. Los datos escritos desaparecen.
**Regla**: En formularios, usar siempre `v-show`. Todos los paneles quedan montados en el DOM pero ocultos, manteniendo el estado reactivo.

### 6. Conflicto de colores: PLAN vs GUIA_ESTILOS
**Problema**: `PLAN_woocommerce.md` definía Verde Bosque `#2D5A27` y Naranja Terracota `#D2691E`. La `GUIA_ESTILOS.md` define Naranja OS `#E8750A` y Verde `#3A7A35`.
**Regla** (MANIFESTO sección 14.2): `GUIA_ESTILOS.md` es la fuente de verdad para todos los colores y estilos. Si hay conflicto con un plan, siempre gana la guía de estilos. Reportar el conflicto a Santi pero aplicar la guía.

---

## Ejemplos de código correcto
### Importación limpia en el Router
```javascript
// src/router/routes.js
{
  path: '/comercial/producto/:uid',
  component: () => import('modulos/comercial/FormularioProducto.vue')
}
```

### Componente Placeholder Estándar
```vue
<template>
  <q-page class="flex flex-center">
    <div class="text-h5 text-grey-6">Módulo en construcción: [Nombre]</div>
  </q-page>
</template>
```

### Patrón de sección dentro de card (`s-header`)
```vue
<div class="card-origenes q-pa-lg q-mb-md">
  <div class="s-header s-header--naranja q-mb-lg">
    <div class="s-header__icono" style="background:#FFF0E5">
      <q-icon name="inventory_2" size="15px" color="orange-8" />
    </div>
    <span class="s-header__titulo">Nombre de sección</span>
    <div class="s-header__linea" />
  </div>
  <!-- campos aquí -->
</div>
```
Variantes de color disponibles: `s-header--naranja`, `s-header--azul`, `s-header--verde`, `s-header--amarillo`.
