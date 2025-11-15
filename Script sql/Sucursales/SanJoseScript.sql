create database SanJose

-- SCRIPT PARA Sanjose


use SanJose
go






ALTER TABLE Sales.Customers
ALTER COLUMN BillToCustomerID INT NULL;

ALTER TABLE Sales.Customers
ALTER COLUMN CustomerCategoryID INT NULL;

ALTER TABLE Sales.Customers
ALTER COLUMN DeliveryMethodID INT NULL;

ALTER TABLE Sales.Customers
ALTER COLUMN DeliveryCityID INT NULL;


ALTER TABLE Sales.Customers
ALTER COLUMN PostalCityID INT NULL;


ALTER TABLE Sales.Customers
ALTER COLUMN AccountOpenedDate date NULL;

ALTER TABLE Sales.Customers
ALTER COLUMN StandardDiscountPercentage decimal NULL;

ALTER TABLE Sales.Customers
ALTER COLUMN IsStatementSent int NULL;


ALTER TABLE Sales.Customers
ALTER COLUMN IsOnCreditHold int NULL;

ALTER TABLE Sales.Customers
ALTER COLUMN PaymentDays int NULL;

ALTER TABLE Sales.Customers
ALTER COLUMN PhoneNumber int NULL;

ALTER TABLE Sales.Customers
ALTER COLUMN WebsiteURL int NULL;

ALTER TABLE Sales.Customers
ALTER COLUMN DeliveryAddressLine1 int NULL;

ALTER TABLE Sales.Customers
ALTER COLUMN DeliveryPostalCode int NULL;

ALTER TABLE Sales.Customers
ALTER COLUMN PostalAddressLine1 int NULL;

ALTER TABLE Sales.Customers
ALTER COLUMN PostalPostalCode int NULL;

ALTER TABLE Sales.Customers
ALTER COLUMN LastEditedBy int NULL;




ALTER TABLE Application.People
DROP COLUMN SearchName;

ALTER TABLE Application.People
DROP COLUMN OtherLanguages;

ALTER TABLE Application.People
ADD SearchName AS (PreferredName + ' ' + FullName) PERSISTED;

ALTER TABLE Application.People
ADD OtherLanguages AS (JSON_QUERY(CustomFields, '$.OtherLanguages')) PERSISTED;


-- Primero a ejecutar
INSERT INTO Application.People(
    PersonID, FullName, PreferredName, IsPermittedToLogon, LogonName,
    IsExternalLogonProvider, HashedPassword, IsSystemUser, IsEmployee,
    IsSalesperson, UserPreferences, PhoneNumber, FaxNumber, EmailAddress,
    Photo, CustomFields, LastEditedBy, ValidFrom, ValidTo
)
SELECT 
    PersonID, FullName, PreferredName, IsPermittedToLogon, LogonName,
    IsExternalLogonProvider, HashedPassword, IsSystemUser, IsEmployee,
    IsSalesperson, UserPreferences, PhoneNumber, FaxNumber, EmailAddress,
    Photo, CustomFields, LastEditedBy, ValidFrom, ValidTo
FROM WideWorldImportersP.Application.People

insert into Application.TransactionTypes(
TransactionTypeID
      ,TransactionTypeName
      ,LastEditedBy
      ,ValidFrom
      ,ValidTo
) select 
TransactionTypeID
      ,TransactionTypeName
      ,LastEditedBy
      ,ValidFrom
      ,ValidTo
  FROM WideWorldImportersP.Application.TransactionTypes


insert into Sales.Customers(
CustomerID
      ,CustomerName
      ,PrimaryContactPersonID
      ,AlternateContactPersonID
	  ,FaxNumber


) select
CustomerID
      ,CustomerName
      ,PrimaryContactPersonID
      ,AlternateContactPersonID
	  ,FaxNumber
  FROM WideWorldImportersP.Sales.Customers




  insert into Application.Countries (
CountryID ,CountryName ,FormalName ,IsoAlpha3Code
,IsoNumericCode ,CountryType ,LatestRecordedPopulation
,Continent ,Region ,Subregion ,Border ,LastEditedBy
,ValidFrom ,ValidTo
) select 
	CountryID ,CountryName ,FormalName ,IsoAlpha3Code
	,IsoNumericCode ,CountryType ,LatestRecordedPopulation
	,Continent ,Region ,Subregion ,Border ,LastEditedBy
	,ValidFrom ,ValidTo from WideWorldImportersP.Application.Countries

  insert into Application.StateProvinces(
	StateProvinceID, StateProvinceCode ,StateProvinceName
	,CountryID ,SalesTerritory ,Border ,LatestRecordedPopulation
	,LastEditedBy ,ValidFrom ,ValidTo
	) 
