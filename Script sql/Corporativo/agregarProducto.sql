create procedure AgregarProducto
      @StockItemID				int,                      -- PK
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
as
begin
    set nocount on;

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
          LastEditedBy
    )
    values (
          @StockItemID,
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
          @LastEditedBy
    );
end;
go