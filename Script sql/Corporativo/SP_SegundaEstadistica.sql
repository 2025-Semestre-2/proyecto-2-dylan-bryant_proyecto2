CREATE PROCEDURE SP_SegundaEstadistica
(
	@Cliente nvarchar(100),
	@Categoria nvarchar(50)
)
AS
BEGIN
	SELECT Customer, Category, MaxAmount, MinAmount, AvgAmount
	FROM (
		SELECT Customer, Category, MaxAmount, MinAmount, AvgAmount 
		FROM LIMON_SERVER.Limon.dbo.SegundaEstadistica
		
		UNION ALL
		
		SELECT Customer, Category, MaxAmount, MinAmount, AvgAmount
		FROM  SANJOSE_SERVER.SanJose.dbo.SegundaEstadistica
	) AS Consolidado
	WHERE (Customer LIKE '%' + @Cliente + '%') 
	   OR (Category LIKE '%' + @Categoria + '%')
	ORDER BY Customer;
END
