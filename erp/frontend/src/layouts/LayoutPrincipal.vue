<template>
  <q-layout view="lHh Lpr lFf">
    <!-- TOPBAR DE ESTADO -->
    <q-header elevated class="bg-dark text-white shadow-2 border-bottom-sutil">
      <q-toolbar style="height: 64px;" class="q-px-lg">
        <!-- Botón Hamburguesa Móvil -->
        <q-btn flat dense round icon="menu" aria-label="Menu" @click="menuAbierto = !menuAbierto" class="q-mr-sm lt-md" />
        
        <!-- Info del Usuario Logueado (Izquierda) -->
        <div class="flex items-center q-gutter-x-md" v-if="authStore.estaAutenticado">
          <q-avatar size="38px" color="primary" text-color="white">
            <img v-if="authStore.usuario?.foto" :src="authStore.usuario.foto" />
            <span v-else class="text-weight-bold">{{ authStore.usuario?.nombre?.charAt(0) || 'U' }}</span>
          </q-avatar>
          <div class="column justify-center" style="line-height: 1.2;">
            <div class="text-subtitle2 text-weight-bold">{{ authStore.usuario?.nombre || 'Usuario' }}</div>
            <div class="font-mono text-grey-5" style="font-size: 11px;">{{ authStore.usuario?.email || '' }}</div>
          </div>
          
          <q-separator vertical dark class="q-mx-sm opacity-30" />
          
          <!-- Selector Multi-tenant: muestra uid + nombre_empresa + siglas -->
          <div class="flex items-center q-gutter-x-sm">
            <div class="text-caption text-grey-4">Entorno:</div>
            <q-select
              dark
              dense
              outlined
              v-model="empresaSeleccionada"
              :options="opcionesEmpresas"
              option-value="uid_empresa"
              emit-value
              map-options
              style="min-width: 260px;"
              bg-color="black"
            >
              <template v-slot:prepend>
                <q-icon name="storefront" size="xs" />
              </template>
              <!-- Opción personalizada: uid · Nombre · [SIG] -->
              <template v-slot:option="scope">
                <q-item v-bind="scope.itemProps">
                  <q-item-section avatar><q-icon name="domain" size="xs" /></q-item-section>
                  <q-item-section>
                    <q-item-label class="text-weight-bold text-caption font-mono">{{ scope.opt.uid_empresa }}</q-item-label>
                    <q-item-label caption>{{ scope.opt.nombre_empresa }} · [{{ scope.opt.siglas }}]</q-item-label>
                  </q-item-section>
                </q-item>
              </template>
              <!-- Valor seleccionado: muestra nombre completo y siglas -->
              <template v-slot:selected-item="scope">
                <span class="text-white text-weight-bold" style="font-size:12px;">
                  {{ scope.opt.nombre_empresa }}
                  <span class="text-grey-4 q-ml-xs">[{{ scope.opt.siglas }}]</span>
                </span>
              </template>
            </q-select>
            <q-btn
              v-if="empresaSeleccionada !== authStore.empresaActiva"
              unelevated
              color="primary"
              icon="swap_horiz"
              label="Cambiar"
              dense
              class="q-px-sm text-weight-bold"
              @click="ejecutarCambioEmpresa"
              :loading="cargandoCambio"
            />
          </div>
        </div>
        
        <q-space />
        
        <!-- Reloj y Fecha (Derecha) -->
        <div class="flex items-center text-right q-gutter-x-sm font-mono text-grey-4">
          <q-icon name="schedule" size="sm" />
          <div>
            <div class="text-white text-weight-bold" style="font-size: 15px; letter-spacing: 1px;">{{ horaActual }}</div>
            <div style="font-size: 11px;">{{ fechaActual }}</div>
          </div>
        </div>
      </q-toolbar>
    </q-header>

    <!-- Sidebar -->
    <q-drawer v-model="menuAbierto" show-if-above :width="230" :breakpoint="768">
      <div class="sidebar">
        <!-- Logo -->
        <div class="sidebar__logo">
          <div class="sidebar__logo-mark">🌿</div>
          <div>
            <div class="sidebar__logo-nombre">Origen Silvestre</div>
            <div class="sidebar__logo-tag">ERP · Panel de control</div>
          </div>
        </div>

        <!-- Navegación -->
        <q-scroll-area class="sidebar__nav">
          <div class="nav-grupo">
            <div class="nav-grupo__label">Principal</div>
            <q-item clickable v-ripple :to="{ name: 'inicio' }" active-class="nav-item--activo" class="nav-item">
              <q-item-section avatar><q-icon name="dashboard" size="18px" /></q-item-section>
              <q-item-section>Dashboard</q-item-section>
            </q-item>
          </div>

          <div class="nav-grupo">
            <div class="nav-grupo__label">Módulos</div>

            <template v-for="nodoNivel1 in menuArbol" :key="nodoNivel1.uid">
              <q-expansion-item
                v-if="tieneHijos(nodoNivel1)"
                :default-opened="nodoAbiertoPorRuta(nodoNivel1)"
                class="nav-expansion nav-expansion--nivel-1"
                expand-icon-class="text-grey-6"
              >
                <template #header>
                  <q-item-section avatar>
                    <q-icon :name="nodoNivel1.icono || 'folder'" size="18px" />
                  </q-item-section>
                  <q-item-section class="nav-expansion__titulo">
                    {{ nodoNivel1.titulo }}
                  </q-item-section>
                </template>

                <template v-for="nodoNivel2 in nodoNivel1.hijos || []" :key="nodoNivel2.uid">
                  <q-expansion-item
                    v-if="tieneHijos(nodoNivel2)"
                    :default-opened="nodoAbiertoPorRuta(nodoNivel2)"
                    class="nav-expansion nav-expansion--nivel-2"
                    dense
                    expand-icon-class="text-grey-5"
                  >
                    <template #header>
                      <q-item-section avatar>
                        <q-icon :name="nodoNivel2.icono || 'subdirectory_arrow_right'" size="16px" />
                      </q-item-section>
                      <q-item-section class="nav-expansion__titulo nav-expansion__titulo--sub">
                        {{ nodoNivel2.titulo }}
                      </q-item-section>
                    </template>

                    <q-item
                      v-for="nodoNivel3 in nodoNivel2.hijos || []"
                      :key="nodoNivel3.uid"
                      clickable
                      v-ripple
                      :to="nodoNivel3.destino || undefined"
                      :disable="!nodoNivel3.destino"
                      active-class="nav-item--activo"
                      class="nav-item nav-item--nivel-3"
                    >
                      <q-item-section avatar>
                        <q-icon :name="nodoNivel3.icono || 'chevron_right'" size="14px" />
                      </q-item-section>
                      <q-item-section>{{ nodoNivel3.titulo }}</q-item-section>
                    </q-item>
                  </q-expansion-item>

                  <q-item
                    v-else
                    clickable
                    v-ripple
                    :to="nodoNivel2.destino || undefined"
                    :disable="!nodoNivel2.destino"
                    active-class="nav-item--activo"
                    class="nav-item nav-item--nivel-2"
                  >
                    <q-item-section avatar>
                      <q-icon :name="nodoNivel2.icono || 'chevron_right'" size="16px" />
                    </q-item-section>
                    <q-item-section>{{ nodoNivel2.titulo }}</q-item-section>
                  </q-item>
                </template>
              </q-expansion-item>

              <q-item
                v-else
                clickable
                v-ripple
                :to="nodoNivel1.destino || undefined"
                :disable="!nodoNivel1.destino"
                active-class="nav-item--activo"
                class="nav-item nav-item--nivel-1"
              >
                <q-item-section avatar><q-icon :name="nodoNivel1.icono || 'folder'" size="18px" /></q-item-section>
                <q-item-section>{{ nodoNivel1.titulo }}</q-item-section>
              </q-item>
            </template>
          </div>
        </q-scroll-area>

        <!-- Footer: Cerrar Sesión -->
        <div class="sidebar__footer">
          <q-btn
            unelevated
            class="full-width text-weight-bold btn-logout"
            icon="logout"
            label="Cerrar Sesión"
            @click="cerrarSesion"
          />
        </div>
      </div>
    </q-drawer>

    <!-- Contenido -->
    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script setup>
