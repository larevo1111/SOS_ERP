<template>
  <q-page class="pagina-formulario">

    <!-- ── Cabecera ────────────────────────────────────────────── -->
    <div class="cabecera q-mb-lg">
      <div>
        <div class="cabecera__titulo">
          {{ esMaestro ? 'Producto Maestro' : 'Variación de producto' }}
          <span v-if="producto.nombre" class="cabecera__nombre">— {{ producto.nombre }}</span>
        </div>
        <div class="cabecera__badges q-mt-xs">
          <span :class="['badge', producto.estado === 'Activo' ? 'badge-activo' : 'badge-inactivo']">
            {{ producto.estado }}
          </span>
          <!-- Maestro: es el representante del grupo en WooCommerce -->
          <span v-if="esMaestro" class="badge-maestro q-ml-sm">★ Maestro del grupo</span>
          <!-- Hija: variación que apunta a un Maestro -->
          <span v-else class="badge-hija q-ml-sm">
            ↳ Variación de: {{ uidMaestroCorto }}
          </span>
        </div>
      </div>
      <div class="cabecera__acciones">
        <q-btn flat label="Cancelar" color="grey-7" @click="cancelar" />
        <q-btn
          unelevated label="Guardar cambios" color="primary" icon="save"
          @click="guardar" :loading="guardando" class="q-ml-sm"
        />
      </div>
    </div>

    <!-- ── Cuerpo: formulario + panel lateral ─────────────────── -->
    <div class="cuerpo" :class="{ 'cuerpo--con-panel': esMaestro }">

      <!-- Formulario principal (tabs) -->
      <div class="formulario-principal">
        <q-tabs
          v-model="tabActiva" align="left"
          indicator-color="primary" active-color="primary"
          class="tabs-navegacion q-mb-md"
        >
          <q-tab name="general"    label="General"    icon="inventory_2" />
          <q-tab name="variacion"  label="Variación"  icon="tune" />
          <q-tab name="precios"    label="Precios"    icon="sell" />
          <q-tab name="contenido"  label="Contenido"  icon="description" />
          <q-tab name="historia"   label="Historia"   icon="eco" />
          <q-tab name="multimedia" label="Multimedia" icon="photo_library" />
          <q-tab name="auditoria"  label="Auditoría"  icon="manage_search" />
        </q-tabs>

        <q-tab-panels v-model="tabActiva" animated transition-prev="fade" transition-next="fade">

          <!-- ── TAB: GENERAL ──────────────────────────────────── -->
          <q-tab-panel name="general" class="q-pa-none">
            <div class="card-origenes q-pa-lg">
              <div class="q-gutter-md">

                <q-input
                  v-model="producto.nombre"
                  label="Nombre del producto *"
                  outlined dense
                  hint="Nombre completo incluyendo tamaño. Ej: Miel Silvestre 500g"
                />

                <div class="row q-col-gutter-md">
                  <div class="col-12 col-md-6">
                    <q-select
                      v-model="producto.estado"
                      :options="opcionesEstado"
                      label="Estado *" outlined dense
                      emit-value map-options
                    />
                  </div>
                  <div class="col-12 col-md-6">
                    <q-select
                      v-model="producto.estado_publicacion"
                      :options="opcionesPublicacion"
                      label="Estado de publicación *" outlined dense
                      emit-value map-options
                    />
                  </div>
                </div>

                <div class="row q-col-gutter-md">
                  <div class="col-12 col-md-6">
                    <q-input v-model="producto.categoria" label="Categoría" outlined dense />
                  </div>
                  <div class="col-12 col-md-6">
                    <q-input v-model="producto.marca" label="Marca" outlined dense />
                  </div>
                </div>

                <q-input
                  v-model="producto.etiquetas"
                  label="Etiquetas"
                  outlined dense
                  hint="Separadas por coma. Ej: miel, natural, artesanal"
                />

              </div>
            </div>
          </q-tab-panel>

          <!-- ── TAB: VARIACIÓN ────────────────────────────────── -->
          <q-tab-panel name="variacion" class="q-pa-none">
            <div class="card-origenes q-pa-lg">
              <div class="q-gutter-md">

                <!--
                  LÓGICA VARIACIÓN REPRESENTANTE:
                  - Si producto_principal_variacion = NULL → es MAESTRO
                    → nombre_grupo_catalogo es el nombre de familia en WooCommerce
                  - Si producto_principal_variacion tiene un UID → es HIJA
                    → nombre_grupo_catalogo se ignora (lo toma del Maestro)
                -->

                <!-- Aviso visual según rol -->
                <div v-if="esMaestro" class="aviso aviso--maestro">
                  <q-icon name="star" size="16px" class="q-mr-sm" />
                  <span>
                    Este producto es el <strong>Representante</strong> del grupo.
                    El <code>nombre_grupo_catalogo</code> es lo que WooCommerce muestra
                    como nombre de familia del producto.
                  </span>
                </div>
                <div v-else class="aviso aviso--hija">
                  <q-icon name="account_tree" size="16px" class="q-mr-sm" />
                  <span>
                    Esta es una <strong>variación hija</strong>. Su grupo de catálogo
                    lo define el Maestro al que apunta.
                  </span>
                </div>

                <!-- Nombre del grupo: solo editable en el Maestro -->
                <q-input
                  v-if="esMaestro"
                  v-model="producto.nombre_grupo_catalogo"
                  label="Nombre del grupo de catálogo (familia) *"
                  outlined dense
                  hint="Ej: Miel Silvestre — este nombre aparece en WooCommerce como producto padre"
                >
                  <template #prepend>
                    <q-icon name="folder_special" color="warning" />
                  </template>
                </q-input>

                <div class="row q-col-gutter-md">
                  <div class="col-12 col-md-6">
                    <q-input
                      v-model="producto.nombre_atributo_variacion"
                      label="Atributo de variación"
                      outlined dense
                      hint="Ej: Peso, Tamaño, Presentación"
                    />
                  </div>
                  <div class="col-12 col-md-6">
                    <q-input
                      v-model="producto.valor_atributo_variacion"
                      label="Valor del atributo"
                      outlined dense
                      hint="Ej: 500g, Grande, Caja × 6"
                    />
                  </div>
                </div>

                <!-- Vínculo con Costos: siempre visible pero solo lectura -->
                <q-input
                  v-model="producto.uid_producto_padre"
                  label="UID Producto Padre (Costos)"
                  outlined dense readonly
                  hint="Vincula este producto con su ficha de costos. Solo lectura."
                  bg-color="grey-1"
                >
                  <template #prepend>
                    <q-icon name="link" color="grey-6" />
                  </template>
                </q-input>

              </div>
            </div>
          </q-tab-panel>

          <!-- ── TAB: PRECIOS ──────────────────────────────────── -->
          <q-tab-panel name="precios" class="q-pa-none">
            <div class="card-origenes q-pa-lg">
              <div class="q-gutter-md">

                <div class="row q-col-gutter-md">
                  <div class="col-12 col-md-6">
                    <q-input
                      v-model.number="producto.precio_regular"
                      label="Precio regular *"
                      type="number" outlined dense prefix="$"
                      :rules="[val => val > 0 || 'El precio debe ser mayor a 0']"
                    />
                  </div>
                  <div class="col-12 col-md-6">
                    <q-input
                      v-model.number="producto.precio_oferta"
                      label="Precio de oferta"
                      type="number" outlined dense prefix="$"
                      hint="Dejar vacío si no hay oferta activa"
                    />
                  </div>
                </div>

                <div class="texto-seccion q-pt-sm">Vigencia de la oferta</div>
                <div class="row q-col-gutter-md">
                  <div class="col-12 col-md-6">
                    <q-input
                      v-model="producto.fecha_oferta_desde"
                      label="Desde" outlined dense type="date"
                      :disable="!producto.precio_oferta"
                    />
                  </div>
                  <div class="col-12 col-md-6">
                    <q-input
                      v-model="producto.fecha_oferta_hasta"
                      label="Hasta" outlined dense type="date"
                      :disable="!producto.precio_oferta"
                    />
                  </div>
                </div>

              </div>
            </div>
          </q-tab-panel>

          <!-- ── TAB: CONTENIDO ────────────────────────────────── -->
          <q-tab-panel name="contenido" class="q-pa-none">
            <div class="card-origenes q-pa-lg">
              <div class="q-gutter-lg">

                <q-input
                  v-model="producto.descripcion_corta"
                  label="Descripción corta"
                  type="textarea" outlined :rows="3"
                  hint="Máximo 2 líneas. Aparece debajo del nombre en la tienda"
                />
                <q-input
                  v-model="producto.descripcion_larga"
                  label="Descripción larga"
                  type="textarea" outlined :rows="7"
                  hint="Descripción completa. Puede incluir HTML básico"
                />
                <q-input
                  v-model="producto.bullets_superiores"
                  label="Bullets superiores"
                  type="textarea" outlined :rows="4"
                  hint="Un punto clave por línea. Se muestran destacados en la página del producto"
                />
                <q-input
                  v-model="producto.ingredientes_resumen"
                  label="Ingredientes / Resumen"
                  type="textarea" outlined :rows="4"
                />
                <q-input
                  v-model="producto.tabla_nutricional"
                  label="Tabla nutricional"
                  type="textarea" outlined :rows="6"
                  hint="Texto estructurado o HTML de la tabla"
                />

              </div>
            </div>
          </q-tab-panel>

          <!-- ── TAB: HISTORIA ─────────────────────────────────── -->
          <q-tab-panel name="historia" class="q-pa-none">
            <div class="card-origenes q-pa-lg">
              <div class="q-gutter-lg">

                <q-input v-model="producto.problema_real"
                  label="Problema real que resuelve" type="textarea" outlined :rows="4" />
                <q-input v-model="producto.origen_macro"
                  label="Origen del producto" type="textarea" outlined :rows="4"
                  hint="De dónde viene, cómo se obtiene" />
                <q-input v-model="producto.beneficios_explicados"
                  label="Beneficios explicados" type="textarea" outlined :rows="4" />
                <q-input v-model="producto.experiencia_y_modo_de_uso"
                  label="Experiencia y modo de uso" type="textarea" outlined :rows="4" />

                <div class="row q-col-gutter-md">
                  <div class="col-12 col-md-6">
                    <q-input v-model="producto.productor"
                      label="Productor" type="textarea" outlined :rows="3" />
                  </div>
                  <div class="col-12 col-md-6">
                    <q-input v-model="producto.ubicacion_productor"
                      label="Ubicación del productor" type="textarea" outlined :rows="3" />
                  </div>
                </div>

                <q-input v-model="producto.sistema_de_cultivo_origen"
                  label="Sistema de cultivo / Origen" type="textarea" outlined :rows="4" />
                <q-input v-model="producto.proceso_de_transformacion"
                  label="Proceso de transformación" type="textarea" outlined :rows="4" />

              </div>
            </div>
          </q-tab-panel>

          <!-- ── TAB: MULTIMEDIA ───────────────────────────────── -->
          <q-tab-panel name="multimedia" class="q-pa-none">
            <div class="card-origenes q-pa-lg">

              <div class="galeria__cabecera q-mb-md">
                <span class="texto-seccion">Galería de archivos</span>
                <q-btn
                  unelevated size="sm" icon="upload" label="Agregar archivo"
                  color="primary" @click="abrirSubida"
                />
              </div>

              <!-- Estado vacío -->
              <div v-if="multimedia.length === 0" class="galeria__vacia">
                <q-icon name="photo_library" size="56px" color="grey-3" />
                <div class="q-mt-sm text-grey-5 text-caption">
                  Sin archivos. Agrega imágenes o videos del producto.
                </div>
              </div>

              <!-- Grid de archivos -->
              <div v-else class="galeria__grid">
                <div
                  v-for="archivo in multimedia"
                  :key="archivo.uid"
                  class="galeria__item"
                  :class="{ 'galeria__item--principal': archivo.uso === 'Principal' }"
                  draggable="true"
                  @dragstart="alIniciarArrastre($event, archivo)"
                  @dragover.prevent
                  @drop="alSoltar($event, archivo)"
                >
                  <!-- Vista previa -->
                  <div class="galeria__preview">
                    <img
                      v-if="archivo.tipo_archivo === 'imagen'"
                      :src="urlArchivo(archivo)"
                      :alt="archivo.uso"
                    />
                    <div v-else class="galeria__preview-icono">
                      <q-icon name="videocam" size="32px" color="grey-5" />
                      <div class="text-caption text-grey-5 q-mt-xs">Video</div>
                    </div>
                    <!-- Badge "Principal" sobre la imagen -->
                    <div v-if="archivo.uso === 'Principal'" class="galeria__badge-principal">
                      ★ Principal
                    </div>
                  </div>

                  <!-- Selector de uso -->
                  <div class="galeria__uso q-pa-sm">
                    <q-select
                      v-model="archivo.uso"
                      :options="opcionesUso"
                      label="Uso" outlined dense emit-value map-options
                      @update:model-value="actualizarUsoArchivo(archivo)"
                    />
                  </div>

                  <!-- Acciones -->
                  <div class="galeria__acciones">
                    <q-icon
                      name="drag_indicator"
                      class="cursor-move" color="grey-4" size="20px"
                      title="Arrastrar para reordenar"
                    />
                    <q-btn
                      flat round dense size="sm" icon="delete" color="negative"
                      @click="eliminarArchivo(archivo)"
                    />
                  </div>

                </div>
              </div>

            </div>
          </q-tab-panel>

          <!-- ── TAB: AUDITORÍA ────────────────────────────────── -->
          <q-tab-panel name="auditoria" class="q-pa-none">
            <div class="card-origenes q-pa-lg">

              <div class="aviso aviso--info q-mb-lg">
                <q-icon name="lock" size="16px" class="q-mr-xs" />
                <span>Estos campos son de <strong>solo lectura</strong>. El sistema los gestiona automáticamente.</span>
              </div>

              <div class="auditoria__grid">
                <div class="campo-auditoria">
                  <div class="campo-auditoria__label">UID del producto</div>
                  <div class="campo-auditoria__valor">{{ producto.uid || '—' }}</div>
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
                  <div class="campo-auditoria__valor">{{ producto.url_producto || '—' }}</div>
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
          </q-tab-panel>

        </q-tab-panels>
      </div>

      <!-- ── Panel lateral: Variaciones (solo si es Maestro) ─── -->
      <div v-if="esMaestro" class="panel-variaciones card-origenes q-pa-lg">

        <div class="panel-variaciones__cabecera q-mb-md">
          <span class="texto-seccion">Variaciones del grupo</span>
          <q-btn flat dense size="sm" icon="add" color="primary" @click="crearVariacion" />
        </div>

        <div v-if="variaciones.length === 0" class="panel-variaciones__vacio">
          <q-icon name="tune" size="36px" color="grey-3" />
          <div class="text-caption text-grey-5 q-mt-sm text-center">
            Sin variaciones. Crea la primera con el botón +
          </div>
        </div>

        <div v-else class="panel-variaciones__lista">
          <!--
            Cada variacion.producto_principal_variacion = uid del Maestro actual.
            Al hacer clic, abrimos el formulario de esa variación hija.
          -->
          <div
            v-for="variacion in variaciones"
            :key="variacion.uid"
            class="variacion-item"
            @click="irAVariacion(variacion.uid)"
          >
            <div class="variacion-item__nombre">{{ variacion.nombre }}</div>
            <div class="variacion-item__atributo">
              {{ variacion.nombre_atributo_variacion }}:
              <strong>{{ variacion.valor_atributo_variacion }}</strong>
            </div>
            <div class="variacion-item__pie">
              <span :class="['badge', variacion.estado === 'Activo' ? 'badge-activo' : 'badge-inactivo']">
                {{ variacion.estado }}
              </span>
              <span v-if="variacion.precio_regular" class="variacion-item__precio">
                ${{ variacion.precio_regular }}
              </span>
            </div>
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

