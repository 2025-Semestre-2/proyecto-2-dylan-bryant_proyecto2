<template>
     <div class="flex justify-center items-center h-screen" style="background-color: #03366A;">
        <fieldset class="fieldset bg-base-200 border-base-300 rounded-box w-xs border p-4 shadow-lg">
            <form id="loginForm" @submit.prevent="redirigir">
                <legend class="fieldset-legend text-2xl text-center ">Iniciar Sesión</legend>

                <label class="label">Correo</label>
                <input type="email" class="input" placeholder="usuario@dominio.com" required id="email" v-model="usuario"/>

                <label class="label">Contraseña</label>
                <input type="password" class="input" placeholder="****" required id="password" v-model="contrasenia"/>

                <!--Selector del grupo-->
                <fieldset class="fieldset">
                <legend class="fieldset-legend">Sucursal</legend>
                <select class="select" v-model="sucursalSeleccionada">
                    <option value="Limon" selected>Limón</option>
                    <option value="SanJose">San José</option>
                    <option value="Corporativo">Corporativo</option>
                </select>
                <span class="label"></span>
                </fieldset>

                <div class="botonesEncabezado flex justify-center gap-5 p-5">
                    <button class="btn bg-[#03366A] text-white hover:bg-[#022f5c]" type="submit">Iniciar Sesión</button>
                    <button class="btn bg-[#03366A] text-white hover:bg-[#022f5c]" type="button">Olvidé mi Contraseña</button>
                </div>

            </form>
        </fieldset>
    </div>
</template>
<script>
import { usuarioStore } from '../stores/usuario.js'
export default {
    data(){
        return{
            sucursalSeleccionada: ""
        }
    },
    methods: {
    async redirigir() {
      //Primero guardo el usuario
        await this.colocarSucursal(this.sucursalSeleccionada);
        await this.$router.push('/clientes');
      
 
    },
    async colocarSucursal(sucursal){
        console.log("Sucursal atributo: "+ this.sucursalSeleccionada)
        const store = usuarioStore();
        await store.setSucursal(sucursal);
    }

  }
}
</script>