import { onMounted, onUnmounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useQuasar } from 'quasar'
import { llamar } from '../servicios/apiService.js'
import { useAuthStore } from '../stores/authStore.js'

const authStore = useAuthStore()
const $q = useQuasar()
const menuAbierto = ref(true)
const menuArbol = ref([])
const route = useRoute()
const router = useRouter()

// Variables Topbar Multi-tenant
const empresaSeleccionada = ref(authStore.empresaActiva || null)
const opcionesEmpresas = ref(authStore.empresas || [])
const cargandoCambio = ref(false)

// Variables Reloj
const horaActual = ref('')
const fechaActual = ref('')
let timerReloj = null

const rutasAlias = {
  'integracion-woocommerce': 'woocommerce'
}

const menuFallback = [
  {
    uid: 'fallback-comercial',
    titulo: 'Comercial',
    icono: 'store',
    destino: null,
    hijos: [
      { uid: 'fallback-catalogo', titulo: 'Catálogo Comercial', icono: 'inventory_2', destino: { name: 'catalogo-productos' }, hijos: [] },
      { uid: 'fallback-woo', titulo: 'Integración WooCommerce', icono: 'sync_alt', destino: { name: 'woocommerce' }, hijos: [] }
    ]
  }
]

function tieneHijos (nodo) {
  return Array.isArray(nodo?.hijos) && nodo.hijos.length > 0
}

