CREATE VIEW SegundaEstadistica AS
SELECT ISNULL(ac.Name, CASE WHEN ac.Category IS NULL THEN 'Total general.'ELSE 'Total Categoria'END) as Customer, 
ISNULL(ac.Category, CASE WHEN ac.Name IS NULL THEN 'Total Cliente.'ELSE ac.Category END)  as Category ,
CASE WHEN MAX(ai.Total) IS NULL THEN 0 ELSE MAX(ai.Total) END AS MaxAmount, 
CASE WHEN MIN(ai.Total) IS NULL THEN 0 ELSE MIN(ai.Total) END AS MinAmount, 
CASE WHEN AVG(ai.Total) IS NULL THEN 0 ELSE AVG(ai.Total) END AS AvgAmount
FROM AllCustomers ac
LEFT JOIN AllInvoices ai on ac.[Name] = ai.Customer
GROUP BY ROLLUP(ac.Category, ac.[Name])


CREATE VIEW AllInvoices AS
SELECT i.InvoiceID as ID, i.invoiceDate as Date, ac.Name as Customer, ac.DeliveryMethod as DeliveryMethod,  
SUM((il.UnitPrice * (il.TaxRate/100) * il.Quantity) + (il.Quantity * il.UnitPrice)) AS Total
FROM Invoices i
JOIN AllCustomers ac on i.CustomerID = ac.CustomerID
JOIN InvoiceLines il on i.InvoiceID = il.InvoiceID
GROUP BY i.InvoiceID, i.invoiceDate, ac.Name, ac.DeliveryMethod

