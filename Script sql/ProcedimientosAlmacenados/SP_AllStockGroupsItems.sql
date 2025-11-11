USE WideWorldImporters;
GO

CREATE PROCEDURE SP_AllStockGroupsItems AS
BEGIN
	SELECT StockGroupName FROM AllStockGroupsItems;
END
