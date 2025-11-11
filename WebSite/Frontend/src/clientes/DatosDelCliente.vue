<template>
  <div class="flex justify-center mt-10 px-4">
    <div v-if="!cliente" class="text-center text-gray-500 text-lg">
      No se encontró información del cliente.
    </div>

    <!--Datos del cliente-->
    <div v-else class="w-full max-w-4xl p-12 bg-base-100 shadow-lg rounded-xl text-lg">
      <h2 class="text-4xl font-bold mb-8">{{ cliente.Name }}</h2>

      <p class="mb-4"><strong>Categoría:</strong> {{ cliente.Category }}</p>
      <p class="mb-4"><strong>Método de entrega:</strong> {{ cliente.DeliveryMethod }}</p>
      <p class="mb-4"><strong>Teléfono:</strong> {{ cliente.Phone }}</p>
      <p class="mb-4"><strong>Fax:</strong> {{ cliente.Fax }}</p>
      <p class="mb-4"><strong>Contacto principal:</strong> {{ cliente.PrimaryContact }}</p>
      <p class="mb-4"><strong>Contacto alternativo:</strong> {{ cliente.AlternateContact }}</p>
      <p class="mb-4"><strong>Grupo de facturación:</strong> {{ cliente.BillToCustomer }}</p>
      <p class="mb-4"><strong>Días de pago:</strong> {{ cliente.PaymentDays }}</p>
      <p class="mb-4"><strong>Dirección completa:</strong> {{ cliente.FullAddress }}</p>
      <p class="mb-4"><strong>Código postal:</strong> {{ cliente.PostalCode }}</p>
      <p class="mb-4">
        <strong>Sitio web:</strong>
        <a :href="cliente.WebSite" target="_blank" class="link link-primary text-lg">
          {{ cliente.WebSite }}
        </a>
      </p>

      <!-- Mapa dentro del v-else -->
      <div v-if="cliente?.DeliveryLocation?.points?.length" class="mt-6 h-96 w-full rounded-lg">
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
      cliente: null,
      map: null
    }
  },

  methods: {
    async buscarClienteEspecifico(nombre) {
      if (!nombre) return;

      try {
        const url = `http://localhost:3000/customers/getSpecificCustomer?name=${encodeURIComponent(nombre)}`;
        const res = await fetch(url);
        if (!res.ok) throw new Error('Error en la respuesta del servidor');
        const result = await res.json();
        this.cliente = result.length ? result[0] : null;

        await nextTick();
        this.mostrarMapa();

      } catch (err) {
        console.error('Error al buscar clientes:', err);
      }
    },

   mostrarMapa() {
    if (!this.cliente?.DeliveryLocation?.points?.length) return;

    const { lat, lng } = this.cliente.DeliveryLocation.points[0];

    
    if (this.map) this.map.remove();

    
    this.map = L.map('map').setView([lat, lng], 13);

    
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; OpenStreetMap contributors'
    }).addTo(this.map);

    // El marcador
    L.marker([lat, lng]).addTo(this.map)
        .bindPopup(`Ubicación de entrega de ${this.cliente.Name}`)
        .openPopup();
    }
  },

  mounted() {
    const nombreCliente = localStorage.getItem('clienteSeleccionado') || '';
    this.buscarClienteEspecifico(nombreCliente);
  }
}
</script>