// ── Navegación ────────────────────────────────────────────────────
const route  = useRoute()
const router = useRouter()
const $q     = useQuasar()

// ── Estado ────────────────────────────────────────────────────────
const tabActiva = ref('general')
const guardando = ref(false)

// Producto vacío con todos los campos de com_productos
const producto = ref({
  uid: '',
  empresa: '',
  estado: 'Activo',
  id_producto_woocommerce: null,
  uid_producto_padre: '',
  nombre: '',
  nombre_grupo_catalogo: null,      // NULL = este producto es el Maestro del grupo
  estado_publicacion: 'borrador',
  url_producto: '',
  producto_principal_variacion: null, // NULL = Maestro; UID del Maestro = Hija
  nombre_atributo_variacion: '',
  valor_atributo_variacion: '',
  categoria: '',
  marca: '',
  descripcion_corta: '',
  descripcion_larga: '',
  etiquetas: '',
  precio_regular: null,
  precio_oferta: null,
  fecha_oferta_desde: null,
  fecha_oferta_hasta: null,
  bullets_superiores: '',
  ingredientes_resumen: '',
  tabla_nutricional: '',
  problema_real: '',
  origen_macro: '',
  beneficios_explicados: '',
  experiencia_y_modo_de_uso: '',
  productor: '',
  ubicacion_productor: '',
  sistema_de_cultivo_origen: '',
  proceso_de_transformacion: '',
  galeria_adicional: '',
  usuario_creador: '',
  usuario_ult_modificacion: '',
  fecha_creacion: null,
  fecha_ult_modificacion: null
})

