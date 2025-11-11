<template>
    <div class="flex justify-center p-5">
        <h1 class="text-4xl">Inventarios</h1>
    </div>

    <div class="flex flex-wrap gap-15 justify-center">
    <!--Entrada para el nombre-->
    <fieldset class="fieldset">
      <legend class="fieldset-legend">Nombre del Item</legend>
      <input type="text" class="input" placeholder="Puede escribir una parte del nombre" v-model="filtroNombre" @input="cambioEnLosFiltros"/>
      <p class="label"></p>
    </fieldset>

    <!--Selector del grupo-->
    <fieldset class="fieldset">
      <legend class="fieldset-legend">Grupo</legend>
      <select class="select" v-model="filtroGrupo" @change="cambioEnLosFiltros">
        <option  selected value="">Sin especificar</option>
        <option v-for="grupo in listaGrupos" :key="grupo.StockGroupName" :value="grupo.StockGroupName">
          {{ grupo.StockGroupName }}
        </option>
      </select>
      <span class="label"></span>
    </fieldset>

    <!--Minimo-->
    <fieldset class="fieldset">
      <legend class="fieldset-legend">Mínimo</legend>
      <input
          type="number"
          class="input input-bordered w-full"
          v-model.number="filtroMinimo"
          :min="minimoOriginal"
          :max="maximoOriginal"
          placeholder="Mínimo"
          @change="cambioEnLosFiltros"
        />
      <span class="label"></span>
    </fieldset>

    <!--Máximo-->
    <fieldset class="fieldset">
      <legend class="fieldset-legend">Máximo</legend>
      <input
          type="number"
          class="input input-bordered w-full"
          v-model.number="filtroMaximo"
          :min="minimoOriginal"
          :max="maximoOriginal"
          placeholder="Mínimo"
          @change="cambioEnLosFiltros"
        />
      <span class="label"></span>
    </fieldset>

    <!--Botón para restaurar-->
    <fieldset class="fieldset pb-7">
      <legend class="fieldset-legend invisible">Botón</legend>
      <button class="btn btn-error w-full" @click="restaurarFiltros">Restaurar Filtros</button>
    </fieldset>
    
  </div>
    
    <div class="flex justify-center p-2">
    <div class="w-[70%] overflow-x-auto rounded-box border border-base-content/5 bg-base-100">
      <table class="table">
        <thead>
          <tr>
            <th>Nombre</th>
            <th>Grupo</th>
            <th>Cantidad</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in itemsPagina" :key="index" @click="seleccionarItem(item.StockItemName)">
            <td>{{ item.StockItemName }}</td>
            <td>{{ item.StockGroup }}</td>
            <td>{{ item.Quantity }}</td>
          </tr>
        </tbody>
      </table>

      <!-- Paginación -->
      <div class="flex justify-center mt-4 space-x-1 flex-wrap">
        <button 
          class="btn btn-sm btn-ghost" 
          @click="paginaActual--" 
          :disabled="paginaActual === 1"
        >
          « Anterior
        </button>

        <template v-for="n in totalPaginas">
          <button
            v-if="n === 1 || n === totalPaginas || Math.abs(n - paginaActual) <= 2"
            :key="n"
            class="btn btn-sm btn-ghost"
            :class="{ 'btn-active': n === paginaActual }"
            @click="paginaActual = n"
          >
            {{ n }}
          </button>
          <span v-else-if="(n === paginaActual - 3 || n === paginaActual + 3)">…</span>
        </template>

        <button 
          class="btn btn-sm btn-ghost" 
          @click="paginaActual++" 
          :disabled="paginaActual === totalPaginas"
        >
          Siguiente »
        </button>
      </div>
    </div>
  </div>
</template>

<script>
    export default{
        data(){
            return{
                listaTodosLosItems: [],
                listaGrupos: [],
                filtroNombre: '',
                filtroGrupo: '',
                filtroMaximo: 0,
                filtroMinimo: 0,
                maximoOriginal: 0,
                minimoOriginal: 0,
                itemsPorPagina: 10,
                paginaActual: 1,
                minimoYmaximo: null
            }
        },
        computed:{  
            itemsPagina() {
            const inicio = (this.paginaActual - 1) * this.itemsPorPagina
            const fin = inicio + this.itemsPorPagina
            return this.listaTodosLosItems.slice(inicio, fin)
            },
            totalPaginas() {
            return Math.ceil(this.listaTodosLosItems.length / this.itemsPorPagina)
            }
        },

        methods:{
            obtenerTodosLosItems() {
            fetch('http://localhost:3000/items/getAllItems')
                .then(res => res.json())
                .then(result => {
                this.listaTodosLosItems = result
                })
            },

            obtenerLosGrupos(){
            fetch('http://localhost:3000/items/getStockGroupItem')
                .then(res => res.json())
                .then(result => {
                    this.listaGrupos = result
                })
            },

            obtenerElMaximoYMinimo(){
            fetch('http://localhost:3000/items/getMaxAndMinStockItemHoldings')
                .then(res => res.json())
                .then(result => {
                    this.minimoYmaximo = result[0]
                    console.log("Resultado minimYmaximo: ", this.minimoYmaximo)
                    this.minimoOriginal = this.minimoYmaximo.MinStock !== '' ? parseInt(this.minimoYmaximo.MinStock, 10) : null;
                    this.maximoOriginal = this.minimoYmaximo.MaxStock !== '' ? parseInt(this.minimoYmaximo.MaxStock, 10) : null;
                    this.filtroMinimo = this.minimoOriginal;
                    this.filtroMaximo = this.maximoOriginal;
                    
                })
            },

            buscarItems(){
            const url = `http://localhost:3000/items/searchItems?name=${encodeURIComponent(this.filtroNombre)}&group=${encodeURIComponent(this.filtroGrupo)}&maxQuantity=${encodeURIComponent(this.filtroMaximo)}&minQuantity=${encodeURIComponent(this.filtroMinimo)}`;

            fetch(url)
                .then(res => {
                if (!res.ok) throw new Error('Error en la respuesta del servidor');
                return res.json();
                })
                .then(result => {
                this.listaTodosLosItems = result; 
                })
                .catch(err => {
                console.error('Error al buscar clientes:', err);
                });
            },

            cambioEnLosFiltros(){
            //Tengo que fijarme que no ponga el mínimo mayor que el maximo y viceversa
            const min = parseInt(this.filtroMinimo);
            const max = parseInt(this.filtroMaximo);

            // Validar que ambos sean números válidos
            if (!isNaN(min) && !isNaN(max)) {
                if (min > max) {
                    alert("El valor mínimo no puede ser mayor que el máximo.");
                    return; 
                }else{
                    this.buscarItems();
                }
            }
                
            },

            restaurarFiltros(){
            //Devolver todo a vacío y mostrar todos los clientes
            this.filtroNombre = '';
            this.filtroGrupo = '';
            this.filtroMinimo = this.minimoOriginal;
            this.filtroMaximo = this.maximoOriginal;
            this.obtenerTodosLosItems();
            },

            seleccionarItem(nombre){
                localStorage.setItem('itemSeleccionado', nombre);
                //Abro la otra
                this.$router.push('/datosDelItem');
            }
        },

        mounted(){
            this.obtenerTodosLosItems();
            this.obtenerLosGrupos();
            this.obtenerElMaximoYMinimo();
        }
    }
</script>