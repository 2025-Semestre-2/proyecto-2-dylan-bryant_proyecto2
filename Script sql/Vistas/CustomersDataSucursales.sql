SELECT *
FROM CORPORATIVO_SERVER.Corporativo.dbo.PruebaCustomersData;

SELECT *
FROM OPENQUERY(CORPORATIVO_SERVER, 'SELECT TOP 10 * FROM Corporativo.dbo.AllCustomers');

SELECT * FROM OPENQUERY(CORPORATIVO_SERVER, 'SELECT * FROM dbo.PruebaCustomersData')

--Ahora si puedo hacer la vista que junta de aquí a los datos de allá
CREATE VIEW CustomersData AS
SELECT cu.CustomerID, cd.Name, cd.Category, 
CASE WHEN cd.BuyingGroup IS NULL THEN 'Sin grupo.' ELSE cd.buyingGroup END AS BuyingGroup, cd.PrimaryContact, 
CASE WHEN cd.AlternateContact IS NULL THEN 'Sin contacto alternativo.' ELSE cd.AlternateContact END AS AlternateContact, cd.BillToCustomer, cd.DeliveryMethod,
cd.DeliveryCity, cd.PostalCode, cd.PaymentDays, cd.Website,
CONCAT(cd.DeliveryAddressLine1, ' ', cd.DeliveryAddressLine2, ' ', cd.PostalAddressLine1, ' ', cd.PostalAddressLine2) as FullAddress,
cd.Longitude, cd.Latitude
FROM Customers cu
JOIN CORPORATIVO_SERVER.Corporativo.dbo.PruebaCustomersData cd on cu.CustomerID = cd.CustomerID