<template>
  <div class="flex justify-center p-5">
        <h1 class="text-4xl">Ventas</h1>
    </div>

    <div class="flex flex-wrap gap-15 justify-center">
    <!--Entrada para el nombre-->
    <fieldset class="fieldset">
      <legend class="fieldset-legend">Nombre Cliente</legend>
      <input type="text" class="input" placeholder="Puede escribir una parte del nombre" v-model="filtroNombreCliente" @input="cambioEnLosFiltros"/>
      <p class="label"></p>
    </fieldset>

    <!--Selector del método de entrega-->
    <fieldset class="fieldset">
      <legend class="fieldset-legend">Método de Entrega</legend>
      <select class="select" v-model="filtroMetodoEntrega" @change="cambioEnLosFiltros">
        <option  selected value="">Sin especificar</option>
        <option v-for="metodo in listaMetodosDeEntrega" :key="metodo.StockGroupName" :value="metodo.DeliveryMethodName">
          {{ metodo.DeliveryMethodName }}
        </option>
      </select>
      <span class="label"></span>
    </fieldset>

    <!--Minimo-->
    <fieldset class="fieldset">
      <legend class="fieldset-legend">Monto Mínimo</legend>
      <input
          type="number"
          class="input input-bordered w-full"
          v-model.number="filtroMontoMinimo"
          :min="montoMinimoOriginal"
          :max="montoMaximoOriginal"
          placeholder="Mínimo"
          @change="cambioEnLosFiltros"
        />
      <span class="label"></span>
    </fieldset>

    <!--Máximo-->
    <fieldset class="fieldset">
      <legend class="fieldset-legend">Monto Máximo</legend>
      <input
          type="number"
          class="input input-bordered w-full"
          v-model.number="filtroMontoMaximo"
          :min="montoMinimoOriginal"
          :max="montoMaximoOriginal"
          placeholder="Mínimo"
          @change="cambioEnLosFiltros"
        />
      <span class="label"></span>
    </fieldset>

    <!--Fecha mínima-->
    <fieldset class="fieldset">
      <legend class="fieldset-legend">Fecha Mínima</legend>
      <input type="date" class="input" v-model="filtroFechaMinima" :min="fechaMinimaOriginal" :max="fechaMaximaOriginal" @change="cambioEnLosFiltros"/>
      <span class="label"></span>
    </fieldset>

    <!--Fecha máxima-->
    <fieldset class="fieldset">
      <legend class="fieldset-legend">Fecha Máxima</legend>
      <input type="date" class="input" v-model="filtroFechaMaxima" :min="fechaMinimaOriginal" :max="fechaMaximaOriginal" @change="cambioEnLosFiltros"/>
      <span class="label"></span>
    </fieldset>

    <!--Botón para restaurar-->
    <fieldset class="fieldset pb-7">
      <legend class="fieldset-legend invisible">Botón</legend>
      <button class="btn btn-error w-full" @click="restaurarFiltros">Restaurar Filtros</button>
    </fieldset>
    
  </div>

    <!--Tabla-->
    <div class="flex justify-center p-2">
    <div class="w-[70%] overflow-x-auto rounded-box border border-base-content/5 bg-base-100">
      <table class="table">
        <thead>
          <tr>
            <th>Número de Factura</th>
            <th>Fecha</th>
            <th>Cliente</th>
            <th>Método de Entrega</th>
            <th>Monto</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(factura, index) in facturasPagina" :key="index" @click="seleccionarItem(factura.ID)">
            <td>{{ factura.ID }}</td>
            <td>{{ factura.Date }}</td>
            <td>{{ factura.Customer }}</td>
            <td>{{ factura.DeliveryMethod }}</td>
            <td>{{ factura.Total }}</td>
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
                listaTodasLasFacturas: [],
                listaMetodosDeEntrega: [],
                filtroNombreCliente: '',
                filtroMetodoEntrega: '',
                filtroFechaMaxima: '',
                filtroFechaMinima: '',
                filtroMontoMaximo: 0,
                filtroMontoMinimo: 0,
                fechaMaximaOriginal: '',
                fechaMinimaOriginal: '',
                montoMinimoOriginal: 0,
                montoMaximoOriginal: 0,
                facturasPorPagina: 10,
                paginaActual: 1
            }
        },
        computed:{
            facturasPagina() {
            const inicio = (this.paginaActual - 1) * this.facturasPorPagina
            const fin = inicio + this.facturasPorPagina
            return this.listaTodasLasFacturas.slice(inicio, fin)
            },
            totalPaginas() {
            return Math.ceil(this.listaTodasLasFacturas.length / this.facturasPorPagina)
            }
        },

        methods:{
            obtenerTodasLasFacturas() {
            fetch('http://localhost:3000/sales/getAllInvoices')
                .then(res => res.json())
                .then(result => {
                this.listaTodasLasFacturas = result
                })
            },

            obtenerTodosLosTiposDeEntrega(){
            fetch('http://localhost:3000/customers/getAllDeliveryMethods')
                .then(res => res.json())
                .then(result => {
                this.listaMetodosDeEntrega = result
                })
            },

            buscarFacturas(){
            const url = `http://localhost:3000/sales/searchInvoices?customer=${encodeURIComponent(this.filtroNombreCliente)}&deliveryMethod=${encodeURIComponent(this.filtroMetodoEntrega)}&minDate=${encodeURIComponent(this.filtroFechaMinima)}
            &maxDate=${encodeURIComponent(this.filtroFechaMaxima)}&minAmount=${encodeURIComponent(this.filtroMontoMinimo)}&maxAmount=${encodeURIComponent(this.filtroMontoMaximo)}`;

            fetch(url)
                .then(res => {
                if (!res.ok) throw new Error('Error en la respuesta del servidor');
                return res.json();
                })
                .then(result => {
                this.listaTodasLasFacturas = result; 
                })
                .catch(err => {
                console.error('Error al buscar facturas:', err);
                });
            },

            obtenerFechaMaximaYminima(){
            fetch('http://localhost:3000/sales/getMinAndMaxDate')
                .then(res => res.json())
                .then(result => {
                    const resultadoFecha = result[0]
                    console.log("Resultado fecha: ", resultadoFecha)
                    this.fechaMinimaOriginal = resultadoFecha.Min;
                    this.fechaMaximaOriginal = resultadoFecha.Max;
                    
            })
            },

            obtenerFechaMaximaYminima(){
            fetch('http://localhost:3000/sales/getMinAndMaxDate')
                .then(res => res.json())
                .then(result => {
                    const resultadoFecha = result[0]
                    console.log("Resultado fecha: ", resultadoFecha)
                    this.fechaMinimaOriginal = resultadoFecha.Min.split("T")[0];
                    this.fechaMaximaOriginal = resultadoFecha.Max.split("T")[0];
                    this.filtroFechaMinima = this.fechaMinimaOriginal;
                    this.filtroFechaMaxima = this.fechaMaximaOriginal;
                    
            })
            },

            obtenerMontoMaximoYminomo(){
            fetch('http://localhost:3000/sales/getMinAndMaxAmount')
                .then(res => res.json())
                .then(result => {
                    const resultadoMonto = result[0]
                    console.log("Resultado monto: ", resultadoMonto)
                    this.montoMinimoOriginal = resultadoMonto.Min;
                    this.montoMaximoOriginal = resultadoMonto.Max;
                    this.filtroMontoMaximo = this.montoMaximoOriginal;
                    this.filtroMontoMinimo = this.montoMinimoOriginal;
                    
            })
            },

           
         cambioEnLosFiltros(){
            //Tengo que fijarme que no ponga el mínimo mayor que el maximo y viceversa
            const min = parseInt(this.filtroMontoMinimo);
            const max = parseInt(this.filtroMontoMaximo);

            // Validar que ambos sean números válidos
            if (!isNaN(min) && !isNaN(max)) {
                if (min > max) {
                    alert("El valor mínimo no puede ser mayor que el máximo.");
                    return; 
                }else{
                    this.buscarFacturas();
                }
            }
            },

             restaurarFiltros(){
            //Devolver todo a vacío y mostrar todos los clientes
            this.filtroNombreCliente = '';
            this.filtroMetodoEntrega = '';
            this.filtroMontoMaximo = this.montoMaximoOriginal;
            this.filtroMontoMinimo = this.montoMinimoOriginal;
            this.filtroFechaMinima = this.fechaMinimaOriginal;
            this.filtroFechaMaxima = this.fechaMaximaOriginal;
            this.obtenerTodasLasFacturas();
            },

            seleccionarItem(id){
                localStorage.setItem('facturaSeleccionada', id);
  
                //Abro la otra
                this.$router.push('/detalleDeLaFactura');
            }

    },
        mounted(){
            this.obtenerTodasLasFacturas();
            this.obtenerTodosLosTiposDeEntrega();
            this.obtenerFechaMaximaYminima();
            this.obtenerMontoMaximoYminomo();
        }
}
</script>