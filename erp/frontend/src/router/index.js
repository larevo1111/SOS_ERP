import { createRouter, createWebHashHistory } from 'vue-router'
import routes from './routes'

import { useAuthStore } from 'src/stores/authStore'

const router = createRouter({
  scrollBehavior: () => ({ left: 0, top: 0 }),
  routes,
  history: createWebHashHistory(process.env.VUE_ROUTER_BASE)
})

router.beforeEach((to, from, next) => {
  const authStore = useAuthStore()
  if (to.name !== 'login' && !authStore.estaAutenticado) {
    next({ name: 'login' })
  } else if (to.name === 'login' && authStore.estaAutenticado) {
    next({ name: 'inicio' })
  } else {
    next()
  }
})

export default router
