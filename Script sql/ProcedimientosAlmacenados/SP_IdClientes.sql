--Se seleccionan todos los id de los clientes
USE Limon;
GO

CREATE PROCEDURE SP_IdClientes AS
BEGIN
	SELECT CustomerID FROM Customers
END

