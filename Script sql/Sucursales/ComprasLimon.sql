
--Inserts para compras en Limón

INSERT INTO Limon.Purchasing.PurchaseOrders (PurchaseOrderID, SupplierID, OrderDate,DeliveryMethodID, ContactPersonID, ExpectedDeliveryDate, SupplierReference,
IsOrderFinalized, Comments, InternalComments, LastEditedBy, LastEditedWhen)
SELECT PurchaseOrderID, SupplierID, OrderDate, DeliveryMethodID, ContactPersonID, ExpectedDeliveryDate, SupplierReference,
IsOrderFinalized, Comments, InternalComments, LastEditedBy, LastEditedWhen FROM WideWorldImportersP.Purchasing.PurchaseOrders 
where PurchaseOrderID between 1 and 1037

INSERT INTO Limon.Purchasing.PurchaseOrderLines (PurchaseOrderLineID, PurchaseOrderID, StockItemID, OrderedOuters, [Description], ReceivedOuters, PackageTypeID,
ExpectedUnitPricePerOuter, LastReceiptDate, IsOrderLineFinalized, LastEditedBy, LastEditedWhen)
SELECT PurchaseOrderLineID, PurchaseOrderID, StockItemID, OrderedOuters, [Description], ReceivedOuters, PackageTypeID,
ExpectedUnitPricePerOuter, LastReceiptDate, IsOrderLineFinalized, LastEditedBy, LastEditedWhen FROM WideWorldImportersP.Purchasing.PurchaseOrderLines
where PurchaseOrderID between 1 and 1037