select 
	StateProvinceID, StateProvinceCode ,StateProvinceName
	,CountryID ,SalesTerritory ,Border ,LatestRecordedPopulation
	,LastEditedBy ,ValidFrom ,ValidTo 

from WideWorldImportersP.Application.StateProvinces


insert into Application.Cities(
CityID,CityName,StateProvinceID,Location,LatestRecordedPopulation,
LastEditedBy,ValidFrom,ValidTo
) select
	CityID, CityName, StateProvinceID, Location,
	LatestRecordedPopulation, LastEditedBy,
	ValidFrom, ValidTo

FROM WideWorldImportersP.Application.Cities
 
 
insert into Application.DeliveryMethods(
DeliveryMethodID ,DeliveryMethodName
,LastEditedBy ,ValidFrom ,ValidTo
) select 
	DeliveryMethodID ,DeliveryMethodName
	,LastEditedBy ,ValidFrom ,ValidTo

from WideWorldImportersP.Application.DeliveryMethods




insert into Purchasing.SupplierCategories(
SupplierCategoryID
      ,SupplierCategoryName
      ,LastEditedBy
      ,ValidFrom
      ,ValidTo
)select 
SupplierCategoryID
      ,SupplierCategoryName
      ,LastEditedBy
      ,ValidFrom
      ,ValidTo
  FROM WideWorldImportersP.Purchasing.SupplierCategories






--- Hasta aquí tengo a mis proveedores

insert into Purchasing.Suppliers (
SupplierID
      ,SupplierName
      ,SupplierCategoryID
      ,PrimaryContactPersonID
      ,AlternateContactPersonID
      ,DeliveryMethodID
      ,DeliveryCityID
      ,PostalCityID
      ,SupplierReference
      ,BankAccountName
      ,BankAccountBranch
      ,BankAccountCode
      ,BankAccountNumber
      ,BankInternationalCode
      ,PaymentDays
      ,InternalComments
      ,PhoneNumber
      ,FaxNumber
      ,WebsiteURL
      ,DeliveryAddressLine1
      ,DeliveryAddressLine2
      ,DeliveryPostalCode
      ,DeliveryLocation
      ,PostalAddressLine1
      ,PostalAddressLine2
      ,PostalPostalCode
      ,LastEditedBy
      ,ValidFrom
      ,ValidTo
) select SupplierID
      ,SupplierName
      ,SupplierCategoryID
      ,PrimaryContactPersonID
      ,AlternateContactPersonID
      ,DeliveryMethodID
      ,DeliveryCityID
      ,PostalCityID
      ,SupplierReference
      ,BankAccountName
      ,BankAccountBranch
      ,BankAccountCode
      ,BankAccountNumber
      ,BankInternationalCode
      ,PaymentDays
      ,InternalComments
      ,PhoneNumber
      ,FaxNumber
      ,WebsiteURL
      ,DeliveryAddressLine1
      ,DeliveryAddressLine2
      ,DeliveryPostalCode
      ,DeliveryLocation
      ,PostalAddressLine1
      ,PostalAddressLine2
      ,PostalPostalCode
      ,LastEditedBy
      ,ValidFrom
      ,ValidTo
  FROM WideWorldImportersP.Purchasing.Suppliers




-- Productos





-- Necesario para  Warehouse.StockItems
insert into Warehouse.Colors( ColorID
      ,ColorName
      ,LastEditedBy
      ,ValidFrom
      ,ValidTo
) select
ColorID
      ,ColorName
      ,LastEditedBy
      ,ValidFrom
      ,ValidTo
  FROM WideWorldImportersP.Warehouse.Colors


