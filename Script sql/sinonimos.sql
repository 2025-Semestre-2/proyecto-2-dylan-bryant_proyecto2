USE WideWorldImporters;
GO

-- Todos los sinónimos
CREATE SYNONYM Customers FOR Sales.Customers;
CREATE SYNONYM CustomerCategories FOR Sales.CustomerCategories;
CREATE SYNONYM DeliveryMethods FOR Application.DeliveryMethods;
CREATE SYNONYM People FOR Application.People;
CREATE SYNONYM Cities FOR Application.Cities;
CREATE SYNONYM BuyingGroups FOR Sales.BuyingGroups;
CREATE SYNONYM SupplierCategories FOR Purchasing.SupplierCategories;
CREATE SYNONYM Suppliers FOR Purchasing.Suppliers;
CREATE SYNONYM StockItems FOR Warehouse.StockItems;
CREATE SYNONYM StockItemStockGroups FOR Warehouse.StockItemStockGroups;
CREATE SYNONYM StockGroups FOR Warehouse.StockGroups;
CREATE SYNONYM StockItemHoldings FOR Warehouse.StockItemHoldings;
CREATE SYNONYM Colors FOR Warehouse.Colors;
CREATE SYNONYM PackageTypes FOR Warehouse.PackageTypes;
CREATE SYNONYM Invoices FOR Sales.Invoices;
CREATE SYNONYM InvoiceLines FOR Sales.InvoiceLines;
CREATE SYNONYM SupplierTransactions FOR Purchasing.SupplierTransactions;
CREATE SYNONYM PurchaseOrders FOR Purchasing.PurchaseOrders;
CREATE SYNONYM PurchaseOrderLines FOR Purchasing.PurchaseOrderLines;
GO


