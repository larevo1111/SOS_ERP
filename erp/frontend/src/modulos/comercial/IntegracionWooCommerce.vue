<template>
  <q-page class="woo-page">
    <div class="woo-header">
      <div class="woo-header__icono">🛒</div>
      <div>
        <div class="woo-header__titulo">Integración WooCommerce</div>
        <div class="woo-header__subtitulo">Sincronización con tu tienda en línea</div>
      </div>
    </div>

    <!-- Estado de Conexión -->
    <div class="woo-card woo-estado">
      <div class="woo-estado__icono">⚡</div>
      <div>
        <div class="woo-estado__titulo">Estado de Conexión</div>
        <div class="woo-estado__badge woo-estado__badge--pendiente">Pendiente de configuración</div>
      </div>
    </div>

    <!-- Acciones disponibles -->
    <div class="woo-grid">
      <div class="woo-card woo-card--accion" v-for="accion in acciones" :key="accion.id">
        <div class="woo-card__icono">{{ accion.icono }}</div>
        <div class="woo-card__titulo">{{ accion.titulo }}</div>
        <div class="woo-card__desc">{{ accion.desc }}</div>
        <q-btn
          outline
          color="primary"
          :label="accion.boton"
          class="woo-card__btn"
          :disable="true"
          size="sm"
        />
      </div>
    </div>

    <!-- Próximos Pasos -->
    <div class="woo-card woo-proximos">
      <div class="woo-proximos__titulo">📋 Próximos Pasos</div>
      <div class="woo-proximos__item" v-for="(paso, i) in pasos" :key="i">
        <span class="woo-proximos__num">{{ i + 1 }}</span>
        <span>{{ paso }}</span>
      </div>
    </div>
  </q-page>
</template>

<script setup>
const acciones = [
  {
    id: 1,
    icono: '↓',
    titulo: 'Importar Productos',
    desc: 'Trae todos los productos de WooCommerce al ERP.',
    boton: 'Próximamente'
  },
  {
    id: 2,
    icono: '↑',
    titulo: 'Exportar al Catálogo',
    desc: 'Sube tus productos del ERP a la tienda web.',
    boton: 'Próximamente'
  },
  {
    id: 3,
    icono: '🔁',
    titulo: 'Sincronizar Precios',
    desc: 'Actualiza precios en ambas plataformas.',
    boton: 'Próximamente'
  }
]

const pasos = [
  'Configurar las llaves API de WooCommerce (Ajustes de Sistema)',
  'Verificar la conexión con tu tienda en línea',
  'Crear el mapeo de categorías entre ERP y WooCommerce',
  'Realizar la primera sincronización de prueba'
]
</script>

<style lang="scss" scoped>
.woo-page {
  padding: 28px 32px;
  background: #FDFDFB;
  min-height: 100vh;
}

.woo-header {
  display: flex;
  align-items: center;
  gap: 14px;
  margin-bottom: 24px;

  &__icono {
    width: 48px;
    height: 48px;
    background: #fff3e0;
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 22px;
    flex-shrink: 0;
  }

  &__titulo {
    font-size: 20px;
    font-weight: 700;
    color: #1A1A1A;
  }

  &__subtitulo {
    font-size: 13px;
    color: #8A8A8A;
    margin-top: 2px;
  }
}

.woo-card {
  background: #fff;
  border: 1px solid rgba(141, 184, 154, 0.2);
  border-radius: 14px;
  padding: 20px;
  margin-bottom: 16px;
}

.woo-estado {
  display: flex;
  align-items: center;
  gap: 14px;

  &__icono {
    font-size: 24px;
  }

  &__titulo {
    font-size: 13px;
    font-weight: 600;
    color: #1A1A1A;
    margin-bottom: 4px;
  }

  &__badge {
    display: inline-block;
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: 600;

    &--pendiente {
      background: #fff3e0;
      color: #C55E00;
    }

    &--conectado {
      background: #e8f5e9;
      color: #2D5A27;
    }
  }
}

.woo-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 14px;
  margin-bottom: 16px;

  @media (max-width: 768px) {
    grid-template-columns: 1fr;
  }
}

.woo-card--accion {
  text-align: center;

  .woo-card__icono {
    font-size: 28px;
    margin-bottom: 10px;
  }

  .woo-card__titulo {
    font-size: 14px;
    font-weight: 700;
    color: #1A1A1A;
    margin-bottom: 6px;
  }

  .woo-card__desc {
    font-size: 12px;
    color: #7A7A7A;
    margin-bottom: 14px;
    line-height: 1.4;
  }

  .woo-card__btn {
    width: 100%;
  }
}

.woo-proximos {
  &__titulo {
    font-size: 14px;
    font-weight: 700;
    color: #1A1A1A;
    margin-bottom: 14px;
  }

  &__item {
    display: flex;
    align-items: flex-start;
    gap: 10px;
    font-size: 13px;
    color: #4A4A4A;
    margin-bottom: 10px;
  }

  &__num {
    width: 22px;
    height: 22px;
    background: rgba(141, 184, 154, 0.2);
    color: #2D5A27;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 11px;
    font-weight: 700;
    flex-shrink: 0;
  }
}
</style>
