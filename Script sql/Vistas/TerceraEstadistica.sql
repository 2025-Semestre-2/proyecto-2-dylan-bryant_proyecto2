USE WideWorldImporters;
go

CREATE VIEW TerceraEstadistica AS
SELECT YEAR(i.InvoiceDate) as [Year], dil.ProductName as [Product], SUM(dil.Total) AS SumaTotalVentas
FROM DetailedInvoiceLines dil
JOIN Invoices i on dil.InvoiceID = i.InvoiceID
JOIN InvoiceLines il on i.InvoiceID = il.InvoiceID
GROUP BY dil.ProductName, YEAR(i.InvoiceDate);
