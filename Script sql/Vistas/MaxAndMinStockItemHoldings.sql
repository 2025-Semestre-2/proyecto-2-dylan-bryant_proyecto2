USE WideWorldImporters;
GO

CREATE VIEW MaxAndMinStockItemHoldings AS
SELECT MIN(Quantity) AS MinStock, MAX(Quantity) as MaxStock FROM AllItems