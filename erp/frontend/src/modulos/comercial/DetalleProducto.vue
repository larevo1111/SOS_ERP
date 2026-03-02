<template>
  <q-page class="pagina-detalle">

    <!-- ── CABECERA ─────────────────────────────────────────────── -->
    <div class="cabecera">
      <div class="cabecera__izq">
        <div class="cabecera__miga">
          <span class="cabecera__miga-link" @click="irAlCatalogo">Comercial</span>
          <q-icon name="chevron_right" size="14px" color="grey-4" />
          <span class="cabecera__miga-link" @click="irAlCatalogo">Productos</span>
          <q-icon name="chevron_right" size="14px" color="grey-4" />
          <span class="cabecera__miga-actual">{{ producto.nombre || '…' }}</span>
        </div>
        <div class="cabecera__titulo-row">
          <div class="cabecera__titulo">{{ producto.nombre }}</div>
          <div class="cabecera__chips">
            <span :class="['chip', producto.estado === 'Activo' ? 'chip--verde' : 'chip--gris']">
              {{ producto.estado }}
            </span>
            <span :class="['chip', `chip--pub-${producto.estado_publicacion || 'borrador'}`]">
              {{ producto.estado_publicacion || 'Borrador' }}
            </span>
            <span v-if="esMaestro" class="chip chip--maestro">★ Maestro</span>
            <span v-else class="chip chip--hija">↳ Variación</span>
          </div>
        </div>
      </div>
      <div class="cabecera__der">
        <q-btn flat no-caps icon="arrow_back" label="Volver" color="grey-6" size="sm" @click="irAlCatalogo" class="q-mr-sm" />
        <q-btn unelevated no-caps icon="edit" label="Editar producto" color="primary" @click="irAEditar" />
      </div>
    </div>
    <div class="cabecera__separador q-mb-xl" />

    <!-- ── CONTENIDO PRINCIPAL ──────────────────────────────────── -->
    <div v-if="cargando" class="flex flex-center q-pa-xl">
      <q-spinner-orbit size="48px" color="primary" />
    </div>

    <div v-else-if="!producto.uid" class="flex flex-center q-pa-xl">
      <div class="text-center text-grey-5">
        <q-icon name="inventory_2" size="64px" />
        <div class="text-h6 q-mt-md">Producto no encontrado</div>
      </div>
    </div>

    <div v-else class="detalle-grid">

      <!-- ─ Columna principal ─────────────────────────────────── -->
      <div class="detalle-principal">

        <!-- Galería de imágenes -->
        <div v-if="multimedia.length > 0" class="card-detalle q-mb-md">
          <div class="card-detalle__titulo">
            <q-icon name="photo_library" size="18px" color="orange-8" />
            Galería ({{ multimedia.length }})
          </div>
          <div class="galeria-grid">
            <div
              v-for="archivo in multimedia"
              :key="archivo.uid"
              class="galeria-item"
              :class="{ 'galeria-item--portada': archivo.uso === 'Principal' }"
            >
              <img :src="archivo.archivo_woocommerce || archivo.archivo_local" :alt="archivo.archivo_local" loading="lazy" />
              <div class="galeria-item__etiqueta">{{ archivo.uso }}</div>
            </div>
          </div>
        </div>

        <!-- Identificación -->
        <div class="card-detalle q-mb-md">
          <div class="card-detalle__titulo">
            <q-icon name="inventory_2" size="18px" color="orange-8" />
            Identificación
          </div>
          <div class="campo-row">
            <span class="campo-label">Nombre</span>
            <span class="campo-valor">{{ producto.nombre }}</span>
          </div>
          <div class="campo-row" v-if="producto.nombre_grupo_catalogo">
            <span class="campo-label">Grupo / Catálogo</span>
            <span class="campo-valor">{{ producto.nombre_grupo_catalogo }}</span>
          </div>
          <div class="campo-row" v-if="producto.nombre_atributo_variacion">
            <span class="campo-label">Atributo variación</span>
            <span class="campo-valor">{{ producto.nombre_atributo_variacion }}: {{ producto.valor_atributo_variacion }}</span>
          </div>
          <div class="campo-row">
            <span class="campo-label">Categoría</span>
            <span class="campo-valor">{{ producto.categoria || '—' }}</span>
          </div>
          <div class="campo-row">
            <span class="campo-label">Marca</span>
            <span class="campo-valor">{{ producto.marca || '—' }}</span>
          </div>
        </div>

        <!-- Precios -->
        <div class="card-detalle q-mb-md">
          <div class="card-detalle__titulo">
            <q-icon name="sell" size="18px" color="green-7" />
            Precios
          </div>
          <div class="campo-row">
            <span class="campo-label">Precio regular</span>
            <span class="campo-valor campo-valor--precio">{{ formatearPrecio(producto.precio_regular) }}</span>
          </div>
          <div class="campo-row" v-if="producto.precio_oferta">
            <span class="campo-label">Precio oferta</span>
            <span class="campo-valor campo-valor--oferta">{{ formatearPrecio(producto.precio_oferta) }}</span>
          </div>
        </div>

        <!-- Descripción y contenido -->
        <div class="card-detalle q-mb-md" v-if="producto.descripcion_corta || producto.descripcion_larga">
          <div class="card-detalle__titulo">
            <q-icon name="description" size="18px" color="blue-7" />
            Descripción
          </div>
          <div v-if="producto.descripcion_corta" class="q-mb-sm">
            <div class="campo-label q-mb-xs">Descripción corta</div>
            <div class="campo-texto">{{ producto.descripcion_corta }}</div>
          </div>
          <div v-if="producto.descripcion_larga">
            <div class="campo-label q-mb-xs">Descripción larga</div>
            <div class="campo-texto">{{ producto.descripcion_larga }}</div>
          </div>
        </div>

        <!-- Historia y marketing -->
        <div class="card-detalle q-mb-md" v-if="producto.origen_macro || producto.productor">
          <div class="card-detalle__titulo">
            <q-icon name="eco" size="18px" color="green-8" />
            Origen y Productor
          </div>
          <div class="campo-row" v-if="producto.productor">
            <span class="campo-label">Productor</span>
            <span class="campo-valor">{{ producto.productor }}</span>
          </div>
          <div class="campo-row" v-if="producto.ubicacion_productor">
            <span class="campo-label">Ubicación</span>
            <span class="campo-valor">{{ producto.ubicacion_productor }}</span>
          </div>
          <div v-if="producto.origen_macro" class="q-mt-sm">
            <div class="campo-label q-mb-xs">Origen</div>
            <div class="campo-texto">{{ producto.origen_macro }}</div>
          </div>
        </div>
      </div>

      <!-- ─ Panel lateral derecho ─────────────────────────────── -->
      <div class="detalle-lateral">

        <!-- Variaciones -->
        <div class="card-detalle q-mb-md">
          <div class="card-detalle__titulo q-mb-sm">
            <q-icon name="account_tree" size="18px" color="deep-orange-6" />
            Variaciones ({{ variaciones.length }})
          </div>
          <div v-if="variaciones.length === 0" class="text-grey-5 text-caption q-pa-sm text-center">
            Sin variaciones registradas
          </div>
          <div
            v-for="v in variaciones"
            :key="v.uid"
            class="variacion-item"
            @click="irADetalle(v.uid)"
          >
            <div class="variacion-item__nombre">{{ v.nombre }}</div>
            <div class="variacion-item__atributo text-caption text-grey-6" v-if="v.nombre_atributo_variacion">
              {{ v.nombre_atributo_variacion }}: {{ v.valor_atributo_variacion }}
            </div>
          </div>
        </div>

        <!-- Auditoría -->
        <div class="card-detalle">
          <div class="card-detalle__titulo">
            <q-icon name="manage_search" size="18px" color="grey-6" />
            Auditoría
          </div>
          <div class="campo-row">
            <span class="campo-label">UID</span>
            <span class="campo-valor text-mono text-caption">{{ producto.uid }}</span>
          </div>
          <div class="campo-row">
            <span class="campo-label">Empresa</span>
            <span class="campo-valor">{{ producto.empresa }}</span>
          </div>
          <div class="campo-row">
            <span class="campo-label">Creado</span>
            <span class="campo-valor">{{ formatearFecha(producto.fecha_creacion) }}</span>
          </div>
          <div class="campo-row">
            <span class="campo-label">Modificado</span>
            <span class="campo-valor">{{ formatearFecha(producto.fecha_ult_modificacion) }}</span>
          </div>
        </div>
      </div>
    </div>

  </q-page>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useQuasar } from 'quasar'
