
CREATE VIEW AllCustomers AS
SELECT c.CustomerID, c.Name, c.Category, c.DeliveryMethod
FROM CORPORATIVO_SERVER.Corporativo.dbo.AllCustomers AS c
INNER JOIN dbo.Customers AS s  ON c.CustomerID = s.CustomerID

