use WideWorldImportersP
go

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
FROM WideWorldImporters.Application.People



-- Segundo a ejecutar
insert into Application.Countries (
CountryID ,CountryName ,FormalName ,IsoAlpha3Code
,IsoNumericCode ,CountryType ,LatestRecordedPopulation
,Continent ,Region ,Subregion ,Border ,LastEditedBy
,ValidFrom ,ValidTo
) select 
	CountryID ,CountryName ,FormalName ,IsoAlpha3Code
	,IsoNumericCode ,CountryType ,LatestRecordedPopulation
	,Continent ,Region ,Subregion ,Border ,LastEditedBy
	,ValidFrom ,ValidTo from WideWorldImporters.Application.Countries



--Tercero a ejecutar
insert into Application.StateProvinces(
	StateProvinceID, StateProvinceCode ,StateProvinceName
	,CountryID ,SalesTerritory ,Border ,LatestRecordedPopulation
	,LastEditedBy ,ValidFrom ,ValidTo
	) 
select 
	StateProvinceID, StateProvinceCode ,StateProvinceName
	,CountryID ,SalesTerritory ,Border ,LatestRecordedPopulation
	,LastEditedBy ,ValidFrom ,ValidTo 

from WideWorldImporters.Application.StateProvinces



--Cuarto a ejecutar
insert into Application.Cities(
CityID,CityName,StateProvinceID,Location,LatestRecordedPopulation,
LastEditedBy,ValidFrom,ValidTo
) select
	CityID, CityName, StateProvinceID, Location,
	LatestRecordedPopulation, LastEditedBy,
	ValidFrom, ValidTo

FROM WideWorldImporters.Application.Cities


--Quinto a ejecutar

insert into Application.DeliveryMethods(
DeliveryMethodID ,DeliveryMethodName
,LastEditedBy ,ValidFrom ,ValidTo
) select 
	DeliveryMethodID ,DeliveryMethodName
	,LastEditedBy ,ValidFrom ,ValidTo

from WideWorldImporters.Application.DeliveryMethods


-- Sexto a ejecutar


insert into Application.PaymentMethods(
	PaymentMethodID ,PaymentMethodName
	,LastEditedBy ,ValidFrom ,ValidTo
)select
	PaymentMethodID ,PaymentMethodName
	,LastEditedBy ,ValidFrom ,ValidTo

 FROM WideWorldImporters.Application.PaymentMethods


 -- Septimo a ejecutar
 insert into Application.SystemParameters(

 SystemParameterID
      ,DeliveryAddressLine1
      ,DeliveryAddressLine2
      ,DeliveryCityID
      ,DeliveryPostalCode
      ,DeliveryLocation
      ,PostalAddressLine1
      ,PostalAddressLine2
      ,PostalCityID
      ,PostalPostalCode
      ,ApplicationSettings
      ,LastEditedBy
      ,LastEditedWhen
) select 
 SystemParameterID
      ,DeliveryAddressLine1
      ,DeliveryAddressLine2
      ,DeliveryCityID
      ,DeliveryPostalCode
      ,DeliveryLocation
      ,PostalAddressLine1
      ,PostalAddressLine2
      ,PostalCityID
      ,PostalPostalCode
      ,ApplicationSettings
      ,LastEditedBy
      ,LastEditedWhen
  FROM WideWorldImporters.Application.SystemParameters



-- Octavo a ejecutar

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
  FROM WideWorldImporters.Application.TransactionTypes



-- Hasta aqui llegue con application


-- EMPIEZA WAREHOUSE

-- Noveno a ejecutar

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
  FROM WideWorldImporters.Warehouse.StockGroups


-- decimo a ejecutar

INSERT INTO Warehouse.ColdRoomTemperatures
(ColdRoomSensorNumber, RecordedWhen, Temperature)
VALUES
( 1, '2016-05-31 23:59:24.0000000', 3.72),
( 2, '2016-05-31 23:59:24.0000000', 4.70),
( 3, '2016-05-31 23:59:24.0000000', 3.00),
( 4, '2016-05-31 23:59:24.0000000', 3.58);





