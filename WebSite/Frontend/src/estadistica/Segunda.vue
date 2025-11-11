<template>
    <div class="flex justify-center p-5">
        <h1 class="text-4xl">Montos de Clientes</h1>
    </div>

    <div class="flex flex-wrap gap-15 justify-center">

        <fieldset class="fieldset">
        <legend class="fieldset-legend">Cliente/Categoría</legend>
        <input type="text" class="input" placeholder="Puede escribir una parte del nombre" v-model="filtro" @input="cambioEnLosFiltros"/>
        <p class="label">Puede ingresar texto que pertenezca al cliente o la categoría</p>
        </fieldset>

    </div>


    <div class="flex justify-center p-2">
    <div class="w-[70%] overflow-x-auto rounded-box border border-base-content/5 bg-base-100">
      <table class="table">
        <thead>
          <tr>
            <th>Cliente</th>
            <th>Categoria</th>
            <th>Monto Máximo</th>
            <th>Monto Mínimo</th>
            <th>Monto Medio</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="i in lista">
            <td>{{ i.Customer }}</td>
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
    export default{
        data(){
            return{
                filtro: '',
                lista: []
            }
            
        },
        methods:{
            buscar(){
            const url = `http://localhost:3000/stats/segundaEstadistica?cliente=${encodeURIComponent(this.filtro)}`;

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