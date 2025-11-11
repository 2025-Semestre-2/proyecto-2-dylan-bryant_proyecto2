USE WideWorldImporters;
GO

CREATE PROCEDURE SP_AllInvoices AS
BEGIN
	SELECT ID, [Date], Customer, DeliveryMethod, Total FROM AllInvoices
	ORDER BY Customer;
END

