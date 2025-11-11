USE WideWorldImporters;
GO

CREATE PROCEDURE SP_PrimerEstadistica
(
	@Proveedor nvarchar(100),
	@Categoria nvarchar(50)
)
AS
BEGIN
	SELECT Supplier, Category, MaxAmount, MinAmount, AvgAmount FROM EstadisticaMaxMinAvgComprasProveedores
	WHERE (Supplier LIKE '%' + @Proveedor + '%') OR (Category LIKE '%' + @Proveedor + '%');
END

