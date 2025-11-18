USE WideWorldImporters;
GO

CREATE PROCEDURE SP_CuartaEstadistica
(
	@AnioI INT,
	@AnioF INT
)
AS
BEGIN
	SELECT TOP 5 [Year], Name as Customer, TotalInvoices, Total, 
	DENSE_RANK() OVER (PARTITION BY [Year] ORDER BY TotalInvoices DESC) AS Ranking 
	FROM CuartaEstadistica 
	WHERE [Year] BETWEEN  @AnioI AND @AnioF
END