-- undecimo a ejecutar
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
  FROM WideWorldImporters.Warehouse.Colors



---- duodecimo a ejecutar
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
  FROM WideWorldImporters.Warehouse.PackageTypes


-- Trigesimo a ejecutar

use WideWorldImporters
go
CREATE TABLE Warehouse.VehicleTemperaturesaaa
(
    VehicleTemperatureID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    VehicleRegistration NVARCHAR(40) NOT NULL,
    ChillerSensorNumber INT NOT NULL,
    RecordedWhen DATETIME2(7) NOT NULL,
    Temperature DECIMAL(10,2) NOT NULL,
    FullSensorData NVARCHAR(2000) NULL,
    IsCompressed BIT NOT NULL,
    CompressedSensorData VARBINARY(MAX) NULL
);

SET IDENTITY_INSERT Warehouse.VehicleTemperaturesaaa ON;

INSERT INTO Warehouse.VehicleTemperaturesaaa
(VehicleRegistration, ChillerSensorNumber, RecordedWhen,
 Temperature, FullSensorData, IsCompressed, CompressedSensorData)
SELECT
    VehicleRegistration, ChillerSensorNumber, RecordedWhen,
    Temperature, FullSensorData, IsCompressed, CompressedSensorData
FROM WideWorldImporters.Warehouse.VehicleTemperatures;

SET IDENTITY_INSERT Warehouse.VehicleTemperaturesaaa OFF;


USE WideWorldImportersP 
go
insert into Warehouse.VehicleTemperatures
(VehicleTemperatureID,VehicleRegistration, ChillerSensorNumber, RecordedWhen,
 Temperature, FullSensorData, IsCompressed, CompressedSensorData)
SELECT
    VehicleTemperatureID, VehicleRegistration, ChillerSensorNumber, RecordedWhen,
    Temperature, FullSensorData, IsCompressed, CompressedSensorData
FROM WideWorldImporters.Warehouse.VehicleTemperaturesaaa;


---- 14 a ejecutar


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
  FROM WideWorldImporters.Purchasing.SupplierCategories


--- 15 a ejecutar

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
  FROM WideWorldImporters.Purchasing.Suppliers




-- 16 a ejecutar

use WideWorldImportersP
go

ALTER TABLE Warehouse.StockItems DROP COLUMN Tags, SearchDetails;

ALTER TABLE Warehouse.StockItems
ADD Tags AS (JSON_QUERY(CustomFields, N'$.Tags')) PERSISTED;

ALTER TABLE Warehouse.StockItems
ADD SearchDetails AS (CONCAT(StockItemName, N' ', MarketingComments)) PERSISTED;



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
FROM WideWorldImporters.Warehouse.StockItems


-- 17 a ejecutar

insert into Warehouse.StockItemStockGroups(
StockItemStockGroupID
      ,StockItemID
      ,StockGroupID
      ,LastEditedBy
      ,LastEditedWhen

) select
	StockItemStockGroupID
      ,StockItemID
      ,StockGroupID
      ,LastEditedBy
      ,LastEditedWhen

 FROM WideWorldImporters.Warehouse.StockItemStockGroups


 -- 18 a ejecutar 

insert into Warehouse.StockItemHoldings(
  StockItemID
      ,QuantityOnHand
      ,BinLocation
      ,LastStocktakeQuantity
      ,LastCostPrice
      ,ReorderLevel
      ,TargetStockLevel
      ,LastEditedBy
      ,LastEditedWhen
) select 
  StockItemID
      ,QuantityOnHand
      ,BinLocation
      ,LastStocktakeQuantity
      ,LastCostPrice
      ,ReorderLevel
      ,TargetStockLevel
      ,LastEditedBy
      ,LastEditedWhen
  FROM WideWorldImporters.Warehouse.StockItemHoldings


-- 19 a ejecutar

