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

const routes = [
  { path: '/', component: HomeView },
  { path: '/proveedores', component: AboutView },
  { path: '/datosDelCliente', component: DatosDelCliente },
  { path: '/datosDelProveedor', component: DatosDelProveedor },
  { path: '/inventario', component: Inventario },
  { path: '/datosDelItem', component: DatosDelItem },
  { path: '/ventas', component: Ventas },
  { path: '/detalleDeLaFactura', component: DetalleFactura },
  { path: '/primeraEstadistica', component: PrimeraEstadistica },
  { path: '/segundaEstadistica', component: SegundaEstadistica },
  { path: '/terceraEstadistica', component: TerceraEstadistica },
  { path: '/cuartaEstadistica', component: CuartaEstadistica },
  { path: '/quintaEstadistica', component: QuintaEstadistica }
]

const router = createRouter({
  history: createWebHistory(), // usa el historial del navegador
  routes
})

export default router