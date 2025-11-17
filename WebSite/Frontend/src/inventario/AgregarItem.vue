<template>
    <div class="flex justify-center p-5">
        <h1 class="text-4xl">Agregar Producto</h1>
    </div>
    <div class="flex justify-center items-center">
        <fieldset class="fieldset bg-base-200 border-base-300 rounded-box w-xs border p-4 shadow-lg">
            <form id="loginForm" @submit.prevent="redirigir">

                <legend class="fieldset-legend">Nombre</legend> <!---->
                <input type="text" class="input" placeholder="..." required id="nombreProducto" v-model="nombreProducto"/>
                <span class="label"></span>

                <!--Selector del grupo-->
                <fieldset class="fieldset">  <!---->
                <legend class="fieldset-legend">Proveedor</legend>
                <select class="select" v-model="proveedor">
                    <option value="Limon" selected>Limón</option>
                </select>
                <span class="label"></span>
                </fieldset>

                <fieldset class="fieldset">  <!---->
                <legend class="fieldset-legend">Color</legend>
                <select class="select" v-model="color">
                    <option value="Limon" selected>Limón</option>
                </select>
                <span class="label"></span>
                </fieldset>

                <fieldset class="fieldset">  <!---->
                <legend class="fieldset-legend">Unit Package</legend>
        
                <select class="select" v-model="unitPackageID">
                    <option value="Limon" selected>Limón</option>
                </select>
                <span class="label"></span>
                </fieldset>

                <fieldset class="fieldset"> <!---->
                <legend class="fieldset-legend">Outer Package</legend>
                <select class="select" v-model="outerPackage">
                    <option value="Limon" selected>Limón</option>
                </select>
                <span class="label"></span>
                </fieldset>

                <fieldset class="fieldset"> <!---->
                <legend class="fieldset-legend">¿Es Refrigerado?</legend>
                <label>
                    <input type="checkbox" v-model="siEsRefrigerado">
                    Sí
                </label>
                <label>
                    <input type="checkbox" v-model="noEsRefrigerado">
                    No
                </label>
                <span class="label"></span>
                </fieldset>

                <legend class="fieldset-legend">Marca</legend> <!---->
                <input type="text" class="input" placeholder="..." required id="marca" v-model="marca"/>

                <legend class="fieldset-legend">Talla/Tamaño</legend> <!---->
                <input type="text" class="input" placeholder="..." required id="talla_tamanio" v-model="talla_tamanio"/>

                 <legend class="fieldset-legend">Lead Time Days</legend>
                <input type="number" class="input" placeholder="..." required id="leadTimeDays" v-model="leadTimeDays"/>

                <legend class="fieldset-legend">Quantity Per Outer</legend> <!---->
                <input type="number" class="input" placeholder="..." required id="quantityPerOuter" v-model="quantityPerOuter"/>

                <legend class="fieldset-legend">Codigo de Barras</legend> 
                <input type="text" class="input" placeholder="..." required id="codigoDeBarras" v-model="codigoDeBarras"/>

                <legend class="fieldset-legend">Impuesto</legend>  <!---->
                <input type="number" class="input" placeholder="..." required id="codigoDeBarras" v-model="impuesto"/>

                <legend class="fieldset-legend">Precio Unitario</legend>  <!---->
                <input type="number" class="input" placeholder="..." required id="precio" v-model="precio"/>

                <legend class="fieldset-legend">Precio Recomendado de Retail</legend>  <!---->
                <input type="number" class="input" placeholder="..." required id="precio" v-model="precioRetail"/>

                <legend class="fieldset-legend">Peso Por Unidad</legend> <!---->
                <input type="number" class="input" placeholder="..." required id="precio" v-model="precioRetail"/>

                <legend class="fieldset-legend">Detalles De Búsqueda</legend> 
                <input type="text" class="input" placeholder="..." required id="precio" v-model="detallesDeBusqueda"/>


                <div class="botonesEncabezado flex justify-center gap-5 p-5">
                    <button class="btn bg-[#03366A] text-white hover:bg-[#022f5c]" type="submit">Agregar Producto</button>
                </div>
                
            </form>
        </fieldset>
    </div>

</template>
<script>
    import { usuarioStore } from '../stores/usuario.js'
    export default{
        data(){
            return{
                
            }
        },
     

        methods:{
           

        },

        async mounted(){
            const store = usuarioStore();
            console.log("Sucursal: " + store.sucursal)
            this.sucursal = store.sucursal;
          
        }
    }
</script>