import { llamar } from '../../servicios/apiService.js'

const route  = useRoute()
const router = useRouter()
const $q     = useQuasar()

const cargando    = ref(true)
const producto    = ref({})
const multimedia  = ref([])
const variaciones = ref([])

const esMaestro = computed(() => !producto.value.producto_principal_variacion)

// ── Navegación ──────────────────────────────────────────────────
function irAlCatalogo () { router.push({ name: 'catalogo-productos' }) }
function irAEditar    () { router.push({ name: 'editar-producto', params: { uid: route.params.uid } }) }
function irADetalle   (uid) { router.push({ name: 'ver-producto', params: { uid } }) }

// ── Carga de datos ───────────────────────────────────────────────
async function cargarProducto () {
  cargando.value = true
  try {
    const uid = route.params.uid
    const respuesta = await llamar('comercial', 'productos', 'obtener_producto', { uid })
    if (respuesta?.producto) {
      producto.value    = respuesta.producto
      multimedia.value  = respuesta.multimedia  || []
      variaciones.value = respuesta.variaciones || []
    }
  } catch (error) {
    $q.notify({ type: 'negative', message: `Error cargando el producto: ${error.message}`, icon: 'error' })
  } finally {
    cargando.value = false
  }
}

// ── Formateo ─────────────────────────────────────────────────────
function formatearPrecio (valor) {
  if (!valor) return '—'
  return new Intl.NumberFormat('es-CO', { style: 'currency', currency: 'COP', minimumFractionDigits: 0 }).format(valor)
}

