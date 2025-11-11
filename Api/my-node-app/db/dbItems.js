const sql = require("mssql");

class DBItems {
  static #_instance = null;

  constructor() {
    if (DBItems.#_instance) {
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

    DBItems.#_instance = this;
    try{
      this._conection =  sql.connect(this._config);
      console.log("Conectado a sql server desde db.js")
    }catch(err){
      console.error('Error al intentarse conectar desde db.js:', err);
    }


  }

  static getInstance() {
    if (!DBItems.#_instance) {
      DBItems.#_instance = new DBItems();
    }
    return DBItems.#_instance;
  }


  async SP_AllItems() {
    try {
      const result = await sql.query`EXEC SP_AllItems`;
      return result.recordset;
    } catch (err) {
      console.error("Error al ejecutar SP_AllItems:", err);
      throw err;
    }
  }

  //Retorna todos los datos de un item específico
  async SP_SelectSpecificItemData(name) {
    try{
      //Abrir el request
      const pool = await sql.connect(this._config);
      const request = pool.request();

      //Poner los parámetros de entrada
      request.input("ItemName", sql.NVarChar(100), name); //Nombre del parámetro, tipo y la variable asignada de esta función

      //Poner el parámetro de salida
      request.output("Success", sql.SmallInt); //Nombre del parámetro y tipo

      //Ejecutar el procedimiento
      const result = await request.execute("SP_SelectSpecificItemData");

      //Obtener el número que me indica si se hizo bien o con error
      const numero = result.output.Success;
      console.log("El resultado de la consulta es: ", numero);
      return {resultado: numero, filas: result.recordset};
    }catch (err) {  
      console.error("Error al ejecutar ST_AllCustomers:", err);
      throw err;
    }
  }

  //Retorna los items que coincidan
  async SearchItems(name, group, cantidadMinima, cantidadMaxima){
     try{
      //Abrir el request
      const pool = await sql.connect(this._config);
      const request = pool.request();

      //Poner los parámetros de entrada
      request.input("ItemName", sql.NVarChar(100), name); //Nombre del parámetro, tipo y la variable asignada de esta función
      request.input("Group", sql.NVarChar(50), group);
      request.input("MinQuantity", sql.Int, cantidadMinima);
      request.input("MaxQuantity", sql.Int, cantidadMaxima);

      //Poner el parámetro de salida
      request.output("Success", sql.SmallInt); //Nombre del parámetro y tipo

      //Ejecutar el procedimiento
      const result = await request.execute("SearchItems");

      //Obtener el número que me indica si se hizo bien o con error
      const numero = result.output.Success;
      console.log("El resultado de la consulta es: ", numero);
      return {resultado: numero, filas: result.recordset};
    }catch (err) {  
      console.error("Error al ejecutar SearchItems:", err);
      throw err;
    }
  }


  //Retorna todos los grupos de stock
    async SP_AllStockGroupsItems() {
    try {
      const result = await sql.query`EXEC SP_AllStockGroupsItems`;
      return result.recordset;
    } catch (err) {
      console.error("Error al ejecutar SP_AllStockGroupsItems:", err);
      throw err;
    }
    }

    //Retorna el máximo y mínimo del inventario
    async SP_MaxAndMinStockItemHoldings() {
    try {
      const result = await sql.query`EXEC SP_MaxAndMinStockItemHoldings`;
      return result.recordset;
    } catch (err) {
      console.error("Error al ejecutar SP_MaxAndMinStockItemHoldings:", err);
      throw err;
    }
    }

}

module.exports = DBItems;
