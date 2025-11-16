<script setup>
import { RouterLink, RouterView } from 'vue-router'
import Navbar from '../components/Navbar.vue'
</script>
<template>
    <div class="min-h-screen bg-gray-100 text-gray-800">
        <header>
            <Navbar /> <!--Con esto coloco el componente importado-->
        </header>
        <main class="p-4">
            <RouterView />
        </main>
    </div>
</template>