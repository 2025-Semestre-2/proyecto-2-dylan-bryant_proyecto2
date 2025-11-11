const sql = require("mssql");

class DBStats{
    static #_instance = null; // Se utiliza el patrón singleton para un mejor diseño

    constructor() {
    if (DBStats.#_instance) {
      throw new Error("No se puede instanciar más de una vez");
    }

    this._config = {
      user: "sa",
      password: "YourStrong!Passw0rd",
      server: "86.48.22.228",
      port: 1433, 
      database: "WideWorldImporters",
      options: {
        encrypt: false,
        trustServerCertificate: true,
      },
    };

    DBStats.#_instance = this;
    try{
      this._conection =  sql.connect(this._config);
      console.log("Conectado a sql server desde db.js")
    }catch(err){
      console.error('Error al intentarse conectar desde db.js:', err);
    }
  }
  
  
  //Para obtener la instancia
  static getInstance() {
    if (!DBStats.#_instance) {
      DBStats.#_instance = new DBStats();
    }
    return DBStats.#_instance;
  } 

  //Aquí ya ejecuto todos los procedimientos

  async PrimeraEstadistica(proveedor, categoria){
    try{
      //Abrir el request
      const pool = await sql.connect(this._config);
      const request = pool.request();
  
      //Poner los parámetros de entrada
      request.input("Proveedor", sql.NVarChar(100), proveedor); //Nombre del parámetro, tipo y la variable asignada de esta función
      request.input("Categoria", sql.NVarChar(50), categoria);
  
  
      //Ejecutar el procedimiento
      const result = await request.execute("SP_PrimerEstadistica");
      
      return result.recordset;
      }catch (err) {  
        console.error("Error al ejecutar SP_PrimerEstadistica:", err);
        throw err;
      }
  }

  async SegundaEstadistica(cliente, categoria){
    try{
      //Abrir el request
      const pool = await sql.connect(this._config);
      const request = pool.request();
  
      //Poner los parámetros de entrada
      request.input("Cliente", sql.NVarChar(100), cliente); //Nombre del parámetro, tipo y la variable asignada de esta función
      request.input("Categoria", sql.NVarChar(50), categoria);
  
  
      //Ejecutar el procedimiento
      const result = await request.execute("SP_SegundaEstadistica");
      
      return result.recordset;
      }catch (err) {  
        console.error("Error al ejecutar SP_SegundaEstadistica:", err);
        throw err;
      }
  }

  async TerceraEstadistica(anio){
    try{
      //Abrir el request
      const pool = await sql.connect(this._config);
      const request = pool.request();
  
      //Poner los parámetros de entrada
      request.input("Anio", sql.Int, anio); //Nombre del parámetro, tipo y la variable asignada de esta función

  
  
      //Ejecutar el procedimiento
      const result = await request.execute("SP_TerceraEstadistica");
      
      return result.recordset;
      }catch (err) {  
        console.error("Error al ejecutar SP_TerceraEstadistica:", err);
        throw err;
      }
  }

  async CuartaEstadistica(anio){
    try{
      //Abrir el request
      const pool = await sql.connect(this._config);
      const request = pool.request();
  
      //Poner los parámetros de entrada
      request.input("Anio", sql.Int, anio); //Nombre del parámetro, tipo y la variable asignada de esta función

  
  
      //Ejecutar el procedimiento
      const result = await request.execute("SP_CuartaEstadistica");
      
      return result.recordset;
      }catch (err) {  
        console.error("Error al ejecutar SP_CuartaEstadistica:", err);
        throw err;
      }
  }

   async QuintaEstadistica(anio){
    try{
      //Abrir el request
      const pool = await sql.connect(this._config);
      const request = pool.request();
  
      //Poner los parámetros de entrada
      request.input("Anio", sql.Int, anio); //Nombre del parámetro, tipo y la variable asignada de esta función

  
  
      //Ejecutar el procedimiento
      const result = await request.execute("SP_QuintaEstadistica");
      
      return result.recordset;
      }catch (err) {  
        console.error("Error al ejecutar SP_QuintaEstadistica:", err);
        throw err;
      }
  }
}

module.exports = DBStats;