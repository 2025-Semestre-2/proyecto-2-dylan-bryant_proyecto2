const sql = require("mssql");

class DBCustomers {
  static #_instance = null;

  constructor() {
    if (DBCustomers.#_instance) {
      throw new Error("No se puede instanciar más de una vez");
    }

    this._config = {
      user: "sa",
      password: "YourStrong!Passw0rd",
      server: "sqlserver", // nombre del servicio en Docker Compose
      database: "WideWorldImporters",
      options: {
        encrypt: false,
        trustServerCertificate: true,
      },
    };

    DBCustomers.#_instance = this;
    try{
      this._conection =  sql.connect(this._config);
      console.log("Conectado a sql server desde db.js")
    }catch(err){
      console.error('Error al intentarse conectar desde db.js:', err);
    }


  }

  static getInstance() {
    if (!DBCustomers.#_instance) {
      DBCustomers.#_instance = new DBCustomers();
    }
    return DBCustomers.#_instance;
  }


  async SP_AllCustomers() {
    try {
      const result = await sql.query`EXEC SP_AllCustomers`;
      return result.recordset;
    } catch (err) {
      console.error("Error al ejecutar ST_AllCustomers:", err);
      throw err;
    }
  }

  //Retorna todos los datos de un cliente específico
  async SP_SelectSpecificCustomerData(name) {
    try{
      //Abrir el request
      const pool = await sql.connect(this._config);
      const request = pool.request();

      //Poner los parámetros de entrada
      request.input("CustomerName", sql.NVarChar(100), name); //Nombre del parámetro, tipo y la variable asignada de esta función

      //Poner el parámetro de salida
      request.output("Success", sql.SmallInt); //Nombre del parámetro y tipo

      //Ejecutar el procedimiento
      const result = await request.execute("SP_SelectSpecificCustomerData");

      //Obtener el número que me indica si se hizo bien o con error
      const numero = result.output.Success;
      console.log("El resultado de la consulta es: ", numero);
      return {resultado: numero, filas: result.recordset};
    }catch (err) {  
      console.error("Error al ejecutar ST_AllCustomers:", err);
      throw err;
    }
  }

  //Retorna los clientes que coincidan
  async SearchCustomers(name, category, deliveryMethod){
     try{
      //Abrir el request
      const pool = await sql.connect(this._config);
      const request = pool.request();

      //Poner los parámetros de entrada
      request.input("CustomerName", sql.NVarChar(100), name); //Nombre del parámetro, tipo y la variable asignada de esta función
      request.input("Category", sql.NVarChar(50), category);
      request.input("DeliveryMethod", sql.NVarChar(50), deliveryMethod);

      //Poner el parámetro de salida
      request.output("Success", sql.SmallInt); //Nombre del parámetro y tipo

      //Ejecutar el procedimiento
      const result = await request.execute("SearchCustomers");

      //Obtener el número que me indica si se hizo bien o con error
      const numero = result.output.Success;
      console.log("El resultado de la consulta es: ", numero);
      return {resultado: numero, filas: result.recordset};
    }catch (err) {  
      console.error("Error al ejecutar ST_AllCustomers:", err);
      throw err;
    }
  }


  //Retorna todas las posibles categorías de los clientes
    async SP_AllCustomerCategories() {
    try {
      const result = await sql.query`EXEC SP_AllCustomerCategories`;
      return result.recordset;
    } catch (err) {
      console.error("Error al ejecutar SP_AllCustomerCategories:", err);
      throw err;
    }
  }

  //Retorna todos los posibles métodos de entrega 
  async SP_All_DeliveryMethods(){
    try {
      const result = await sql.query`EXEC SP_All_DeliveryMethods`;
      return result.recordset;
    } catch (err) {
      console.error("Error al ejecutar SP_All_DeliveryMethods:", err);
      throw err;
    }
  }
}

module.exports = DBCustomers;
