<template>
    <div class="flex justify-center p-5">
        <h1 class="text-4xl">Montos de Proveedores</h1>
    </div>

    <div class="flex flex-wrap gap-15 justify-center">

        <fieldset class="fieldset">
        <legend class="fieldset-legend">Proveedor/Categoría</legend>
        <input type="text" class="input" placeholder="Puede escribir una parte del nombre" v-model="filtro" @input="cambioEnLosFiltros"/>
        <p class="label">Puede ingresar texto que pertenezca al provedor o la categoría</p>
        </fieldset>

        <fieldset class="fieldset">
        <legend class="fieldset-legend">Sucursal</legend>
        <select class="select" v-model="sucursalSeleccionada" @change="cambioEnLosFiltros">
                    <option value="Limon" selected>Limón</option>
                    <option value="SanJose">San José</option>
                    <option value="Corporativo">Consolidado</option>
        </select>
        <p class="label">Puede consultar una única sucursal o un consolidado entre todas.</p>
        </fieldset>

    </div>


    <div class="flex justify-center p-2">
    <div class="w-[70%] overflow-x-auto rounded-box border border-base-content/5 bg-base-100">
      <table class="table">
        <thead>
          <tr>
            <th>Proveedor</th>
            <th>Categoria</th>
            <th>Monto Máximo</th>
            <th>Monto Mínimo</th>
            <th>Monto Medio</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="i in lista">
            <td>{{ i.Supplier }}</td>
            <td>{{ i.Category }}</td>
            <td>{{ i.MaxAmount }}</td>
            <td>{{ i.MinAmount }}</td>
            <td>{{ i.AvgAmount }}</td>
          </tr>
        </tbody>
      </table>

      
    </div>
  </div>
    
</template>

<script>
  import { usuarioStore } from '../stores/usuario.js'
    export default{
        data(){
            return{
                filtro: '',
                lista: [],
                sucursalSeleccionada: 'Limon',
                link: ''
            }
            
        },
        methods:{
            buscar(){
            const url = `${this.link}/stats/primeraEstadistica?proveedor=${encodeURIComponent(this.filtro)}&sucursal=${encodeURIComponent(this.sucursalSeleccionada)}`;
              console.log("Url: " + url)
            fetch(url)
                .then(res => {
                if (!res.ok) throw new Error('Error en la respuesta del servidor');
                return res.json();
                })
                .then(result => {
                this.lista = result; 
                console.log("Resultado: " + result)
                })
                .catch(err => {
                console.error('Error al buscar:', err);
                });
            },

            cambioEnLosFiltros(){
                this.buscar();
            }
        },
        mounted(){
            const store = usuarioStore();
            this.link = store.link;
            this.buscar();

        }
    }
</script>