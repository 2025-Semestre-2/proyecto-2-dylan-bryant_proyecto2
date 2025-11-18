import { defineStore } from 'pinia'

export const usuarioStore = defineStore('usuario', {
    state: () =>({
       sucursal: '', 
       link: ''
    }),

    actions:{
        setSucursal(pSucursal){
            this.sucursal = pSucursal
        },
        setLink(pLink){
            this.link = pLink
        }
    },
    persist: true //Simula el session storage y no va a morir el dato aunque recarguen la página
})