USE WideWorldImporters;
GO

CREATE VIEW AllInvoices AS
SELECT i.InvoiceID as ID, i.invoiceDate as Date, c.CustomerName as Customer, dm.DeliveryMethodName as DeliveryMethod,  
SUM((il.UnitPrice * (il.TaxRate/100) * il.Quantity) + (il.Quantity * il.UnitPrice)) AS Total
FROM Invoices i
JOIN Customers c on i.CustomerID = c.CustomerID
JOIN DeliveryMethods dm on i.DeliveryMethodID = dm.DeliveryMethodID
JOIN InvoiceLines il on i.InvoiceID = il.InvoiceID
GROUP BY i.InvoiceID, i.invoiceDate, c.CustomerName, dm.DeliveryMethodName



