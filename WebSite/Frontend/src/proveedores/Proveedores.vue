<template>
  <div class="flex justify-center p-5">
        <h1 class="text-4xl">Proveedores</h1>
    </div>
  <div class="flex flex-wrap gap-15 justify-center">
    <!--Entrada para el nombre-->
    <fieldset class="fieldset">
      <legend class="fieldset-legend">Nombre del Cliente</legend>
      <input type="text" class="input" placeholder="Puede escribir una parte del nombre" v-model="filtroNombre" @input="cambioEnLosFiltros"/>
      <p class="label"></p>
    </fieldset>

    <!--Selector de la categoría-->
    <fieldset class="fieldset">
      <legend class="fieldset-legend">Categoría</legend>
      <select class="select" v-model="filtroCategoria" @change="cambioEnLosFiltros">
        <option  selected value="">Sin especificar</option>
        <option v-for="categoria in listaCategorias" :key="categoria.SupplierCategoryName" :value="categoria.SupplierCategoryName">
          {{ categoria.SupplierCategoryName }}
        </option>
      </select>
      <span class="label"></span>
    </fieldset>

    <!--Selector del método de entrega-->
    <fieldset class="fieldset">
      <legend class="fieldset-legend">Método de Entrega</legend>
      <select class="select" v-model="filtroMetodoEntrega" @change="cambioEnLosFiltros">
        <option  selected value="">Sin especificar</option>
        <option v-for="metodo in listaMetodosDeEntrega" :key="metodo.DeliveryMethodName" :value="metodo.DeliveryMethodName">
          {{ metodo.DeliveryMethodName }}
        </option>
      </select>
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
            <th>Categoría</th>
            <th>Método de Entrega</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(proveedor, index) in proveedoresPagina" :key="index" @click="seleccionarProveedor(proveedor.SupplierName)">
            <td>{{ proveedor.SupplierName }}</td>
            <td>{{ proveedor.SupplierCategory }}</td>
            <td>{{ proveedor.DeliveryMethod }}</td>
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
  export default {
    data(){
      return{
        listaTodosLosProveedores: [],
        listaCategorias: [],
        listaMetodosDeEntrega: [],
        filtroNombre: '',
        filtroCategoria: '',
        filtroMetodoEntrega: '',
        proveedoresPorPagina: 10,
        paginaActual: 1
      }
    },
    computed: {
    proveedoresPagina() {
      const inicio = (this.paginaActual - 1) * this.proveedoresPorPagina
      const fin = inicio + this.proveedoresPorPagina
      return this.listaTodosLosProveedores.slice(inicio, fin)
    },
    totalPaginas() {
      return Math.ceil(this.listaTodosLosProveedores.length / this.proveedoresPorPagina)
    }
    },

    methods: {
      obtenerTodosLosProveedores(){
        fetch('http://localhost:3000/suppliers/getAllSuppliers')
        .then(res => res.json())
        .then(result => {
          this.listaTodosLosProveedores = result
        })
      },

      obtenerLasCategorias(){
      fetch('http://localhost:3000/suppliers/getAllCategories')
        .then(res => res.json())
        .then(result => {
          this.listaCategorias = result
        })
    },

    obtenerTodosLosTiposDeEntrega(){
      fetch('http://localhost:3000/customers/getAllDeliveryMethods')
        .then(res => res.json())
        .then(result => {
          this.listaMetodosDeEntrega = result
        })
    },

    buscarProveedores(){
      const url = `http://localhost:3000/suppliers/searchSuppliers?name=${encodeURIComponent(this.filtroNombre)}&category=${encodeURIComponent(this.filtroCategoria)}&deliveryMethod=${encodeURIComponent(this.filtroMetodoEntrega)}`;

      fetch(url)
        .then(res => {
          if (!res.ok) throw new Error('Error en la respuesta del servidor');
          return res.json();
        })
        .then(result => {
          this.listaTodosLosProveedores = result; 
        })
        .catch(err => {
          console.error('Error al buscar proveedores:', err);
        });
    },

    seleccionarProveedor(nombre){
      console.log("Proveedor seleccionado: ", nombre);
      localStorage.setItem('proveedorSeleccionado', nombre);
      
      //Abro la otra
      this.$router.push('/datosDelProveedor');
    },
    cambioEnLosFiltros(){
      this.buscarProveedores();
      
    },

    restaurarFiltros(){
      //Devolver todo a vacío y mostrar todos los proveedores
      this.filtroNombre = '';
      this.filtroCategoria = '';
      this.filtroMetodoEntrega = '';
      this.obtenerTodosLosProveedores();
    }
    },

    mounted(){
      this.obtenerTodosLosProveedores();
      this.obtenerLasCategorias();
      this.obtenerTodosLosTiposDeEntrega();
    }
  }
</script>