insert into Purchasing.PurchaseOrders(
PurchaseOrderID
      ,SupplierID
      ,OrderDate
      ,DeliveryMethodID
      ,ContactPersonID
      ,ExpectedDeliveryDate
      ,SupplierReference
      ,IsOrderFinalized
      ,Comments
      ,InternalComments
      ,LastEditedBy
      ,LastEditedWhen
) select 
PurchaseOrderID
      ,SupplierID
      ,OrderDate
      ,DeliveryMethodID
      ,ContactPersonID
      ,ExpectedDeliveryDate
      ,SupplierReference
      ,IsOrderFinalized
      ,Comments
      ,InternalComments
      ,LastEditedBy
      ,LastEditedWhen
  FROM WideWorldImporters.Purchasing.PurchaseOrders

-- 20 a ejecutar
insert into Purchasing.PurchaseOrderLines (
PurchaseOrderLineID
      ,PurchaseOrderID
      ,StockItemID
      ,OrderedOuters
      ,Description
      ,ReceivedOuters
      ,PackageTypeID
      ,ExpectedUnitPricePerOuter
      ,LastReceiptDate
      ,IsOrderLineFinalized
      ,LastEditedBy
      ,LastEditedWhen
) select
PurchaseOrderLineID
      ,PurchaseOrderID
      ,StockItemID
      ,OrderedOuters
      ,Description
      ,ReceivedOuters
      ,PackageTypeID
      ,ExpectedUnitPricePerOuter
      ,LastReceiptDate
      ,IsOrderLineFinalized
      ,LastEditedBy
      ,LastEditedWhen
  FROM WideWorldImporters.Purchasing.PurchaseOrderLines





-- 21 a ejecutar

USE WideWorldImportersP;
GO

-- Si ya existe, primero eliminarla
ALTER TABLE Purchasing.SupplierTransactions
DROP COLUMN IsFinalized;
GO

-- Volver a crearla como columna computada
ALTER TABLE Purchasing.SupplierTransactions
ADD IsFinalized AS (
    CASE 
        WHEN FinalizationDate IS NOT NULL THEN 1 
        ELSE 0 
    END
) PERSISTED;
GO

insert into Purchasing.SupplierTransactions(
SupplierTransactionID
      ,SupplierID
      ,TransactionTypeID
      ,PurchaseOrderID
      ,PaymentMethodID
      ,SupplierInvoiceNumber
      ,TransactionDate
      ,AmountExcludingTax
      ,TaxAmount
      ,TransactionAmount
      ,OutstandingBalance
      ,FinalizationDate
      ,LastEditedBy
      ,LastEditedWhen
) select 
SupplierTransactionID
      ,SupplierID
      ,TransactionTypeID
      ,PurchaseOrderID
      ,PaymentMethodID
      ,SupplierInvoiceNumber
      ,TransactionDate
      ,AmountExcludingTax
      ,TaxAmount
      ,TransactionAmount
      ,OutstandingBalance
      ,FinalizationDate
      ,LastEditedBy
      ,LastEditedWhen
  FROM WideWorldImporters.Purchasing.SupplierTransactions


-- Ya aqui estan todos los purchasing 




--22 a ejecutar
insert into Sales.CustomerCategories(
CustomerCategoryID
      ,CustomerCategoryName
      ,LastEditedBy
      ,ValidFrom
      ,ValidTo
)select 
CustomerCategoryID
      ,CustomerCategoryName
      ,LastEditedBy
      ,ValidFrom
      ,ValidTo
  FROM WideWorldImporters.Sales.CustomerCategories


-- 23 a ejecutar
insert into Sales.BuyingGroups(
BuyingGroupID
      ,BuyingGroupName
      ,LastEditedBy
      ,ValidFrom
      ,ValidTo
) select
BuyingGroupID
      ,BuyingGroupName
      ,LastEditedBy
      ,ValidFrom
      ,ValidTo
  FROM WideWorldImporters.Sales.BuyingGroups


-- 24 a ejecutar

