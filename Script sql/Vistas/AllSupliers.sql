USE WideWorldImporters;
GO
CREATE VIEW AllSuppliers AS
SELECT s.SupplierName as SupplierName, sc.SupplierCategoryName as SupplierCategory, 
CASE WHEN s.DeliveryMethodID IS NULL THEN 'Sin método.' ELSE de.DeliveryMethodName END AS DeliveryMethod
FROM Suppliers s
JOIN SupplierCategories sc on s.SupplierCategoryID = sc.SupplierCategoryID
LEFT JOIN DeliveryMethods de on s.DeliveryMethodID = de.DeliveryMethodID;