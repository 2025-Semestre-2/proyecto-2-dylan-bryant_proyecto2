-- Para la búsqueda de facturas

USE WideWorldImporters;
GO
CREATE PROCEDURE SearchInvoices
(
	@Customer nvarchar(100),
	@DeliveryMethod nvarchar(50),
	@MinDate DATE,
	@MaxDate DATE,
	@MinAmount INT,
	@MaxAmount INT,
	@Success int out
)
AS
BEGIN
	BEGIN TRY
		SET @Success = 1; --Por defecto indicar true
		SELECT ID, [Date], Customer, DeliveryMethod, Total 
		FROM AllInvoices 
		WHERE (Customer LIKE '%' + @Customer + '%') AND (@DeliveryMethod = '' OR DeliveryMethod = @DeliveryMethod) AND 
		([Date] BETWEEN @MinDate AND @MaxDate) AND (Total BETWEEN @MinAmount AND @MaxAmount);
	END TRY
	BEGIN CATCH
	SET @Success = 0; -- Indicar error
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END

