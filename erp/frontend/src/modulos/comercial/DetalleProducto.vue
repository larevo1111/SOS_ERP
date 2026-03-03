<template>
  <q-page class="pagina-detalle">

    <!-- ════════════════════════════════════════════════════════════
         CABECERA
    ═════════════════════════════════════════════════════════════ -->
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
        <q-btn flat no-caps icon="arrow_back" label="Volver"
          color="grey-6" size="sm" @click="irAlCatalogo" class="q-mr-sm" />
        <q-btn unelevated no-caps icon="edit" label="Editar"
          color="primary" @click="irAEditar" />
      </div>
    </div>
    <div class="cabecera__separador q-mb-lg" />

    <!-- Loading -->
    <div v-if="cargando" class="flex flex-center q-pa-xl">
      <q-spinner-orbit size="48px" color="primary" />
    </div>

    <!-- Vacío -->
    <div v-else-if="!producto.uid" class="flex flex-center q-pa-xl">
      <div class="text-center text-grey-5">
        <q-icon name="inventory_2" size="64px" />
        <div class="text-h6 q-mt-md">Producto no encontrado</div>
      </div>
    </div>

    <!-- ════════════════════════════════════════════════════════════
         CONTENIDO PRINCIPAL
    ═════════════════════════════════════════════════════════════ -->
    <div v-else class="cuerpo" :class="{ 'cuerpo--con-panel': esMaestro && tabActiva === 'general' }">

      <div class="contenido-principal">

        <!-- Barra de tabs -->
        <div class="tabs-barra q-mb-lg">
          <div
            v-for="tab in tabs"
            :key="tab.nombre"
            :class="['tab-item', { 'tab-item--activo': tabActiva === tab.nombre }]"
            @click="tabActiva = tab.nombre"
          >
            <q-icon :name="tab.icono" size="16px" class="tab-item__icono" />
            <span>{{ tab.label }}</span>
          </div>
        </div>

        <!-- ── TAB: GENERAL ──────────────────────────────────── -->
        <div v-show="tabActiva === 'general'">

          <!-- Identificación + foto principal -->
          <div class="card-seccion q-mb-md">
            <div class="s-header s-header--naranja q-mb-lg">
              <div class="s-header__icono" style="background:#FFF0E5">
                <q-icon name="inventory_2" size="15px" color="orange-8" />
              </div>
              <span class="s-header__titulo">Identificación</span>
              <div class="s-header__linea" />
            </div>

            <div class="identif-hero">
              <!-- Foto principal -->
              <div
                class="identif-hero__imagen"
                :class="{ 'identif-hero__imagen--clic': fotoPrincipal }"
                @click="fotoPrincipal && abrirLightbox(fotoPrincipal)"
              >
                <img v-if="fotoPrincipal"
                  :src="urlArchivo(fotoPrincipal)"
                  alt="Foto principal" />
                <div v-else class="identif-hero__placeholder">
                  <q-icon name="image" size="36px" color="grey-3" />
                  <div class="text-caption text-grey-4 q-mt-xs">Sin imagen</div>
                </div>
                <div v-if="fotoPrincipal" class="identif-hero__zoom">
                  <q-icon name="zoom_in" size="24px" color="white" />
                </div>
                <div v-if="fotoPrincipal" class="identif-hero__badge">★ Principal</div>
              </div>

              <!-- Campos de identificación -->
              <div class="identif-hero__datos">
                <div class="campo-row">
                  <span class="campo-label">Nombre</span>
                  <span class="campo-valor campo-valor--nombre">{{ producto.nombre }}</span>
                </div>
                <div class="campo-row" v-if="producto.nombre_grupo_catalogo">
                  <span class="campo-label">Grupo catálogo</span>
                  <span class="campo-valor">{{ producto.nombre_grupo_catalogo }}</span>
                </div>
                <div class="campo-row" v-if="producto.nombre_atributo_variacion">
                  <span class="campo-label">Atributo</span>
                  <span class="campo-valor">
                    {{ producto.nombre_atributo_variacion }}:
                    <strong>{{ producto.valor_atributo_variacion }}</strong>
                  </span>
                </div>
                <div class="campo-row">
                  <span class="campo-label">Categoría</span>
                  <span class="campo-valor">{{ producto.categoria || '—' }}</span>
                </div>
                <div class="campo-row">
                  <span class="campo-label">Marca</span>
                  <span class="campo-valor">{{ producto.marca || '—' }}</span>
                </div>
                <div class="campo-row" v-if="producto.estado_publicacion">
                  <span class="campo-label">Publicación</span>
                  <span :class="['chip', `chip--pub-${producto.estado_publicacion}`]" style="font-size:10px">
                    {{ producto.estado_publicacion }}
                  </span>
                </div>
              </div>
            </div>
          </div>

          <!-- Precios -->
          <div class="card-seccion q-mb-md" v-if="producto.precio_regular">
            <div class="s-header s-header--verde q-mb-lg">
              <div class="s-header__icono" style="background:#E8F5E5">
                <q-icon name="sell" size="15px" color="green-8" />
              </div>
              <span class="s-header__titulo">Precios</span>
              <div class="s-header__linea" />
            </div>
            <div class="precios-row">
              <div class="precio-item">
                <div class="campo-label q-mb-xs">Precio regular</div>
                <div class="campo-valor campo-valor--precio">{{ formatearPrecio(producto.precio_regular) }}</div>
              </div>
              <div class="precio-item" v-if="producto.precio_oferta">
                <div class="campo-label q-mb-xs">Precio oferta</div>
                <div class="campo-valor campo-valor--oferta">{{ formatearPrecio(producto.precio_oferta) }}</div>
              </div>
            </div>
          </div>

        </div>

        <!-- ── TAB: CONTENIDO ────────────────────────────────── -->
        <div v-show="tabActiva === 'contenido'">

          <div v-if="!tieneContenido" class="card-seccion flex flex-center column q-pa-xl text-grey-5">
            <q-icon name="description" size="56px" />
            <div class="q-mt-sm text-body2">No hay contenido registrado para este producto.</div>
            <q-btn flat no-caps label="Ir a editar" color="primary" icon="edit"
              class="q-mt-md" @click="irAEditar" />
          </div>

          <template v-else>

            <!-- Descripción -->
            <div class="card-seccion q-mb-md"
              v-if="producto.descripcion_corta || producto.descripcion_larga">
              <div class="s-header s-header--naranja q-mb-lg">
                <div class="s-header__icono" style="background:#FFF0E5">
                  <q-icon name="description" size="15px" color="orange-8" />
                </div>
                <span class="s-header__titulo">Descripción</span>
                <div class="s-header__linea" />
              </div>
              <div v-if="producto.descripcion_corta" class="q-mb-md">
                <div class="campo-label q-mb-sm">Descripción corta</div>
                <div class="campo-texto">{{ producto.descripcion_corta }}</div>
              </div>
              <div v-if="producto.descripcion_larga">
                <div class="campo-label q-mb-sm">Descripción larga</div>
                <div class="campo-texto">{{ producto.descripcion_larga }}</div>
              </div>
            </div>

            <!-- Puntos clave -->
            <div class="card-seccion q-mb-md" v-if="producto.bullets_superiores">
              <div class="s-header s-header--azul q-mb-lg">
                <div class="s-header__icono" style="background:#E5F0FF">
                  <q-icon name="format_list_bulleted" size="15px" color="blue-8" />
                </div>
                <span class="s-header__titulo">Puntos clave</span>
                <div class="s-header__linea" />
              </div>
              <div class="campo-texto">{{ producto.bullets_superiores }}</div>
            </div>

            <!-- Origen y Productor -->
            <div class="card-seccion q-mb-md"
              v-if="producto.origen_macro || producto.productor || producto.ubicacion_productor">
              <div class="s-header s-header--verde q-mb-lg">
                <div class="s-header__icono" style="background:#E8F5E5">
                  <q-icon name="agriculture" size="15px" color="green-8" />
                </div>
                <span class="s-header__titulo">Origen y Productor</span>
                <div class="s-header__linea" />
              </div>
              <div class="campo-row" v-if="producto.productor">
                <span class="campo-label">Productor</span>
                <span class="campo-valor">{{ producto.productor }}</span>
              </div>
              <div class="campo-row" v-if="producto.ubicacion_productor">
                <span class="campo-label">Ubicación</span>
                <span class="campo-valor">{{ producto.ubicacion_productor }}</span>
              </div>
              <div v-if="producto.origen_macro" class="q-mt-md">
                <div class="campo-label q-mb-sm">Origen</div>
                <div class="campo-texto">{{ producto.origen_macro }}</div>
              </div>
            </div>

            <!-- Composición -->
            <div class="card-seccion q-mb-md"
              v-if="producto.ingredientes_resumen || producto.tabla_nutricional">
              <div class="s-header s-header--amarillo q-mb-lg">
                <div class="s-header__icono" style="background:#FEF8E0">
                  <q-icon name="science" size="15px" color="amber-8" />
                </div>
                <span class="s-header__titulo">Composición</span>
                <div class="s-header__linea" />
              </div>
              <div v-if="producto.ingredientes_resumen" class="q-mb-md">
                <div class="campo-label q-mb-sm">Ingredientes / Resumen</div>
                <div class="campo-texto">{{ producto.ingredientes_resumen }}</div>
              </div>
              <div v-if="producto.tabla_nutricional">
                <div class="campo-label q-mb-sm">Tabla nutricional</div>
                <div class="campo-texto">{{ producto.tabla_nutricional }}</div>
              </div>
            </div>

          </template>
        </div>

        <!-- ── TAB: GALERÍA ──────────────────────────────────── -->
        <div v-show="tabActiva === 'galeria'">

          <div v-if="multimedia.length === 0"
            class="card-seccion flex flex-center column q-pa-xl text-grey-5">
            <q-icon name="photo_library" size="56px" />
            <div class="q-mt-sm text-body2">Sin archivos multimedia.</div>
            <q-btn flat no-caps label="Ir a galería" color="primary" icon="collections"
              class="q-mt-md" @click="irAGaleria" />
          </div>

          <template v-else>

            <!-- Galería principal -->
            <div class="card-seccion q-mb-md" v-if="fotosGaleria.length > 0">
              <div class="s-header s-header--naranja q-mb-lg">
                <div class="s-header__icono" style="background:#FFF0E5">
                  <q-icon name="photo_library" size="15px" color="orange-8" />
                </div>
                <span class="s-header__titulo">Galería ({{ fotosGaleria.length }})</span>
                <div class="s-header__linea" />
              </div>
              <div class="galeria-grid">
                <div v-for="f in fotosGaleria" :key="f.uid"
                  class="galeria-item cursor-pointer" @click="abrirLightbox(f)">
                  <template v-if="f.tipo_archivo === 'imagen'">
                    <img :src="urlArchivo(f)" :alt="f.uso" loading="lazy" />
                    <div class="galeria-item__zoom"><q-icon name="zoom_in" size="20px" color="white" /></div>
                  </template>
                  <template v-else-if="f.tipo_archivo === 'video'">
                    <div class="galeria-item__icono" style="background:#F3F1EE;width:100%;height:100%;display:flex;align-items:center;justify-content:center"><q-icon name="videocam" size="32px" color="grey-6" /></div>
                    <div class="galeria-item__zoom"><q-icon name="open_in_new" size="20px" color="white" /></div>
                  </template>
                  <div v-if="f.nombre_archivo" class="galeria-item__nombre" :title="f.nombre_archivo">
                    {{ f.nombre_archivo }}
                  </div>
                  <template v-else>
                    <div class="galeria-item__icono" style="background:#E5F0FF;width:100%;height:100%;display:flex;align-items:center;justify-content:center"><q-icon name="description" size="32px" color="blue-6" /></div>
                    <div class="galeria-item__zoom"><q-icon name="open_in_new" size="20px" color="white" /></div>
                  </template>
                  <div v-if="f.nombre_archivo" class="galeria-item__nombre" :title="f.nombre_archivo">
                    {{ f.nombre_archivo }}
                  </div>
                </div>
              </div>
            </div>

            <!-- Galería secundaria -->
            <div class="card-seccion q-mb-md" v-if="fotosGaleriaSecundaria.length > 0">
              <div class="s-header s-header--azul q-mb-lg">
                <div class="s-header__icono" style="background:#E5F0FF">
                  <q-icon name="collections" size="15px" color="blue-8" />
                </div>
                <span class="s-header__titulo">
                  Galería secundaria ({{ fotosGaleriaSecundaria.length }})
                </span>
                <div class="s-header__linea" />
              </div>
              <div class="galeria-grid">
                <div v-for="f in fotosGaleriaSecundaria" :key="f.uid"
                  class="galeria-item cursor-pointer" @click="abrirLightbox(f)">
                  <template v-if="f.tipo_archivo === 'imagen'">
                    <img :src="urlArchivo(f)" :alt="f.uso" loading="lazy" />
                    <div class="galeria-item__zoom"><q-icon name="zoom_in" size="20px" color="white" /></div>
                  </template>
                  <template v-else-if="f.tipo_archivo === 'video'">
                    <div class="galeria-item__icono" style="background:#F3F1EE;width:100%;height:100%;display:flex;align-items:center;justify-content:center"><q-icon name="videocam" size="32px" color="grey-6" /></div>
                    <div class="galeria-item__zoom"><q-icon name="open_in_new" size="20px" color="white" /></div>
                  </template>
                  <div v-if="f.nombre_archivo" class="galeria-item__nombre" :title="f.nombre_archivo">
                    {{ f.nombre_archivo }}
                  </div>
                  <template v-else>
                    <div class="galeria-item__icono" style="background:#E5F0FF;width:100%;height:100%;display:flex;align-items:center;justify-content:center"><q-icon name="description" size="32px" color="blue-6" /></div>
                    <div class="galeria-item__zoom"><q-icon name="open_in_new" size="20px" color="white" /></div>
                  </template>
                  <div v-if="f.nombre_archivo" class="galeria-item__nombre" :title="f.nombre_archivo">
                    {{ f.nombre_archivo }}
                  </div>
                </div>
              </div>
            </div>

            <!-- Imágenes de variaciones -->
            <div class="card-seccion q-mb-md" v-if="fotosVariacion.length > 0">
              <div class="s-header s-header--verde q-mb-lg">
                <div class="s-header__icono" style="background:#E8F5E5">
                  <q-icon name="account_tree" size="15px" color="green-8" />
                </div>
                <span class="s-header__titulo">
                  Imágenes de variaciones ({{ fotosVariacion.length }})
                </span>
                <div class="s-header__linea" />
              </div>
              <div class="galeria-grid">
                <div v-for="f in fotosVariacion" :key="f.uid"
                  class="galeria-item cursor-pointer" @click="abrirLightbox(f)">
                  <template v-if="f.tipo_archivo === 'imagen'">
                    <img :src="urlArchivo(f)" :alt="f.uso" loading="lazy" />
                    <div class="galeria-item__zoom"><q-icon name="zoom_in" size="20px" color="white" /></div>
                  </template>
                  <template v-else-if="f.tipo_archivo === 'video'">
                    <div class="galeria-item__icono" style="background:#F3F1EE;width:100%;height:100%;display:flex;align-items:center;justify-content:center"><q-icon name="videocam" size="32px" color="grey-6" /></div>
                    <div class="galeria-item__zoom"><q-icon name="open_in_new" size="20px" color="white" /></div>
                  </template>
                  <div v-if="f.nombre_archivo" class="galeria-item__nombre" :title="f.nombre_archivo">
                    {{ f.nombre_archivo }}
                  </div>
                  <template v-else>
                    <div class="galeria-item__icono" style="background:#E5F0FF;width:100%;height:100%;display:flex;align-items:center;justify-content:center"><q-icon name="description" size="32px" color="blue-6" /></div>
                    <div class="galeria-item__zoom"><q-icon name="open_in_new" size="20px" color="white" /></div>
                  </template>
                  <div v-if="f.nombre_archivo" class="galeria-item__nombre" :title="f.nombre_archivo">
                    {{ f.nombre_archivo }}
                  </div>
                </div>
              </div>
            </div>

            <div class="q-mt-md flex justify-end">
              <q-btn flat no-caps size="sm" icon="edit" label="Gestionar en formulario"
                color="grey-6" @click="irAGaleria" />
            </div>

          </template>
        </div>

        <!-- ── TAB: AUDITORÍA ────────────────────────────────── -->
        <div v-show="tabActiva === 'auditoria'">
          <div class="card-seccion">
            <div class="s-header s-header--gris q-mb-lg">
              <div class="s-header__icono" style="background:#F3F1EE">
                <q-icon name="manage_search" size="15px" color="grey-7" />
              </div>
              <span class="s-header__titulo">Datos de Auditoría</span>
              <div class="s-header__linea" />
            </div>
            <div class="auditoria-grid">
              <div class="campo-auditoria">
                <div class="campo-auditoria__label">UID del producto</div>
                <div class="campo-auditoria__valor mono">{{ producto.uid || '—' }}</div>
              </div>
              <div class="campo-auditoria">
                <div class="campo-auditoria__label">Empresa</div>
                <div class="campo-auditoria__valor">{{ producto.empresa || '—' }}</div>
              </div>
              <div class="campo-auditoria">
                <div class="campo-auditoria__label">ID en WooCommerce</div>
                <div class="campo-auditoria__valor">
                  {{ producto.id_producto_woocommerce || 'No sincronizado' }}
                </div>
              </div>
              <div class="campo-auditoria">
                <div class="campo-auditoria__label">URL del producto</div>
                <div class="campo-auditoria__valor mono">{{ producto.url_producto || '—' }}</div>
              </div>
              <div class="campo-auditoria">
                <div class="campo-auditoria__label">Creado por</div>
                <div class="campo-auditoria__valor">{{ producto.usuario_creador || '—' }}</div>
              </div>
              <div class="campo-auditoria">
                <div class="campo-auditoria__label">Última modificación por</div>
                <div class="campo-auditoria__valor">{{ producto.usuario_ult_modificacion || '—' }}</div>
              </div>
              <div class="campo-auditoria">
                <div class="campo-auditoria__label">Fecha de creación</div>
                <div class="campo-auditoria__valor">{{ formatearFecha(producto.fecha_creacion) }}</div>
              </div>
              <div class="campo-auditoria">
                <div class="campo-auditoria__label">Última modificación</div>
                <div class="campo-auditoria__valor">{{ formatearFecha(producto.fecha_ult_modificacion) }}</div>
              </div>
            </div>
          </div>
        </div>

      </div>

      <!-- ════════════════════════════════════════════════════════
           PANEL LATERAL: Variaciones (solo en tab General)
      ═════════════════════════════════════════════════════════ -->
      <div v-if="esMaestro && tabActiva === 'general'" class="panel-variaciones card-seccion q-pa-lg">
        <div class="panel-variaciones__cabecera q-mb-md">
          <div>
            <div class="texto-seccion">Variaciones</div>
            <div class="text-caption text-grey-5 q-mt-xs">
              {{ variaciones.length }} registrada{{ variaciones.length !== 1 ? 's' : '' }}
            </div>
          </div>
          <q-btn flat round dense icon="edit" size="sm" color="grey-6" @click="irAEditar">
            <q-tooltip>Editar para agregar variaciones</q-tooltip>
          </q-btn>
        </div>

        <div v-if="variaciones.length === 0"
          class="text-caption text-grey-5 text-center q-pa-sm">
          Sin variaciones registradas
        </div>

        <div v-for="v in variaciones" :key="v.uid"
          class="variacion-item" @click="irADetalle(v.uid)">
          <div class="variacion-item__nombre">{{ v.nombre }}</div>
          <div class="variacion-item__atributo text-caption text-grey-6"
            v-if="v.nombre_atributo_variacion">
            {{ v.nombre_atributo_variacion }}: <strong>{{ v.valor_atributo_variacion }}</strong>
          </div>
          <div class="variacion-item__precio text-caption q-mt-xs"
            v-if="v.precio_regular">
            {{ formatearPrecio(v.precio_regular) }}
          </div>
        </div>
      </div>

    </div>

    <!-- ════════════════════════════════════════════════════════════
         LIGHTBOX
    ═════════════════════════════════════════════════════════════ -->
    <q-dialog v-model="lightboxAbierto" maximized transition-show="fade" transition-hide="fade">
      <div
        style="background:rgba(0,0,0,0.92);width:100%;height:100%;display:flex;align-items:center;justify-content:center;cursor:pointer;position:relative;"
        @click="lightboxAbierto = false"
      >
        <img
          :src="lightboxSrc"
          style="max-width:90vw;max-height:88vh;border-radius:8px;object-fit:contain;box-shadow:0 20px 60px rgba(0,0,0,0.5);"
          @click.stop
          alt=""
        />
        <q-btn
          flat round dense icon="close" color="white"
          style="position:absolute;top:20px;right:20px;"
          @click.stop="lightboxAbierto = false"
        />
      </div>
    </q-dialog>

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

