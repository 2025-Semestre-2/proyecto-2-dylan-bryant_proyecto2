const express = require('express')
const suppliersRouter = express.Router()
const DB = require("../db/dbSuppliers");
const db = DB.getInstance();


//Retorna a todos los proveedores
suppliersRouter.get("/getAllSuppliers", async (req, res) =>{
  try{
    const result = await db.SP_AllSupliers();
    res.json(result); //Por defecto ya va con el código 200
  }catch(err){
     console.error("Error al ejecutar el procedimiento almacenado SP_AllItems:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SP_AllItems: ${err.message}`);
  }
});

//Retorna a todos los proveedores que coincidan con las entradas
suppliersRouter.get("/searchSuppliers", async (req, res) =>{
  try{
    const { name = '', category = '', deliveryMethod = '' } = req.query;
    console.log("Nombre: ", name);
    console.log("Categoría: ", category);
    console.log("DeliveryMethod: ", deliveryMethod);
    const result = await db.SearchSuppliers(name, category, deliveryMethod);
    //console.log(result);
    if(result.resultado == 1){
      return res.json(result.filas);
    }else{
      return res.status(500).send('Error al ejecutar el procedimiento almacenado SearchSuppliers: ');
    }

  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SearchSuppliers:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SearchSuppliers: ${err.message}`);
  }
});

//Retorna la versión extendida de los datos para un cliente
suppliersRouter.get("/getSpecificSupplier", async (req, res) =>{
  try{
    const { name = '' } = req.query;

    const result = await db.SP_SelectSpecificSupplierData(name);
    console.log(result);
    if(result.resultado == 1){
      return res.json(result.filas);
    }else{
      return res.status(500).send('Error al ejecutar el procedimiento almacenado SP_SelectSpecificSupplierData: ');
    }

  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SP_SelectSpecificSupplierData:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SP_SelectSpecificSupplierData: ${err.message}`);
  }
});


suppliersRouter.get("/getAllCategories", async (req, res) =>{
  try{
    const result = await db.SP_AllSuppliersCategories();
    res.json(result); //Por defecto ya va con el código 200
  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SP_AllSuppliersCategories:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SP_AllSuppliersCategories: ${err.message}`);
  }
});
// Exporta el router
module.exports = suppliersRouter;