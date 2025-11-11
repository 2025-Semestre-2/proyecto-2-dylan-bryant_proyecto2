USE WideWorldImporters;
GO

CREATE VIEW AllCustomers AS
SELECT cu.CustomerName as Name, ca.CustomerCategoryName as Category, de.DeliveryMethodName as DeliveryMethod
FROM Customers cu
JOIN CustomerCategories ca on cu.CustomerCategoryID = ca.CustomerCategoryID
JOIN DeliveryMethods de on cu.DeliveryMethodID = de.DeliveryMethodID;

