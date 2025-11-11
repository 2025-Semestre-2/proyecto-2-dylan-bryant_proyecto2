USE WideWorldImporters;
GO

CREATE VIEW ItemsData AS 
SELECT si.StockItemName as StockItemName, sup.SupplierName as Supplier,
CASE WHEN col.ColorName IS NULL THEN 'Sin color.' ELSE col.ColorName END AS Color,
pac.PackageTypeName as UnitPackage, pac_2.PackageTypeName as OuterPackage,
CASE WHEN si.RecommendedRetailPrice IS NULL THEN 'Sin precio de venta' ELSE si.RecommendedRetailPrice END AS RecommendedRetailPrice,
si.TypicalWeightPerUnit as Weight, si.SearchDetails, si.QuantityPerOuter,
CASE WHEN si.Brand IS NULL THEN 'Sin marca.' ELSE si.Brand END AS Brand,
CASE WHEN si.Size IS NULL THEN 'Sin talla/tamaño.' ELSE si.Size END AS Size,
si.TaxRate as Tax, si.UnitPrice, sih.QuantityOnHand as Quantity, sih.BinLocation as Location
FROM StockItems si
JOIN Suppliers sup on si.SupplierID = sup.SupplierID
LEFT JOIN Colors col on si.ColorID = col.ColorID
LEFT JOIN StockItemHoldings sih on si.StockItemID  = sih.StockItemID
JOIN PackageTypes pac on si.UnitPackageID = pac.PackageTypeID
JOIN PackageTypes pac_2 on si.OuterPackageID = pac_2.PackageTypeID;

