USE WideWorldImporters;
GO

CREATE PROCEDURE SP_AllCustomers 
AS
	SELECT Name, Category, DeliveryMethod FROM AllCustomers
	ORDER BY Name ASC;
GO
