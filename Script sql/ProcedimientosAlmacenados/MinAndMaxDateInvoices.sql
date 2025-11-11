USE WideWorldImporters;
GO

CREATE VIEW MinAndMaxDateInvoices AS
SELECT MIN([Date]) AS [Min], MAX([Date]) AS [Max] FROM AllInvoices;