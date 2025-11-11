USE WideWorldImporters;
GO

CREATE PROCEDURE SP_MinAndMaxDateInvoices AS
	SELECT [Min], [Max] FROM MinAndMaxDateInvoices;