// Multimedia: registros de com_productos_multimedia
const multimedia = ref([])

// Variaciones hijas (solo se cargan si este producto es Maestro)
const variaciones = ref([])

// Control de arrastre para reordenar galería
const archivoEnArrastre = ref(null)

// ── Computed ──────────────────────────────────────────────────────

// Es Maestro si producto_principal_variacion es null o vacío
const esMaestro = computed(() => !producto.value.producto_principal_variacion)

// Muestra los primeros 12 caracteres del UID del Maestro
const uidMaestroCorto = computed(() => {
  const uid = producto.value.producto_principal_variacion
  return uid ? `${uid.substring(0, 12)}...` : ''
})

// ── Opciones para selects ─────────────────────────────────────────
const opcionesEstado = [
  { label: 'Activo',   value: 'Activo' },
  { label: 'Inactivo', value: 'Inactivo' }
]

const opcionesPublicacion = [
  { label: 'Borrador',  value: 'borrador' },
  { label: 'Publicado', value: 'publicado' },
  { label: 'Privado',   value: 'privado' },
  { label: 'Pendiente', value: 'pendiente' }
]

const opcionesUso = [
  { label: 'Principal (portada)',  value: 'Principal' },
  { label: 'Galería',             value: 'Galeria' },
  { label: 'Variación',           value: 'Variacion' },
  { label: 'Galería secundaria',  value: 'Galeria secundaria' },
  { label: 'Otro',                value: 'Otro' }
]

