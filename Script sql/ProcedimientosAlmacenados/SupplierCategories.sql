USE WideWorldImporters;
GO

CREATE PROCEDURE SP_AllSuppliersCategories AS
BEGIN 
	SELECT SupplierCategoryName FROM SupplierCategories;
END