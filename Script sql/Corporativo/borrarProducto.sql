create procedure eliminarProducto
	@StockItemID int 

as begin
	set nocount on;
	delete from Warehouse.StockItems
	where StockItemID = @StockItemID;
end;
Go