// ── Carga de datos ────────────────────────────────────────────────

async function cargarProducto (uid) {
  // TODO: reemplazar con llamada real cuando el backend esté listo
  // Formato esperado: GET /api/comercial/productos/:uid
  // Respuesta esperada: { exito: true, datos: { ...campos }, errores: [] }
  console.log('[FormularioProducto] Cargando producto:', uid)
}

async function cargarMultimedia (uid) {
  // TODO: GET /api/comercial/productos/:uid/multimedia
  console.log('[FormularioProducto] Cargando multimedia:', uid)
}

async function cargarVariaciones (uidMaestro) {
  // Carga todos los registros donde producto_principal_variacion = uidMaestro
  // TODO: GET /api/comercial/productos/:uid/variaciones
  console.log('[FormularioProducto] Cargando variaciones del Maestro:', uidMaestro)
}

// ── Acciones ──────────────────────────────────────────────────────

async function guardar () {
  guardando.value = true
  try {
    // TODO: PUT /api/comercial/productos/:uid con producto.value
    // El backend actualiza usuario_ult_modificacion y fecha_ult_modificacion automáticamente
    $q.notify({ type: 'positive', message: 'Producto guardado correctamente' })
  } catch (error) {
    $q.notify({ type: 'negative', message: `Error al guardar: ${error.message}` })
  } finally {
    guardando.value = false
  }
}

