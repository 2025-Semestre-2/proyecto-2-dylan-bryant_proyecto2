USE WideWorldImporters;
GO

CREATE PROCEDURE SP_SegundaEstadistica
(
	@Cliente nvarchar(100),
	@Categoria nvarchar(50)
)
AS
BEGIN
	SELECT Customer, Category, MaxAmount, MinAmount, AvgAmount FROM SegundaEstadistica
	WHERE (Customer LIKE '%' + @Cliente + '%') OR (Category  LIKE '%' + @Cliente + '%')
	ORDER BY Customer;
END

