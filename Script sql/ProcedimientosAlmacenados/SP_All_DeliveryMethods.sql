USE WideWorldImporters;
GO

CREATE PROCEDURE SP_All_DeliveryMethods
AS
BEGIN
	SELECT DeliveryMethodName FROM All_DeliveryMethods;
END

