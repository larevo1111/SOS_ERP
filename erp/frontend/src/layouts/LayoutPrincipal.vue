<template>
  <q-layout view="lHh Lpr lFf">
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

          <!-- Módulo Comercial — expandible -->
          <q-expansion-item
            default-opened
            expand-separator
            class="nav-expansion"
            expand-icon-class="text-grey-6"
          >
            <!-- Cabecera idéntica a "Dashboard" -->
            <template v-slot:header>
              <q-item-section avatar>
                <q-icon name="store" size="18px" />
              </q-item-section>
              <q-item-section class="nav-expansion__titulo">
                Comercial
              </q-item-section>
            </template>

            <!-- Subitems con leve sangría hacia la derecha -->
            <q-item clickable v-ripple :to="{ name: 'catalogo-productos' }" active-class="nav-item--activo" class="nav-item nav-item--sub">
              <q-item-section avatar><q-icon name="inventory_2" size="16px" /></q-item-section>
              <q-item-section>Catálogo Comercial</q-item-section>
            </q-item>
            <q-item clickable v-ripple :to="{ name: 'woocommerce' }" active-class="nav-item--activo" class="nav-item nav-item--sub">
              <q-item-section avatar><q-icon name="shopping_cart" size="16px" /></q-item-section>
              <q-item-section>Integración WooCommerce</q-item-section>
            </q-item>
          </q-expansion-item>
        </q-scroll-area>

        <!-- Usuario -->
        <div class="sidebar__footer">
          <div class="sidebar__usuario">
            <div class="sidebar__avatar">SS</div>
            <div>
              <div class="sidebar__usuario-nombre">Santiago Sierra</div>
              <div class="sidebar__usuario-rol">Administrador</div>
            </div>
          </div>
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
import { ref } from 'vue'
const menuAbierto = ref(true)
</script>

<style lang="scss" scoped>
.sidebar {
  height: 100%;
  display: flex;
  flex-direction: column;
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
    padding: 14px 18px 0;
    border-top: 1px solid rgba(141, 184, 154, 0.15);
  }

  &__usuario {
    display: flex;
    align-items: center;
    gap: 10px;
  }

  &__avatar {
    width: 34px;
    height: 34px;
    background: #2C3D2E;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #8DB89A;
    font-size: 11px;
    font-weight: 800;
    flex-shrink: 0;
  }

  &__usuario-nombre {
    font-size: 12px;
    font-weight: 700;
    color: #1A1A1A;
  }

  &__usuario-rol {
    font-size: 10px;
    color: #8A8A8A;
  }
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

  &--sub {
    font-size: 13px;
    padding-left: 24px; // Levemente corridos hacia la derecha como pidió Santi
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
  }

  :deep(.q-item) {
    border-radius: 10px;
    padding: 8px 16px; // Mismo padding exacto que el Dashboard (nav-item por defecto de Quasar suele tener esto)
    min-height: 36px;
  }
}
</style>
