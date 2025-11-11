USE WideWorldImporters;
GO

CREATE VIEW MinAndMaxTotalInvoices AS
SELECT MIN(Total) AS [Min], MAX(Total) AS [Max] FROM AllInvoices;