function cancelar () {
  router.back()
}

function irAVariacion (uid) {
  router.push({ name: 'editar-producto', params: { uid } })
}

function crearVariacion () {
  // TODO: abrir modal para crear una variación nueva vinculada al Maestro actual
  // La variación nueva tendrá: producto_principal_variacion = producto.value.uid
  $q.dialog({
    title: 'Nueva variación',
    message: `Se creará una variación hija vinculada al Maestro: ${producto.value.nombre}`,
    cancel: true
  })
}

// ── Galería multimedia ────────────────────────────────────────────

function urlArchivo (archivo) {
  return archivo.archivo_local || archivo.archivo_woocommerce || ''
}

function abrirSubida () {
  // TODO: implementar subida de archivos al servidor
  // El backend detecta el tipo (imagen/video) por MIME y guarda en SOS_ERP_archivos/
  console.log('[Multimedia] Abrir subida de archivos')
}

function eliminarArchivo (archivo) {
  $q.dialog({
    title: 'Eliminar archivo',
    message: '¿Seguro que quieres eliminar este archivo? Esta acción no se puede deshacer.',
    cancel: { label: 'Cancelar', flat: true },
    ok: { label: 'Eliminar', color: 'negative', unelevated: true }
  }).onOk(() => {
    multimedia.value = multimedia.value.filter(m => m.uid !== archivo.uid)
    // TODO: DELETE /api/comercial/multimedia/:uid
  })
}