-- Necesario para insert into Purchasing.PurchaseOrderLines y productos
insert into Warehouse.PackageTypes(
PackageTypeID
      ,PackageTypeName
      ,LastEditedBy
      ,ValidFrom
      ,ValidTo
) select 
PackageTypeID
      ,PackageTypeName
      ,LastEditedBy
      ,ValidFrom
      ,ValidTo
  FROM WideWorldImportersP.Warehouse.PackageTypes


insert into Warehouse.StockGroups(

StockGroupID
      ,StockGroupName
      ,LastEditedBy
      ,ValidFrom
      ,ValidTo
) select
		StockGroupID
		,StockGroupName
		,LastEditedBy
		,ValidFrom
		,ValidTo
  FROM WideWorldImportersP.Warehouse.StockGroups

-- Productos y es necesario para Purchasing.PurchaseOrderLines
insert into Warehouse.StockItems(
StockItemID
      ,StockItemName
      ,SupplierID
      ,ColorID
      ,UnitPackageID
      ,OuterPackageID
      ,Brand
      ,Size
      ,LeadTimeDays
      ,QuantityPerOuter
      ,IsChillerStock
      ,Barcode
      ,TaxRate
      ,UnitPrice
      ,RecommendedRetailPrice
      ,TypicalWeightPerUnit
      ,MarketingComments
      ,InternalComments
      ,Photo
      ,CustomFields
      ,LastEditedBy
      ,ValidFrom
      ,ValidTo
) select 
StockItemID
      ,StockItemName
      ,SupplierID
      ,ColorID
      ,UnitPackageID
      ,OuterPackageID
      ,Brand
      ,Size
      ,LeadTimeDays
      ,QuantityPerOuter
      ,IsChillerStock
      ,Barcode
      ,TaxRate
      ,UnitPrice
      ,RecommendedRetailPrice
      ,TypicalWeightPerUnit
      ,MarketingComments
      ,InternalComments
      ,Photo
      ,CustomFields
      ,LastEditedBy
      ,ValidFrom
      ,ValidTo
FROM WideWorldImportersP.Warehouse.StockItems


INSERT INTO Warehouse.StockItemHoldings(
    StockItemID,
    QuantityOnHand,
    BinLocation,
    LastStocktakeQuantity,
    LastCostPrice,
    ReorderLevel,
    TargetStockLevel,
    LastEditedBy,
    LastEditedWhen
)
SELECT TOP 65 PERCENT  
    StockItemID,
    QuantityOnHand,
    BinLocation,
    LastStocktakeQuantity,
    LastCostPrice,
    ReorderLevel,
    TargetStockLevel,
    LastEditedBy,
    LastEditedWhen
FROM WideWorldImportersP.Warehouse.StockItemHoldings
ORDER BY NEWID();






-- Aqui se insertan las ordenes que no tienen la dependencia de backorderID


-- Se sigue con la facturación aleatoria

USE SanJose;
GO

INSERT INTO Sales.Orders(
    OrderID,
    CustomerID,
    SalespersonPersonID,
    PickedByPersonID,
    ContactPersonID,
    BackorderOrderID,
    OrderDate,
    ExpectedDeliveryDate,
    CustomerPurchaseOrderNumber,
    IsUndersupplyBackordered,
    Comments,
    DeliveryInstructions,
    InternalComments,
    PickingCompletedWhen,
    LastEditedBy,
    LastEditedWhen
)
SELECT TOP 60 PERCENT
    o.OrderID,
    o.CustomerID,
    o.SalespersonPersonID,
    o.PickedByPersonID,
    o.ContactPersonID,
    NULL AS BackorderOrderID,
    o.OrderDate,
    o.ExpectedDeliveryDate,
    o.CustomerPurchaseOrderNumber,
    o.IsUndersupplyBackordered,
    o.Comments,
    o.DeliveryInstructions,
    o.InternalComments,
    o.PickingCompletedWhen,
    o.LastEditedBy,
    o.LastEditedWhen
