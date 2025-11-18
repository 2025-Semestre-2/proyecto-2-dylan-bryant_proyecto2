const sql = require("mssql");

class DBSuppliers{
    static #_instance = null; // Se utiliza el patrón singleton para un mejor diseño

    constructor() {
    if (DBSuppliers.#_instance) {
      throw new Error("No se puede instanciar más de una vez");
    }

  
    // Lista con todas las configuraciones
     this.listaConfiguraciones = [
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


    DBSuppliers.#_instance = this;

    
   
  }
  
  
  //Para obtener la instancia
  static getInstance() {
    if (!DBSuppliers.#_instance) {
      DBSuppliers.#_instance = new DBSuppliers();
    }
    return DBSuppliers.#_instance;
  }
  


  //Se verifica que la sucursal que envía exista y retorna la conexión
  verificarSucursal(pSucursal){
    for(let i = 0; i < this.listaConfiguraciones.length; i++){
      if(this.listaConfiguraciones[i].database === pSucursal){
        return this.listaConfiguraciones[i]
      }
    }
    throw new Error(`La sucursal "${pSucursal}" no existe`);
  }

  //Aquí ya ejecuto todos los procedimientos
  //Retorna a todos los proveedores
  async SP_AllSupliers(sucursal){
     try {

      const configuracion = this.verificarSucursal(sucursal)

      console.log("Desde la sucursal: " + sucursal)
      const pool = await sql.connect(configuracion);
      const request = pool.request();

      const result = await request.execute("SP_AllSuppliers");
      return result.recordset;

      } catch (err) {
        console.error("Error al ejecutar SP_AllSuppliers:", err);
        throw err;
      }
  }

  //Retorna a los proveedores que sus datos coincidan con las entradas
  async SearchSuppliers(name, category, deliveryMethod, sucursal){
    try{
      //Abrir el request
      const configuracion = this.verificarSucursal(sucursal)
      const pool = await sql.connect(configuracion);
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
  async SP_SelectSpecificSupplierData(name, sucursal){
    try{
      //Abrir el request
      const configuracion = this.verificarSucursal(sucursal)
      const pool = await sql.connect(configuracion);
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
      console.error("Error al ejecutar SP_SelectSpecificSupplierData:", err);
      throw err;
    }
  }

    async SP_AllSuppliersCategories(sucursal) {
      try {

        const configuracion = this.verificarSucursal(sucursal)
        const pool = await sql.connect(configuracion);
        const request = pool.request();
        const result = await request.execute("SP_AllSuppliersCategories");
        return result.recordset;

      } catch (err) {
        console.error("Error al ejecutar SP_AllSuppliersCategories:", err);
        throw err;
      }
    }

}

module.exports = DBSuppliers;