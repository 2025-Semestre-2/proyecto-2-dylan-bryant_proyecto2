create procedure AgregarProducto
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
      @LastEditedBy             int = 1,
	  @estaActivo				bit = 1 
as
begin
    set nocount on;
    DECLARE @NuevoID INT;

    SELECT @NuevoID = ISNULL(MAX(StockItemID), 0) + 1
    FROM Warehouse.StockItems;

    insert into Warehouse.StockItems (
          StockItemID,
          StockItemName,
          SupplierID,
          ColorID,
          UnitPackageID,
          OuterPackageID,
          Brand,
          Size,
          LeadTimeDays,
          QuantityPerOuter,
          IsChillerStock,
          Barcode,
          TaxRate,
          UnitPrice,
          RecommendedRetailPrice,
          TypicalWeightPerUnit,
          MarketingComments,
          InternalComments,
          Photo,
          CustomFields,
          LastEditedBy,
		  estaActivo,
          ValidFrom,
          ValidTo
    )
    values (
          @NuevoID,
          @StockItemName,
          @SupplierID,
          @ColorID,
          @UnitPackageID,
          @OuterPackageID,
          @Brand,
          @Size,
          @LeadTimeDays,
          @QuantityPerOuter,
          @IsChillerStock,
          @Barcode,
          @TaxRate,
          @UnitPrice,
          @RecommendedRetailPrice,
          @TypicalWeightPerUnit,
          @MarketingComments,
          @InternalComments,
          @Photo,
          @CustomFields,
          @LastEditedBy,
		  @estaActivo,
          '2016-05-31 23:11:00.0000000',
          '9999-12-31 23:59:59.9999999'
          
    );
end;