const tabs = [
  { nombre: 'general',   label: 'General',   icono: 'inventory_2' },
  { nombre: 'contenido', label: 'Contenido', icono: 'description' },
  { nombre: 'galeria',   label: 'Galería',   icono: 'photo_library' },
  { nombre: 'auditoria', label: 'Auditoría', icono: 'manage_search' }
]

const tabActiva       = ref('general')
const cargando        = ref(true)
const producto        = ref({})
const multimedia      = ref([])
const variaciones     = ref([])
const lightboxAbierto = ref(false)
const lightboxSrc     = ref('')

const esMaestro = computed(() => !producto.value.producto_principal_variacion)

// Vistas filtradas por sección
const fotoPrincipal          = computed(() => multimedia.value.find(m => m.uso === 'Principal') || null)
const fotosGaleria           = computed(() => multimedia.value.filter(m => m.uso === 'Galeria'))
const fotosGaleriaSecundaria = computed(() => multimedia.value.filter(m => m.uso === 'Galeria secundaria'))
const fotosVariacion         = computed(() => multimedia.value.filter(m => m.uso === 'Variacion'))

const tieneContenido = computed(() =>
  producto.value.descripcion_corta ||
  producto.value.descripcion_larga ||
  producto.value.bullets_superiores ||
  producto.value.origen_macro ||
  producto.value.productor ||
  producto.value.ingredientes_resumen ||
  producto.value.tabla_nutricional
)

