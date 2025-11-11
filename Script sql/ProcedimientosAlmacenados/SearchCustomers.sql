--Este procedimiento es para la búsqueda.
USE WideWorldImporters;
GO
CREATE PROCEDURE SearchCustomers
(
	@CustomerName nvarchar(100),
	@Category nvarchar(50),
	@DeliveryMethod nvarchar(50),
	@Success int out
)
AS	
	BEGIN TRY
		SET @Success = 1; --Por defecto indicar true
		--Declaración de variable para el like
		DECLARE @CustomerNameLike AS NVARCHAR(102);
		SET @CustomerNameLike = '%' + @CustomerName + '%';
		SELECT Name, Category, DeliveryMethod FROM AllCustomers
		WHERE (Name LIKE @CustomerNameLike) AND (@Category = '' OR Category = @Category) AND (@DeliveryMethod = '' OR DeliveryMethod = @DeliveryMethod)
		ORDER BY Name ASC;
	END TRY
	BEGIN CATCH
		SET @Success = 0; -- Indicar error
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