function actualizarUsoArchivo (archivo) {
  // TODO: PATCH /api/comercial/multimedia/:uid con { uso: archivo.uso }
  console.log('[Multimedia] Actualizando uso de:', archivo.uid, '→', archivo.uso)
}

// Drag & drop para reordenar galería (actualiza campo `orden`)
function alIniciarArrastre (evento, archivo) {
  archivoEnArrastre.value = archivo
  evento.dataTransfer.effectAllowed = 'move'
}

function alSoltar (evento, archivoDestino) {
  if (!archivoEnArrastre.value || archivoEnArrastre.value.uid === archivoDestino.uid) return

  const lista    = [...multimedia.value]
  const indexOrigen  = lista.findIndex(m => m.uid === archivoEnArrastre.value.uid)
  const indexDestino = lista.findIndex(m => m.uid === archivoDestino.uid)

  // Intercambia posiciones
  lista.splice(indexDestino, 0, lista.splice(indexOrigen, 1)[0])

  // Actualiza campo `orden` según nueva posición
  lista.forEach((item, i) => { item.orden = i + 1 })
  multimedia.value = lista

  archivoEnArrastre.value = null
  // TODO: PATCH /api/comercial/multimedia/reordenar con el nuevo orden de UIDs
}

// ── Utilidades ────────────────────────────────────────────────────

function formatearFecha (fecha) {
  if (!fecha) return '—'
  return new Date(fecha).toLocaleString('es-CO', {
    year: 'numeric', month: 'long', day: 'numeric',
    hour: '2-digit', minute: '2-digit'
  })
}

// ── Ciclo de vida ─────────────────────────────────────────────────

onMounted(async () => {
  const uid = route.params.uid
  if (uid) {
    await cargarProducto(uid)
    await cargarMultimedia(uid)
    // Solo carga variaciones si el producto es Maestro
    if (esMaestro.value) {
      await cargarVariaciones(uid)
    }
  }
})
</script>

<style lang="scss" scoped>
// Referencia visual: .agent/diseno/dashboard_ref.html
// Colores: .agent/diseno/GUIA_ESTILOS.md

.pagina-formulario {
  padding: 28px 30px;
  max-width: 1400px;
  margin: 0 auto;
}

// ── Cabecera ───────────────────────────────────────────────────────
.cabecera {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 16px;

  &__titulo {
    font-size: 22px;
    font-weight: 800;
    color: #1A1A1A;
  }

  &__nombre {
    font-weight: 500;
    color: #6A6A6A;
    font-size: 18px;
  }

  &__badges {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    gap: 6px;
    margin-top: 6px;
  }

  &__acciones {
    display: flex;
    align-items: center;
    flex-shrink: 0;
  }
}

// ── Layout principal ───────────────────────────────────────────────
.cuerpo {
  display: flex;
  gap: 20px;

  .formulario-principal {
    flex: 1;
    min-width: 0;
  }

  &--con-panel {
    .formulario-principal {
      flex: 1;
    }
  }
}

