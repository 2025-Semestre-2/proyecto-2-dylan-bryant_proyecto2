--Se seleccionan todos los id de clientes
USE Limon;
GO

CREATE VIEW ID_Clientes AS
SELECT cu.CustomerID AS CustomerID FROM Customers cu