FROM WideWorldImportersP.Sales.Orders o
WHERE o.CustomerID IN (SELECT CustomerID FROM SanJose.Sales.Customers)
  AND o.SalespersonPersonID IN (SELECT PersonID FROM SanJose.Application.People)
  AND o.PickedByPersonID IN (SELECT PersonID FROM SanJose.Application.People)
  AND o.ContactPersonID IN (SELECT PersonID FROM SanJose.Application.People)
  AND o.BackorderOrderID IS NULL
  AND o.OrderID NOT IN (SELECT OrderID FROM SanJose.Sales.Orders) -- <-- evita duplicados
ORDER BY NEWID();

SELECT COUNT(*)
FROM WideWorldImportersP.Sales.Orders o
WHERE o.BackorderOrderID IS NOT NULL
  AND o.BackorderOrderID IN (SELECT OrderID FROM SanJose.Sales.Orders);

INSERT INTO Sales.Orders(
    OrderID,
    CustomerID,
    SalespersonPersonID,
    PickedByPersonID,
    ContactPersonID,
    BackorderOrderID,
    OrderDate,
    ExpectedDeliveryDate,
    CustomerPurchaseOrderNumber,
    IsUndersupplyBackordered,
    Comments,
    DeliveryInstructions,
    InternalComments,
    PickingCompletedWhen,
    LastEditedBy,
    LastEditedWhen
)
SELECT
    o.OrderID,
    o.CustomerID,
    o.SalespersonPersonID,
    o.PickedByPersonID,
    o.ContactPersonID,
    o.BackorderOrderID,
    o.OrderDate,
    o.ExpectedDeliveryDate,
    o.CustomerPurchaseOrderNumber,
    o.IsUndersupplyBackordered,
    o.Comments,
    o.DeliveryInstructions,
    o.InternalComments,
    o.PickingCompletedWhen,
    o.LastEditedBy,
    o.LastEditedWhen
FROM WideWorldImportersP.Sales.Orders o
WHERE o.BackorderOrderID IS NOT NULL
  AND o.BackorderOrderID IN (SELECT OrderID FROM SanJose.Sales.Orders)
ORDER BY NEWID();  


--- Orders Lines después de orders siempre

INSERT INTO Sales.OrderLines(
    OrderLineID,
    OrderID,
    StockItemID,
    Description,
    PackageTypeID,
    Quantity,
    UnitPrice,
    TaxRate,
    PickedQuantity,
    PickingCompletedWhen,
    LastEditedBy,
    LastEditedWhen
)
SELECT 
    ol.OrderLineID,
    ol.OrderID,
    ol.StockItemID,
    ol.Description,
    ol.PackageTypeID,
    ol.Quantity,
    ol.UnitPrice,
    ol.TaxRate,
    ol.PickedQuantity,
    ol.PickingCompletedWhen,
    ol.LastEditedBy,
    ol.LastEditedWhen
FROM WideWorldImportersP.Sales.OrderLines ol
WHERE ol.OrderID IN (SELECT OrderID FROM SanJose.Sales.Orders)



INSERT INTO Sales.Invoices(
    InvoiceID,
    CustomerID,
    BillToCustomerID,
    OrderID,
    DeliveryMethodID,
    ContactPersonID,
    AccountsPersonID,
    SalespersonPersonID,
    PackedByPersonID,
    InvoiceDate,
    CustomerPurchaseOrderNumber,
    IsCreditNote,
    CreditNoteReason,
    Comments,
    DeliveryInstructions,
    InternalComments,
    TotalDryItems,
    TotalChillerItems,
    DeliveryRun,
    RunPosition,
    ReturnedDeliveryData,
    LastEditedBy,
    LastEditedWhen
)
SELECT 
    i.InvoiceID,
    i.CustomerID,
    i.BillToCustomerID,
    i.OrderID,
    i.DeliveryMethodID,
    i.ContactPersonID,
    i.AccountsPersonID,
    i.SalespersonPersonID,
    i.PackedByPersonID,
    i.InvoiceDate,
    i.CustomerPurchaseOrderNumber,
    i.IsCreditNote,
    i.CreditNoteReason,
    i.Comments,
    i.DeliveryInstructions,
    i.InternalComments,
    i.TotalDryItems,
    i.TotalChillerItems,
    i.DeliveryRun,
    i.RunPosition,
    i.ReturnedDeliveryData,
    i.LastEditedBy,
    i.LastEditedWhen
