import { defineStore } from 'pinia'

export const usuarioStore = defineStore('usuario', {
    state: () =>({
       sucursal: '' 
    }),

    actions:{
        setSucursal(pSucursal){
            this.sucursal = pSucursal
        }
    },
    persist: true //Simula el session storage y no va a morir el dato aunque recarguen la página
})