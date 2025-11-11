<template>
    
  <div class="flex justify-center mt-10 px-4">
    <div v-if="!proveedor" class="text-center text-gray-500 text-lg">
      No se encontró información del proveedor.
    </div>

    <!--Datos del cliente-->
    <div v-else class="w-full max-w-4xl p-12 bg-base-100 shadow-lg rounded-xl text-lg">
      <h2 class="text-4xl font-bold mb-8">{{ proveedor.SupplierName }}</h2>

      <p class="mb-4"><strong>Referencia:</strong> {{ proveedor.SupplierReference }}</p>
      <p class="mb-4"><strong>Categoría:</strong> {{ proveedor.SupplierCategory }}</p>
      <p class="mb-4"><strong>Contacto Principal:</strong> {{ proveedor.PrimaryContactPerson }}</p>
      <p class="mb-4"><strong>Contacto Alternativo:</strong> {{ proveedor.AlternateContactPerson }}</p>
      <p class="mb-4"><strong>Método de Entrega:</strong> {{ proveedor.DeliveryMethod }}</p>
      <p class="mb-4"><strong>Ciudad De Entrega:</strong> {{ proveedor.DeliveryCity }}</p>
      <p class="mb-4"><strong>Código Postal:</strong> {{ proveedor.PostalCode }}</p>
      <p class="mb-4"><strong>Teléfono:</strong> {{ proveedor.PhoneNumber }}</p>
      <p class="mb-4"><strong>Fax:</strong> {{ proveedor.Fax }}</p>
      <p class="mb-4"><strong>Dirección Completa:</strong> {{ proveedor.FullAddress }}</p>
      <p class="mb-4">
        <strong>Sitio web:</strong>
        <a :href="proveedor.WebSite" target="_blank" class="link link-primary text-lg">
          {{ proveedor.WebSite }}
        </a>
      </p>

      <!-- Mapa dentro del v-else -->
      <div v-if="proveedor?.DeliveryLocation?.points?.length" class="mt-6 h-96 w-full rounded-lg">
        <div id="map" class="h-full w-full rounded-lg"></div>
      </div>
    </div>
  </div>
</template>


<script>
import { nextTick } from 'vue';
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';

export default {
  data() {
    return {
      proveedor: null,
      map: null
    }
  },

  methods: {
    async buscarProveedorEspecifico(nombre) {
      if (!nombre) return;

      try {
        const url = `http://localhost:3000/suppliers/getSpecificSupplier?name=${encodeURIComponent(nombre)}`;
        const res = await fetch(url);
        if (!res.ok) throw new Error('Error en la respuesta del servidor');
        const result = await res.json();
        this.proveedor = result.length ? result[0] : null;

        await nextTick();
        this.mostrarMapa();

      } catch (err) {
        console.error('Error al buscar proveedor:', err);
      }
    },

   mostrarMapa() {
    if (!this.proveedor?.DeliveryLocation?.points?.length) return;

    const { lat, lng } = this.proveedor.DeliveryLocation.points[0];

    
    if (this.map) this.map.remove();

    
    this.map = L.map('map').setView([lat, lng], 13);

    
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; OpenStreetMap contributors'
    }).addTo(this.map);

    // El marcador
    L.marker([lat, lng]).addTo(this.map)
        .bindPopup(`Ubicación de ${this.proveedor.SupplierName}`)
        .openPopup();
    }
  },

  mounted() {
    const nombreDelProveedor = localStorage.getItem('proveedorSeleccionado') || '';
    this.buscarProveedorEspecifico(nombreDelProveedor);
  }
}
</script>


