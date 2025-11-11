--El STRING_AGG lo que hace es juntar todos los valores de la misma columna. El group by funciona como el PARTITION BY porque con él es que sabe cuales columnas combinar
USE WideWorldImporters;
GO
CREATE VIEW AllItems AS
SELECT si.stockItemID, si.StockItemName as StockItemName,  
STRING_AGG(sg.StockGroupName, ', ')  as StockGroup,
sih.QuantityOnHand as Quantity
FROM StockItems si
JOIN StockItemStockGroups sisg on si.StockItemID = sisg.StockItemId
JOIN StockGroups sg on sisg.StockGroupID = sg.StockGroupID
LEFT JOIN StockItemHoldings sih on si.StockItemID  = sih.StockItemID
GROUP BY si.stockItemID, si.StockItemName, sih.QuantityOnHand;




