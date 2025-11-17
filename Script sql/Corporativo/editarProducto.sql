create procedure editarProducto
	  @StockItemID              int,
      @StockItemName			nvarchar(200),            
      @SupplierID               int,                      -- FK
      @ColorID                  int = NULL,               -- FK 
      @UnitPackageID            int,                      -- FK
      @OuterPackageID           int,                      -- FK
      @Brand                    nvarchar(100) = NULL,
      @Size                     nvarchar(50) = NULL,
      @LeadTimeDays             int,
      @QuantityPerOuter         int,
      @IsChillerStock           bit,
      @Barcode                  nvarchar(200) = NULL,
      @TaxRate                  decimal(18,3),
      @UnitPrice                decimal(18,2),
      @RecommendedRetailPrice   decimal(18,2) = NULL,
      @TypicalWeightPerUnit     decimal(18,3),
      @MarketingComments        nvarchar(MAX) = NULL,
      @InternalComments         nvarchar(MAX) = NULL,
      @Photo                    varbinary(MAX) = NULL,
      @CustomFields             nvarchar(MAX) = NULL,
      @LastEditedBy             int
as begin
	set nocount on
	update Warehouse.StockItems
	set
        StockItemName = @StockItemName,
        SupplierID = @SupplierID,
        ColorID = @ColorID,
        UnitPackageID = @UnitPackageID,
        OuterPackageID = @OuterPackageID,
        Brand = @Brand,
        Size = @Size,
        LeadTimeDays = @LeadTimeDays,
        QuantityPerOuter = @QuantityPerOuter,
        IsChillerStock = @IsChillerStock,
        Barcode = @Barcode,
        TaxRate = @TaxRate,
        UnitPrice = @UnitPrice,
        RecommendedRetailPrice = @RecommendedRetailPrice,
        TypicalWeightPerUnit = @TypicalWeightPerUnit,
        MarketingComments = @MarketingComments,
        InternalComments = @InternalComments,
        Photo = @Photo,
        CustomFields = @CustomFields,
        LastEditedBy = @LastEditedBy
	where StockItemID = @StockItemID
end;
go