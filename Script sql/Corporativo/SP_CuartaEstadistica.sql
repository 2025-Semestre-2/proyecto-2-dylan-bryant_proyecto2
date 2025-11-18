CREATE PROCEDURE SP_CuartaEstadistica
(
    @AnioI INT,
    @AnioF INT
)
AS
BEGIN
    SELECT TOP 5 *
    FROM (
        SELECT TOP 5 [Year], [Name] , TotalInvoices, Total, 
		DENSE_RANK() OVER (PARTITION BY [Year] ORDER BY TotalInvoices DESC) AS Ranking 
		FROM (
			SELECT [Year], [Name] , TotalInvoices, Total FROM SANJOSE_SERVER.SanJose.dbo.CuartaEstadistica
			UNION ALL
			SELECT [Year], [Name] , TotalInvoices, Total FROM LIMON_SERVER.Limon.dbo.CuartaEstadistica
		) as consolidado
		WHERE [Year] BETWEEN @AnioI AND @AnioF
    ) x      
    ORDER BY Ranking  
END;
GO

