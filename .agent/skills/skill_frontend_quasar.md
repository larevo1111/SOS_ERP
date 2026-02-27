# SKILL_FRONTEND_QUASAR.md

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