insert into Sales.Customers(
CustomerID
      ,CustomerName
      ,BillToCustomerID
      ,CustomerCategoryID
      ,BuyingGroupID
      ,PrimaryContactPersonID
      ,AlternateContactPersonID
      ,DeliveryMethodID
      ,DeliveryCityID
      ,PostalCityID
      ,CreditLimit
      ,AccountOpenedDate
      ,StandardDiscountPercentage
      ,IsStatementSent
      ,IsOnCreditHold
      ,PaymentDays
      ,PhoneNumber
      ,FaxNumber
      ,DeliveryRun
      ,RunPosition
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
) select
CustomerID
      ,CustomerName
      ,BillToCustomerID
      ,CustomerCategoryID
      ,BuyingGroupID
      ,PrimaryContactPersonID
      ,AlternateContactPersonID
      ,DeliveryMethodID
      ,DeliveryCityID
      ,PostalCityID
      ,CreditLimit
      ,AccountOpenedDate
      ,StandardDiscountPercentage
      ,IsStatementSent
      ,IsOnCreditHold
      ,PaymentDays
      ,PhoneNumber
      ,FaxNumber
      ,DeliveryRun
      ,RunPosition
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
  FROM WideWorldImporters.Sales.Customers

-- 25 a ejecutar
insert into Sales.Orders(
OrderID
      ,CustomerID
      ,SalespersonPersonID
      ,PickedByPersonID
      ,ContactPersonID
      ,BackorderOrderID
      ,OrderDate
      ,ExpectedDeliveryDate
      ,CustomerPurchaseOrderNumber
      ,IsUndersupplyBackordered
      ,Comments
      ,DeliveryInstructions
      ,InternalComments
      ,PickingCompletedWhen
      ,LastEditedBy
      ,LastEditedWhen
)select 
OrderID
      ,CustomerID
      ,SalespersonPersonID
      ,PickedByPersonID
      ,ContactPersonID
      ,BackorderOrderID
      ,OrderDate
      ,ExpectedDeliveryDate
      ,CustomerPurchaseOrderNumber
      ,IsUndersupplyBackordered
      ,Comments
      ,DeliveryInstructions
      ,InternalComments
      ,PickingCompletedWhen
      ,LastEditedBy
      ,LastEditedWhen
  FROM WideWorldImporters.Sales.Orders


-- 26 a ejecutar
insert into Sales.OrderLines(
OrderLineID
      ,OrderID
      ,StockItemID
      ,Description
      ,PackageTypeID
      ,Quantity
      ,UnitPrice
      ,TaxRate
      ,PickedQuantity
      ,PickingCompletedWhen
      ,LastEditedBy
      ,LastEditedWhen
) select 
OrderLineID
      ,OrderID
      ,StockItemID
      ,Description
      ,PackageTypeID
      ,Quantity
      ,UnitPrice
      ,TaxRate
      ,PickedQuantity
      ,PickingCompletedWhen
      ,LastEditedBy
      ,LastEditedWhen
FROM WideWorldImporters.Sales.OrderLines



-- 27 a ejecutar

ALTER TABLE Sales.Invoices
DROP COLUMN ConfirmedDeliveryTime, ConfirmedReceivedBy;
GO

ALTER TABLE Sales.Invoices
ADD ConfirmedDeliveryTime AS (
    TRY_CONVERT(datetime2(7), JSON_VALUE(ReturnedDeliveryData, N'$.DeliveredWhen'), 126)
) PERSISTED;

ALTER TABLE Sales.Invoices
ADD ConfirmedReceivedBy AS (
    JSON_VALUE(ReturnedDeliveryData, N'$.ReceivedBy')
) PERSISTED;
GO


