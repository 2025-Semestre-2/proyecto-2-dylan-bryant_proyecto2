-- Con este obtengo el detalle de todas las líneas de una factura
USE WideWorldImporters;
GO

CREATE PROCEDURE SP_InvoiceLines
(
	@InvoiceID INT,
	@Success INT OUT
)
AS
BEGIN
	BEGIN TRY
		SET @Success = 1; 
		
		SELECT InvoiceID, ProductName, Quantity, UnitPrice, TaxRate, Tax, Total
		FROM DetailedInvoiceLines
		WHERE InvoiceID = @InvoiceID;

	END TRY
	BEGIN CATCH
	SET @Success = 0; -- Indicar error
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
