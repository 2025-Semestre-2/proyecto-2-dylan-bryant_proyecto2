const sql = require("mssql");

class DBSuppliers{
    static #_instance = null; // Se utiliza el patrón singleton para un mejor diseño

    constructor() {
    if (DBSuppliers.#_instance) {
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

    DBSuppliers.#_instance = this;
    try{
      this._conection =  sql.connect(this._config);
      console.log("Conectado a sql server desde db.js")
    }catch(err){
      console.error('Error al intentarse conectar desde db.js:', err);
    }
  }
  
  
  //Para obtener la instancia
  static getInstance() {
    if (!DBSuppliers.#_instance) {
      DBSuppliers.#_instance = new DBSuppliers();
    }
    return DBSuppliers.#_instance;
  } 

  //Aquí ya ejecuto todos los procedimientos
  //Retorna a todos los proveedores
  async SP_AllSupliers(){
     try {
          const result = await sql.query`EXEC SP_AllSuppliers`;
          return result.recordset;
        } catch (err) {
          console.error("Error al ejecutar SP_AllSuppliers:", err);
          throw err;
        }
  }

  //Retorna a los proveedores que sus datos coincidan con las entradas
  async SearchSuppliers(name, category, deliveryMethod){
    try{
      //Abrir el request
      const pool = await sql.connect(this._config);
      const request = pool.request();
  
      //Poner los parámetros de entrada
      request.input("SupplierName", sql.NVarChar(100), name); //Nombre del parámetro, tipo y la variable asignada de esta función
      request.input("Category", sql.NVarChar(50), category);
      request.input("DeliveryMethod", sql.NVarChar(50), deliveryMethod);
  
      //Poner el parámetro de salida
      request.output("Success", sql.SmallInt); //Nombre del parámetro y tipo
  
      //Ejecutar el procedimiento
      const result = await request.execute("SearchSuppliers");
  
      //Obtener el número que me indica si se hizo bien o con error
      const numero = result.output.Success;
      console.log("El resultado de la consulta es: ", numero);
      return {resultado: numero, filas: result.recordset};
      }catch (err) {  
        console.error("Error al ejecutar SearchSuppliers:", err);
        throw err;
      }
  }

  //Retorna el proveedor que coincida en la entrada
  async SP_SelectSpecificSupplierData(name){
    try{
      //Abrir el request
      const pool = await sql.connect(this._config);
      const request = pool.request();
  
      //Poner los parámetros de entrada
      request.input("SupplierName", sql.NVarChar(100), name); //Nombre del parámetro, tipo y la variable asignada de esta función
  
      //Poner el parámetro de salida
      request.output("Success", sql.SmallInt); //Nombre del parámetro y tipo
  
      //Ejecutar el procedimiento
      const result = await request.execute("SP_SelectSpecificSupplierData");
  
      //Obtener el número que me indica si se hizo bien o con error
      const numero = result.output.Success;
      console.log("El resultado de la consulta es: ", numero);
      return {resultado: numero, filas: result.recordset};
    }catch (err) {  
      console.error("Error al ejecutar SearchSuppliers:", err);
      throw err;
    }
  }

    async SP_AllSuppliersCategories() {
      try {
        const result = await sql.query`EXEC SP_AllSuppliersCategories`;
        return result.recordset;
      } catch (err) {
        console.error("Error al ejecutar SP_AllSuppliersCategories:", err);
        throw err;
      }
    }

}

module.exports = DBSuppliers;