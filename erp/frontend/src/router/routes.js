const routes = [
  {
    path: '/',
    component: () => import('layouts/LayoutPrincipal.vue'),
    children: [
      {
        path: '',
        name: 'inicio',
        component: () => import('pages/PaginaInicio.vue')
      },
      {
        path: '/comercial/productos',
        name: 'catalogo-productos',
        component: () => import('modulos/comercial/CatalogoProductos.vue')
      },
      {
        path: '/comercial/producto/:uid/ver',
        name: 'ver-producto',
        component: () => import('modulos/comercial/DetalleProducto.vue')
      },
      {
        path: '/comercial/producto/:uid',
        name: 'editar-producto',
        component: () => import('modulos/comercial/FormularioProducto.vue')
      },
      {
        path: '/comercial/producto/nuevo',
        name: 'nuevo-producto',
        component: () => import('modulos/comercial/FormularioProducto.vue')
      },
      {
        path: '/comercial/woocommerce',
        name: 'woocommerce',
        component: () => import('modulos/comercial/IntegracionWooCommerce.vue')
      }
    ]
  },
  {
    path: '/login',
    name: 'login',
    component: () => import('pages/PaginaLogin.vue')
  },
  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/PaginaError404.vue')
  }
]

export default routes
