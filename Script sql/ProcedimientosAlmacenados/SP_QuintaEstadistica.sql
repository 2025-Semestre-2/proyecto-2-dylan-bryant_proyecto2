USE WideWorldImporters;
GO

CREATE PROCEDURE SP_QuintaEstadistica
(
	@Anio INT
)
AS
BEGIN
	SELECT TOP 5 [Year], Supplier, TotalOrdenes, TotalEnOrdenes, 
	DENSE_RANK() OVER (PARTITION BY [Year] ORDER BY TotalOrdenes DESC) AS Ranking 
	FROM QuintaEstadistica 
	WHERE [Year] = @Anio
END