// URL de imagen según skill_multimedia_r2.md §5.3
function urlArchivo (archivo) {
  return archivo.url_publica_calculada || archivo.archivo_woocommerce || archivo.archivo_local || ''
}

function abrirLightbox (archivo) {
  const url = urlArchivo(archivo)
  if (archivo.tipo_archivo !== 'imagen') {
    window.open(url, '_blank')
    return
  }
  lightboxSrc.value = url
  lightboxAbierto.value = true
}

// ── Navegación ──────────────────────────────────────────────────
function irAlCatalogo () { router.push({ name: 'catalogo-productos' }) }
function irAEditar    () { router.push({ name: 'editar-producto', params: { uid: route.params.uid } }) }
function irAGaleria   () { router.push({ name: 'editar-producto', params: { uid: route.params.uid }, query: { tab: 'galeria' } }) }
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
  return new Intl.NumberFormat('es-CO', {
    style: 'currency', currency: 'COP', minimumFractionDigits: 0
  }).format(valor)
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
// Referencia visual: .agent/diseno/GUIA_ESTILOS.md

.pagina-detalle {
  padding: 28px 32px;
  max-width: 1440px;
  margin: 0 auto;
}

// ══════════════════════════════════════════════════════════════════
// CABECERA
// ══════════════════════════════════════════════════════════════════
.cabecera {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 20px;

  &__izq { flex: 1; min-width: 0; }

  &__miga {
    display: flex;
    align-items: center;
    gap: 4px;
    margin-bottom: 8px;
    font-size: 12px;
  }

  &__miga-link {
    color: #AAAAAA;
    cursor: pointer;
    transition: color 0.15s;
    &:hover { color: #E8750A; }
  }

  &__miga-actual {
    color: #6A6A6A;
    font-weight: 500;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }

  &__titulo-row {
    display: flex;
    align-items: center;
    gap: 12px;
    flex-wrap: wrap;
  }

  &__titulo {
    font-size: 24px;
    font-weight: 800;
    color: #1A1A1A;
    line-height: 1.2;
  }

  &__chips {
    display: flex;
    align-items: center;
    gap: 6px;
    flex-wrap: wrap;
  }

  &__der {
    display: flex;
    align-items: center;
    flex-shrink: 0;
    padding-top: 28px;
  }

  &__separador {
    height: 1px;
    background: linear-gradient(90deg, #E8750A22 0%, #E0DDD8 30%, #F8F7F5 100%);
    margin-top: 16px;
  }
}

// ── Chips de estado ───────────────────────────────────────────────
.chip {
  font-size: 10px;
  font-weight: 700;
  padding: 3px 10px;
  border-radius: 20px;
  white-space: nowrap;
  letter-spacing: 0.2px;

  &--verde   { background: #E8F5E5; color: #2E7A2A; }
  &--gris    { background: #F3F1EE; color: #7A7A7A; }
  &--maestro { background: #FEF8E0; color: #9A7200; }
  &--hija    { background: #E5F0FF; color: #1A5ACC; font-family: monospace; }
  &--pub-borrador  { background: #F3F1EE; color: #7A7A7A; }
  &--pub-publicado { background: #E8F5E5; color: #2E7A2A; }
  &--pub-privado   { background: #E5F0FF; color: #1A5ACC; }
  &--pub-pendiente { background: #FEF8E0; color: #9A7200; }
}

// ══════════════════════════════════════════════════════════════════
// LAYOUT PRINCIPAL
// ══════════════════════════════════════════════════════════════════
.cuerpo {
  &--con-panel {
    display: grid;
    grid-template-columns: 1fr 280px;
    gap: 24px;
    align-items: start;

    @media (max-width: 900px) {
      grid-template-columns: 1fr;
    }
  }
}

// ══════════════════════════════════════════════════════════════════
// TABS (mismo diseño que FormularioProducto)
// ══════════════════════════════════════════════════════════════════
.tabs-barra {
  display: flex;
  gap: 2px;
  background: #fff;
  border: 1px solid rgba(0, 0, 0, 0.05);
  border-radius: 14px;
  padding: 5px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
  overflow-x: auto;

  &::-webkit-scrollbar { height: 0; }
}

.tab-item {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 8px 16px;
  border-radius: 10px;
  font-size: 12px;
  font-weight: 600;
  color: #7A7A7A;
  cursor: pointer;
  white-space: nowrap;
  transition: all 0.15s;
  user-select: none;

  &__icono { opacity: 0.6; transition: opacity 0.15s; }

  &:hover {
    background: #F8F7F5;
    color: #3A3A3A;
    .tab-item__icono { opacity: 0.8; }
  }

  &--activo {
    background: rgba(232, 117, 10, 0.09);
    color: #C55E00;
    .tab-item__icono { opacity: 1; color: #E8750A; }
  }
}

// ══════════════════════════════════════════════════════════════════
// CARDS DE SECCIÓN
// ══════════════════════════════════════════════════════════════════
.card-seccion {
  background: #FFFFFF;
  border-radius: 16px;
  padding: 20px 24px;
  border: 1px solid rgba(0, 0, 0, 0.04);
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06), 0 4px 16px rgba(0, 0, 0, 0.04);
}

// ── Encabezados de sección ────────────────────────────────────────
.s-header {
  display: flex;
  align-items: center;
  gap: 10px;

  &__icono {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 28px;
    height: 28px;
    border-radius: 8px;
    flex-shrink: 0;
  }

  &__titulo {
    font-size: 11px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    color: #9A9A9A;
    white-space: nowrap;
  }

  &__linea {
    flex: 1;
    height: 1px;
    background: #F0EDE8;
  }
}

// ══════════════════════════════════════════════════════════════════
// CAMPOS
// ══════════════════════════════════════════════════════════════════
.campo-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
  padding: 9px 0;
  border-bottom: 1px solid #F3F1EE;

  &:last-child { border-bottom: none; }
}

.campo-label {
  font-size: 11px;
  font-weight: 600;
  color: #AAAAAA;
  text-transform: uppercase;
  letter-spacing: 0.4px;
  flex-shrink: 0;
  min-width: 110px;
}

.campo-valor {
  font-size: 13px;
  font-weight: 500;
  color: #2A2A2A;
  text-align: right;

  &--nombre { font-size: 15px; font-weight: 700; color: #1A1A1A; }
  &--precio  { font-size: 20px; font-weight: 800; color: #1A1A1A; }
  &--oferta  { font-size: 20px; font-weight: 800; color: #E8750A; }
}

.campo-texto {
  font-size: 13px;
  color: #3A3A3A;
  line-height: 1.7;
  white-space: pre-wrap;
}

// ══════════════════════════════════════════════════════════════════
// HERO — Identificación con foto principal
// ══════════════════════════════════════════════════════════════════
.identif-hero {
  display: flex;
  gap: 24px;
  align-items: flex-start;

  @media (max-width: 600px) {
    flex-direction: column;
  }

  &__imagen {
    flex-shrink: 0;
    width: 160px;
    height: 160px;
    border-radius: 12px;
    overflow: hidden;
    background: #F8F7F5;
    border: 1px solid rgba(0, 0, 0, 0.06);
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;

    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      display: block;
      transition: transform 0.25s;
    }

    &--clic {
      cursor: pointer;
      &:hover {
        img { transform: scale(1.04); }
        .identif-hero__zoom { opacity: 1; }
      }
    }
  }

  &__zoom {
    position: absolute;
    inset: 0;
    background: rgba(0, 0, 0, 0.30);
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    transition: opacity 0.2s;
  }

  &__badge {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background: rgba(232, 117, 10, 0.88);
    color: white;
    font-size: 9px;
    font-weight: 700;
    text-align: center;
    padding: 4px 0;
    letter-spacing: 0.3px;
  }

  &__placeholder {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 100%;
  }

  &__datos {
    flex: 1;
    min-width: 0;
  }
}

// ── Precios ───────────────────────────────────────────────────────
.precios-row {
  display: flex;
  gap: 40px;
  align-items: flex-end;
  flex-wrap: wrap;
}

.precio-item {
  .campo-label { margin-bottom: 4px; }
}

// ══════════════════════════════════════════════════════════════════
// GALERÍA
// ══════════════════════════════════════════════════════════════════
.galeria-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(130px, 1fr));
  gap: 12px;
}

.galeria-item {
  position: relative;
  border-radius: 10px;
  overflow: hidden;
  aspect-ratio: 1;
  background: #F8F7F5;
  border: 1px solid rgba(0, 0, 0, 0.05);

  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
    transition: transform 0.2s;
  }

  &__zoom {
    position: absolute;
    inset: 0;
    background: rgba(0, 0, 0, 0.30);
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    transition: opacity 0.2s;
  }

  &__nombre {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(2px);
    padding: 6px 4px;
    font-size: 10px;
    color: #7A7A7A;
    text-align: center;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    border-top: 1px solid #eee;
    z-index: 10;
  }

  &:hover {
    img { transform: scale(1.04); }
    .galeria-item__zoom { opacity: 1; }
  }
}

// ══════════════════════════════════════════════════════════════════
// AUDITORÍA
// ══════════════════════════════════════════════════════════════════
.auditoria-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20px;

  @media (max-width: 600px) {
    grid-template-columns: 1fr;
  }
}

.campo-auditoria {
  &__label {
    font-size: 10px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    color: #AAAAAA;
    margin-bottom: 5px;
  }

  &__valor {
    font-size: 13px;
    color: #2A2A2A;
    &.mono { font-family: 'Courier New', monospace; font-size: 11px; color: #5A5A5A; }
  }
}

// ══════════════════════════════════════════════════════════════════
// PANEL LATERAL DE VARIACIONES
// ══════════════════════════════════════════════════════════════════
.panel-variaciones {
  &__cabecera {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
  }
}

.texto-seccion {
  font-size: 11px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.8px;
  color: #9A9A9A;
}

.variacion-item {
  padding: 10px 12px;
  border-radius: 8px;
  cursor: pointer;
  border: 1px solid #F0EDE8;
  margin-bottom: 6px;
  transition: all 0.15s;

  &:last-child { margin-bottom: 0; }

  &:hover {
    border-color: #E8750A;
    background: #FFF8F0;
  }

  &__nombre { font-size: 13px; font-weight: 600; color: #2A2A2A; }
  &__atributo { margin-top: 2px; }
  &__precio { color: #3A7A35; font-weight: 600; }
}
</style>
