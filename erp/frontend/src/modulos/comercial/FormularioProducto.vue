<template>
  <q-page class="pagina-formulario">

    <!-- ════════════════════════════════════════════════════════════
         CABECERA
    ═════════════════════════════════════════════════════════════ -->
    <div class="cabecera">

      <!-- Lado izquierdo: migas + título -->
      <div class="cabecera__izq">
        <div class="cabecera__miga">
          <span class="cabecera__miga-link" @click="cancelar">Comercial</span>
          <q-icon name="chevron_right" size="14px" color="grey-4" />
          <span class="cabecera__miga-link" @click="cancelar">Productos</span>
          <q-icon name="chevron_right" size="14px" color="grey-4" />
          <span class="cabecera__miga-actual">
            {{ producto.nombre || 'Nuevo producto' }}
          </span>
        </div>

        <div class="cabecera__titulo-row">
          <div class="cabecera__titulo">
            {{ producto.nombre || (esMaestro ? 'Producto Maestro' : 'Variación') }}
          </div>
          <div class="cabecera__chips">
            <span :class="['chip', producto.estado === 'Activo' ? 'chip--verde' : 'chip--gris']">
              {{ producto.estado || 'Activo' }}
            </span>
            <span :class="['chip', `chip--pub-${producto.estado_publicacion || 'borrador'}`]">
              {{ producto.estado_publicacion || 'Borrador' }}
            </span>
            <span v-if="esMaestro" class="chip chip--maestro">★ Maestro</span>
            <span v-else class="chip chip--hija">↳ Variación</span>
          </div>
        </div>
      </div>

      <!-- Lado derecho: acciones -->
      <div class="cabecera__der">
        <q-btn
          flat no-caps icon="arrow_back" label="Volver"
          color="grey-6" size="sm" @click="cancelar"
          class="q-mr-sm"
        />
        <q-btn
          unelevated no-caps icon="save" label="Guardar cambios"
          color="primary" @click="guardar" :loading="guardando"
        />
      </div>
    </div>

    <!-- Línea separadora bajo la cabecera -->
    <div class="cabecera__separador q-mb-lg" />

    <!-- ════════════════════════════════════════════════════════════
         CUERPO: tabs + panel lateral
    ═════════════════════════════════════════════════════════════ -->
    <div class="cuerpo" :class="{ 'cuerpo--con-panel': esMaestro }">

      <!-- ── Formulario principal ──────────────────────────────── -->
      <div class="formulario-principal">

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

          <div class="card-origenes q-pa-lg q-mb-md">
            <div class="s-header s-header--naranja q-mb-md">
              <div class="s-header__icono" style="background:#FFF0E5">
                <q-icon name="inventory_2" size="15px" color="orange-8" />
              </div>
              <span class="s-header__titulo">Identificación</span>
              <div class="s-header__linea" />
            </div>

            <q-select
              v-model="producto.uid_producto_padre"
              :options="opcionesMaestrosCosto"
              :loading="cargandoMaestrosCosto"
              label="Producto de costos *"
              outlined
              dense
              class="q-mb-md"
              clearable
              emit-value
              map-options
              use-input
              fill-input
              hide-selected
              input-debounce="250"
              hint="Busca por nombre en costos_encabezados_productos y guarda el UID"
              @filter="filtrarMaestrosCosto"
              @update:model-value="alSeleccionarMaestroCosto"
            >
              <template #prepend><q-icon name="link" color="grey-5" /></template>
              <template #no-option>
                <q-item>
                  <q-item-section class="text-grey-6">
                    No hay coincidencias en Costos.
                  </q-item-section>
                </q-item>
              </template>
            </q-select>

            <div class="row items-center justify-between q-mb-xs">
              <div class="text-caption text-weight-medium">Nombre para Catálogo (Grupo) *</div>
              <q-btn
                flat dense no-caps
                icon="auto_awesome"
                color="grey-6"
                size="xs"
                label="Sugerir IA"
                @click="solicitarAsistenciaIA('nombre_grupo_catalogo', producto)"
              />
            </div>
            <q-input
              v-model="producto.nombre_grupo_catalogo"
              label="Nombre para Catálogo (Ej: Miel Silvestre)"
              outlined
              class="q-mb-md"
            />

            <div class="row items-center justify-between q-mb-xs">
              <div class="text-caption text-weight-medium">Nombre del producto (Variación) *</div>
              <q-btn
                flat dense no-caps
                icon="auto_awesome"
                color="grey-6"
                size="xs"
                label="Sugerir IA"
                @click="solicitarAsistenciaIA('nombre', producto)"
              />
            </div>
            <q-input
              v-model="producto.nombre"
              label="Nombre completo (Ej: Miel Silvestre 500g)"
              outlined
              class="q-mb-md nombre-grande"
            />

            <div class="row q-col-gutter-md q-mb-sm">
              <div class="col-12 col-md-6">
                <q-select v-model="producto.estado" :options="opcionesEstado"
                  label="Estado *" outlined dense emit-value map-options />
              </div>
              <div class="col-12 col-md-6">
                <q-select v-model="producto.estado_publicacion" :options="opcionesPublicacion"
                  label="Publicación *" outlined dense emit-value map-options />
              </div>
            </div>

            <q-input
              v-model="producto.url_producto"
              label="URL producto"
              outlined
              dense
              hint="Slug o URL pública del producto (WooCommerce)"
            />
          </div>

          <div class="card-origenes q-pa-lg q-mb-md">
            <div class="s-header s-header--verde q-mb-md">
              <div class="s-header__icono" style="background:#E8F5E5">
                <q-icon name="sell" size="15px" color="green-8" />
              </div>
              <span class="s-header__titulo">Precios</span>
              <div class="s-header__linea" />
            </div>

            <div class="row q-col-gutter-md">
              <div class="col-12 col-md-6">
                <q-input v-model.number="producto.precio_regular"
                  label="Precio regular *" type="number" outlined prefix="$"
                  :rules="[val => !val || val > 0 || 'Debe ser mayor a 0']" />
              </div>
              <div class="col-12 col-md-6">
                <q-input v-model.number="producto.precio_oferta"
                  label="Precio de oferta" type="number" outlined prefix="$"
                  hint="Vacío = sin oferta activa" />
              </div>
            </div>

            <div class="row q-col-gutter-md q-mt-sm">
              <div class="col-12 col-md-6">
                <q-input v-model="producto.fecha_oferta_desde"
                  label="Fecha oferta desde" outlined dense type="date" />
              </div>
              <div class="col-12 col-md-6">
                <q-input v-model="producto.fecha_oferta_hasta"
                  label="Fecha oferta hasta" outlined dense type="date" />
              </div>
            </div>
          </div>

          <div class="card-origenes q-pa-lg">
            <div class="s-header s-header--azul q-mb-md">
              <div class="s-header__icono" style="background:#E5F0FF">
                <q-icon name="label" size="15px" color="blue-8" />
              </div>
              <span class="s-header__titulo">Clasificación</span>
              <div class="s-header__linea" />
            </div>

            <div class="row q-col-gutter-md q-mb-md">
              <div class="col-12 col-md-6">
                <q-input v-model="producto.categoria" label="Categoría" outlined dense />
              </div>
              <div class="col-12 col-md-6">
                <q-select
                  v-model="producto.marca"
                  :options="opcionesMarcas"
                  :loading="cargandoMarcas"
                  label="Marca *"
                  outlined
                  dense
                  clearable
                  emit-value
                  map-options
                  use-input
                  fill-input
                  hide-selected
                  input-debounce="250"
                  hint="Muestra nombre de marca y guarda UID"
                  @filter="filtrarMarcas"
                >
                  <template #prepend><q-icon name="branding_watermark" color="blue-6" /></template>
                  <template #no-option>
                    <q-item>
                      <q-item-section class="text-grey-6">
                        Sin marcas disponibles.
                      </q-item-section>
                    </q-item>
                  </template>
                </q-select>
              </div>
            </div>
            <q-input v-model="producto.etiquetas" label="Etiquetas" outlined dense
              hint="Separadas por coma. Ej: miel, natural, artesanal" />
          </div>

          <!-- Card: Foto Principal -->
          <div class="card-origenes q-pa-lg q-mt-md">
            <div class="s-header s-header--naranja q-mb-md">
              <div class="s-header__icono" style="background:#FFF0E5">
                <q-icon name="image" size="15px" color="orange-8" />
              </div>
              <span class="s-header__titulo">Foto Principal</span>
              <div class="s-header__linea" />
            </div>

            <div v-if="!producto.uid" class="galeria__vacia">
              <q-icon name="lock" size="32px" color="grey-3" />
              <div class="q-mt-sm text-grey-5 text-caption text-center">
                Guarda el producto para poder adjuntar la foto principal.
              </div>
            </div>

            <template v-else>
              <div v-if="fotoPrincipal" class="foto-principal">
                <div class="foto-principal__preview">
                  <img :src="urlArchivo(fotoPrincipal)" alt="Foto principal" />
                  <div class="galeria__badge-principal">★ Principal</div>
                </div>
                <div class="foto-principal__acciones">
                  <q-btn flat dense no-caps size="sm" icon="swap_horiz" label="Reemplazar"
                    color="grey-7" @click="abrirSubidaSeccion('Principal')" />
                  <q-btn flat dense no-caps size="sm" icon="delete" color="negative"
                    @click="eliminarArchivo(fotoPrincipal)" />
                </div>
              </div>
              <div v-else class="galeria__vacia foto-principal__dropzone"
                @click="abrirSubidaSeccion('Principal')">
                <q-icon name="add_photo_alternate" size="40px" color="grey-3" />
                <div class="q-mt-sm text-grey-5 text-caption">
                  Clic para subir la foto principal del producto
                </div>
              </div>
            </template>
          </div>
        </div>

        <!-- ── TAB: CONTENIDO (fusiona Contenido + Historia) ─── -->
        <div v-show="tabActiva === 'contenido'">

          <!-- Sección 1: Texto del producto -->
          <div class="card-origenes q-pa-lg q-mb-md">
            <div class="s-header s-header--naranja q-mb-lg">
              <div class="s-header__icono" style="background:#FFF0E5">
                <q-icon name="description" size="15px" color="orange-8" />
              </div>
              <span class="s-header__titulo">Texto del producto</span>
              <div class="s-header__linea" />
            </div>

            <div class="row items-center justify-between q-mb-xs">
              <div class="text-caption text-grey-7">Descripción corta</div>
              <q-btn flat dense no-caps size="xs" icon="auto_awesome" color="grey-6"
                label="Sugerir IA" @click="solicitarAsistenciaIA('descripcion_corta', producto)" />
            </div>
            <q-input v-model="producto.descripcion_corta"
              type="textarea" outlined :rows="3" class="q-mb-md"
              placeholder="Máximo 2 líneas. Aparece debajo del nombre en la tienda." />

            <div class="row items-center justify-between q-mb-xs">
              <div class="text-caption text-grey-7">Descripción larga</div>
              <q-btn flat dense no-caps size="xs" icon="auto_awesome" color="grey-6"
                label="Sugerir IA" @click="solicitarAsistenciaIA('descripcion_larga', producto)" />
            </div>
            <q-input v-model="producto.descripcion_larga"
              type="textarea" outlined :rows="7"
              placeholder="Descripción completa del producto. Puede incluir HTML básico." />
          </div>

          <!-- Sección 2: Puntos clave -->
          <div class="card-origenes q-pa-lg q-mb-md">
            <div class="s-header s-header--azul q-mb-lg">
              <div class="s-header__icono" style="background:#E5F0FF">
                <q-icon name="format_list_bulleted" size="15px" color="blue-8" />
              </div>
              <span class="s-header__titulo">Puntos clave</span>
              <div class="s-header__linea" />
            </div>

            <div class="row items-center justify-between q-mb-xs">
              <div class="text-caption text-grey-7">Bullets superiores</div>
              <q-btn flat dense no-caps size="xs" icon="auto_awesome" color="grey-6"
                label="Sugerir IA" @click="solicitarAsistenciaIA('bullets_superiores', producto)" />
            </div>
            <q-input v-model="producto.bullets_superiores"
              type="textarea" outlined :rows="5"
              placeholder="Un punto por línea. Se muestran destacados en la parte superior de la página del producto." />
          </div>

          <!-- Sección 3: Origen (productor, lugar, cómo se hace) -->
          <div class="card-origenes q-pa-lg q-mb-md">
            <div class="s-header s-header--verde q-mb-lg">
              <div class="s-header__icono" style="background:#E8F5E5">
                <q-icon name="agriculture" size="15px" color="green-8" />
              </div>
              <span class="s-header__titulo">Origen</span>
              <div class="s-header__linea" />
            </div>

            <div class="row items-center justify-between q-mb-xs">
              <div class="text-caption text-grey-7">Origen del producto</div>
              <q-btn flat dense no-caps size="xs" icon="auto_awesome" color="grey-6"
                label="Sugerir IA" @click="solicitarAsistenciaIA('origen_macro', producto)" />
            </div>
            <q-input v-model="producto.origen_macro"
              type="textarea" outlined :rows="4" class="q-mb-md"
              placeholder="De dónde viene, cómo se obtiene, región de origen." />

            <div class="row q-col-gutter-md q-mb-md">
              <div class="col-12 col-md-6">
                <q-input v-model="producto.productor" label="Nombre del productor"
                  outlined dense>
                  <template #prepend>
                    <q-icon name="person_outline" color="grey-5" />
                  </template>
                </q-input>
              </div>
              <div class="col-12 col-md-6">
                <q-input v-model="producto.ubicacion_productor" label="Ubicación"
                  outlined dense>
                  <template #prepend>
                    <q-icon name="location_on" color="grey-5" />
                  </template>
                </q-input>
              </div>
            </div>

            <div class="row q-col-gutter-md">
              <div class="col-12 col-md-6">
                <q-input v-model="producto.sistema_de_cultivo_origen"
                  label="Sistema de cultivo / Origen"
                  type="textarea" outlined :rows="4" />
              </div>
              <div class="col-12 col-md-6">
                <q-input v-model="producto.proceso_de_transformacion"
                  label="Proceso de transformación"
                  type="textarea" outlined :rows="4" />
              </div>
            </div>
          </div>

          <!-- Sección 4: Composición -->
          <div class="card-origenes q-pa-lg q-mb-md">
            <div class="s-header s-header--amarillo q-mb-lg">
              <div class="s-header__icono" style="background:#FEF8E0">
                <q-icon name="science" size="15px" color="amber-8" />
              </div>
              <span class="s-header__titulo">Composición</span>
              <div class="s-header__linea" />
            </div>

            <div class="row items-center justify-between q-mb-xs">
              <div class="text-caption text-grey-7">Ingredientes / Resumen</div>
              <q-btn flat dense no-caps size="xs" icon="auto_awesome" color="grey-6"
                label="Sugerir IA" @click="solicitarAsistenciaIA('ingredientes_resumen', producto)" />
            </div>
            <q-input v-model="producto.ingredientes_resumen"
              type="textarea" outlined :rows="4" class="q-mb-md"
              placeholder="Ingredientes, alérgenos y notas de etiquetado." />

            <div class="row items-center justify-between q-mb-xs">
              <div class="text-caption text-grey-7">Tabla nutricional</div>
              <q-btn flat dense no-caps size="xs" icon="auto_awesome" color="grey-6"
                label="Sugerir IA" @click="solicitarAsistenciaIA('tabla_nutricional', producto)" />
            </div>
            <q-input v-model="producto.tabla_nutricional"
              type="textarea" outlined :rows="6"
              placeholder="Texto estructurado o HTML de la tabla nutricional." />
          </div>

          <!-- Sección 5: Propuesta de valor -->
          <div class="card-origenes q-pa-lg q-mb-md">
            <div class="s-header s-header--naranja q-mb-lg">
              <div class="s-header__icono" style="background:#FFF0E5">
                <q-icon name="star_rate" size="15px" color="orange-8" />
              </div>
              <span class="s-header__titulo">Propuesta de valor</span>
              <div class="s-header__linea" />
            </div>

            <div class="row items-center justify-between q-mb-xs">
              <div class="text-caption text-grey-7">Problema real que resuelve</div>
              <q-btn flat dense no-caps size="xs" icon="auto_awesome" color="grey-6"
                label="Sugerir IA" @click="solicitarAsistenciaIA('problema_real', producto)" />
            </div>
            <q-input v-model="producto.problema_real"
              type="textarea" outlined :rows="4" class="q-mb-md"
              placeholder="¿Qué necesidad o dolor del cliente resuelve este producto?" />

            <div class="row items-center justify-between q-mb-xs">
              <div class="text-caption text-grey-7">Beneficios explicados</div>
              <q-btn flat dense no-caps size="xs" icon="auto_awesome" color="grey-6"
                label="Sugerir IA" @click="solicitarAsistenciaIA('beneficios_explicados', producto)" />
            </div>
            <q-input v-model="producto.beneficios_explicados"
              type="textarea" outlined :rows="4" class="q-mb-md"
              placeholder="Beneficios concretos del producto, ordenados por impacto." />

            <div class="row items-center justify-between q-mb-xs">
              <div class="text-caption text-grey-7">Experiencia y modo de uso</div>
              <q-btn flat dense no-caps size="xs" icon="auto_awesome" color="grey-6"
                label="Sugerir IA" @click="solicitarAsistenciaIA('experiencia_y_modo_de_uso', producto)" />
            </div>
            <q-input v-model="producto.experiencia_y_modo_de_uso"
              type="textarea" outlined :rows="4"
              placeholder="Cómo se usa, en qué momentos y con qué combinarlo." />
          </div>

        </div>

        <!-- ── TAB: GALERIA ───────────────────────────────── -->
        <div v-show="tabActiva === 'galeria'">

          <!-- Input oculto compartido para todas las subidas de galería -->
          <input
            ref="inputArchivo"
            type="file"
            accept="image/jpeg,image/png,image/webp,image/gif,video/mp4,video/webm,application/pdf,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/zip"
            multiple
            style="display:none"
            @change="procesarArchivos($event.target.files)"
          />

          <!-- Sección 1: Galería -->
          <div class="card-origenes q-pa-lg q-mb-md">
            <div class="galeria__cabecera q-mb-lg">
              <div>
                <div class="s-header__titulo" style="font-size:14px">Galería</div>
                <div class="text-caption text-grey-5 q-mt-xs">
                  Imágenes principales del producto · Arrastra para reordenar
                </div>
              </div>
              <q-btn unelevated size="sm" icon="upload" label="Agregar"
                color="primary" @click="abrirSubidaSeccion('Galeria')" />
            </div>

            <div v-if="fotosGaleria.length === 0" class="galeria__vacia">
              <q-icon name="photo_library" size="56px" color="grey-3" />
              <div class="q-mt-sm text-grey-5 text-caption">
                Sin imágenes de galería. Agrega imágenes del producto.
              </div>
            </div>

            <div v-else class="galeria__grid">
              <div
                v-for="archivo in fotosGaleria"
                :key="archivo.uid"
                class="galeria__item"
                draggable="true"
                @dragstart="alIniciarArrastre($event, archivo)"
                @dragover.prevent
                @drop="alSoltar($event, archivo)"
              >
                <div class="galeria__preview">
                  <img v-if="archivo.tipo_archivo === 'imagen'"
                    :src="urlArchivo(archivo)" :alt="archivo.uso" />
                  <video v-else-if="archivo.tipo_archivo === 'video'"
                    :src="urlArchivo(archivo)"
                    autoplay loop muted playsinline
                    style="width:100%; height:100%; object-fit:cover"
                  ></video>
                  <div v-else class="galeria__preview-icono">
                    <q-icon name="description" size="32px" color="blue-grey-5" />
                  </div>
                </div>
                <div class="galeria__acciones">
                  <q-icon name="drag_indicator" class="cursor-move" color="grey-4" size="20px" />
                  <q-btn flat round dense size="sm" icon="delete" color="negative"
                    @click="eliminarArchivo(archivo)" />
                </div>
                <div class="galeria__nombre row items-center no-wrap">
                  <input v-model="archivo.nombre_archivo"
                    class="input-nombre-nativo col"
                    placeholder="Nombre SEO"
                    @blur="actualizarNombreMultimedia(archivo)"
                    @keyup.enter="$event.target.blur()"
                  />
                  <q-icon
                    name="auto_awesome"
                    color="grey-5"
                    size="14px"
                    class="cursor-pointer q-ml-xs hover-icon-ia"
                    title="Sugerir nombre con IA"
                    @click="sugerirNombreMultimediaIA(archivo)"
                  />
                </div>
              </div>
            </div>
          </div>

          <!-- Sección 2: Galería secundaria -->
          <div class="card-origenes q-pa-lg">
            <div class="galeria__cabecera q-mb-lg">
              <div>
                <div class="s-header__titulo" style="font-size:14px">Galería secundaria</div>
                <div class="text-caption text-grey-5 q-mt-xs">
                  Fotos adicionales del producto · Arrastra para reordenar
                </div>
              </div>
              <q-btn unelevated size="sm" icon="upload" label="Agregar"
                color="primary" @click="abrirSubidaSeccion('Galeria secundaria')" />
            </div>

            <div v-if="fotosGaleriaSecundaria.length === 0" class="galeria__vacia">
              <q-icon name="photo_library" size="56px" color="grey-3" />
              <div class="q-mt-sm text-grey-5 text-caption">
                Sin imágenes secundarias.
              </div>
            </div>

            <div v-else class="galeria__grid">
              <div
                v-for="archivo in fotosGaleriaSecundaria"
                :key="archivo.uid"
                class="galeria__item"
                draggable="true"
                @dragstart="alIniciarArrastre($event, archivo)"
                @dragover.prevent
                @drop="alSoltar($event, archivo)"
              >
                <div class="galeria__preview">
                  <img v-if="archivo.tipo_archivo === 'imagen'"
                    :src="urlArchivo(archivo)" :alt="archivo.uso" />
                  <video v-else-if="archivo.tipo_archivo === 'video'"
                    :src="urlArchivo(archivo)"
                    autoplay loop muted playsinline
                    style="width:100%; height:100%; object-fit:cover"
                  ></video>
                  <div v-else class="galeria__preview-icono">
                    <q-icon name="description" size="32px" color="blue-grey-5" />
                  </div>
                </div>
                <div class="galeria__acciones">
                  <q-icon name="drag_indicator" class="cursor-move" color="grey-4" size="20px" />
                  <q-btn flat round dense size="sm" icon="delete" color="negative"
                    @click="eliminarArchivo(archivo)" />
                </div>
                <div class="galeria__nombre row items-center no-wrap">
                  <input v-model="archivo.nombre_archivo"
                    class="input-nombre-nativo col"
                    placeholder="Nombre SEO"
                    @blur="actualizarNombreMultimedia(archivo)"
                    @keyup.enter="$event.target.blur()"
                  />
                  <q-icon
                    name="auto_awesome"
                    color="grey-5"
                    size="14px"
                    class="cursor-pointer q-ml-xs hover-icon-ia"
                    title="Sugerir nombre con IA"
                    @click="sugerirNombreMultimediaIA(archivo)"
                  />
                </div>
              </div>
            </div>
          </div>

        </div>

        <!-- ── TAB: AUDITORÍA ────────────────────────────────── -->
        <div v-show="tabActiva === 'auditoria'">
          <div class="card-origenes q-pa-lg">

            <div class="aviso aviso--info q-mb-lg">
              <q-icon name="lock" size="15px" class="q-mr-sm flex-shrink-0" />
              <span>Campos de <strong>solo lectura</strong>. El sistema los gestiona automáticamente.</span>
            </div>

            <div class="auditoria__grid">
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
           PANEL LATERAL: Variaciones (solo si es Maestro)
      ═════════════════════════════════════════════════════════ -->
      <div v-if="tabActiva === 'general'" class="panel-variaciones card-origenes q-pa-lg">

        <div class="panel-variaciones__cabecera q-mb-md">
          <div>
            <div class="texto-seccion">Variaciones</div>
            <div class="text-caption text-grey-5 q-mt-xs">
              {{ variaciones.length }} registrada{{ variaciones.length !== 1 ? 's' : '' }}
            </div>
          </div>
          <q-btn unelevated round dense size="sm" icon="add" color="primary"
            @click="abrirPopupVariacion" />
        </div>

        <div v-if="variaciones.length === 0" class="panel-variaciones__vacio">
          <div class="panel-variaciones__vacio-icono">
            <q-icon name="tune" size="24px" color="grey-4" />
          </div>
          <div class="text-caption text-grey-5 q-mt-sm text-center">
            Sin variaciones aún.<br>Usa el + para crear la primera.
          </div>
        </div>

        <div v-else class="panel-variaciones__lista">
          <div
            v-for="variacion in variaciones"
            :key="variacion.uid"
            class="variacion-item"
            @click="editarVariacion(variacion)"
          >
            <div class="variacion-item__cabecera">
              <div class="variacion-item__nombre">{{ variacion.nombre }}</div>
              <span :class="['chip chip--xs', variacion.estado === 'Activo' ? 'chip--verde' : 'chip--gris']">
                {{ variacion.estado }}
              </span>
            </div>
            <div class="variacion-item__atributo">
              {{ variacion.nombre_atributo_variacion }}:
              <strong>{{ variacion.valor_atributo_variacion }}</strong>
            </div>
            <div v-if="variacion.precio_regular" class="variacion-item__precio">
              ${{ variacion.precio_regular }}
            </div>
          </div>
        </div>

      </div>
    </div>

    <q-dialog v-model="popupVariacionAbierto" persistent @hide="limpiarArchivoVariacion">
      <q-card class="popup-variacion">
        <q-card-section class="row items-center justify-between q-pb-sm">
          <div class="text-subtitle1 text-weight-bold">
            {{ variacionDraft.uid ? 'Edición Variación' : 'Nueva Variación' }}
          </div>
          <q-btn icon="close" flat round dense color="grey-6" @click="popupVariacionAbierto = false" />
        </q-card-section>

        <q-card-section class="q-pt-none">
          <q-select
            v-model="variacionDraft.uid_producto_padre"
            :options="opcionesMaestrosCosto"
            :loading="cargandoMaestrosCosto"
            label="Producto de Costos *"
            outlined dense
            class="q-mb-sm"
            emit-value map-options
            use-input fill-input hide-selected
            input-debounce="250"
            @filter="filtrarMaestrosCosto"
          />

          <div class="row items-center justify-between q-mb-xs">
            <div class="text-caption text-weight-medium">Nombre variación *</div>
            <q-btn flat dense no-caps size="xs" icon="auto_awesome" color="grey-6"
              label="Sugerir IA"
              @click="solicitarAsistenciaIA('nombre', variacionDraft)"
            />
          </div>
          <q-input v-model="variacionDraft.nombre" outlined dense class="q-mb-sm"
            placeholder="Ej: Miel Silvestre 500g" />

          <div class="row items-center justify-between q-mb-xs">
            <div class="text-caption text-weight-medium">Tipo de atributo</div>
            <q-btn flat dense no-caps size="xs" icon="auto_awesome" color="grey-6"
              label="Sugerir IA"
              @click="solicitarAsistenciaIA('nombre_atributo_variacion', variacionDraft)"
            />
          </div>
          <q-input v-model="variacionDraft.nombre_atributo_variacion" outlined dense class="q-mb-sm"
            placeholder="Ej: Peso, Tamaño, Sabor" />

          <div class="row items-center justify-between q-mb-xs">
            <div class="text-caption text-weight-medium">Valor del atributo</div>
            <q-btn flat dense no-caps size="xs" icon="auto_awesome" color="grey-6"
              label="Sugerir IA"
              @click="solicitarAsistenciaIA('valor_atributo_variacion', variacionDraft)"
            />
          </div>
          <q-input v-model="variacionDraft.valor_atributo_variacion" outlined dense class="q-mb-md"
            placeholder="Ej: 500g, Grande, Naranja" />

          <div class="text-caption text-weight-medium text-grey-7 q-mb-sm">Precios</div>
          <div class="row q-col-gutter-sm">
            <div class="col-12 col-md-6">
              <q-input v-model.number="variacionDraft.precio_regular" label="precio_regular" outlined dense type="number" />
            </div>
            <div class="col-12 col-md-6">
              <q-input v-model.number="variacionDraft.precio_oferta" label="precio_oferta" outlined dense type="number" />
            </div>
            <div class="col-12 col-md-6">
              <q-input v-model="variacionDraft.fecha_oferta_desde" label="fecha_oferta_desde" outlined dense type="date" />
            </div>
            <div class="col-12 col-md-6">
              <q-input v-model="variacionDraft.fecha_oferta_hasta" label="fecha_oferta_hasta" outlined dense type="date" />
            </div>
          </div>
        </q-card-section>

        <q-card-section class="q-pt-none">
          <div class="text-caption text-weight-medium q-mb-sm">Imagen de la variación</div>
          <div v-if="!producto.uid" class="text-caption text-grey-5 q-mb-sm">
            Guarda el producto maestro primero para poder adjuntar imagen.
          </div>
          <template v-else>
            <div v-if="previewArchivoVariacion" class="q-mb-sm">
              <img :src="previewArchivoVariacion"
                style="width:100%;max-height:160px;object-fit:cover;border-radius:8px;display:block;" />
              <q-btn flat dense no-caps size="xs" icon="close" label="Quitar imagen" color="negative"
                class="q-mt-xs" @click="limpiarArchivoVariacion" />
            </div>
            <div v-else class="galeria__vacia cursor-pointer" style="padding:20px 0;"
              @click="inputArchivoVariacion?.click()">
              <q-icon name="add_photo_alternate" size="32px" color="grey-3" />
              <div class="q-mt-xs text-grey-5 text-caption">Clic para adjuntar imagen</div>
            </div>
            <input
              ref="inputArchivoVariacion"
              type="file"
              style="display:none"
              accept="image/jpeg,image/png,image/webp"
              @change="seleccionarArchivoVariacion($event.target.files)"
            />
          </template>
        </q-card-section>

        <q-card-actions align="right">
          <q-btn flat no-caps label="Cancelar" color="grey-7" @click="popupVariacionAbierto = false" />
          <q-btn unelevated no-caps label="Guardar variación" color="primary" :loading="guardandoVariacion" @click="guardarVariacionExpress" />
        </q-card-actions>
      </q-card>
    </q-dialog>

  </q-page>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useQuasar } from 'quasar'
