USE WideWorldImporters;
GO

--Este procedimiento es para cuando se seleccione un cliente de la tabla
USE WideWorldImporters;
GO

CREATE PROCEDURE SP_SelectSpecificCustomerData 
(
	@CustomerName nvarchar(100),
	@Success int out
)
AS
BEGIN
	BEGIN TRY
		SET @Success = 1; --Por defecto indicar true
		--Select de la vista
		SELECT Name, Category, BuyingGroup, PrimaryContact, 
		AlternateContact, BillToCustomer, DeliveryMethod, DeliveryCity, PostalCode, Fax, Phone,
		PaymentDays, WebSite, FullAddress, DeliveryLocation
		FROM CustomersData 
		WHERE Name = @CustomerName;
	END TRY
	BEGIN CATCH
		SET @Success = 0; -- Indicar error
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END 