function resolverDestino (rutaVue) {
  if (!rutaVue) return null
  const rutaNormalizada = rutasAlias[rutaVue] || rutaVue

  if (router.hasRoute(rutaNormalizada)) {
    return { name: rutaNormalizada }
  }

  const destinoPath = rutaNormalizada.startsWith('/') ? rutaNormalizada : `/${rutaNormalizada}`
  return destinoPath
}

function normalizarNodo (nodo) {
  return {
    uid: nodo.uid,
    titulo: nodo.titulo,
    icono: nodo.icono,
    destino: resolverDestino(nodo.ruta_vue),
    hijos: (nodo.hijos || []).map(normalizarNodo)
  }
}

function destinoEsActivo (destino) {
  if (!destino) return false
  if (typeof destino === 'string') return route.path === destino
  if (destino.name) return route.name === destino.name
  return false
}

function nodoAbiertoPorRuta (nodo) {
  if (destinoEsActivo(nodo.destino)) return true
  return (nodo.hijos || []).some(hijo => nodoAbiertoPorRuta(hijo))
}

async function cargarMenuDinamico () {
  try {
    const datos = await llamar('sistema', 'menu', 'obtener_menu', {})
    const menu = Array.isArray(datos?.menu) ? datos.menu : []
    menuArbol.value = menu.length > 0 ? menu.map(normalizarNodo) : menuFallback
  } catch (error) {
    console.warn('[LayoutPrincipal] No se pudo cargar menú dinámico:', error?.message)
    menuArbol.value = menuFallback
  }
}

