<template>
  <q-layout view="lHh Lpr lFf" class="bg-gradiente-oscuro">
    <q-page-container>
      <q-page class="flex flex-center">

        <!-- Tarjeta Central de Login -->
        <q-card
          class="q-pa-xl text-white no-shadow border-sutil"
          style="width: 440px; max-width: 92vw; background: rgba(20, 26, 22, 0.92); backdrop-filter: blur(16px); border-radius: 18px;"
        >
          <!-- Encabezado -->
          <div class="text-center q-mb-xl q-mt-sm">
            <q-avatar size="100px" class="q-mb-md" style="background: rgba(43, 194, 83, 0.08); border: 2px solid rgba(43,194,83,0.2);">
              <q-icon name="forest" size="58px" color="primary" />
            </q-avatar>
            <div class="text-h4 text-weight-bolder font-title" style="letter-spacing: 2px;">
              ORIGEN SILVESTRE
            </div>
            <div class="text-caption text-grey-5 font-mono q-mt-xs" style="letter-spacing: 1px;">
              ERP · Panel del Productor
            </div>
          </div>

          <!-- PANTALLA 1: SELECCIÓN DE MÉTODO DE INGRESO -->
          <div v-if="!requiereSeleccionEmpresa" class="text-center">

            <div class="text-body2 text-grey-4 q-mb-lg">
              Ingresa con tu cuenta corporativa
            </div>

            <!-- Botón Google OAuth — componente oficial vue3-google-login -->
            <div class="flex flex-center q-mb-lg">
              <GoogleLogin
                :callback="handleGoogleCallback"
                :buttonConfig="{
                  theme: 'outline',
                  size: 'large',
                  text: 'continue_with',
                  shape: 'rectangular',
                  width: 360,
                  locale: 'es'
                }"
              />
            </div>

            <!-- Indicador de carga mientras procesa -->
            <div v-if="cargando" class="flex flex-center q-mt-md">
              <q-spinner-dots color="primary" size="36px" />
              <span class="q-ml-sm text-grey-4 text-caption">Verificando identidad...</span>
            </div>

            <div class="text-caption text-grey-6 q-mt-xl" style="font-size: 10px;">
              🔒 Acceso protegido · Solo usuarios autorizados
            </div>
          </div>

          <!-- PANTALLA 2: SELECCIÓN DE EMPRESA -->
          <div v-else class="text-center">
            <q-icon name="domain" size="52px" color="primary" class="q-mb-sm" />
            <div class="text-h6 text-weight-bold q-mb-xs">Selecciona tu Empresa</div>
            <div class="text-caption text-grey-4 q-mb-lg">
              Tienes acceso a múltiples entornos. ¿A cuál deseas ingresar?
            </div>

            <div class="q-gutter-y-sm">
              <q-btn
                v-for="empresa in empresasDisponibles"
                :key="empresa.uid_empresa"
                unelevated
                no-caps
                align="left"
                class="full-width q-px-md q-py-sm"
                style="border-radius: 10px; border: 1px solid rgba(255,255,255,0.1); background: rgba(255,255,255,0.04);"
                @click="seleccionarEmpresa(empresa.uid_empresa)"
                :loading="empresaSeleccionada === empresa.uid_empresa"
              >
                <q-icon name="storefront" color="primary" class="q-mr-md" />
                <div class="col text-left">
                  <div class="text-body1 text-white text-weight-bold">{{ empresa.nombre_empresa }}</div>
                  <div class="text-caption text-grey-5">
                    {{ empresa.uid_empresa }}
                    <span class="q-ml-xs text-grey-6">[{{ empresa.siglas }}]</span>
                  </div>
                </div>
              </q-btn>
            </div>

            <q-btn
              flat
              no-caps
              color="grey-5"
              class="q-mt-lg"
              icon="arrow_back"
              label="Ingresar con otra cuenta"
              @click="cancelarSeleccion"
            />
          </div>

        </q-card>
      </q-page>
    </q-page-container>
  </q-layout>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useQuasar } from 'quasar'
import { useAuthStore } from 'src/stores/authStore'
import { GoogleLogin } from 'vue3-google-login'

const router    = useRouter()
const $q        = useQuasar()
const authStore = useAuthStore()

const cargando              = ref(false)
const requiereSeleccionEmpresa = ref(false)
const empresasDisponibles   = ref([])
const empresaSeleccionada   = ref(null)

// ── 1. Callback del componente GoogleLogin ────────────────────────
// response.credential es el id_token JWT firmado por Google.
// El backend lo valida en /api/sistema/login → accion: autenticar_google
const handleGoogleCallback = async (response) => {
  if (!response?.credential) return
  try {
    cargando.value = true
    const resultado = await authStore.autenticarGoogle(response.credential)
    manejarRespuestaAuth(resultado)
  } catch (err) {
    mostrarError(err.message)
  } finally {
    cargando.value = false
  }
}

// ── 2. Procesar respuesta: ¿ya entró o necesita elegir empresa? ───
const manejarRespuestaAuth = (resultado) => {
  if (resultado.requiereMapeo) {
    empresasDisponibles.value      = resultado.empresas
    requiereSeleccionEmpresa.value = true
  } else {
    router.push('/')
  }
}

// ── 3. Seleccionar empresa y obtener JWT definitivo ───────────────
const seleccionarEmpresa = async (uidEmpresa) => {
  try {
    empresaSeleccionada.value = uidEmpresa
    await authStore.seleccionarEmpresa(uidEmpresa)
    $q.notify({ type: 'positive', message: '¡Bienvenido a Origen Silvestre!' })
    router.push('/')
  } catch (err) {
    mostrarError(err.message)
    empresaSeleccionada.value = null
  }
}

// ── 4. Cancelar (vuelve a la pantalla de Google) ─────────────────
const cancelarSeleccion = () => {
  requiereSeleccionEmpresa.value = false
  empresasDisponibles.value      = []
  authStore.cerrarSesion()
}

// ── Utilidad: mostrar error ───────────────────────────────────────
const mostrarError = (msg) => {
  $q.notify({ type: 'negative', message: msg || 'Error desconocido', position: 'top', icon: 'warning' })
}
</script>

<style scoped>
.bg-gradiente-oscuro {
  background: radial-gradient(ellipse at 50% 100%, #0d2a1a 0%, #0a0e0c 65%, #000000 100%);
}
.border-sutil {
  border: 1px solid rgba(255, 255, 255, 0.06);
}
.font-title {
  font-family: 'Inter', 'Roboto', sans-serif;
}
.font-mono {
  font-family: 'Space Mono', 'Courier', monospace;
}
</style>
