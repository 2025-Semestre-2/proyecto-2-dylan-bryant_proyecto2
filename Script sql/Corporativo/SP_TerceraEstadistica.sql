CREATE PROCEDURE SP_TerceraEstadistica
(
	@AnioI INT,
	@AnioF INT
)
AS
BEGIN
	SELECT TOP 5 *
	FROM (
		SELECT
			[Year],
			[Product],
			SumaTotalVentas,
			DENSE_RANK() OVER (PARTITION BY [Year] ORDER BY SumaTotalVentas DESC) AS Ranking
		FROM (
			
			SELECT [Year], [Product], SumaTotalVentas
			FROM SANJOSE_SERVER.SanJose.dbo.TerceraEstadistica
			UNION ALL
			SELECT [Year], [Product], SumaTotalVentas
			FROM LIMON_SERVER.Limon.dbo.TerceraEstadistica
		) AS Consolidado 

		WHERE [Year] BETWEEN @AnioI AND @AnioF
	) x
	ORDER BY Ranking;
END

EXEC SP_TerceraEstadistica @AnioI = 2013, @AnioF = 2018;