// ── Tabs de navegación ─────────────────────────────────────────────
.tabs-navegacion {
  background: #fff;
  border-radius: 12px 12px 0 0;
  border: 1px solid rgba(0, 0, 0, 0.04);
  border-bottom: none;
}

// ── Texto de sección ───────────────────────────────────────────────
.texto-seccion {
  font-size: 13px;
  font-weight: 700;
  color: #1A1A1A;
}

// ── Badges de identificación Maestro/Hija ──────────────────────────
.badge-maestro {
  background: #FEF8E0;
  color: #9A7200;
  font-size: 10px;
  font-weight: 700;
  padding: 3px 9px;
  border-radius: 20px;
}

.badge-hija {
  background: #E5F0FF;
  color: #1A5ACC;
  font-size: 10px;
  font-weight: 700;
  padding: 3px 9px;
  border-radius: 20px;
  font-family: monospace;
}

// ── Avisos contextuales ────────────────────────────────────────────
.aviso {
  display: flex;
  align-items: flex-start;
  padding: 12px 14px;
  border-radius: 10px;
  font-size: 13px;
  color: #3A3A3A;

  code {
    background: rgba(240, 184, 34, 0.2);
    padding: 1px 6px;
    border-radius: 4px;
    font-size: 11px;
  }

  &--maestro {
    background: rgba(240, 184, 34, 0.08);
    border: 1px solid rgba(240, 184, 34, 0.25);
    color: #7A5E00;
  }

  &--hija {
    background: rgba(26, 90, 204, 0.06);
    border: 1px solid rgba(26, 90, 204, 0.2);
    color: #1A3A6A;
  }

  &--info {
    background: #F8F7F5;
    border-radius: 10px;
    color: #7A7A7A;
    font-size: 12px;
  }
}

// ── Galería multimedia ─────────────────────────────────────────────
.galeria {
  &__cabecera {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }

  &__vacia {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 56px;
    border: 2px dashed #E0DDD8;
    border-radius: 12px;
  }

  &__grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
    gap: 12px;
  }

  &__item {
    border: 1px solid #E0DDD8;
    border-radius: 12px;
    overflow: hidden;
    background: #F8F7F5;
    transition: box-shadow 0.15s;
    position: relative;

    &:hover {
      box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
    }

    // Destaca visualmente el archivo marcado como Principal
    &--principal {
      border-color: #E8750A;
      border-width: 2px;
    }
  }

  &__preview {
    height: 140px;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    background: #F0EDE8;
    position: relative;

    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
  }

  &__preview-icono {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  &__badge-principal {
    position: absolute;
    top: 6px;
    left: 6px;
    background: #E8750A;
    color: #fff;
    font-size: 9px;
    font-weight: 700;
    padding: 2px 7px;
    border-radius: 10px;
  }

  &__uso {
    padding: 8px;
  }

  &__acciones {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 4px 10px 8px;
  }
}

// ── Panel lateral: Variaciones ─────────────────────────────────────
.panel-variaciones {
  width: 280px;
  flex-shrink: 0;
  height: fit-content;
  position: sticky;
  top: 24px;

  &__cabecera {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }

  &__vacio {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 24px 0;
  }

  &__lista {
    display: flex;
    flex-direction: column;
    gap: 8px;
  }
}

.variacion-item {
  padding: 10px 12px;
  border-radius: 10px;
  border: 1px solid #F0EDE8;
  cursor: pointer;
  transition: all 0.15s;

  &:hover {
    background: rgba(232, 117, 10, 0.04);
    border-color: rgba(232, 117, 10, 0.3);
  }

  &__nombre {
    font-size: 12px;
    font-weight: 600;
    color: #1A1A1A;
    margin-bottom: 2px;
  }

  &__atributo {
    font-size: 11px;
    color: #7A7A7A;
    margin-bottom: 6px;
  }

  &__pie {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }

  &__precio {
    font-size: 11px;
    font-weight: 700;
    color: #C55E00;
  }
}

// ── Grid de auditoría ──────────────────────────────────────────────
.auditoria__grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 12px;

  @media (max-width: 599px) {
    grid-template-columns: 1fr;
  }
}
</style>
