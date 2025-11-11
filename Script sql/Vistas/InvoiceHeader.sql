USE WideWorldImporters;
GO

CREATE VIEW InvoiceHeader AS
SELECT i.InvoiceID as ID, c.CustomerName as Customer, dm.DeliveryMethodName as DeliveryMethod, 
CASE WHEN i.CustomerPurchaseOrderNumber IS NULL THEN 'Sin número de orden.' ELSE i.CustomerPurchaseOrderNumber END AS PurcharseOrderNumber,
pe.FullName as ContactPerson, pe_2.FullName as SalesPerson, i.InvoiceDate, 
CASE WHEN i.DeliveryInstructions IS NULL THEN 'Sin instrucciones de entrega.' ELSE i.DeliveryInstructions END AS DeliveryInstructions
FROM Invoices i
JOIN Customers c on i.CustomerID = c.CustomerID
JOIN DeliveryMethods dm on i.DeliveryMethodID = dm.DeliveryMethodID
JOIN People pe on i.ContactPersonID = pe.PersonID
JOIN People pe_2 on i.SalesPersonPersonID = pe_2.PersonID;