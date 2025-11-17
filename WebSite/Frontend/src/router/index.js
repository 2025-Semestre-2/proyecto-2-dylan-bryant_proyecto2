import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../clientes/Clientes.vue'
import AboutView from '../proveedores/Proveedores.vue'
import DatosDelCliente from '../clientes/DatosDelCliente.vue'
import DatosDelProveedor from '../proveedores/DatosDelProveedor.vue'
import Inventario from '../inventario/Inventario.vue'
import DatosDelItem from '../inventario/DatosDelItem.vue'
import Ventas from '../ventas/Ventas.vue'
import DetalleFactura from '../ventas/DetalleVenta.vue'
import PrimeraEstadistica from '../estadistica/Primera.vue'
import SegundaEstadistica from '../estadistica/Segunda.vue'
import TerceraEstadistica from '../estadistica/Tecera.vue'
import CuartaEstadistica from '../estadistica/Cuarta.vue'
import QuintaEstadistica from '../estadistica/Quinta.vue'
import Layout from '../layout/LayoutApp.vue'


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes:[
    {
    path: '/',
    redirect: '/login'
  },
  { 
    path: '/clientes', 
    component: Layout,
    children:[
      {path: '', name: 'clientes', component: () => import('../clientes/Clientes.vue')}
    ]  
  },
  { path: '/proveedores', 
    component: Layout,
    children:[
      {path: '', name: 'proveedores', component: () => import('../proveedores/Proveedores.vue')}
    ]  
  },
  { path: '/datosDelCliente', 
    component: Layout,
    children:[
      {path: '', name: 'datosDelCliente', component: () => import('../clientes/DatosDelCliente.vue')}
    ]  
  },
   { path: '/datosDelProveedor', 
    component: Layout,
    children:[
      {path: '', name: 'datosDelProveedor', component: () => import('../proveedores/DatosDelProveedor.vue')}
    ]  
  },
  { path: '/inventario', 
    component: Layout,
    children:[
      {path: '', name: 'inventario', component: () => import('../inventario/Inventario.vue')}
    ]  
  },
  { path: '/datosDelItem', 
    component: Layout,
    children:[
      {path: '', name: 'datosDelItem', component: () => import('../inventario/DatosDelItem.vue')}
    ]  
  },
  { path: '/agregarProducto', 
    component: Layout,
    children:[
      {path: '', name: 'agregarProducto', component: () => import('../inventario/AgregarItem.vue')}
    ]  
  },
 
  { path: '/ventas', 
    component: Layout,
    children:[
      {path: '', name: 'ventas', component: () => import('../ventas/Ventas.vue')}
    ]  
  },

  { path: '/detalleDeLaFactura', 
    component: Layout,
    children:[
      {path: '', name: 'detalleDeLaFactura', component: () => import('../ventas/DetalleVenta.vue')}
    ]  
  },

  { path: '/primeraEstadistica', 
    component: Layout,
    children:[
      {path: '', name: 'primeraEstadistica', component: () => import('../estadistica/Primera.vue')}
    ]  
  },

  { path: '/segundaEstadistica', 
    component: Layout,
    children:[
      {path: '', name: 'segundaEstadistica', component: () => import('../estadistica/Segunda.vue')}
    ]  
  },

  { path: '/terceraEstadistica', 
    component: Layout,
    children:[
      {path: '', name: 'terceraEstadistica', component: () => import('../estadistica/Tecera.vue')}
    ]  
  },

  { path: '/cuartaEstadistica', 
    component: Layout,
    children:[
      {path: '', name: 'cuartaEstadistica', component: () => import('../estadistica/Cuarta.vue')}
    ]  
  },

  { path: '/quintaEstadistica', 
    component: Layout,
    children:[
      {path: '', name: 'quintaEstadistica', component: () => import('../estadistica/Quinta.vue')}
    ]  
  },
 
  {
      path: '/login',
      name: 'Iniciar Sesión',
      component: () => import('../login/login.vue'),
    }
  ],
})


export default router