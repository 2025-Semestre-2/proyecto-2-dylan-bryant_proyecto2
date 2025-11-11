select * from Purchasing.SupplierTransactions

CREATE VIEW SumaDeCadaOrdenPorProveedor AS
SELECT po.PurchaseOrderID, s.SupplierID AS Supplier, SUM(pol.ReceivedOuters * pol.ExpectedUnitPricePerOuter) as TotalOrder
FROM Suppliers s
LEFT JOIN PurchaseOrders po on s.SupplierID = po.SupplierID
LEFT JOIN PurchaseOrderLines pol on po.PurchaseOrderID = pol.PurchaseOrderID
GROUP BY po.PurchaseOrderID, s.SupplierID;




CREATE VIEW EstadisticaMaxMinAvgComprasProveedores AS
SELECT ISNULL(s.SupplierName, 'Total Categoría') as Supplier, 
ISNULL(sc.SupplierCategoryName, CASE WHEN s.SupplierName = 'Total Categoría' THEN 'Total general.' ELSE 'Total proveedor.'END)  as Category ,
CASE WHEN MAX(st.TotalOrder) IS NULL THEN 0 ELSE MAX(st.TotalOrder) END AS MaxAmount, 
CASE WHEN MIN(st.TotalOrder) IS NULL THEN 0 ELSE MIN(st.TotalOrder) END AS MinAmount, 
CASE WHEN AVG(st.TotalOrder) IS NULL THEN 0 ELSE AVG(st.TotalOrder) END AS AvgAmount
FROM Suppliers s
LEFT JOIN SumaDeCadaOrdenPorProveedor st on s.SupplierID = st.Supplier
JOIN SupplierCategories sc on s.SupplierCategoryID = sc.SupplierCategoryID
GROUP BY ROLLUP(sc.SupplierCategoryName, s.SupplierName);


