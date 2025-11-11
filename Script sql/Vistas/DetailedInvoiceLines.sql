USE WideWorldImporters;
GO

CREATE VIEW DetailedInvoiceLines AS
SELECT il.InvoiceID ,si.StockItemName as ProductName, il.Quantity, 
CASE WHEN il.UnitPrice IS NULL THEN si.UnitPrice ELSE il.UnitPrice END AS UnitPrice,
il.TaxRate,
CASE WHEN il.UnitPrice IS NULL THEN ((il.taxRate/100) * si.UnitPrice ) ELSE ((il.taxRate/100) * il.UnitPrice ) END AS Tax,

( ((il.taxRate/100) * si.UnitPrice * il.Quantity) + (il.Quantity * il.UnitPrice)) as Total
FROM InvoiceLines il
JOIN StockItems si on il.StockItemID = si.StockItemID;

SELECT * FROM Sales.InvoiceLines