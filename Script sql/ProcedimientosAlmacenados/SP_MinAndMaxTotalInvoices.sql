USE WideWorldImporters;
GO

CREATE PROCEDURE SP_MinAndMaxTotalInvoices AS
	SELECT [Min], [Max] FROM MinAndMaxTotalInvoices;