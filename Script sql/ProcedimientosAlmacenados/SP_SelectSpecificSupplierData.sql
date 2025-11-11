--Este procedimiento es para cuando seleccionan a un proveedor de la tabla

USE WideWorldImporters;
GO

CREATE PROCEDURE SP_SelectSpecificSupplierData
(
	@SupplierName nvarchar(100),
	@Success int out
)
AS
BEGIN
	BEGIN TRY
		SET @Success = 1; -- Por defecto éxito

		--Select a la vista
		SELECT SupplierReference, SupplierName, SupplierCategory, PrimaryContactPerson, AlternateContactPerson, DeliveryMethod, 
		DeliveryCity, PostalCode, PhoneNumber, Fax, WebSite, FullAddress, DeliveryLocation, BankName, BankAccountNumber, PaymentDays 
		FROM SuppliersData 
		WHERE SupplierName = @SupplierName
		ORDER BY SupplierName ASC;
		END TRY
	BEGIN CATCH
		SET @Success = 0; -- Indicar error
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END 