FROM WideWorldImportersP.Sales.Invoices i
WHERE i.CustomerID IN (SELECT CustomerID FROM SanJose.Sales.Customers)
  AND i.OrderID IN (SELECT OrderID FROM SanJose.Sales.Orders)



insert into Sales.InvoiceLines(
 InvoiceLineID
      ,InvoiceID
      ,StockItemID
      ,Description
      ,PackageTypeID
      ,Quantity
      ,UnitPrice
      ,TaxRate
      ,TaxAmount
      ,LineProfit
      ,ExtendedPrice
      ,LastEditedBy
      ,LastEditedWhen
) select 
 il.InvoiceLineID
      ,il.InvoiceID
      ,il.StockItemID
      ,il.Description
      ,il.PackageTypeID
      ,il.Quantity
      ,il.UnitPrice
      ,il.TaxRate
      ,il.TaxAmount
      ,il.LineProfit
      ,il.ExtendedPrice
      ,il.LastEditedBy
      ,il.LastEditedWhen
  FROM WideWorldImportersP.Sales.InvoiceLines il
  where il.InvoiceID in (select InvoiceID from SanJose.Sales.Invoices)
  and il.StockItemID in (select StockItemID from SanJose.Warehouse.StockItems)




insert into Warehouse.StockItemTransactions(StockItemTransactionID
      ,StockItemID
      ,TransactionTypeID
      ,CustomerID
      ,InvoiceID
      ,SupplierID
      ,PurchaseOrderID
      ,TransactionOccurredWhen
      ,Quantity
      ,LastEditedBy
      ,LastEditedWhen
) select 
sit.StockItemTransactionID
      ,sit.StockItemID
      ,sit.TransactionTypeID
      ,sit.CustomerID
      ,sit.InvoiceID
      ,sit.SupplierID
      ,sit.PurchaseOrderID
      ,sit.TransactionOccurredWhen
      ,sit.Quantity
      ,sit.LastEditedBy
      ,sit.LastEditedWhen
  FROM WideWorldImportersP.Warehouse.StockItemTransactions sit
  where sit.StockItemID in ( select StockItemID from SanJose.Warehouse.StockItems)
  and sit.CustomerID in ( select CustomerID from SanJose.Sales.Customers)
  and sit.InvoiceID in ( select InvoiceID from SanJose.Sales.Invoices)
  and (sit.PurchaseOrderID IS NULL OR sit.PurchaseOrderID IN (SELECT PurchaseOrderID FROM SanJose.Purchasing.PurchaseOrders))
  and (sit.SupplierID IS NULL OR sit.SupplierID IN (SELECT SupplierID FROM SanJose.Purchasing.Suppliers))


  ALTER TABLE Warehouse.StockItems DROP COLUMN Tags
GO

ALTER TABLE Warehouse.StockItems DROP COLUMN SearchDetails
GO



use SanJose
go


create table Roles(
	idRol int identity(1,1) primary key,
	rol varchar(30)
)

insert into Roles(rol) values ('Administrador'), ('Corporativo')


 create table usuarios(
  iduser int identity(1,1) primary key,
  username varchar(30) not null,
  password varbinary(256) not null,
  fullname varchar(90),
  active int default 1,
  idRol int,
  email varchar(200),
  hiredate date
  CONSTRAINT FK_UsuariosRoles FOREIGN KEY (idRol) REFERENCES Roles(idRol)
)
  

insert into Usuarios (Username, Password, FullName, idRol, Email, HireDate)
values (
    'Bunuelo',
    HASHBYTES('SHA2_256', 'luigi'),
    'Madremia',
    2,
    'PerroRabioso@hotmail.com',
    GETDATE()
),
(

    'Vegetta',
    HASHBYTES('SHA2_256', 'Puchonki'),
    'Cristiano ronadlo',
    1,
    'Roanldinno@gmail.com',
    GETDATE()
),
(
    'PedroPascal',
    HASHBYTES('SHA2_256', 'ananin'),
    'Saiyajin',
    1,
    'GokuYvegetta@outlook.com',
    GETDATE()
);
