const sql = require("mssql");

class DBStats{
    static #_instance = null; // Se utiliza el patrón singleton para un mejor diseño

    constructor() {
    if (DBStats.#_instance) {
      throw new Error("No se puede instanciar más de una vez");
    }

    this.listaConfiguraciones = [
      {
      user: "sa",
      password: "YourStrong!Passw0rd",
      server: "86.48.22.228",
      port: 1433, 
      database: "Corporativo",
      options: {
        encrypt: false,
        trustServerCertificate: true,
      },
      },
      {
        user: "sa",
        password: "YourStrongPassw0rd2",
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
        password: "YourStrongPassw0rd3",
        server: "86.48.22.228",
        port: 1435,
        database: "SanJose",
        options: {
          encrypt: false,
          trustServerCertificate: true,
        },
      }
    ]

    DBStats.#_instance = this;
  }
  
  
  //Para obtener la instancia
  static getInstance() {
    if (!DBStats.#_instance) {
      DBStats.#_instance = new DBStats();
    }
    return DBStats.#_instance;
  }
  
  verificarSucursal(pSucursal){
    for(let i = 0; i < this.listaConfiguraciones.length; i++){
      if(this.listaConfiguraciones[i].database === pSucursal){
        return this.listaConfiguraciones[i]
      }
    }
    throw new Error(`La sucursal "${pSucursal}" no existe`);
  }

  //Aquí ya ejecuto todos los procedimientos

  async PrimeraEstadistica(proveedor, categoria, sucursal){
    try{
      //Abrir el request
      const configuracion = this.verificarSucursal(sucursal);
      const pool = await sql.connect(configuracion);
      const request = pool.request();
  
      //Poner los parámetros de entrada
      request.input("Proveedor", sql.NVarChar(100), proveedor); //Nombre del parámetro, tipo y la variable asignada de esta función
      request.input("Categoria", sql.NVarChar(50), categoria);
  
  
      //Ejecutar el procedimiento
      const result = await request.execute("SP_PrimerEstadistica");
      await pool.close();

      return result.recordset;
      }catch (err) {  
        console.error("Error al ejecutar SP_PrimerEstadistica:", err);
        throw err;
      }
  }

  async SegundaEstadistica(cliente, categoria, sucursal){
    try{
      //Abrir el request
      const configuracion = this.verificarSucursal(sucursal);
      const pool = await sql.connect(configuracion);
      const request = pool.request();
  
      //Poner los parámetros de entrada
      request.input("Cliente", sql.NVarChar(100), cliente); //Nombre del parámetro, tipo y la variable asignada de esta función
      request.input("Categoria", sql.NVarChar(50), categoria);
  
  
      //Ejecutar el procedimiento
      const result = await request.execute("SP_SegundaEstadistica");
      await pool.close();
      return result.recordset;
      }catch (err) {  
        console.error("Error al ejecutar SP_SegundaEstadistica:", err);
        throw err;
      }
  }

  async TerceraEstadistica(anio, anioFin, sucursal){
    try{
      //Abrir el request
      const configuracion = this.verificarSucursal(sucursal);
      const pool = await sql.connect(configuracion);
      const request = pool.request();
  
      //Poner los parámetros de entrada
      request.input("AnioI", sql.Int, anio); //Nombre del parámetro, tipo y la variable asignada de esta función
      request.input("AnioF", sql.Int, anioFin);
  
  
      //Ejecutar el procedimiento
      const result = await request.execute("SP_TerceraEstadistica");
      await pool.close();
      return result.recordset;
      }catch (err) {  
        console.error("Error al ejecutar SP_TerceraEstadistica:", err);
        throw err;
      }
  }

  async CuartaEstadistica(anio, anioFin, sucursal){
    try{
      //Abrir el request
      const configuracion = this.verificarSucursal(sucursal);
      const pool = await sql.connect(configuracion);
      const request = pool.request();
  
      //Poner los parámetros de entrada
      request.input("AnioI", sql.Int, anio); //Nombre del parámetro, tipo y la variable asignada de esta función
      request.input("AnioF", sql.Int, anioFin);
  
  
      //Ejecutar el procedimiento
      const result = await request.execute("SP_CuartaEstadistica");
      await pool.close();
      return result.recordset;
      }catch (err) {  
        console.error("Error al ejecutar SP_CuartaEstadistica:", err);
        throw err;
      }
  }

   async QuintaEstadistica(anio, anioFin, sucursal){
    try{
      //Abrir el request
      const configuracion = this.verificarSucursal(sucursal);
      const pool = await sql.connect(configuracion);
      const request = pool.request();
  
      //Poner los parámetros de entrada
      request.input("AnioI", sql.Int, anio); //Nombre del parámetro, tipo y la variable asignada de esta función
      request.input("AnioF", sql.Int, anioFin);
  
  
      //Ejecutar el procedimiento
      const result = await request.execute("SP_QuintaEstadistica");
      await pool.close();
      return result.recordset;
      }catch (err) {  
        console.error("Error al ejecutar SP_QuintaEstadistica:", err);
        throw err;
      }
  }
}

module.exports = DBStats;