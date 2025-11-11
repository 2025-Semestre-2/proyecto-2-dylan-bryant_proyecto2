-- Este procedimiento es para buscar proveedores

USE WideWorldImporters;
GO

CREATE PROCEDURE SearchSuppliers (
	@SupplierName nvarchar(100),
	@Category nvarchar(50),
	@DeliveryMethod nvarchar(50),
	@Success int out
)
AS
BEGIN
	BEGIN TRY
		SET @Success = 1; -- Por defecto éxito
		--Declaración de variable para el like
		DECLARE @SupplierNameLike AS NVARCHAR(102);
		SET @SupplierNameLike = '%' + @SupplierName + '%';

		SELECT SupplierName, SupplierCategory, DeliveryMethod FROM AllSuppliers
		WHERE (SupplierName LIKE @SupplierNameLike) AND (@Category = '' OR SupplierCategory = @Category) AND (@DeliveryMethod = '' OR DeliveryMethod = @DeliveryMethod)
		ORDER BY SupplierName ASC;

	END TRY
	BEGIN CATCH
		SET @Success = 0; -- Indicar error
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END 


