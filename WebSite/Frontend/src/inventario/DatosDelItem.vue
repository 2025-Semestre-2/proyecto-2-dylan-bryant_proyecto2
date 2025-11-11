<template>
    <div class="flex justify-center mt-10 px-4">
        <div v-if="item" class="w-full max-w-4xl p-12 bg-base-100 shadow-lg rounded-xl text-lg">
            <h2 class="text-4xl font-bold mb-8">{{ item.StockItemName }}</h2>

            <!--Este debe ser un link a la página del proveedor-->
            <p class="mb-4 cursor-pointer hover:text-blue-600" @click="mostrarProveedor()"><strong>Proveedor:</strong> {{ item.Supplier }}</p>
            
            <p class="mb-4"><strong>Color:</strong> {{ item.Color }}</p>
            <p class="mb-4"><strong>Unit Package:</strong> {{ item.UnitPackage }}</p>
            <p class="mb-4"><strong>OuterPackage:</strong> {{ item.OuterPackage }}</p>
            <p class="mb-4"><strong>Precio Recomendado:</strong> {{ item.RecommendedRetailPrice }}</p>
            <p class="mb-4"><strong>Peso:</strong> {{ item.Weight }}</p>
            <p class="mb-4"><strong>Unidades por Paquete:</strong> {{ item.QuantityPerOuter }}</p>
            <p class="mb-4"><strong>Marca:</strong> {{ item.Brand }}</p>
            <p class="mb-4"><strong>Tamaño/Talla:</strong> {{ item.Size }}</p>
            <p class="mb-4"><strong>Impuesto:</strong> {{ item.Tax }}</p>
            <p class="mb-4"><strong>Precio Unitario:</strong> {{ item.UnitPrice }}</p>
            <p class="mb-4"><strong>Impuesto:</strong> {{ item.Tax }}</p>
            <p class="mb-4"><strong>Cantidad:</strong> {{ item.Quantity }}</p>
            <p class="mb-4"><strong>Ubicación:</strong> {{ item.Location }}</p>
        </div>
    </div>
</template>
<script>
    export default{
        data(){
            return{
                item: null
            }
        },

        methods:{
            async buscarItem(nombre) {
            if (!nombre) return;

            try {
                const url = `http://localhost:3000/items/getSpecificItem?name=${encodeURIComponent(nombre)}`;
                const res = await fetch(url);
                if (!res.ok) throw new Error('Error en la respuesta del servidor');
                const result = await res.json();
                this.item = result.length ? result[0] : null;
                console.log(this.item)


            } catch (err) {
                console.error('Error al buscar item:', err);
            }
            },

            mostrarProveedor(){
                localStorage.setItem('proveedorSeleccionado', this.item.Supplier);
      
                //Abro la otra
                this.$router.push('/datosDelProveedor');
            }


        },
        mounted(){
            const item = localStorage.getItem('itemSeleccionado') || '';
            console.log("Item: ", item)
            this.buscarItem(item);
        }
    }
</script>