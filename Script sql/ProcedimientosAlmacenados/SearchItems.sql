-- Este procedimiento es para la búsqueda en el inventario
USE WideWorldImporters;
GO

CREATE PROCEDURE SearchItems (
	@ItemName nvarchar(100),
	@Group nvarchar(50),
	@MinQuantity INT,
	@MaxQuantity INT,
	@Success int out
)
AS
BEGIN 
	BEGIN TRY
		SET @Success =1;
		SELECT StockItemName, StockGroup, Quantity 
		FROM AllItems
		WHERE (StockItemName LIKE '%' + @ItemName + '%') AND (StockGroup LIKE '%' +@GROUP + '%') AND (Quantity BETWEEN @MinQuantity AND @MaxQuantity)
		ORDER BY StockItemName DESC;
		END TRY
	BEGIN CATCH
		SET @Success = 0; -- Indicar error
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END 


		