<template>
    <div class="flex justify-center p-5">
        <h1 class="text-4xl">Top 5 Proveedores Mayor Cantidad Ordenes</h1>
    </div>

    <div class="flex flex-wrap gap-15 justify-center">

        <fieldset class="fieldset">
        <legend class="fieldset-legend">Año</legend>
        <select class="select" v-model="filtro" @change="cambioEnLosFiltros">
        <option selected value="2013">2013</option>
        <option value="2014">2014</option>
        <option value="2015">2015</option>
        <option value="2016">2016</option>
      </select>
        </fieldset>

         <fieldset class="fieldset">
        <legend class="fieldset-legend">Año Fin</legend>
        <select class="select" v-model="filtro2" @change="cambioEnLosFiltros">
        <option selected value="2013">2013</option>
        <option value="2014">2014</option>
        <option value="2015">2015</option>
        <option value="2016">2016</option>
      </select>
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
            <th>Año</th>
            <th>Proveedor</th>
            <th>Cantidad Total de Ordenes</th>
            <th>Monto Total Ordenado</th>
            <th>Ranking</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="i in lista">
            <td>{{ i.Year}}</td>
            <td>{{ i.Supplier }}</td>
            <td>{{ i.TotalOrdenes }}</td>
            <td>{{ i.TotalEnOrdenes }}</td>
            <td>{{ i.Ranking }}</td>
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
                filtro: 2013,
                filtro2: 2016,
                lista: [],
                sucursalSeleccionada: 'Limon',
                link: ''
            }
            
        },
        methods:{
            buscar(){
            const url = `${this.link}/stats/quintaEstadistica?anio=${encodeURIComponent(this.filtro)}&anioFin=${encodeURIComponent(this.filtro2)}&sucursal=${encodeURIComponent(this.sucursalSeleccionada)}`;

            fetch(url)
                .then(res => {
                if (!res.ok) throw new Error('Error en la respuesta del servidor');
                return res.json();
                })
                .then(result => {
                this.lista = result; 
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