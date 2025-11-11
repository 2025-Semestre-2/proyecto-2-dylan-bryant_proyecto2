const express = require('express')
const statsRouter = express.Router()
const DB = require("../db/dbStats.js");
const db = DB.getInstance();

//Ejemplo
statsRouter.get("/primeraEstadistica", async (req, res) =>{
  try{
    const { proveedor = '', categoria = '' } = req.query;
 
    const result = await db.PrimeraEstadistica(proveedor, categoria);
    console.log(result);
    return res.json(result);

  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado PrimeraEstadistica:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado PrimeraEstadistica: ${err.message}`);
  }
});


statsRouter.get("/segundaEstadistica", async (req, res) =>{
  try{
    const { cliente = '', categoria = '' } = req.query;
 
    const result = await db.SegundaEstadistica(cliente, categoria);
    console.log(result);
    return res.json(result);

  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SegundaEstadistica:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SegundaEstadistica: ${err.message}`);
  }
});


statsRouter.get("/terceraEstadistica", async (req, res) =>{
  try{
    const { anio = '' } = req.query;
    const anioInt = anio !== '' ? parseInt(anio, 10) : null;

    const result = await db.TerceraEstadistica(anioInt);
    console.log(result);
    return res.json(result);

  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado TerceraEstadistica:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado TerceraEstadistica: ${err.message}`);
  }
});

statsRouter.get("/cuartaEstadistica", async (req, res) =>{
  try{
    const { anio = '' } = req.query;
    const anioInt = anio !== '' ? parseInt(anio, 10) : null;

    const result = await db.CuartaEstadistica(anioInt);
    console.log(result);
    return res.json(result);

  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado CuartaEstadistica:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado CuartaEstadistica: ${err.message}`);
  }
});


statsRouter.get("/quintaEstadistica", async (req, res) =>{
  try{
    const { anio = '' } = req.query;
    const anioInt = anio !== '' ? parseInt(anio, 10) : null;

    const result = await db.QuintaEstadistica(anioInt);
    console.log(result);
   
    return res.json(result);


  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado QuintaEstadistica:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado QuintaEstadistica: ${err.message}`);
  }
});



// Exporta el router
module.exports = statsRouter;