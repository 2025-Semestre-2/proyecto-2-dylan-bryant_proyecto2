const express = require('express')
const itemsRouter = express.Router()
const DB = require("../db/dbItems.js");
const db = DB.getInstance();


//Obtener todos los items
itemsRouter.get("/getAllItems", async (req, res) =>{
  try{
    const sucursal = req.query.sucursal;
    const result = await db.SP_AllItems(sucursal);
    res.json(result); //Por defecto ya va con el código 200
  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SP_AllItems:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SP_AllItems: ${err.message}`);
  }
});

itemsRouter.get("/searchItems", async (req, res) =>{
  try{
    const { name = '', group = '', maxQuantity = '', minQuantity = '' } = req.query;
    console.log("Nombre: ", name);
    console.log("Grupo: ", group);
    
    const sucursal = req.query.sucursal;
    const minQ = minQuantity !== '' ? parseInt(minQuantity, 10) : null;
    const maxQ = maxQuantity !== '' ? parseInt(maxQuantity, 10) : null;
    console.log("Cantidad Mínima: ", minQ);
    console.log("Cantidad máxima:", maxQ);
    const result = await db.SearchItems(name, group, minQ, maxQ, sucursal);
    //console.log(result);
    if(result.resultado == 1){
      return res.json(result.filas);
    }else{
      return res.status(500).send('Error al ejecutar el procedimiento almacenado SearchItems: ');
    }

  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SearchItems:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SearchItems: ${err.message}`);
  }
});


//solo el item seleccionado
itemsRouter.get("/getSpecificItem", async (req, res) =>{
  try{
    const { name = '' } = req.query;
    const sucursal = req.query.sucursal;
    const result = await db.SP_SelectSpecificItemData(name, sucursal);
    console.log(result);
    if(result.resultado == 1){
      return res.json(result.filas);
    }else{
      return res.status(500).send('Error al ejecutar el procedimiento almacenado SP_SelectSpecificItemData: ');
    }

  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SP_SelectSpecificItemData:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SP_SelectSpecificItemData: ${err.message}`);
  }
});

//Retorna la información de los tipos de grupos
itemsRouter.get("/getStockGroupItem", async (req, res) =>{
  try{
    const sucursal = req.query.sucursal;
    const result = await db.SP_AllStockGroupsItems(sucursal);
    res.json(result); //Por defecto ya va con el código 200
  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SP_AllStockGroupsItems:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SP_AllStockGroupsItems: ${err.message}`);
  }
});

//Obtengo los máximos y mínimos del inventario
itemsRouter.get("/getMaxAndMinStockItemHoldings", async (req, res) =>{
  try{
    const sucursal = req.query.sucursal;
    const result = await db.SP_MaxAndMinStockItemHoldings(sucursal);
    res.json(result); //Por defecto ya va con el código 200
  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SP_MaxAndMinStockItemHoldings:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SP_MaxAndMinStockItemHoldings: ${err.message}`);
  }
});

module.exports = itemsRouter;