import { llamar, subirArchivo } from '../../servicios/apiService.js'

const route  = useRoute()
const router = useRouter()
const $q     = useQuasar()

// ── Definición de tabs (sin "historia" — fusionado en "contenido") ─
const tabs = [
  { nombre: 'general',    label: 'General',    icono: 'inventory_2' },
  { nombre: 'contenido',  label: 'Contenido',  icono: 'description' },
  { nombre: 'galeria',    label: 'Galeria',    icono: 'photo_library' },
  { nombre: 'auditoria',  label: 'Auditoría',  icono: 'manage_search' }
]

const tabActiva = ref('general')
const guardando = ref(false)

const producto = ref({
  uid: '',
  empresa: '',
  estado: 'Activo',
  id_producto_woocommerce: null,
  uid_producto_padre: '',
  nombre: '',
  nombre_grupo_catalogo: null,
  estado_publicacion: 'borrador',
  url_producto: '',
  producto_principal_variacion: null,
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

const multimedia        = ref([])
const variaciones       = ref([])
const archivoEnArrastre = ref(null)
const inputArchivo      = ref(null)           // input file compartido de galería
const usoSubidaActual   = ref('Galeria')      // uso a enviar en la próxima subida

// Popup variación — imagen pendiente
const inputArchivoVariacion    = ref(null)
const archivoVariacionPendiente = ref(null)
const previewArchivoVariacion  = ref('')
const opcionesMaestrosCosto = ref([])
const cargandoMaestrosCosto = ref(false)
const ultimoNombreAutocompletado = ref('')
const errorMaestrosCostoMostrado = ref(false)
const opcionesMarcas = ref([])
const cargandoMarcas = ref(false)
const errorMarcasMostrado = ref(false)
const popupVariacionAbierto = ref(false)
const guardandoVariacion = ref(false)
const variacionDraft = ref({
  uid_producto_padre: '',
  nombre: '',
  nombre_grupo_catalogo: '',
  nombre_atributo_variacion: '',
  valor_atributo_variacion: '',
  precio_regular: null,
  precio_oferta: null,
  fecha_oferta_desde: null,
  fecha_oferta_hasta: null
})

const esMaestro = computed(() => !producto.value.producto_principal_variacion)

// Vistas filtradas de multimedia por sección
const fotoPrincipal          = computed(() => multimedia.value.find(m => m.uso === 'Principal') || null)
const fotosGaleria           = computed(() => multimedia.value.filter(m => m.uso === 'Galeria'))
const fotosGaleriaSecundaria = computed(() => multimedia.value.filter(m => m.uso === 'Galeria secundaria'))

const uidMaestroCorto = computed(() => {
  const uid = producto.value.producto_principal_variacion
  return uid ? `${uid.substring(0, 12)}...` : ''
})

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

function mapearMaestrosCosto (items = []) {
  return items.map(item => ({
    label: `${item.producto} | Cod: ${item.uid}`,
    value: item.uid,
    nombre: item.producto
  }))
}

async function consultarMaestrosCosto (busqueda = '') {
  cargandoMaestrosCosto.value = true
  try {
    const datos = await llamar('comercial', 'costos', 'listar_maestros_costo', { busqueda })
    const maestros = Array.isArray(datos?.maestros) ? datos.maestros : []
    opcionesMaestrosCosto.value = mapearMaestrosCosto(maestros)
  } catch (error) {
    if (!errorMaestrosCostoMostrado.value) {
      $q.notify({
        type: 'warning',
        message: 'No fue posible cargar maestros de costo desde backend.',
        icon: 'warning'
      })
      errorMaestrosCostoMostrado.value = true
    }
    opcionesMaestrosCosto.value = []
  } finally {
    cargandoMaestrosCosto.value = false
  }
}

async function filtrarMaestrosCosto (valor, update, abort) {
  if (valor.length < 0) { abort(); return }
  await consultarMaestrosCosto(valor.trim())
  update()
}

function alSeleccionarMaestroCosto (uidSeleccionado) {
  if (!uidSeleccionado) {
    ultimoNombreAutocompletado.value = ''
    return
  }

  const maestro = opcionesMaestrosCosto.value.find(opcion => opcion.value === uidSeleccionado)
  if (!maestro) return

  const nombreActual = (producto.value.nombre || '').trim()
  if (nombreActual === '' || nombreActual === ultimoNombreAutocompletado.value) {
    producto.value.nombre = maestro.nombre
    ultimoNombreAutocompletado.value = maestro.nombre
  }
}

function mapearMarcas (items = []) {
  return items.map(item => ({
    label: item.nombre,
    value: item.uid
  }))
}

async function consultarMarcas (busqueda = '') {
  cargandoMarcas.value = true
  try {
    const datos = await llamar('comercial', 'marcas', 'listar_marcas', { busqueda })
    const marcas = Array.isArray(datos?.marcas) ? datos.marcas : []
    opcionesMarcas.value = mapearMarcas(marcas)
  } catch (error) {
    if (!errorMarcasMostrado.value) {
      $q.notify({
        type: 'warning',
        message: 'No fue posible cargar marcas desde backend. Verifica el endpoint listar_marcas.',
        icon: 'warning'
      })
      errorMarcasMostrado.value = true
    }

    if (producto.value.marca && !opcionesMarcas.value.some(op => op.value === producto.value.marca)) {
      opcionesMarcas.value = [{ label: `Marca actual (${producto.value.marca})`, value: producto.value.marca }]
    }
  } finally {
    cargandoMarcas.value = false
  }
}

async function filtrarMarcas (valor, update, abort) {
  if (valor.length < 0) { abort(); return }
  await consultarMarcas(valor.trim())
  update()
}

async function cargarProducto (uid) {
  try {
    const respuesta = await llamar('comercial', 'productos', 'obtener_producto', { uid })
    // respuesta contiene { producto, multimedia, variaciones }
    if (respuesta?.producto) {
      Object.assign(producto.value, respuesta.producto)
      multimedia.value = respuesta.multimedia || []
      variaciones.value = respuesta.variaciones || []

      // Si el producto tiene una marca, asegurarse de que aparezca en las opciones
      if (producto.value.marca && !opcionesMarcas.value.some(op => op.value === producto.value.marca)) {
        opcionesMarcas.value = [
          { label: producto.value.marca, value: producto.value.marca },
          ...opcionesMarcas.value
        ]
      }
    }
  } catch (error) {
    $q.notify({ type: 'negative', message: `Error al cargar el producto: ${error.message}`, icon: 'error' })
  }
}

async function cargarMultimedia (uid) {
  // La multimedia ya se carga dentro de cargarProducto con obtener_producto.
  // Esta función se mantiene como alias por si se llama sola en el futuro.
  console.log('[FormularioProducto] Multimedia cargada junto con el producto:', uid)
}

async function cargarVariaciones (uidMaestro) {
  // Las variaciones ya se cargan dentro de cargarProducto con obtener_producto.
  // Esta función se mantiene como alias por si se llama sola en el futuro.
  console.log('[FormularioProducto] Variaciones cargadas junto con el producto:', uidMaestro)
}

async function guardar () {
  guardando.value = true
  try {
    const resultado = await llamar('comercial', 'productos', 'guardar_producto', { ...producto.value })
    // El backend devuelve el registro completo (con uid, fechas, etc.)
    Object.assign(producto.value, resultado)
    $q.notify({ type: 'positive', message: 'Producto guardado correctamente', icon: 'check_circle' })
    router.back()
  } catch (error) {
    $q.notify({ type: 'negative', message: error.message, icon: 'error' })
  } finally {
    guardando.value = false
  }
}

function cancelar () { router.back() }

async function editarVariacion (v) {
  try {
    const respuesta = await llamar('comercial', 'productos', 'obtener_producto', { uid: v.uid })
    if (respuesta?.producto) {
      const prod = respuesta.producto
      variacionDraft.value = {
        uid: prod.uid,
        uid_producto_padre: prod.uid_producto_padre || prod.producto_principal_variacion || '',
        nombre: prod.nombre,
        nombre_atributo_variacion: prod.nombre_atributo_variacion,
        valor_atributo_variacion: prod.valor_atributo_variacion,
        precio_regular: prod.precio_regular,
        precio_oferta: prod.precio_oferta,
        fecha_oferta_desde: prod.fecha_oferta_desde,
        fecha_oferta_hasta: prod.fecha_oferta_hasta
      }
      const foto = respuesta.multimedia?.find(m => m.uso === 'Variacion')
      previewArchivoVariacion.value = foto ? (foto.url_publica_calculada || foto.archivo_local) : ''
      
      limpiarArchivoVariacion() // limpia input file físico pero mantiene preview
      popupVariacionAbierto.value = true
    }
  } catch (e) {
    $q.notify({ type: 'negative', message: 'Error cargando variación: ' + e.message })
  }
}

function abrirPopupVariacion () {
  const uidPadre     = producto.value.uid_producto_padre || producto.value.uid || ''
  const opcionCostos = opcionesMaestrosCosto.value.find(op => op.value === uidPadre)
  // Pre-llenar nombre: preferimos el nombre de costos, fallback al grupo/catálogo o nombre del producto
  const nombreSugerido = opcionCostos?.nombre
    || producto.value.nombre_grupo_catalogo
    || producto.value.nombre
    || ''

  variacionDraft.value = {
    uid_producto_padre: uidPadre,
    nombre: nombreSugerido,
    nombre_atributo_variacion: '',
    valor_atributo_variacion: '',
    precio_regular: null,
    precio_oferta: null,
    fecha_oferta_desde: null,
    fecha_oferta_hasta: null
  }
  limpiarArchivoVariacion()
  popupVariacionAbierto.value = true
}

async function guardarVariacionExpress () {
  if (!producto.value.uid) {
    $q.notify({
      type: 'warning',
      message: 'Guarda primero el producto maestro antes de crear variaciones.',
      icon: 'warning'
    })
    return
  }

  guardandoVariacion.value = true
  try {
    const payload = {
      ...variacionDraft.value,
      producto_principal_variacion: producto.value.uid,
      empresa: producto.value.empresa,
      estado: 'Activo',
      estado_publicacion: 'borrador'
    }
    const variacionGuardada = await llamar('comercial', 'productos', 'guardar_producto', payload)
    
    // Si ya existía, la actualizamos en la vista. Si es nueva, va al inicio.
    const i = variaciones.value.findIndex(v => v.uid === variacionGuardada.uid)
    if (i >= 0) {
      variaciones.value[i] = variacionGuardada
    } else {
      variaciones.value.unshift(variacionGuardada)
    }

    // Si hay imagen pendiente, subirla a la VARIACIÓN (hijo) con uso='Variacion'
    if (archivoVariacionPendiente.value && variacionGuardada.uid) {
      const datosImagen = {
        uid_producto:    variacionGuardada.uid,
        empresa:         producto.value.empresa,
        usuario_creador: producto.value.usuario_creador || 'sistema',
        orden:           1,
        uso:             'Variacion'
      }
      const registro = await subirArchivo('comercial', 'productos', 'subir_multimedia', archivoVariacionPendiente.value, datosImagen)
      multimedia.value.push(registro)
    }

    popupVariacionAbierto.value = false
    limpiarArchivoVariacion()
    $q.notify({ type: 'positive', message: 'Variación guardada correctamente', icon: 'check_circle' })
  } catch (error) {
    $q.notify({ type: 'negative', message: error.message, icon: 'error' })
  } finally {
    guardandoVariacion.value = false
  }
}

async function solicitarAsistenciaIA (campo, contexto = null) {
  try {
    const base = (contexto && '__v_isRef' in contexto) ? contexto.value : (contexto || producto.value)
    const valorActual = base[campo] || ''

    // Información del producto disponible
    const nombreProducto = producto.value.nombre || producto.value.nombre_grupo_catalogo || ''
    const nombreGrupo    = producto.value.nombre_grupo_catalogo || ''

    // Nombre del producto de costos seleccionado
    const uidPadreActual = base.uid_producto_padre || producto.value.uid_producto_padre || ''
    const opcionCostos   = opcionesMaestrosCosto.value.find(op => op.value === uidPadreActual)
    const nombreCostos   = opcionCostos?.nombre || ''

    // ── Construir instrucción enriquecida según el campo ──────────
    let instruccion = ''

    if (campo === 'nombre' && base === variacionDraft.value) {
      instruccion = `Eres un especialista en naming de productos para e-commerce colombiano.
Asigna el nombre comercial más apropiado para esta VARIACIÓN del producto.
- Producto de costos (nombre exacto en sistema): "${nombreCostos}"
- Grupo / catálogo del producto maestro: "${nombreGrupo}"
- Nombre del producto maestro: "${nombreProducto}"
- Valor actual del campo (puede estar vacío): "${valorActual}"

Regla: el nombre debe incluir el nombre del grupo Y la presentación/tamaño extraída del nombre de costos.
Ejemplo 1: costos="MIEL SILVESTRE 500G", grupo="Miel Silvestre" → "Miel Silvestre Pura 500g"
Ejemplo 2: costos="CHOCOBEETAL OS 230 GRS", grupo="Chocobeetal Artesanal" → "Chocobeetal Artesanal 230g"
Devuelve SOLO el nombre sugerido, sin explicaciones ni comillas.`
    } else if (campo === 'nombre_grupo_catalogo') {
      instruccion = `Eres un especialista en naming para tiendas online colombianas.
Sugiere el nombre del GRUPO/CATÁLOGO para este producto. Este nombre agrupa todas sus variaciones en la tienda.
- Producto de costos: "${nombreCostos}"
- Nombre actual del producto: "${producto.value.nombre || ''}"
- Valor actual del campo: "${valorActual}"

El nombre del catálogo debe ser corto (2-4 palabras), atractivo y en español.
Ejemplo 1: costos="MIEL SILVESTRE" → "Miel Silvestre"
Ejemplo 2: costos="CHOCOBEETAL OS 230 GRS" → "Chocobeetal Artesanal"
Devuelve SOLO el nombre, sin explicaciones.`
    } else if (campo === 'nombre') {
      instruccion = `Eres un especialista en naming para tiendas online colombianas.
Sugiere el nombre comercial completo para este PRODUCTO MAESTRO (incluye presentación si aplica).
- Producto de costos: "${nombreCostos}"
- Grupo / catálogo: "${nombreGrupo}"
- Valor actual del campo: "${valorActual}"

Ejemplo: costos="MIEL SILVESTRE 500G", grupo="Miel Silvestre" → "Miel Silvestre Pura 500g"
Devuelve SOLO el nombre, sin explicaciones.`
    } else if (campo === 'descripcion_corta') {
      instruccion = `Eres un copywriter especializado en productos naturales y artesanales colombianos para e-commerce.
Escribe una DESCRIPCIÓN CORTA (máximo 2 líneas / 150 caracteres) para este producto. Aparece debajo del nombre en la tienda.
- Producto: "${nombreProducto}"
- Grupo / catálogo: "${nombreGrupo}"
- Descripción corta actual (reescribir o mejorar si hay contenido): "${valorActual}"
- Descripción larga disponible: "${producto.value.descripcion_larga || 'No disponible'}"
- Ingredientes: "${producto.value.ingredientes_resumen || 'No disponible'}"

Ejemplo para "Miel Silvestre 500g": "Miel 100% pura cosechada en colmenas silvestres de los Andes colombianos. Sin procesar, sin aditivos."
Devuelve SOLO la descripción corta.`
    } else if (campo === 'descripcion_larga') {
      instruccion = `Eres un copywriter especializado en productos naturales y artesanales colombianos para e-commerce.
Escribe una DESCRIPCIÓN LARGA completa y atractiva para la página del producto (entre 100 y 300 palabras).
- Producto: "${nombreProducto}"
- Grupo / catálogo: "${nombreGrupo}"
- Descripción corta: "${producto.value.descripcion_corta || 'No disponible'}"
- Ingredientes: "${producto.value.ingredientes_resumen || 'No disponible'}"
- Productor: "${producto.value.productor || 'No disponible'}"
- Origen: "${producto.value.origen_macro || 'No disponible'}"
- Descripción larga actual (mejorar si hay contenido): "${valorActual}"

Menciona el origen, los beneficios y la forma de uso. Usa tono cálido, auténtico y cercano.
Devuelve SOLO la descripción larga.`
    } else if (campo === 'bullets_superiores') {
      instruccion = `Eres un copywriter especializado en productos naturales colombianos.
Escribe los PUNTOS CLAVE de venta de este producto (aparecen destacados en la parte superior de la ficha).
- Producto: "${nombreProducto}"
- Descripción corta: "${producto.value.descripcion_corta || 'No disponible'}"
- Ingredientes: "${producto.value.ingredientes_resumen || 'No disponible'}"
- Contenido actual (mejorar si hay): "${valorActual}"

Formato: máximo 5 puntos, un punto por línea, cada uno empieza con "•".
Ejemplo:
• 100% natural, sin conservantes ni aditivos
• Cosechada artesanalmente en los Andes colombianos
• Rica en enzimas, antioxidantes y propiedades antimicrobianas
Devuelve SOLO los bullets, uno por línea.`
    } else if (campo === 'origen_macro') {
      instruccion = `Eres un especialista en trazabilidad de productos naturales colombianos.
Describe el ORIGEN de este producto de manera atractiva para el consumidor.
- Producto: "${nombreProducto}"
- Productor: "${producto.value.productor || 'No disponible'}"
- Ubicación del productor: "${producto.value.ubicacion_productor || 'No disponible'}"
- Contenido actual (mejorar si hay): "${valorActual}"

Ejemplo: "Proveniente de colmenas silvestres ubicadas en el bosque húmedo andino antioqueño a 1.800 msnm. Cosechada manualmente siguiendo prácticas apícolas tradicionales sin intervención industrial."
Devuelve SOLO el texto de origen.`
    } else if (campo === 'ingredientes_resumen') {
      instruccion = `Eres un especialista en etiquetado de alimentos colombianos (normas INVIMA).
Escribe el RESUMEN DE INGREDIENTES para la etiqueta de este producto.
- Producto: "${nombreProducto}"
- Descripción: "${producto.value.descripcion_corta || 'No disponible'}"
- Contenido actual (mejorar si hay): "${valorActual}"

Ejemplo para miel: "Ingredientes: Miel de abejas 100% pura.\nNo contiene conservantes, colorantes ni saborizantes artificiales.\n* La miel pura puede cristalizarse — calentar a baño maría para recuperar su estado líquido."
Devuelve SOLO el texto de ingredientes.`
    } else if (campo === 'tabla_nutricional') {
      instruccion = `Eres un especialista en nutrición y etiquetado de alimentos colombianos.
Escribe la TABLA NUTRICIONAL o información nutricional básica de este producto.
- Producto: "${nombreProducto}"
- Ingredientes: "${producto.value.ingredientes_resumen || 'No disponible'}"
- Contenido actual (mejorar si hay): "${valorActual}"

Incluye: tamaño de porción, calorías, grasas, carbohidratos, azúcares y proteínas.
Formato texto estructurado. Ejemplo para miel (15g): "Porción: 1 cucharada (15g) | Calorías: 46 kcal | Grasas totales: 0g | Carbohidratos: 12g | Azúcares: 12g | Proteínas: 0g"
Devuelve SOLO la tabla nutricional.`
    } else if (campo === 'problema_real') {
      instruccion = `Eres un especialista en marketing de productos naturales y saludables.
Describe el PROBLEMA REAL que este producto resuelve para el consumidor.
- Producto: "${nombreProducto}"
- Descripción: "${producto.value.descripcion_corta || 'No disponible'}"
- Contenido actual (mejorar si hay): "${valorActual}"

Ejemplo para miel: "Muchas personas buscan endulzantes naturales sin efectos negativos del azúcar refinada. La miel silvestre endulza de forma natural mientras aporta enzimas, antioxidantes y propiedades antimicrobianas."
Devuelve SOLO el texto (2-4 líneas).`
    } else if (campo === 'beneficios_explicados') {
      instruccion = `Eres un especialista en marketing de productos naturales colombianos.
Explica los BENEFICIOS PRINCIPALES de este producto de forma clara y convincente.
- Producto: "${nombreProducto}"
- Ingredientes: "${producto.value.ingredientes_resumen || 'No disponible'}"
- Contenido actual (mejorar si hay): "${valorActual}"

Escribe entre 3 y 5 beneficios concretos, ordenados de mayor a menor impacto.
Ejemplo: "1. Propiedades antimicrobianas naturales que refuerzan el sistema inmune.\n2. Endulzante con bajo índice glucémico comparado con el azúcar refinada.\n3. Rico en antioxidantes que protegen las células del daño oxidativo."
Devuelve SOLO los beneficios numerados.`
    } else if (campo === 'experiencia_y_modo_de_uso') {
      instruccion = `Eres un especialista en comunicación de productos naturales y artesanales.
Describe la EXPERIENCIA DE USO y cómo se usa este producto.
- Producto: "${nombreProducto}"
- Descripción: "${producto.value.descripcion_corta || 'No disponible'}"
- Contenido actual (mejorar si hay): "${valorActual}"

Incluye: cómo consumirlo, cuándo usarlo, con qué combinarlo. Usa un tono evocador y apetecible.
Ejemplo: "Disfruta una cucharadita directamente para aprovechar sus propiedades en estado puro. Úsala para endulzar infusiones tibias, yogur natural o como ingrediente en recetas dulces artesanales. Ideal en las mañanas para empezar el día con energía natural."
Devuelve SOLO el texto de experiencia y modo de uso.`
    } else if (campo === 'nombre_atributo_variacion') {
      instruccion = `Eres un especialista en catálogos de productos para e-commerce.
Sugiere el NOMBRE DEL ATRIBUTO que diferencia esta variación (el tipo de diferenciador).
- Producto: "${nombreProducto}"
- Producto de costos (nombre en sistema): "${nombreCostos}"
- Valor actual del campo: "${valorActual}"

El atributo es la categoría del diferenciador (ej: "Peso", "Tamaño", "Sabor", "Presentación").
Analiza el nombre del producto de costos para deducirlo.
Ejemplo 1: costos="MIEL SILVESTRE 500G" → "Peso"
Ejemplo 2: costos="CHOCOBEETAL OS 230 GRS" → "Peso"
Ejemplo 3: costos="CAFE TOSTADO SUAVE" → "Tostado"
Devuelve SOLO el nombre del atributo (1-2 palabras, sin comillas).`
    } else if (campo === 'valor_atributo_variacion') {
      instruccion = `Eres un especialista en catálogos de productos para e-commerce.
Sugiere el VALOR del atributo "${base.nombre_atributo_variacion || 'de esta variación'}" para este producto.
- Producto: "${nombreProducto}"
- Producto de costos (nombre en sistema): "${nombreCostos}"
- Tipo de atributo: "${base.nombre_atributo_variacion || 'no definido aún'}"
- Valor actual del campo: "${valorActual}"

Extrae el valor del atributo directamente del nombre del producto de costos.
Ejemplo 1: costos="MIEL SILVESTRE 500G", atributo="Peso" → "500g"
Ejemplo 2: costos="CHOCOBEETAL OS 230 GRS", atributo="Peso" → "230g"
Devuelve SOLO el valor (sin unidad si ya está obvia en el contexto).`
    } else {
      instruccion = `Sugiere el mejor valor para el campo "${campo}" del producto "${nombreProducto}". Valor actual: "${valorActual}". Devuelve SOLO el valor sugerido.`
    }

    const respuesta = await llamar('comercial', 'asistente', 'sugerir_datos', {
      contexto: {
        campo_peticion: campo,
        instruccion,
        nombre_producto:   nombreProducto,
        nombre_costos:     nombreCostos,
        nombre_grupo:      nombreGrupo,
        valor_actual:      valorActual
      }
    })

    if (respuesta?.sugerencia) {
      base[campo] = respuesta.sugerencia
      $q.notify({
        type: 'positive',
        message: respuesta.nota || '✨ Sugerencia IA aplicada',
        icon: 'auto_awesome',
        color: 'deep-orange-9',
        timeout: 2500
      })
    }
  } catch (error) {
    console.error('[IA] Error:', error)
    $q.notify({
      type: 'warning',
      message: `Asistencia IA: ${error.message}`,
      icon: 'auto_awesome'
    })
  }
}

function urlArchivo (archivo) {
  // El backend devuelve url_publica_calculada (ver skill_multimedia_r2.md §5.3)
  return archivo.url_publica_calculada || archivo.url_publica || archivo.archivo_local || ''
}

// Abre el input file apuntando a la sección/uso indicado
function abrirSubidaSeccion (uso) {
  usoSubidaActual.value = uso
  inputArchivo.value?.click()
}

async function procesarArchivos (archivos) {
  if (!producto.value.uid) {
    $q.notify({
      type: 'warning',
      message: 'Guarda primero el producto antes de subir multimedia.',
      icon: 'warning'
    })
    return
  }

  const uso = usoSubidaActual.value

  // Si se sube una nueva Principal, mover la anterior a Galeria (solo puede haber una)
  if (uso === 'Principal' && fotoPrincipal.value) {
    fotoPrincipal.value.uso = 'Galeria'
    llamar('comercial', 'productos', 'cambiar_uso_multimedia', { uid: fotoPrincipal.value.uid, uso: 'Galeria' }).catch(e => console.error(e))
  }

  for (const archivo of Array.from(archivos)) {
    const datosExtra = {
      uid_producto:    producto.value.uid,
      empresa:         producto.value.empresa,
      usuario_creador: producto.value.usuario_creador || 'sistema',
      orden:           multimedia.value.length + 1,
      uso
    }
    try {
      $q.loading.show({ message: `Subiendo ${archivo.name}…` })
      const registro = await subirArchivo('comercial', 'productos', 'subir_multimedia', archivo, datosExtra)
      multimedia.value.push(registro)
      $q.notify({ type: 'positive', message: `${archivo.name} subida correctamente` })
    } catch (error) {
      $q.notify({ type: 'negative', message: `Error al subir ${archivo.name}: ${error.message}` })
    } finally {
      $q.loading.hide()
    }
  }
  // Limpiar el input para permitir seleccionar el mismo archivo de nuevo
  if (inputArchivo.value) inputArchivo.value.value = ''
}

function eliminarArchivo (archivo) {
  $q.dialog({
    title: 'Eliminar archivo',
    message: '¿Seguro? Esta acción no se puede deshacer.',
    cancel: { label: 'Cancelar', flat: true },
    ok: { label: 'Eliminar', color: 'negative', unelevated: true }
  }).onOk(async () => {
    try {
      $q.loading.show({ message: 'Eliminando archivo...' })
      await llamar('comercial', 'productos', 'eliminar_multimedia', { uid: archivo.uid })
      multimedia.value = multimedia.value.filter(m => m.uid !== archivo.uid)
      $q.notify({ type: 'positive', message: 'Archivo eliminado correctamente' })
    } catch (e) {
      $q.notify({ type: 'negative', message: 'Error al eliminar: ' + e.message })
    } finally {
      $q.loading.hide()
    }
  })
}

// ── Imagen en popup de variación ─────────────────────────────────
function seleccionarArchivoVariacion (archivos) {
  if (!archivos || archivos.length === 0) return
  const archivo = archivos[0]
  if (previewArchivoVariacion.value) URL.revokeObjectURL(previewArchivoVariacion.value)
  archivoVariacionPendiente.value = archivo
  previewArchivoVariacion.value = URL.createObjectURL(archivo)
  if (inputArchivoVariacion.value) inputArchivoVariacion.value.value = ''
}

function limpiarArchivoVariacion () {
  if (previewArchivoVariacion.value) URL.revokeObjectURL(previewArchivoVariacion.value)
  archivoVariacionPendiente.value = null
  previewArchivoVariacion.value = ''
}

// ── Gestión nombres multimedia ──────────────────────────────────
async function actualizarNombreMultimedia (archivo) {
  try {
    await llamar('comercial', 'productos', 'actualizar_nombre_multimedia', {
      uid: archivo.uid,
      empresa: producto.value.empresa,
      nombre_archivo: archivo.nombre_archivo
    })
    $q.notify({ type: 'positive', message: 'Nombre guardado', timeout: 1000 })
  } catch (e) {
    $q.notify({ type: 'warning', message: 'Error guardando nombre: ' + e.message })
  }
}

async function sugerirNombreMultimediaIA (archivo) {
  try {
    const nombreProd = producto.value.nombre || producto.value.nombre_grupo_catalogo || 'Producto'
    const uso = archivo.uso
    const instruccion = `Eres experto en SEO y WooCommerce. Genera un nombre de archivo optimizado (slug-style) para esta imagen/video.
- Producto: "${nombreProd}"
- Rol de la imagen: "${uso}"
- Nombre actual: "${archivo.nombre_archivo || ''}"

REGLAS STRICTAS:
- Solo texto en minúsculas.
- Separado por guiones cortos (kebab-case).
- Sin extensión de archivo (ej. .jpg).
- Ejemplo: miel-silvestre-pura-frente
Devuelve SOLO el nombre.`

    const respuesta = await llamar('comercial', 'asistente', 'sugerir_datos', {
      contexto: {
        campo_peticion: 'nombre_archivo',
        instruccion,
        nombre_producto: nombreProd
      }
    })

    if (respuesta?.sugerencia) {
      archivo.nombre_archivo = respuesta.sugerencia
      await actualizarNombreMultimedia(archivo)
      $q.notify({
        type: 'positive',
        message: 'Nombre optimizado SEO',
        icon: 'auto_awesome',
        color: 'deep-orange-9',
        timeout: 2000
      })
    }
  } catch (error) {
    console.error(error)
    $q.notify({ type: 'warning', message: 'Error en la IA: ' + error.message })
  }
}

function alIniciarArrastre (evento, archivo) {
  archivoEnArrastre.value = archivo
  evento.dataTransfer.effectAllowed = 'move'
}

function alSoltar (evento, archivoDestino) {
  if (!archivoEnArrastre.value || archivoEnArrastre.value.uid === archivoDestino.uid) return
  const lista = [...multimedia.value]
  const iOrigen  = lista.findIndex(m => m.uid === archivoEnArrastre.value.uid)
  const iDestino = lista.findIndex(m => m.uid === archivoDestino.uid)
  lista.splice(iDestino, 0, lista.splice(iOrigen, 1)[0])
  lista.forEach((item, i) => { item.orden = i + 1 })
  multimedia.value = lista
  
  const uidsOrdenados = lista.map(m => m.uid)
  llamar('comercial', 'productos', 'reordenar_multimedia', { lista: uidsOrdenados }).catch(e => {
    $q.notify({ type: 'negative', message: 'Error guardando orden: ' + e.message })
  })
  archivoEnArrastre.value = null
}

function formatearFecha (fecha) {
  if (!fecha) return '—'
  return new Date(fecha).toLocaleString('es-CO', {
    year: 'numeric', month: 'long', day: 'numeric',
    hour: '2-digit', minute: '2-digit'
  })
}

onMounted(async () => {
  await consultarMaestrosCosto()
  await consultarMarcas()

  const uid = route.params.uid
  if (uid) {
    await cargarProducto(uid)
    await cargarMultimedia(uid)
    if (esMaestro.value) {
      await cargarVariaciones(uid)
    }
  }
})
</script>

<style lang="scss" scoped>
// Referencia visual: .agent/diseno/dashboard_ref.html
// Colores:          .agent/diseno/GUIA_ESTILOS.md

.pagina-formulario {
  padding: 28px 32px;
  max-width: 1440px;
  margin: 0 auto;
}

.popup-variacion {
  width: 100%;
  max-width: 760px;
  border-radius: 14px;
}

// ══════════════════════════════════════════════════════════════════
// CARD DE SECCIÓN (formulario)
// ══════════════════════════════════════════════════════════════════
.card-origenes {
  background: #FFFFFF;
  border-radius: 16px;
  border: 1px solid rgba(0, 0, 0, 0.04);
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05), 0 4px 20px rgba(0, 0, 0, 0.03);
}

// ══════════════════════════════════════════════════════════════════
// CABECERA
// ══════════════════════════════════════════════════════════════════
.cabecera {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
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
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 520px;
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
    padding-top: 28px; // alinea con el título
  }

  &__separador {
    height: 1px;
    background: linear-gradient(90deg, #E8750A22 0%, #E0DDD8 30%, #F8F7F5 100%);
    margin-top: 16px;
  }
}

// ══════════════════════════════════════════════════════════════════
// CHIPS DE ESTADO
// ══════════════════════════════════════════════════════════════════
.chip {
  font-size: 10px;
  font-weight: 700;
  padding: 3px 10px;
  border-radius: 20px;
  white-space: nowrap;
  letter-spacing: 0.2px;

  &--xs { font-size: 9px; padding: 2px 7px; }

  &--verde   { background: #E8F5E5; color: #2E7A2A; }
  &--gris    { background: #F3F1EE; color: #7A7A7A; }
  &--maestro { background: #FEF8E0; color: #9A7200; }
  &--hija    { background: #E5F0FF; color: #1A5ACC; font-family: monospace; }

  // Estados de publicación
  &--pub-borrador  { background: #F3F1EE; color: #7A7A7A; }
  &--pub-publicado { background: #E8F5E5; color: #2E7A2A; }
  &--pub-privado   { background: #E5F0FF; color: #1A5ACC; }
  &--pub-pendiente { background: #FEF8E0; color: #9A7200; }
}

// ══════════════════════════════════════════════════════════════════
// BARRA DE TABS PERSONALIZADA
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
// LAYOUT PRINCIPAL
// ══════════════════════════════════════════════════════════════════
.cuerpo {
  display: flex;
  gap: 20px;
  align-items: flex-start;

  .formulario-principal { flex: 1; min-width: 0; }
}

// ══════════════════════════════════════════════════════════════════
// SEPARADORES DE SECCIÓN DENTRO DE CARDS
// ══════════════════════════════════════════════════════════════════
.s-header {
  display: flex;
  align-items: center;
  gap: 10px;

  &__icono {
    width: 28px;
    height: 28px;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
  }

  &__titulo {
    font-size: 10.5px;
    font-weight: 800;
    letter-spacing: 1px;
    text-transform: uppercase;
    color: #AAAAAA;
    white-space: nowrap;
  }

  &__linea {
    flex: 1;
    height: 1px;
    background: #F0EDE8;
  }
}

// ══════════════════════════════════════════════════════════════════
// INPUT DE NOMBRE (más grande, más presencia)
// ══════════════════════════════════════════════════════════════════
.nombre-grande {
  :deep(.q-field__control) { font-size: 16px; font-weight: 600; }
  :deep(.q-field__label)   { font-size: 13px; }
}

// ══════════════════════════════════════════════════════════════════
// CARD DE OFERTA (aparece/desaparece con transición)
// ══════════════════════════════════════════════════════════════════
.card-oferta {
  background: rgba(232, 117, 10, 0.04);
  border: 1px solid rgba(232, 117, 10, 0.2);
  border-radius: 16px;

  &__header {
    display: flex;
    align-items: center;
    font-size: 13px;
    font-weight: 700;
    color: #C55E00;
  }
}

.fade-slide-enter-active,
.fade-slide-leave-active { transition: all 0.2s ease; }
.fade-slide-enter-from,
.fade-slide-leave-to { opacity: 0; transform: translateY(-6px); }

// ══════════════════════════════════════════════════════════════════
// AVISOS CONTEXTUALES
// ══════════════════════════════════════════════════════════════════
.aviso {
  display: flex;
  align-items: flex-start;
  padding: 12px 14px;
  border-radius: 10px;
  font-size: 13px;

  code {
    background: rgba(240, 184, 34, 0.2);
    padding: 1px 6px;
    border-radius: 4px;
    font-size: 11px;
  }

  &--maestro {
    background: rgba(240, 184, 34, 0.07);
    border: 1px solid rgba(240, 184, 34, 0.22);
    color: #7A5E00;
  }

  &--hija {
    background: rgba(26, 90, 204, 0.05);
    border: 1px solid rgba(26, 90, 204, 0.18);
    color: #1A3A6A;
  }

  &--info {
    background: #F8F7F5;
    color: #7A7A7A;
    font-size: 12px;
  }
}

// ══════════════════════════════════════════════════════════════════
// GALERÍA MULTIMEDIA
// ══════════════════════════════════════════════════════════════════
.galeria {
  &__cabecera {
    display: flex;
    align-items: flex-start;
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
    border: 1px solid rgba(0, 0, 0, 0.05);
    border-radius: 14px;
    overflow: hidden;
    background: #FAFAF9;
    transition: box-shadow 0.2s, transform 0.2s;
    position: relative;

    &:hover {
      box-shadow: 0 6px 20px rgba(0, 0, 0, 0.09);
      transform: translateY(-1px);
    }
    &--principal { border: 2px solid #E8750A; }
  }

  &__preview {
    height: 140px;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    background: #F0EDE8;
    position: relative;

    img { width: 100%; height: 100%; object-fit: cover; }
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

  &__uso     { padding: 8px; }
  &__acciones {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 4px 10px 8px;
  }

  // Fila del nombre SEO — caption minimalista sin caja negra
  &__nombre {
    display: flex;
    align-items: center;
    gap: 4px;
    padding: 6px 10px 9px;
    background: rgba(248, 247, 245, 0.8);
    border-top: 1px solid #F3F1EE;
  }
}

// ── Input de nombre SEO (elimina borde negro del browser) ──────────
.input-nombre-nativo {
  flex: 1;
  border: none;
  outline: none;
  background: transparent;
  font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
  font-size: 10.5px;
  font-weight: 500;
  color: #7A7A7A;
  letter-spacing: 0.2px;
  min-width: 0;
  padding: 0 2px;
  transition: color 0.15s;

  &::placeholder {
    color: #C8C4BE;
    font-style: italic;
    font-size: 10px;
  }

  &:focus {
    color: #C55E00;
  }
}

// ── Ícono IA en nombre multimedia ─────────────────────────────────
.hover-icon-ia {
  flex-shrink: 0;
  transition: color 0.15s, opacity 0.15s;
  opacity: 0.45;
  cursor: pointer;

  &:hover {
    color: #E8750A !important;
    opacity: 1;
  }
}

// ══════════════════════════════════════════════════════════════════
// PANEL LATERAL DE VARIACIONES
// ══════════════════════════════════════════════════════════════════
.panel-variaciones {
  width: 268px;
  flex-shrink: 0;
  position: sticky;
  top: 24px;
  height: fit-content;

  &__cabecera {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
  }

  &__vacio {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 28px 0;
  }

  &__vacio-icono {
    width: 48px;
    height: 48px;
    background: #F8F7F5;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  &__lista {
    display: flex;
    flex-direction: column;
    gap: 6px;
  }
}

.variacion-item {
  padding: 10px 12px;
  border-radius: 10px;
  border: 1px solid #F0EDE8;
  cursor: pointer;
  transition: all 0.18s;

  &:hover {
    background: rgba(232, 117, 10, 0.03);
    border-color: rgba(232, 117, 10, 0.22);
    transform: translateX(3px);
    box-shadow: 0 2px 8px rgba(232, 117, 10, 0.06);
  }

  &__cabecera {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 3px;
  }

  &__nombre {
    font-size: 12px;
    font-weight: 600;
    color: #1A1A1A;
  }

  &__atributo {
    font-size: 11px;
    color: #9A9A9A;
    margin-bottom: 5px;
  }

  &__precio {
    font-size: 11px;
    font-weight: 700;
    color: #C55E00;
  }
}

// ══════════════════════════════════════════════════════════════════
// GRID DE AUDITORÍA
// ══════════════════════════════════════════════════════════════════
.auditoria__grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 12px;

  @media (max-width: 599px) { grid-template-columns: 1fr; }
}

.texto-seccion { font-size: 13px; font-weight: 700; color: #1A1A1A; }

.mono { font-family: monospace; font-size: 11px; }

.flex-shrink-0 { flex-shrink: 0; }

// ══════════════════════════════════════════════════════════════════
// FOTO PRINCIPAL (card en pestaña General)
// ══════════════════════════════════════════════════════════════════
.foto-principal {
  &__preview {
    position: relative;
    border-radius: 12px;
    overflow: hidden;
    background: #F0EDE8;
    max-height: 300px;

    img {
      width: 100%;
      max-height: 300px;
      object-fit: cover;
      display: block;
    }
  }

  &__acciones {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-top: 10px;
  }

  &__dropzone {
    cursor: pointer;
    transition: border-color 0.15s, background 0.15s;
    &:hover {
      border-color: #E8750A;
      background: rgba(232, 117, 10, 0.03);
    }
  }
}
</style>
