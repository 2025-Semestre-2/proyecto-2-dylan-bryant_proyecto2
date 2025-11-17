<template>
     <div class="flex justify-center items-center h-screen" style="background-color: #03366A;">
        <fieldset class="fieldset bg-base-200 border-base-300 rounded-box w-xs border p-4 shadow-lg">
            <form id="loginForm" @submit.prevent="iniciarSesion">
                <legend class="fieldset-legend text-2xl text-center ">Iniciar Sesión</legend>

                <label class="label">Correo</label>
                <input type="text" class="input" placeholder="usuario" required id="user" v-model="usuario"/>

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
            usuario: '',
            sucursalSeleccionada: "Limon",
            contrasenia: ''
        }
    },
    methods: {
    
    async colocarSucursal(sucursal){
        console.log("Sucursal atributo: "+ this.sucursalSeleccionada)
        const store = usuarioStore();
        await store.setSucursal(sucursal);
    },

    async iniciarSesion(){ //Hay que hacer async todo esto porque no espera
                //Llamar al procedimiento que me retorna si puedo iniciar sesión
                fetch('http://localhost:3000/customers/login', {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ usuario: this.usuario, contrasenia: this.contrasenia, sucursal: this.sucursalSeleccionada}) 
                })
                .then(res => res.json())
                .then(async result =>{
                    console.log(result)
                    const entero = result.resultado
                    if(entero){
                        if(this.sucursalSeleccionada == "Limon" || this.sucursalSeleccionada == "SanJose"){
                            //Colocar el usuario en el pinia y seguir
                            await this.colocarSucursal(this.sucursalSeleccionada);
                            await this.$router.push('/clientes') //Pasar a la siguiente ventana
                        }
                        
                    }else{
                        alert("Usuario o contraseña incorrectos")
                        
                    }
                })
                .catch(error => {
                console.error("Error al intentar iniciar sesión", error);
                alert("Error al iniciar sesión")
                });


  }
}
}
</script>