function formatearFecha (fecha) {
  if (!fecha) return '—'
  return new Date(fecha).toLocaleString('es-CO', {
    year: 'numeric', month: 'long', day: 'numeric',
    hour: '2-digit', minute: '2-digit'
  })
}

onMounted(cargarProducto)
</script>

<style lang="scss" scoped>
.pagina-detalle {
  padding: 28px 32px;
  max-width: 1440px;
  margin: 0 auto;
}

.cabecera {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 8px;

  &__miga {
    display: flex;
    align-items: center;
    gap: 4px;
    font-size: 12px;
    color: #9e9e9e;
    margin-bottom: 8px;
  }

  &__miga-link {
    cursor: pointer;
    &:hover { color: #E07A0C; }
  }

  &__miga-actual { font-weight: 500; color: #444; }

  &__titulo-row {
    display: flex;
    align-items: center;
    gap: 12px;
  }

  &__titulo {
    font-size: 22px;
    font-weight: 700;
    color: #1a1a1a;
  }

  &__chips {
    display: flex;
    gap: 6px;
    flex-wrap: wrap;
  }

  &__separador {
    height: 1px;
    background: #f0f0f0;
    margin-top: 12px;
  }

  &__der {
    display: flex;
    align-items: center;
    gap: 8px;
  }
}

.chip {
  padding: 2px 10px;
  border-radius: 20px;
  font-size: 11px;
  font-weight: 600;
  &--verde { background: #e8f5e9; color: #2e7d32; }
  &--gris  { background: #f5f5f5; color: #757575; }
  &--pub-borrador  { background: #fff8e1; color: #f57c00; }
  &--pub-publicado { background: #e8f5e9; color: #2e7d32; }
  &--pub-privado   { background: #fce4ec; color: #c62828; }
  &--pub-pendiente { background: #e3f2fd; color: #1565c0; }
  &--maestro { background: #fff3e0; color: #e65100; }
  &--hija    { background: #f3e5f5; color: #6a1b9a; }
}

.detalle-grid {
  display: grid;
  grid-template-columns: 1fr 320px;
  gap: 24px;

  @media (max-width: 900px) {
    grid-template-columns: 1fr;
  }
}

.card-detalle {
  background: white;
  border-radius: 12px;
  border: 1px solid #f0f0f0;
  padding: 20px 24px;

  &__titulo {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 13px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.6px;
    color: #9e9e9e;
    margin-bottom: 16px;
  }
}

.campo-row {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 12px;
  padding: 8px 0;
  border-bottom: 1px solid #fafafa;

  &:last-child { border-bottom: none; }
}

.campo-label {
  font-size: 12px;
  color: #9e9e9e;
  min-width: 120px;
}

.campo-valor {
  font-size: 13px;
  font-weight: 500;
  color: #333;
  text-align: right;

  &--precio { color: #333; font-size: 16px; font-weight: 700; }
  &--oferta { color: #e65100; font-size: 16px; font-weight: 700; }
}

.campo-texto {
  font-size: 13px;
  color: #444;
  line-height: 1.6;
  white-space: pre-wrap;
}

.galeria-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
  gap: 12px;
}

.galeria-item {
  position: relative;
  border-radius: 8px;
  overflow: hidden;
  aspect-ratio: 1;
  background: #f5f5f5;
  border: 2px solid transparent;

  &--portada { border-color: #E07A0C; }

  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  &__etiqueta {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background: rgba(0,0,0,0.6);
    color: white;
    font-size: 10px;
    text-align: center;
    padding: 3px 0;
  }
}

.variacion-item {
  padding: 10px 12px;
  border-radius: 8px;
  cursor: pointer;
  border: 1px solid #f0f0f0;
  margin-bottom: 6px;
  transition: all 0.2s;

  &:hover {
    border-color: #E07A0C;
    background: #fff8f0;
  }

  &__nombre { font-size: 13px; font-weight: 600; color: #333; }
}
</style>
