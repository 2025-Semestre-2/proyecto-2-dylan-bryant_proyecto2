USE WideWorldImporters;
GO

CREATE VIEW CustomersData AS
SELECT cu.CustomerName AS Name, ca.CustomerCategoryName as Category, 
CASE WHEN bg.BuyingGroupID IS NULL THEN 'Sin grupo.' ELSE bg.BuyingGroupName END AS BuyingGroup, 
pe.FullName as PrimaryContact, 
CASE WHEN cu.AlternateContactPersonID IS NULL THEN 'Sin contacto altenativo.' ELSE pe_2.FullName END AS AlternateContact,
cu.CustomerName as BillToCustomer,  
de.DeliveryMethodName as DeliveryMethod, ci.CityName as DeliveryCity, cu.DeliveryPostalCode as PostalCode, cu.FaxNumber as Fax,
cu.PhoneNumber as Phone, cu.PaymentDays as PaymentDays, cu.WebsiteURL as WebSite,
CONCAT(cu.DeliveryAddressLine1, ' ', cu.DeliveryAddressLine2, ' ', cu.PostalAddressLine1, ' ', cu.PostalAddressLine2) as FullAddress,
cu.DeliveryLocation as DeliveryLocation -- Cuidado que puede ser null
FROM Customers cu 
JOIN People pe on cu.PrimaryContactPersonID =pe.PersonID
LEFT JOIN People pe_2 on cu.AlternateContactPersonID =pe_2.PersonID
JOIN Cities ci on ci.CityID = cu.DeliveryCityID
JOIN CustomerCategories ca on cu.CustomerCategoryID = ca.CustomerCategoryID
JOIN DeliveryMethods de on cu.DeliveryMethodID = de.DeliveryMethodID
LEFT JOIN BuyingGroups bg on bg.BuyingGroupID = cu.BuyingGroupID
GO

