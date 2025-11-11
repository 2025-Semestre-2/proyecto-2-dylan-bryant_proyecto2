const express = require('express')
const customersRouter = express.Router()
const DB = require("../db/dbCustomers");
const db = DB.getInstance();

//Ejemplo

customersRouter.get("/", (req, res) => {
  //Ejecutar la función de la base de datos
  res.send('Hello from customers');
});

customersRouter.get("/getAllCustomers", async (req, res) =>{
  try{
    const result = await db.SP_AllCustomers();
    res.json(result); //Por defecto ya va con el código 200
  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado ST_AllCustomers:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado ST_AllCustomers: ${err.message}`);
  }
});

customersRouter.get("/searchCustomers", async (req, res) =>{
  try{
    const { name = '', category = '', deliveryMethod = '' } = req.query;
    console.log("Nombre: ", name);
    console.log("Categoría: ", category);
    console.log("DeliveryMethod: ", deliveryMethod);
    const result = await db.SearchCustomers(name, category, deliveryMethod);
    //console.log(result);
    if(result.resultado == 1){
      return res.json(result.filas);
    }else{
      return res.status(500).send('Error al ejecutar el procedimiento almacenado SP_SelectSpecificCustomerData: ');
    }

  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SP_SelectSpecificCustomerData:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SP_SelectSpecificCustomerData: ${err.message}`);
  }
});


//Este es pensando solo en que me retorne el que seleccionó de la tabla por medio del nombre
customersRouter.get("/getSpecificCustomer", async (req, res) =>{
  try{
    const { name = '' } = req.query;

    const result = await db.SP_SelectSpecificCustomerData(name);
    console.log(result);
    if(result.resultado == 1){
      return res.json(result.filas);
    }else{
      return res.status(500).send('Error al ejecutar el procedimiento almacenado SP_SelectSpecificCustomerData: ');
    }

  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SP_SelectSpecificCustomerData:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SP_SelectSpecificCustomerData: ${err.message}`);
  }
});


//Retorna todas las posibles categorías de los clientes
customersRouter.get("/getAllCategories", async (req, res) =>{
  try{
    const result = await db.SP_AllCustomerCategories();
    res.json(result); //Por defecto ya va con el código 200
  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SP_AllCustomerCategories:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SP_AllCustomerCategories: ${err.message}`);
  }
});

//Retorna todos los posibles métodos de entrega 
customersRouter.get("/getAllDeliveryMethods", async (req, res) =>{
  try{
    const result = await db.SP_All_DeliveryMethods();
    res.json(result); //Por defecto ya va con el código 200
  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SP_All_DeliveryMethods:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SP_All_DeliveryMethods: ${err.message}`);
  }
});

// Exporta el router
module.exports = customersRouter;