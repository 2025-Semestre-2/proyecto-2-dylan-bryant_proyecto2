

CREATE PROCEDURE SP_PrimerEstadistica
(
	@Proveedor nvarchar(100),
	@Categoria nvarchar(50)
)
AS
BEGIN
    SELECT 
    Supplier,
    Category,
    MAX(MaxAmount) AS MaxAmount,
    MIN(MinAmount) AS MinAmount,
    AVG(AvgAmount) AS AvgAmount
    FROM (
        SELECT Supplier, Category, MaxAmount, MinAmount, AvgAmount   FROM SANJOSE_SERVER.SanJose.dbo.EstadisticaMaxMinAvgComprasProveedores
        UNION ALL
        SELECT Supplier, Category, MaxAmount, MinAmount, AvgAmount FROM LIMON_SERVER.Limon.dbo.EstadisticaMaxMinAvgComprasProveedores
    ) t
    WHERE (Supplier LIKE '%' + @Proveedor + '%') OR (Category LIKE '%' + @Categoria + '%')
    GROUP BY Supplier, Category;


END

EXEC SP_PrimerEstadistica @Proveedor = '', @Categoria = '';



