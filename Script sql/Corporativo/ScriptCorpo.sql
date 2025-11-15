create database Corporativo 
use Corporativo
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


ALTER TABLE Sales.Customers
DROP COLUMN PhoneNumber, FaxNumber;
GO

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






-- Aqui van los proveedores 



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




ALTER TABLE Warehouse.StockItems DROP COLUMN Tags, SearchDetails;

ALTER TABLE Warehouse.StockItems
ADD Tags AS (JSON_QUERY(CustomFields, N'$.Tags')) PERSISTED;

ALTER TABLE Warehouse.StockItems
ADD SearchDetails AS (CONCAT(StockItemName, N' ', MarketingComments)) PERSISTED;


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
  FROM WideWorldImporters.Warehouse.Colors


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
  FROM WideWorldImporters.Warehouse.PackageTypes


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
FROM WideWorldImporters.Warehouse.StockItems







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



ALTER TABLE Purchasing.SupplierTransactions
DROP COLUMN IsFinalized;
GO

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