function actualizarReloj() {
  const ahora = new Date()
  horaActual.value = ahora.toLocaleTimeString('es-CO', { hour: '2-digit', minute: '2-digit', second: '2-digit' })
  fechaActual.value = ahora.toLocaleDateString('es-CO', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' })
}

onMounted(() => {
  cargarMenuDinamico()
  actualizarReloj()
  timerReloj = setInterval(actualizarReloj, 1000)
})

onUnmounted(() => {
  if (timerReloj) clearInterval(timerReloj)
})

async function ejecutarCambioEmpresa() {
  if (!empresaSeleccionada.value) return
  cargandoCambio.value = true
  try {
    await authStore.cambiarEmpresaActiva(empresaSeleccionada.value)
    $q.notify({ type: 'positive', message: 'Entorno cambiado exitosamente.' })
    // Recargar duro la app para limpiar caches de Axios/Pinia y traer nuevos datos
    window.location.reload()
  } catch (error) {
    empresaSeleccionada.value = authStore.empresaActiva
    $q.notify({ type: 'negative', message: error.message || 'Error al cambiar empresa.' })
  } finally {
    cargandoCambio.value = false
  }
}

function cerrarSesion() {
  authStore.cerrarSesion()
  router.push('/login')
}
</script>

<style lang="scss" scoped>
.sidebar {
  height: 100%;
  display: flex;
  flex-direction: column;
  background: rgba(141, 184, 154, 0.08); /* Fondo Sutil verde */
  border-right: 1px solid rgba(141, 184, 154, 0.2);
  padding: 20px 0;
  background: rgba(141, 184, 154, 0.08);
  border-right: 1px solid rgba(141, 184, 154, 0.2);
  padding: 20px 0;

  &__logo {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 0 18px 20px;
    border-bottom: 1px solid rgba(141, 184, 154, 0.15);
    margin-bottom: 12px;
  }

  &__logo-mark {
    width: 38px;
    height: 38px;
    background: #2C2C28;
    border-radius: 11px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
    flex-shrink: 0;
  }

  &__logo-nombre {
    font-size: 13px;
    font-weight: 700;
    color: #1A1A1A;
  }

  &__logo-tag {
    font-size: 10px;
    color: #8A8A8A;
  }

  &__nav {
    flex: 1;
    padding: 0 10px;
  }

  &__footer {
    margin-top: auto;
    padding: 14px 18px 20px;
    border-top: 1px solid rgba(141, 184, 154, 0.15);
  }
}

.btn-logout {
  border-radius: 8px;
  font-size: 13px;
  background: rgba(197, 19, 19, 0.08) !important;
  color: #c51313 !important;
  transition: all 0.3s;
  
  &:hover {
    background: rgba(197, 19, 19, 0.15) !important;
  }
}

.border-bottom-sutil {
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
}
.font-mono {
  font-family: 'Space Mono', 'Courier', monospace;
}

.nav-grupo {
  margin-bottom: 4px;

  &__label {
    font-size: 9.5px;
    font-weight: 700;
    color: #AAAAAA;
    letter-spacing: 1.2px;
    text-transform: uppercase;
    padding: 12px 10px 6px;
  }
}

.nav-item {
  border-radius: 10px;
  font-size: 13px;
  font-weight: 500;
  color: #3A3A3A;
  margin-bottom: 1px;

  &--activo {
    background: rgba(232, 117, 10, 0.08) !important;
    color: #C55E00 !important;
    font-weight: 600;
  }

  &--nivel-1 {
    padding-left: 2px;
  }

  &--nivel-2 {
    margin-left: 10px;
    padding-left: 6px;
  }

  &--nivel-3 {
    margin-left: 28px;
    padding-left: 4px;
    font-size: 12.5px;
    position: relative;

    &::before {
      content: '';
      position: absolute;
      left: -10px;
      top: 8px;
      bottom: 8px;
      width: 2px;
      border-radius: 999px;
      background: rgba(141, 184, 154, 0.35);
    }
  }
}

.nav-expansion {
  border-radius: 10px;
  margin-bottom: 2px;
  
  &__titulo {
    font-size: 13px;
    font-weight: 500;
    color: #3A3A3A;
    text-align: left;

    &--sub {
      font-size: 12.5px;
      color: #4A4A4A;
      font-weight: 600;
    }
  }

  &--nivel-2 {
    margin-left: 10px;
    border-left: 2px solid rgba(141, 184, 154, 0.25);
    padding-left: 8px;
  }

  :deep(.q-item) {
    border-radius: 10px;
    padding: 8px 16px;
    min-height: 36px;
  }
}
</style>
