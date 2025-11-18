EXEC sp_addlinkedserver 
   @server = 'LIMON_SERVER',  
   @srvproduct = '',                 
   @provider = 'SQLNCLI',           
   @datasrc = '86.48.22.228,1434';  

   EXEC sp_addlinkedsrvlogin 
   @rmtsrvname = 'LIMON_SERVER', 
   @useself = 'false',                 
   @locallogin = NULL,                 
   @rmtuser = 'sa',                    
   @rmtpassword = 'YourStrongPassw0rd2'; 

   EXEC sp_addlinkedserver 
   @server = 'SANJOSE_SERVER',  
   @srvproduct = '',                 
   @provider = 'SQLNCLI',           
   @datasrc = '86.48.22.228,1435';  

   EXEC sp_addlinkedsrvlogin 
   @rmtsrvname = 'SANJOSE_SERVER', 
   @useself = 'false',                 
   @locallogin = NULL,                 
   @rmtuser = 'sa',                    
   @rmtpassword = 'YourStrongPassw0rd3'; 



   


