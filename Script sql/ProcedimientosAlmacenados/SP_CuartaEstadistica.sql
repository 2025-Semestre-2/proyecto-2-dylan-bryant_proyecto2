USE WideWorldImporters;
GO

CREATE PROCEDURE SP_CuartaEstadistica
(
	@Anio INT
)
AS
BEGIN
	SELECT TOP 5 [Year], CustomerName as Customer, TotalInvoices, Total, 
	DENSE_RANK() OVER (PARTITION BY [Year] ORDER BY TotalInvoices DESC) AS Ranking 
	FROM CuartaEstadistica 
	WHERE [Year] = @Anio
END

