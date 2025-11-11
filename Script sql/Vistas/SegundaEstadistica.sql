USE WideWorldImporters;
GO

CREATE VIEW SegundaEstadistica AS
SELECT ISNULL(c.CustomerName, CASE WHEN ca.CustomerCategoryName IS NULL THEN 'Total general.'ELSE 'Total Categoría'END) as Customer, 
ISNULL(ca.CustomerCategoryName, CASE WHEN c.CustomerName IS NULL THEN 'Total Cliente.'ELSE ca.CustomerCategoryName END)  as Category ,
CASE WHEN MAX(ai.Total) IS NULL THEN 0 ELSE MAX(ai.Total) END AS MaxAmount, 
CASE WHEN MIN(ai.Total) IS NULL THEN 0 ELSE MIN(ai.Total) END AS MinAmount, 
CASE WHEN AVG(ai.Total) IS NULL THEN 0 ELSE AVG(ai.Total) END AS AvgAmount
FROM Customers c
JOIN CustomerCategories ca on c.CustomerCategoryID = ca.CustomerCategoryID
LEFT JOIN AllInvoices ai on c.CustomerName = ai.Customer
GROUP BY ROLLUP(ca.CustomerCategoryName, c.CustomerName)
