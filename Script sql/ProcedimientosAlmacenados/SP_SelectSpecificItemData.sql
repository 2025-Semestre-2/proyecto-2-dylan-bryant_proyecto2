USE WideWorldImporters;
GO

--Este procedimiento es para cuando se seleccione un item de la tabla
USE WideWorldImporters;
GO

CREATE PROCEDURE SP_SelectSpecificItemData
(
	@ItemName nvarchar(100),
	@Success int out
)
AS
BEGIN
	BEGIN TRY
		SET @Success = 1; --Por defecto indicar true
		--Select de la vista
		SELECT StockItemName, Supplier, Color, UnitPackage, OuterPackage, RecommendedRetailPrice, Weight, SearchDetails,
		QuantityPerOuter, Brand, Size, Tax, UnitPrice, Quantity, Location
		FROM ItemsData 
		WHERE StockItemName = @ItemName;
	END TRY
	BEGIN CATCH
		SET @Success = 0; -- Indicar error
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END 
