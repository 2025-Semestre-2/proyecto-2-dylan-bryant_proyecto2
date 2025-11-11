USE WideWorldImporters;
GO
CREATE PROCEDURE SP_AllSuppliers 
AS
	SELECT SupplierName, SupplierCategory, DeliveryMethod FROM AllSuppliers
	ORDER BY SupplierName ASC;
GO


