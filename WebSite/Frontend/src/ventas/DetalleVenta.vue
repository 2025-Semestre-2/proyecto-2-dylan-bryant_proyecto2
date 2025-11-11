<template>
    <div class="flex justify-center mt-10 px-4">
        <div v-if="encabezado" class="w-full max-w-4xl p-12 bg-base-100 shadow-lg rounded-xl text-lg">
            <h2 class="text-4xl font-bold mb-8">Factura: {{ encabezado.ID }}</h2>

            <!--Este debe ser un link a la página del proveedor-->
            <p class="mb-4 cursor-pointer hover:text-blue-600" @click="mostrarCliente()"><strong>Cliente:</strong> {{ encabezado.Customer }}</p>
            
            <p class="mb-4"><strong>Método de Entrega:</strong> {{ encabezado.DeliveryMethod }}</p>
            <p class="mb-4"><strong>Número de Orden de Compra:</strong> {{ encabezado.PurcharseOrderNumber }}</p>
            <p class="mb-4"><strong>Persona de Contacto:</strong> {{ encabezado.ContactPerson }}</p>
            <p class="mb-4"><strong>Vendedor:</strong> {{ encabezado.SalesPerson }}</p>
            <p class="mb-4"><strong>Fecha:</strong> {{ encabezado.InvoiceDate }}</p>
            <p class="mb-4"><strong>Instrucciones para la Entrega:</strong> {{ encabezado.DeliveryInstructions }}</p>
        </div>
    </div>
    <div class="flex justify-center p-5">
        <h1 class="text-2xl">Detalle de la Factura</h1>
    </div>
    
    <div class="flex justify-center p-2">
        
    <div class="w-[50%] overflow-x-auto rounded-box border border-base-content/5 bg-base-100">
        
      <table class="table">
        <thead>
          <tr>
            <th>Producto</th>
            <th>Cantidad</th>
            <th>Precio Unitario</th>
            <th>Impuesto Aplicado</th>
            <th>Monto del Impuesto</th>
            <th>Total por Línea</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for=" linea in lineas" @click="mostrarProducto(linea.ProductName)">
            <td>{{ linea.ProductName }}</td>
            <td>{{ linea.Quantity }}</td>
            <td>{{ linea.UnitPrice }}</td>
            <td>{{ linea.TaxRate }}%</td>
            <td>{{ linea.Tax }}</td>
            <td>{{ linea.Total }}</td>
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
                encabezado: null,
                lineas: []
            }
        },
     

        methods:{
            async buscarEncabezado(id) {
            if (!id) return;

            try {
                const url = `http://localhost:3000/sales/getSpecificHeader?ID=${encodeURIComponent(id)}`;
                const res = await fetch(url);
                if (!res.ok) throw new Error('Error en la respuesta del servidor');
                const result = await res.json();
                this.encabezado = result.length ? result[0] : null;
                console.log(this.item)


            } catch (err) {
                console.error('Error al buscar el encabezado:', err);
            }
            },

            async buscarLineas(id) {
            if (!id) return;

            try {
                const url = `http://localhost:3000/sales/getInvoiceLines?ID=${encodeURIComponent(id)}`;
                const res = await fetch(url);
                if (!res.ok) throw new Error('Error en la respuesta del servidor');
                const result = await res.json();
                this.lineas = result
                console.log(this.lineas)


            } catch (err) {
                console.error('Error al buscar lineas:', err);
            }
            },

            mostrarProducto(nombre){
                localStorage.setItem('itemSeleccionado', nombre);
      
                //Abro la otra
                this.$router.push('/datosDelItem');
            },
            mostrarCliente(){
                localStorage.setItem('clienteSeleccionado', this.encabezado.Customer);

                //Abro la otra
                this.$router.push('/datosDelCliente');
            }

        },

        async mounted(){
            const id = localStorage.getItem('facturaSeleccionada') || '';
            await this.buscarEncabezado(id);
            this.buscarLineas(id);
        }
    }
</script>