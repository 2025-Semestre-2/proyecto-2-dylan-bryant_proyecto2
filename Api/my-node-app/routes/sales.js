const express = require('express')
const salesRouter = express.Router()
const DB = require("../db/dbSales.js");
const db = DB.getInstance();

salesRouter.get("/getAllInvoices", async (req, res) =>{
  try{
    const result = await db.SP_AllInvoices();
    res.json(result); //Por defecto ya va con el código 200
  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SP_AllItems:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SP_AllItems: ${err.message}`);
  }
});

salesRouter.get("/searchInvoices", async (req, res) =>{
  try{
    const { customer = '', deliveryMethod = '', minDate = '', maxDate = '', minAmount = '', maxAmount = '' } = req.query;
    console.log("Cliente: ", customer);
    console.log("Método de entrega: ", deliveryMethod);
    console.log("Fecha mínima: ", minDate);
    console.log("Fecha máxima: ", maxDate);
    console.log("Monto mínimo ", minAmount);
    console.log("Monto máximo ", maxAmount);

    const minQ = minAmount !== '' ? parseInt(minAmount, 10) : null;
    const maxQ = maxAmount !== '' ? parseInt(maxAmount, 10) : null;
    console.log("Cantidad Mínima: ", minQ);
    console.log("Cantidad máxima:", maxQ);
    const result = await db.SearchInvoices(customer, deliveryMethod, minDate, maxDate,minQ, maxQ);
    //console.log(result);
    if(result.resultado == 1){
      return res.json(result.filas);
    }else{
      return res.status(500).send('Error al ejecutar el procedimiento almacenado SearchInvoices: ');
    }

  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SearchInvoices:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SearchInvoices: ${err.message}`);
  }
});

//Obtener el encabezado específico de la factura
salesRouter.get("/getSpecificHeader", async (req, res) =>{
  try{
    const { ID = '' } = req.query;
    const IDint = ID !== '' ? parseInt(ID, 10) : null;
    const result = await db.SP_InvoiceHeader(IDint);
    console.log(result);
    if(result.resultado == 1){
      return res.json(result.filas);
    }else{
      return res.status(500).send('Error al ejecutar el procedimiento almacenado SP_InvoiceHeader: ');
    }

  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SP_InvoiceHeader:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SP_InvoiceHeader: ${err.message}`);
  }
});


salesRouter.get("/getInvoiceLines", async (req, res) =>{
  try{
    const { ID = '' } = req.query;
    const IDint = ID !== '' ? parseInt(ID, 10) : null;
    const result = await db.SP_InvoiceLines(IDint);
    console.log(result);
    if(result.resultado == 1){
      return res.json(result.filas);
    }else{
      return res.status(500).send('Error al ejecutar el procedimiento almacenado SP_InvoiceLines: ');
    }

  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SP_InvoiceLines:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SP_InvoiceLines: ${err.message}`);
  }
});


salesRouter.get("/getMinAndMaxDate", async (req, res) =>{
  try{
    const result = await db.SP_MinAndMaxDateInvoices();
    res.json(result); //Por defecto ya va con el código 200
  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SP_MinAndMaxDateInvoices:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SP_MinAndMaxDateInvoices: ${err.message}`);
  }
});

salesRouter.get("/getMinAndMaxAmount", async (req, res) =>{
  try{
    const result = await db.SP_MinAndMaxTotalInvoices();
    res.json(result); //Por defecto ya va con el código 200
  }catch(err){
    console.error("Error al ejecutar el procedimiento almacenado SP_MinAndMaxDateInvoices:", err);
    res.status(500).send(`Error al ejecutar el procedimiento almacenado SP_MinAndMaxDateInvoices: ${err.message}`);
  }
});



// Exporta el router
module.exports = salesRouter;