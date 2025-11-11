USE WideWorldImporters;
GO

CREATE PROCEDURE SP_TerceraEstadistica
(
	@Anio INT
)
AS
BEGIN
	SELECT TOP 5 [Year], [Product], SumaTotalVentas, 
	DENSE_RANK() OVER (PARTITION BY [Year] ORDER BY SumaTotalVentas DESC) AS Ranking 
	FROM TerceraEstadistica 
	WHERE [Year] = @Anio
END