USE WideWorldImporters;
GO

CREATE PROCEDURE SP_MaxAndMinStockItemHoldings AS
BEGIN 
	SELECT MinStock, MaxStock FROM MaxAndMinStockItemHoldings;
END