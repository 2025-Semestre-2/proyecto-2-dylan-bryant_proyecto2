USE WideWorldImporters;
GO

CREATE VIEW SuppliersData AS
SELECT CASE WHEN s.SupplierReference IS NULL THEN 'Sin referencia.' ELSE s.SupplierReference END AS SupplierReference,
s.SupplierName as SupplierName,  sc.SupplierCategoryName as SupplierCategory,
p.FullName as PrimaryContactPerson, p_2.FullName as AlternateContactPerson,
CASE WHEN s.DeliveryMethodID IS NULL THEN 'Sin método.' ELSE de.DeliveryMethodName END AS DeliveryMethod,
c.CityName as DeliveryCity, s.PostalPostalCode as PostalCode, s.PhoneNumber, s.FaxNumber as Fax,
s.WebSiteURL as WebSite, CONCAT(s.DeliveryAddressLine1, ' ', s.DeliveryAddressLine2, ' ', s.PostalAddressLine1, ' ', s.PostalAddressLine2) as FullAddress,
s.DeliveryLocation as DeliveryLocation, 
CASE WHEN s.BankAccountName IS NULL THEN 'Sin nombre del banco.' ELSE s.BankAccountName END AS BankName,
CASE WHEN s.BankAccountNumber IS NULL THEN 'Sin número de cuenta.' ELSE s.BankAccountNumber END AS BankAccountNumber,
s.PaymentDays
FROM Suppliers s 
JOIN SupplierCategories sc on s.SupplierCategoryID = sc.SupplierCategoryID
JOIN People p on s.PrimaryContactPersonID = p.PersonID
JOIN People p_2 on s.AlternateContactPersonID = p_2.PersonID
LEFT JOIN DeliveryMethods de on s.DeliveryMethodID = de.DeliveryMethodID
JOIN Cities c on s.DeliveryCityID = c.CityID;



