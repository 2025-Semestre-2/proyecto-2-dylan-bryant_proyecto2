const sql = require("mssql");

class DBSales{
    static #_instance = null; // Se utiliza el patrón singleton para un mejor diseño

    constructor() {
    if (DBSales.#_instance) {
      throw new Error("No se puede instanciar más de una vez");
    }
    
    // Lista con todas las configuraciones
     this.listaConfiguraciones = [
      {
        user: "sa",
        password: "YourStrong!Passw0rd2",
        server: "86.48.22.228",
        port: 1434,
        database: "Limon",
        options: {
          encrypt: false,
          trustServerCertificate: true,
        },
      },

      {
        user: "sa",
        password: "YourStrong!Passw0rd3",
        server: "86.48.22.228",
        port: 1435,
        database: "SanJose",
        options: {
          encrypt: false,
          trustServerCertificate: true,
        },
      }
    ]

    DBSales.#_instance = this;
  }
  
  
  //Para obtener la instancia
  static getInstance() {
    if (!DBSales.#_instance) {
      DBSales.#_instance = new DBSales();
    }
    return DBSales.#_instance;
  } 

  //Aquí ya ejecuto todos los procedimientos
  //Se verifica que la sucursal que envía exista y retorna la conexión
  verificarSucursal(pSucursal){
    for(let i = 0; i < this.listaConfiguraciones.length; i++){
      if(this.listaConfiguraciones[i].database === pSucursal){
        return this.listaConfiguraciones[i]
      }
    }
    throw new Error(`La sucursal "${pSucursal}" no existe`);
  }

  //Obtener todas las facturas para la tabla principal
  async SP_AllInvoices(sucursal) {
    try {
      const configuracion = this.verificarSucursal(sucursal);
      
      console.log("Desde la sucursal: " + sucursal)
      const pool = await sql.connect(configuracion);
      const request = pool.request();
      
      const result = await request.execute("SP_AllInvoices");
      return result.recordset;

    } catch (err) {
      console.error("Error al ejecutar SP_AllInvoices:", err);
      throw err;
    }
  }

  //Obtener el encabezado de la factura para la vista detallada
  async SP_InvoiceHeader(ID, sucursal) {
      try{
        //Abrir el request
        const configuracion = this.verificarSucursal(sucursal);
        const pool = await sql.connect(configuracion);
        const request = pool.request();
  
        //Poner los parámetros de entrada
        request.input("InvoiceID", sql.Int, ID); //Nombre del parámetro, tipo y la variable asignada de esta función
  
        //Poner el parámetro de salida
        request.output("Success", sql.SmallInt); //Nombre del parámetro y tipo
  
        //Ejecutar el procedimiento
        const result = await request.execute("SP_InvoiceHeader");
  
        //Obtener el número que me indica si se hizo bien o con error
        const numero = result.output.Success;
        console.log("El resultado de la consulta es: ", numero);
        return {resultado: numero, filas: result.recordset};
      }catch (err) {  
        console.error("Error al ejecutar SP_InvoiceHeader:", err);
        throw err;
      }
    }

  //Obtener las líneas de una factura para la vista detallada
  async SP_InvoiceLines(ID, sucursal) {
      try{
        //Abrir el request
        const configuracion = this.verificarSucursal(sucursal);
        const pool = await sql.connect(sucursal);
        const request = pool.request();
  
        //Poner los parámetros de entrada
        request.input("InvoiceID", sql.Int, ID); //Nombre del parámetro, tipo y la variable asignada de esta función
  
        //Poner el parámetro de salida
        request.output("Success", sql.SmallInt); //Nombre del parámetro y tipo
  
        //Ejecutar el procedimiento
        const result = await request.execute("SP_InvoiceLines");
  
        //Obtener el número que me indica si se hizo bien o con error
        const numero = result.output.Success;
        console.log("El resultado de la consulta es: ", numero);
        return {resultado: numero, filas: result.recordset};
      }catch (err) {  
        console.error("Error al ejecutar SP_InvoiceLines:", err);
        throw err;
      }
    }

  //Búsqueda entre todas las facturas para la tabla principal
  async SearchInvoices(customer, deliveryMethod, minDate, maxDate, minAmount, maxAmount, sucursal){
    try{
      //Abrir el request
      const configuracion = this.verificarSucursal(sucursal);
      const pool = await sql.connect(sucursal);
      const request = pool.request();
  
      //Poner los parámetros de entrada
      request.input("Customer", sql.NVarChar(100), customer); //Nombre del parámetro, tipo y la variable asignada de esta función
      request.input("DeliveryMethod", sql.NVarChar(50), deliveryMethod);
      request.input("MinDate", sql.Date, minDate);
      request.input("MaxDate", sql.Date, maxDate);
      request.input("MinAmount", sql.Int, minAmount);
      request.input("MaxAmount", sql.Int, maxAmount);

      //Poner el parámetro de salida
      request.output("Success", sql.SmallInt); //Nombre del parámetro y tipo
  
      //Ejecutar el procedimiento
      const result = await request.execute("SearchInvoices");
  
      //Obtener el número que me indica si se hizo bien o con error
      const numero = result.output.Success;
      console.log("El resultado de la consulta es: ", numero);
      return {resultado: numero, filas: result.recordset};
    }catch (err) {  
      console.error("Error al ejecutar SearchInvoices:", err);
      throw err;
    }
  }


  async SP_MinAndMaxTotalInvoices(sucursal) {
    try {
      const configuracion = this.verificarSucursal(sucursal);
      
      console.log("Desde la sucursal: " + sucursal)
      const pool = await sql.connect(configuracion);
      const request = pool.request();
      
      const result = await request.execute("SP_MinAndMaxTotalInvoices");
      return result.recordset;

    } catch (err) {
      console.error("Error al ejecutar SP_MinAndMaxTotalInvoices:", err);
      throw err;
    }
  }

  async SP_MinAndMaxDateInvoices(sucursal) {
    try {
      const configuracion = this.verificarSucursal(sucursal);
      
      console.log("Desde la sucursal: " + sucursal)
      const pool = await sql.connect(configuracion);
      const request = pool.request();
      
      const result = await request.execute("SP_MinAndMaxDateInvoices");
      return result.recordset;
 
    } catch (err) {
      console.error("Error al ejecutar SP_MinAndMaxDateInvoices:", err);
      throw err;
    }
  }



}

module.exports = DBSales;