USE WideWorldImporters;
GO

CREATE PROCEDURE SP_AllItems
AS
	SELECT StockItemName, StockGroup, Quantity FROM AllItems
	ORDER BY StockItemName ASC;
GO

