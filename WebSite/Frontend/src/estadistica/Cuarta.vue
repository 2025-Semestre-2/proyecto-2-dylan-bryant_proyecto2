<template>
    <div class="flex justify-center p-5">
        <h1 class="text-4xl">Top 5 Clientes Mayor Cantidad Facturas</h1>
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

    </div>


    <div class="flex justify-center p-2">
    <div class="w-[70%] overflow-x-auto rounded-box border border-base-content/5 bg-base-100">
      <table class="table">
        <thead>
          <tr>
            <th>Año</th>
            <th>Cliente</th>
            <th>Cantidad Total de Facturas</th>
            <th>Monto Total Facturado</th>
            <th>Ranking</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="i in lista">
            <td>{{ i.Year}}</td>
            <td>{{ i.Customer }}</td>
            <td>{{ i.TotalInvoices }}</td>
            <td>{{ i.Total }}</td>
            <td>{{ i.Ranking }}</td>
          </tr>
        </tbody>
      </table>

      
    </div>
  </div>
    
</template>

<script>
    export default{
        data(){
            return{
                filtro: 2013,
                lista: []
            }
            
        },
        methods:{
            buscar(){
            const url = `http://localhost:3000/stats/cuartaEstadistica?anio=${encodeURIComponent(this.filtro)}`;

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
            this.buscar();

        }
    }
</script>