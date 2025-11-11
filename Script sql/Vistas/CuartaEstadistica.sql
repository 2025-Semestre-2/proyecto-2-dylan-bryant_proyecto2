USE WideWorldImporters;
GO

CREATE VIEW CuartaEstadistica AS
SELECT YEAR(i.InvoiceDate) as [Year], c.CustomerName, COUNT(ai.ID) TotalInvoices ,SUM(ai.Total) AS Total 
FROM Customers c
LEFT JOIN Invoices i on c.CustomerID = i.CustomerID
LEFT JOIN AllInvoices ai on i.InvoiceID = ai.ID
GROUP BY YEAR(i.InvoiceDate), c.CustomerName;