[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/W-fCBWVl)


# Objetivos
SQL Sever
    
    Replicación: No, se intentó de multiples formas y se había logrado pero al intentar hacer una modificación se cayó la replicación y no la pudimos volver a poner a funcionar. La replicación estaba con las bases de datos entre distintos servidores
    Fragmentación: Sí, se eliminaron los datos sensibles del cliente de las sucursales y se dejaron unicamente en el corporativo. En el corporativo se dejó solo lo relacionado a los clientes y sus tablas que eran llaves foráneas de clientes
    Vistas materializadas: Se tomaron vistas del proyecto 1 y algunas consultas tuvieron que modificarse para los clientes para utilizar linked server y que se tomaran los datos de el corporativo y se mezclaran con los de la sucursal
    Concurrencia: No se manejó porque estaba con la replicación
    Encriptación: Sí, se utilizó el SHA256

Sistema WEB
    Funcionalidad: Se logró adaptar la funcionalidad del proyecto 1 a las bases distribuidas. No se lograron poner las estadísticas ni el CRUD para los productos a pesar de que si se cuentan con procedimientos almacenados para esto. Se agregó el inicio de sesión con el selector para la sucursal
    Diseño UI y funcionalidad: Se mantuvo la del primer proyecto
    API: Para todo menos las estadísticas se logró adaptar el api del proyecto 1 para que tomara en cuenta la sucursal hasta la que se dirige la petición para manejar este factor.

