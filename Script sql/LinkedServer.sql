EXEC sp_addlinkedserver 
   @server = 'CORPORATIVO_SERVER',  
   @srvproduct = '',                 
   @provider = 'SQLNCLI',           
   @datasrc = '86.48.22.228,1433';  

   EXEC sp_addlinkedsrvlogin 
   @rmtsrvname = 'CORPORATIVO_SERVER', 
   @useself = 'false',                 
   @locallogin = NULL,                 
   @rmtuser = 'sa',                    
   @rmtpassword = 'YourStrong!Passw0rd'; 


SELECT TOP 10 * 
FROM CORPORATIVO_SERVER.Corporativo.dbo.AllCustomers;

