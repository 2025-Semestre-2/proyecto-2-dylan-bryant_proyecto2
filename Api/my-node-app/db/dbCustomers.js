const sql = require("mssql");

class DBCustomers {
  static #_instance = null;

  constructor() {
    if (DBCustomers.#_instance) {
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

    DBCustomers.#_instance = this;
  }

  static getInstance() {
    if (!DBCustomers.#_instance) {
      DBCustomers.#_instance = new DBCustomers();
    }
    return DBCustomers.#_instance;
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

  //Tengo que combinar los datos de los id de la base de esta sucursal y los que contienen el resto de los datos en el corporativo
  async SP_AllCustomers(sucursal) {
    try {

      const configuracionCorporativo = this.verificarSucursal(sucursal);
      const poolCorp = new sql.ConnectionPool(configuracionCorporativo);
      await poolCorp.connect();
      const resultadosCorporativo = await poolCorp.request().execute("SP_AllCustomers");
      await poolCorp.close();

      return resultadosCorporativo.recordset;


    } catch (err) {
      console.error("Error al ejecutar ST_AllCustomers:", err);
      throw err;
    }
  }



  //Retorna todos los datos de un cliente específico
  async SP_SelectSpecificCustomerData(name, sucursal) {
    try{
      //Abrir el request con la configuración
     const configuracionCorporativo = this.verificarSucursal(sucursal);
      const poolCorporativo = new sql.ConnectionPool(configuracionCorporativo);
      await poolCorporativo.connect();
      const request = poolCorporativo.request();


      //Poner los parámetros de entrada
      request.input("CustomerName", sql.NVarChar(100), name); //Nombre del parámetro, tipo y la variable asignada de esta función

      //Poner el parámetro de salida
      request.output("Success", sql.SmallInt); //Nombre del parámetro y tipo

      //Ejecutar el procedimiento
      const result = await request.execute("SP_SelectSpecificCustomerData");
      await poolCorporativo.close();
      //Obtener el número que me indica si se hizo bien o con error
      const numero = result.output.Success;
      console.log("El resultado de la consulta es: ", numero);
      return {resultado: numero, filas: result.recordset};
    }catch (err) {  
      console.error("Error al ejecutar SP_SelectSpecificCustomerData:", err);
      throw err;
    }
  }

  //Retorna los clientes que coincidan
  async SearchCustomers(name, category, deliveryMethod, sucursal){
     try{
      //Hacer la búsqueda
      const configuracionCorporativo = this.verificarSucursal(sucursal);
      const poolCorporativo = new sql.ConnectionPool(configuracionCorporativo);
      await poolCorporativo.connect();
      const request = poolCorporativo.request();

      //Poner los parámetros de entrada
      request.input("CustomerName", sql.NVarChar(100), name); //Nombre del parámetro, tipo y la variable asignada de esta función
      request.input("Category", sql.NVarChar(50), category);
      request.input("DeliveryMethod", sql.NVarChar(50), deliveryMethod);

      //Poner el parámetro de salida
      request.output("Success", sql.SmallInt); //Nombre del parámetro y tipo

      //Ejecutar el procedimiento
      const result = await request.execute("SearchCustomers");
      await poolCorporativo.close();
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
      const configuracionCorporativo = this.verificarSucursal("Corporativo");
      const poolCorp = new sql.ConnectionPool(configuracionCorporativo);
      await poolCorp.connect();
      const resultadosCorporativo = await poolCorp.request().execute("SP_AllCustomerCategories");
      await poolCorp.close();

      return resultadosCorporativo.recordset;

    } catch (err) {
      console.error("Error al ejecutar SP_AllCustomerCategories:", err);
      throw err;
    }
  }

  //Retorna todos los posibles métodos de entrega 
  async SP_All_DeliveryMethods(){
    try {

      const configuracionCorporativo = this.verificarSucursal("Corporativo");
      const poolCorp = new sql.ConnectionPool(configuracionCorporativo);
      await poolCorp.connect();
      const resultadosCorporativo = await poolCorp.request().execute("SP_All_DeliveryMethods");
      await poolCorp.close();

      return resultadosCorporativo.recordset;

    } catch (err) {
      console.error("Error al ejecutar SP_All_DeliveryMethods:", err);
      throw err;
    }
  }
}

module.exports = DBCustomers;
