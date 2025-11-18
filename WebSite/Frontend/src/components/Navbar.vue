<template>
    <div class="navbar bg-sky-300 shadow-sm">
        <div class="flex-1" v-if="sucursal === 'Limon' || sucursal === 'SanJose'">
            <a class="btn btn-ghost text-xl">Wide World Importers</a>
            <router-link to="/clientes" class="btn btn-ghost text-xl">Clientes</router-link>
            <router-link to="/proveedores" class="btn btn-ghost text-xl">Proveedores</router-link>
            <router-link to="/inventario" class="btn btn-ghost text-xl">Inventario</router-link>
            <router-link to="/ventas" class="btn btn-ghost text-xl">Ventas</router-link>
            
        </div>

         <div class="flex-1" v-if="sucursal === 'Corporativo'">
            <a class="btn btn-ghost text-xl">Wide World Importers</a>
            <router-link to="/primeraEstadistica" class="btn btn-ghost text-xl">Primera</router-link>
            <router-link to="/segundaEstadistica" class="btn btn-ghost text-xl">Segunda</router-link>
            <router-link to="/terceraEstadistica" class="btn btn-ghost text-xl">Tercera</router-link>
            <router-link to="/cuartaEstadistica" class="btn btn-ghost text-xl">Cuarta</router-link>
            <router-link to="/quintaEstadistica" class="btn btn-ghost text-xl">Quinta</router-link>
        </div>
        <!--
        <div class="flex-none">
            <ul class="menu menu-horizontal px-1  text-xl">
      
            <li>
                <details>
                <summary>Estadísticas</summary>
                <ul class="bg-base-100 rounded-t-none p-2">
                    <li><router-link to="/primeraEstadistica">1- Montos de Proveedores</router-link></li>
                    <li><router-link to="/segundaEstadistica">2- Montos de Clientes</router-link></li>
                    <li><router-link to="/terceraEstadistica">3- Top 5 Productos Mayor Ganancia</router-link></li>
                    <li><router-link to="/cuartaEstadistica">4- Top 5 Clientes Mayor Cantidad Facturas</router-link></li>
                    <li><router-link to="/quintaEstadistica">5- Top 5 Proveedores Mayor Cantidad Ordenes</router-link></li>
                </ul>
                </details>
            </li>
            </ul>
        </div>
        -->
    </div>

    
</template>

<script>
    import { usuarioStore } from '../stores/usuario.js'
    export default{
        data(){
            return{
                sucursal: ''
            }
        },
        mounted(){
            const store = usuarioStore();
            this.sucursal = store.sucursal;
        }
    }
</script>
