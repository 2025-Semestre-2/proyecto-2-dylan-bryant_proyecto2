const express = require('express')
const statsRouter = express.Router()
const DB = require("../db/dbStats.js");
const db = DB.getInstance();

//Ejemplo
statsRouter.get("/primeraEstadistica", async (req, res) =>{
  try{
    const { proveedor = '', sucursal = '' } = req.query;
    console.log("SUCURSAL PRIMRA: "+ sucursal )
    const result = await db.PrimeraEstadistica(proveedor, proveedor, sucursal);
    console.log(result);
    return res.json(result);

  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado PrimeraEstadistica:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado PrimeraEstadistica: ${err.message}`);
  }
});


statsRouter.get("/segundaEstadistica", async (req, res) =>{
  try{
    const { cliente = '', sucursal = '' } = req.query;

    const result = await db.SegundaEstadistica(cliente, cliente, sucursal);
    console.log(result);
    return res.json(result);

  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SegundaEstadistica:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SegundaEstadistica: ${err.message}`);
  }
});


statsRouter.get("/terceraEstadistica", async (req, res) =>{
  try{
    const { anio = '', anioFin = '', sucursal = '' } = req.query;
    const anioInt = anio !== '' ? parseInt(anio, 10) : null;
    const anioInt2 = anioFin !== '' ? parseInt(anioFin, 10) : null;
    const result = await db.TerceraEstadistica(anioInt, anioInt2, sucursal);
    console.log(result);
    return res.json(result);

  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado TerceraEstadistica:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado TerceraEstadistica: ${err.message}`);
  }
});

statsRouter.get("/cuartaEstadistica", async (req, res) =>{
  try{
    const { anio = '', anioFin = '',sucursal = '' } = req.query;
    const anioInt = anio !== '' ? parseInt(anio, 10) : null;
    const anioInt2 = anioFin !== '' ? parseInt(anioFin, 10) : null;
    const result = await db.CuartaEstadistica(anioInt, anioInt2, sucursal);
    console.log(result);
    return res.json(result);

  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado CuartaEstadistica:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado CuartaEstadistica: ${err.message}`);
  }
});


statsRouter.get("/quintaEstadistica", async (req, res) =>{
  try{
    const { anio = '', anioFin = '', sucursal = '' } = req.query;
    const anioInt = anio !== '' ? parseInt(anio, 10) : null;
    const anioInt2 = anioFin !== '' ? parseInt(anioFin, 10) : null;
    const result = await db.QuintaEstadistica(anioInt, anioInt2, sucursal);
    console.log(result);
   
    return res.json(result);


  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado QuintaEstadistica:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado QuintaEstadistica: ${err.message}`);
  }
});



// Exporta el router
module.exports = statsRouter;