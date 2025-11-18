USE WideWorldImporters;
GO

CREATE VIEW CuartaEstadistica AS
SELECT YEAR(i.InvoiceDate) as [Year], ac.Name, COUNT(ai.ID) TotalInvoices ,SUM(ai.Total) AS Total 
FROM AllCustomers ac
LEFT JOIN Invoices i on ac.CustomerID = i.CustomerID
LEFT JOIN AllInvoices ai on i.InvoiceID = ai.ID
GROUP BY YEAR(i.InvoiceDate), ac.Name;