USE WideWorldImporters;
GO

CREATE VIEW QuintaEstadistica AS
SELECT YEAR(po.OrderDate) as [Year], s.SupplierName as Supplier, COUNT(v.PurchaseOrderID) AS TotalOrdenes ,SUM(v.TotalOrder) AS TotalEnOrdenes
FROM Suppliers s
JOIN PurchaseOrders po on po.SupplierID = s.SupplierID
JOIN SumaDeCadaOrdenPorProveedor v on po.PurchaseOrderID = v.PurchaseOrderID
GROUP BY YEAR(po.OrderDate),s.SupplierName;

