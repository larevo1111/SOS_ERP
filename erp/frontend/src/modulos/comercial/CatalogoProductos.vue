<template>
  <q-page class="pagina-catalogo">

    <!-- Cabecera -->
    <div class="cabecera-catalogo q-mb-xl">
      <div>
        <div class="text-h5 text-weight-bold text-dark">Catálogo Comercial</div>
        <div class="text-caption text-grey-6 q-mt-xs">Listado maestro de productos y variaciones</div>
      </div>
      <q-btn
        unelevated
        color="primary"
        icon="add"
        label="Nuevo Producto Maestro"
        no-caps
        @click="nuevoProducto"
      />
    </div>

    <!-- Filtros simples (placeholder funcional) -->
    <div class="card-busqueda q-pa-md q-mb-lg row items-center justify-between">
      <q-input
        v-model="busqueda"
        outlined
        dense
        placeholder="Buscar por nombre o UID..."
        class="col-12 col-md-4"
        @keyup.enter="cargarProductos"
      >
        <template v-slot:append>
          <q-icon name="search" class="cursor-pointer" @click="cargarProductos" />
        </template>
      </q-input>

      <div class="row items-center gap-sm">
        <q-toggle v-model="soloMaestros" label="Solo Maestros" color="primary" @update:model-value="cargarProductos" />
        <q-btn flat color="primary" label="Recargar" icon="refresh" no-caps @click="cargarProductos" />
      </div>
    </div>

    <!-- Tabla de Productos Construidos -->
    <q-table
      :rows="productos"
      :columns="columnas"
      row-key="uid"
      :loading="cargando"
      flat bordered
      class="tabla-productos"
      no-data-label="No hay productos registrados aún. Empieza creando el primero."
    >
      <template v-slot:body-cell-foto="props">
        <q-td :props="props">
          <div class="producto-thumb">
            <img v-if="props.row.foto_principal" :src="props.row.foto_principal" loading="lazy" />
            <q-icon v-else name="image" color="grey-4" size="20px" />
          </div>
        </q-td>
      </template>

      <template v-slot:body-cell-nombre="props">
        <q-td :props="props">
          <div class="row items-center cursor-pointer text-primary text-weight-medium" @click="verProducto(props.row.uid)">
            <q-icon v-if="!props.row.producto_principal_variacion" name="star" color="amber" size="14px" class="q-mr-xs" />
            <q-icon v-else name="account_tree" color="grey" size="14px" class="q-mr-xs" />
            {{ props.row.nombre }}
          </div>
        </q-td>
      </template>

      <template v-slot:body-cell-estado="props">
        <q-td :props="props">
          <q-chip :color="props.row.estado === 'Activo' ? 'positive' : 'grey'" text-color="white" size="sm">
            {{ props.row.estado }}
          </q-chip>
        </q-td>
      </template>

      <template v-slot:body-cell-precio="props">
        <q-td :props="props">
          {{ props.row.precio_regular ? '$' + props.row.precio_regular : '—' }}
        </q-td>
      </template>
      
      <template v-slot:body-cell-acciones="props">
        <q-td :props="props" class="text-right">
          <q-btn flat round dense color="grey-6" icon="visibility" @click="verProducto(props.row.uid)" class="q-mr-xs">
            <q-tooltip>Ver detalle</q-tooltip>
          </q-btn>
          <q-btn flat round dense color="primary" icon="edit" @click="editarProducto(props.row.uid)">
            <q-tooltip>Editar producto</q-tooltip>
          </q-btn>
        </q-td>
      </template>
    </q-table>
  </q-page>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { llamar } from '../../servicios/apiService.js'

const router = useRouter()

const busqueda = ref('')
const soloMaestros = ref(true)
const cargando = ref(false)
const productos = ref([])

const columnas = [
  { name: 'foto',      label: '',               align: 'center', field: 'foto_principal', style: 'width:68px; padding:8px' },
  { name: 'nombre',   label: 'Nombre del Producto', align: 'left', field: 'nombre', sortable: true },
  { name: 'categoria', label: 'Categoría',      align: 'left',   field: 'categoria',     sortable: true },
  { name: 'marca',    label: 'Marca',            align: 'left',   field: 'marca',         sortable: true },
  { name: 'precio',   label: 'Precio Regular',   align: 'right',  field: 'precio_regular', sortable: true },
  { name: 'estado',   label: 'Estado',           align: 'center', field: 'estado',        sortable: true },
  { name: 'acciones', label: '',                 align: 'right' }
]

async function cargarProductos () {
  cargando.value = true
  try {
    const params = {
      empresa: 'Origen Silvestre', // Provisional, debería venir del store de auth
      busqueda: busqueda.value,
      solo_maestros: soloMaestros.value
    }
    const data = await llamar('comercial', 'productos', 'listar_productos', params)
    productos.value = data || []
  } catch (e) {
    // Si la conexion HTTP falla en este entorno en crudo (auth no configurada 100%), no romper la UI
    console.error('Error cargando catalogo:', e)
  } finally {
    cargando.value = false
  }
}

function nuevoProducto () {
  router.push({ name: 'nuevo-producto' })
}

function verProducto (uid) {
  router.push({ name: 'ver-producto', params: { uid } })
}

function editarProducto (uid) {
  router.push({ name: 'editar-producto', params: { uid } })
}

onMounted(() => {
  cargarProductos()
})
</script>

<style lang="scss" scoped>
.pagina-catalogo {
  padding: 32px 40px;
  max-width: 1440px;
  margin: 0 auto;
}

.cabecera-catalogo {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-busqueda {
  background: white;
  border-radius: 12px;
  border: 1px solid rgba(0,0,0,0.05);
  box-shadow: 0 2px 10px rgba(0,0,0,0.02);
}

.tabla-productos {
  border-radius: 12px;
  :deep(.q-table__top) {
    padding: 16px;
  }
}

.gap-sm {
  gap: 16px;
}

.producto-thumb {
  width: 48px;
  height: 48px;
  border-radius: 8px;
  overflow: hidden;
  background: #f5f5f5;
  border: 1px solid rgba(0, 0, 0, 0.05);
  display: flex;
  align-items: center;
  justify-content: center;

  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
  }
}
</style>
