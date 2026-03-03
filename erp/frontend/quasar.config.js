import { defineConfig } from '#q-app/wrappers'
import { fileURLToPath } from 'url'

export default defineConfig((_ctx) => {
  return {
    boot: ['googleAuth', 'pinia'],

    css: ['app.scss'],

    extras: ['material-icons'],

    build: {
      target: {
        browser: ['es2019', 'edge88', 'firefox78', 'chrome87', 'safari13.1'],
        node: 'node20'
      },
      vueRouterMode: 'hash',

      // Alias para que las rutas puedan importar con 'modulos/...'
      extendViteConf(viteConf) {
        Object.assign(viteConf.resolve.alias, {
          modulos: fileURLToPath(new URL('./src/modulos', import.meta.url))
        })
      }
    },

    devServer: {
      open: true,
      port: 5173
    },

    framework: {
      config: {
        brand: {
          primary: '#E8750A',
          secondary: '#3A7A35',
          accent: '#8DB89A',
          dark: '#2C2C28',
          positive: '#3A7A35',
          negative: '#C55E00',
          info: '#1A5ACC',
          warning: '#F0B822'
        }
      },
      plugins: ['Notify', 'Dialog', 'Loading']
    },

    animations: []
  }
})
