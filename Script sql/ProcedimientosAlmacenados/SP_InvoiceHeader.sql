-- Con este obtengo el encabezado de la factura para la vista detallada
USE WideWorldImporters;
GO

CREATE PROCEDURE SP_InvoiceHeader 
(
	@InvoiceID INT,
	@Success INT OUT
)
AS
BEGIN
	BEGIN TRY
		SET @Success = 1; 
		
		SELECT ID, Customer, DeliveryMethod, PurcharseOrderNumber, ContactPerson, SalesPerson, InvoiceDate, DeliveryInstructions
		FROM InvoiceHeader
		WHERE ID = @InvoiceID;

	END TRY
	BEGIN CATCH
	SET @Success = 0; -- Indicar error
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
	
