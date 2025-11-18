USE WideWorldImporters;
GO

CREATE PROCEDURE SP_TerceraEstadistica
(
	@AnioI INT,
	@AnioF INT
)
AS
BEGIN
	SELECT TOP 5 [Year], [Product], SumaTotalVentas, 
	DENSE_RANK() OVER (PARTITION BY [Year] ORDER BY SumaTotalVentas DESC) AS Ranking 
	FROM TerceraEstadistica 
	WHERE [Year] BETWEEN  @AnioI AND @AnioF
END

