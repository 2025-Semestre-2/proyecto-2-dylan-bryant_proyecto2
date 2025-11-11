USE WideWorldImporters;
GO

CREATE PROCEDURE SP_AllCustomerCategories
AS
BEGIN
	SELECT CustomerCategoryName FROM AllCustomerCategories;
END