insert into Sales.Invoices(
InvoiceID
      ,CustomerID
      ,BillToCustomerID
      ,OrderID
      ,DeliveryMethodID
      ,ContactPersonID
      ,AccountsPersonID
      ,SalespersonPersonID
      ,PackedByPersonID
      ,InvoiceDate
      ,CustomerPurchaseOrderNumber
      ,IsCreditNote
      ,CreditNoteReason
      ,Comments
      ,DeliveryInstructions
      ,InternalComments
      ,TotalDryItems
      ,TotalChillerItems
      ,DeliveryRun
      ,RunPosition
      ,ReturnedDeliveryData
      ,LastEditedBy
      ,LastEditedWhen
) select
InvoiceID
      ,CustomerID
      ,BillToCustomerID
      ,OrderID
      ,DeliveryMethodID
      ,ContactPersonID
      ,AccountsPersonID
      ,SalespersonPersonID
      ,PackedByPersonID
      ,InvoiceDate
      ,CustomerPurchaseOrderNumber
      ,IsCreditNote
      ,CreditNoteReason
      ,Comments
      ,DeliveryInstructions
      ,InternalComments
      ,TotalDryItems
      ,TotalChillerItems
      ,DeliveryRun
      ,RunPosition
      ,ReturnedDeliveryData
      ,LastEditedBy
      ,LastEditedWhen
 FROM WideWorldImporters.Sales.Invoices

 -- 28 a ejecutar

ALTER TABLE Sales.CustomerTransactions
DROP COLUMN IsFinalized;
GO

ALTER TABLE Sales.CustomerTransactions
ADD IsFinalized AS (
    CASE 
        WHEN FinalizationDate IS NOT NULL THEN 1 
        ELSE 0 
    END
) PERSISTED;
GO


Insert into Sales.CustomerTransactions(
CustomerTransactionID
      ,CustomerID
      ,TransactionTypeID
      ,InvoiceID
      ,PaymentMethodID
      ,TransactionDate
      ,AmountExcludingTax
      ,TaxAmount
      ,TransactionAmount
      ,OutstandingBalance
      ,FinalizationDate
      ,LastEditedBy
      ,LastEditedWhen
)select 
CustomerTransactionID
      ,CustomerID
      ,TransactionTypeID
      ,InvoiceID
      ,PaymentMethodID
      ,TransactionDate
      ,AmountExcludingTax
      ,TaxAmount
      ,TransactionAmount
      ,OutstandingBalance
      ,FinalizationDate
      ,LastEditedBy
      ,LastEditedWhen
  FROM WideWorldImporters.Sales.CustomerTransactions


-- 29 a ejecutar

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
  FROM WideWorldImporters.Sales.InvoiceLines


-- 30 a ejecutar
insert into Sales.SpecialDeals(
SpecialDealID
      ,StockItemID
      ,CustomerID
      ,BuyingGroupID
      ,CustomerCategoryID
      ,StockGroupID
      ,DealDescription
      ,StartDate
      ,EndDate
      ,DiscountAmount
      ,DiscountPercentage
      ,UnitPrice
      ,LastEditedBy
      ,LastEditedWhen
) select 
SpecialDealID
      ,StockItemID
      ,CustomerID
      ,BuyingGroupID
      ,CustomerCategoryID
      ,StockGroupID
      ,DealDescription
      ,StartDate
      ,EndDate
      ,DiscountAmount
      ,DiscountPercentage
      ,UnitPrice
      ,LastEditedBy
      ,LastEditedWhen
  FROM WideWorldImporters.Sales.SpecialDeals


-- 31 a ejecutar 

insert into Warehouse.StockItemTransactions(
StockItemTransactionID
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
StockItemTransactionID
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
  FROM WideWorldImporters.Warehouse.StockItemTransactions






  -- Esto sera para los usuarios 

use Corporativo
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
    'bryan',
    HASHBYTES('SHA2_256', 'unMacaco'),
    'Bryan Londoño',
    1,
    'bryan@lala.com',
    GETDATE()
),
(

    'Dylantero',
    HASHBYTES('SHA2_256', 'uabbcita'),
    'Dylan Rodriguez',
    2,
    'Drodriguez09@gmail.com',
    GETDATE()
),
(
    'Miketowel',
    HASHBYTES('SHA2_256', 'finura'),
    'Maicol Torres',
    1,
    'Mykecito11@gmail.com',
    GETDATE()
);

