section Section1;
shared DimProduct_raw = let
    Source = fxGetFile("DimProduct.csv"),
    #"Changed column type" =
        Table.TransformColumnTypes(
            Source,
            {
                {
                    "ProductKey",
                    Int64.Type
                },
                {
                    "ProductLabel",
                    Int64.Type
                },
                {
                    "ProductName",
                    type text
                },
                {
                    "ProductDescription",
                    type text
                },
                {
                    "ProductSubcategoryKey",
                    Int64.Type
                },
                {
                    "Manufacturer",
                    type text
                },
                {
                    "BrandName",
                    type text
                },
                {
                    "ClassID",
                    Int64.Type
                },
                {
                    "ClassName",
                    type text
                },
                {
                    "StyleID",
                    Int64.Type
                },
                {
                    "StyleName",
                    type text
                },
                {
                    "ColorID",
                    Int64.Type
                },
                {
                    "ColorName",
                    type text
                },
                {
                    "Size",
                    type text
                },
                {
                    "Weight",
                    type number
                },
                {
                    "WeightUnitMeasureID",
                    type text
                },
                {
                    "UnitOfMeasureID",
                    Int64.Type
                },
                {
                    "UnitOfMeasureName",
                    type text
                },
                {
                    "StockTypeID",
                    Int64.Type
                },
                {
                    "StockTypeName",
                    type text
                },
                {
                    "UnitCost",
                    type number
                },
                {
                    "UnitPrice",
                    type number
                }
            }
        )
in
    #"Changed column type";
shared DimProductCategory_raw = let
    Source = fxGetFile("DimProductCategory.csv"),
    #"Changed column type" =
        Table.TransformColumnTypes(
            Source,
            {
                {
                    "ProductCategoryKey",
                    Int64.Type
                },
                {
                    "ProductCategoryLabel",
                    Int64.Type
                },
                {
                    "ProductCategoryName",
                    type text
                },
                {
                    "ProductCategoryDescription",
                    type text
                }
            }
        ),
  #"Marked key columns" = Table.AddKey(#"Changed column type", {"ProductCategoryKey"}, true)
in
    #"Marked key columns";
shared DimProductSubcategory_raw = let
    Source = fxGetFile("DimProductSubcategory.csv"),
    #"Changed column type" =
        Table.TransformColumnTypes(
            Source,
            {
                {
                    "ProductSubcategoryKey",
                    Int64.Type
                },
                {
                    "ProductSubcategoryLabel",
                    Int64.Type
                },
                {
                    "ProductSubcategoryName",
                    type text
                },
                {
                    "ProductSubcategoryDescription",
                    type text
                },
                {
                    "ProductCategoryKey",
                    Int64.Type
                }
            }
        ),
  #"Marked key columns" = Table.AddKey(#"Changed column type", {"ProductSubcategoryKey"}, true)
in
    #"Marked key columns";
shared DimCustomer_raw = let
    Source = fxGetFile("DimCustomer.csv"),
    #"Changed column type" =
        Table.TransformColumnTypes(Source, {{"CustomerKey", Int64.Type}, {"GeographyKey", Int64.Type}, {"FirstName", type text}, {"MiddleName", type text}, {"LastName", type text}, {"BirthDate", type datetime}, {"MaritalStatus", type text}, {"Suffix", type text}, {"Title", type text}, {"EmailAddress", type text}, {"YearlyIncome", Int64.Type}, {"Education", type text}, {"Occupation", type text}, {"AddressLine1", type text}, {"AddressLine2", type text}, {"Phone", type text}, {"DateFirstPurchase", type datetime}, {"CustomerType", type text}})
in
    #"Changed column type";
shared DimGeography_raw = let
    Source = fxGetFile("DimGeography.csv"),
    #"Changed column type" =
        Table.TransformColumnTypes(
            Source,
            {
                {
                    "GeographyKey",
                    Int64.Type
                },
                {
                    "GeographyType",
                    type text
                },
                {
                    "ContinentName",
                    type text
                },
                {
                    "CityName",
                    type text
                },
                {
                    "StateProvinceName",
                    type text
                },
                {
                    "RegionCountryName",
                    type text
                },
                {
                    "Geometry",
                    type text
                }
            }
        )
in
    #"Changed column type";
shared DimDate = let
    Source = fxGetFile("DimDate.csv"),
    #"Changed column type" =
        Table.TransformColumnTypes(Source, {{"DateKey", type date}, {"Day", Int64.Type}, {"DaySuffix", type text}, {"DayName", type text}, {"DayOfWeek", Int64.Type}, {"DayOfWeekInMonth", Int64.Type}, {"DayOfYear", Int64.Type}, {"IsWeekend", Int64.Type}, {"Week", Int64.Type}, {"ISOweek", Int64.Type}, {"FirstOfWeek", type datetime}, {"LastOfWeek", type datetime}, {"WeekOfMonth", Int64.Type}, {"Month", Int64.Type}, {"MonthName", type text}, {"FirstOfMonth", type datetime}, {"LastOfMonth", type datetime}, {"FirstOfNextMonth", type datetime}, {"LastOfNextMonth", type datetime}, {"Quarter", Int64.Type}, {"FirstOfQuarter", type datetime}, {"LastOfQuarter", type datetime}, {"Year", Int64.Type}, {"ISOYear", Int64.Type}, {"FirstOfYear", type datetime}, {"LastOfYear", type datetime}, {"IsLeapYear", Int64.Type}, {"Has53Weeks", Int64.Type}, {"Has53ISOWeeks", Int64.Type}, {"YYYYMMDDKey", Int64.Type}})
in
    #"Changed column type";
shared DimEmployee = let
    Source = fxGetFile("DimEmployee.csv"),
    #"Changed column type" =
        Table.TransformColumnTypes(Source, {{"EmployeeKey", Int64.Type}, {"FirstName", type text}, {"LastName", type text}, {"MiddleName", type text}, {"Title", type text}, {"HireDate", type datetime}, {"BirthDate", type datetime}, {"EmailAddress", type text}, {"Phone", type text}, {"MaritalStatus", type text}, {"EmergencyContactName", type text}, {"EmergencyContactPhone", type text}, {"SalariedFlag", Int64.Type}, {"Gender", type text}, {"PayFrequency", Int64.Type}, {"BaseRate", type number}, {"VacationHours", Int64.Type}, {"SalesPersonFlag", Int64.Type}, {"DepartmentName", type text}, {"StartDate", type datetime}, {"EndDate", type datetime}, {"StoreKey", Int64.Type}})
in
    #"Changed column type";
shared DimStore = let
    Source = fxGetFile("DimStore.csv"),
    #"Changed column type" =
        Table.TransformColumnTypes(
            Source,
            {
                {
                    "StoreKey",
                    Int64.Type
                },
                {
                    "GeographyKey",
                    Int64.Type
                },
                {
                    "StoreManager",
                    Int64.Type
                },
                {
                    "StoreType",
                    type text
                },
                {
                    "StoreName",
                    type text
                },
                {
                    "StoreDescription",
                    type text
                },
                {
                    "Status",
                    type text
                },
                {
                    "OpenDate",
                    type datetime
                },
                {
                    "CloseDate",
                    type datetime
                },
                {
                    "EntityKey",
                    Int64.Type
                },
                {
                    "ZipCode",
                    Int64.Type
                },
                {
                    "ZipCodeExtension",
                    Int64.Type
                },
                {
                    "StorePhone",
                    type text
                },
                {
                    "StoreFax",
                    type text
                },
                {
                    "AddressLine1",
                    type text
                },
                {
                    "AddressLine2",
                    type text
                },
                {
                    "CloseReason",
                    type text
                },
                {
                    "SellingAreaSize",
                    Int64.Type
                },
                {
                    "LastRemodelDate",
                    type datetime
                },
                {
                    "GeoLocation",
                    type text
                },
                {
                    "Geometry",
                    type text
                }
            }
        )
in
    #"Changed column type";
shared DimCustomer = let
    Source = DimCustomer_raw,
    #"Merged queries" =
        Table.NestedJoin(
            Source,
            {"GeographyKey"},
            DimGeography_raw,
            {"GeographyKey"},
            "DimGeography_raw",
            JoinKind.Inner
        ),
    #"Expanded DimGeography_raw" =
        Table.ExpandTableColumn(
            #"Merged queries",
            "DimGeography_raw",
            {
                "GeographyType",
                "ContinentName",
                "CityName",
                "StateProvinceName",
                "RegionCountryName",
                "Geometry"
            },
            {
                "GeographyType",
                "ContinentName",
                "CityName",
                "StateProvinceName",
                "RegionCountryName",
                "Geometry"
            }
        ),
    #"Removed columns" =
        Table.RemoveColumns(
            #"Expanded DimGeography_raw",
            {"GeographyKey"}
        )
in
    #"Removed columns";
shared DimProduct = let
    Source =
        Table.NestedJoin(
            DimProduct_raw,
            {"ProductSubcategoryKey"},
            DimProductSubcategory_raw,
            {"ProductSubcategoryKey"},
            "DimProductSubcategory_raw",
            JoinKind.Inner
        ),
    #"Expanded DimProductSubcategory_raw" =
        Table.ExpandTableColumn(
            Source,
            "DimProductSubcategory_raw",
            {
                "ProductSubcategoryName",
                "ProductCategoryKey"
            },
            {
                "ProductSubcategoryName",
                "ProductCategoryKey"
            }
        ),
    #"Merged queries" =
        Table.NestedJoin(
            #"Expanded DimProductSubcategory_raw",
            {"ProductCategoryKey"},
            DimProductCategory_raw,
            {"ProductCategoryKey"},
            "DimProductCategory_raw",
            JoinKind.Inner
        ),
    #"Expanded DimProductCategory_raw" =
        Table.ExpandTableColumn(
            #"Merged queries",
            "DimProductCategory_raw",
            {"ProductCategoryName"},
            {"ProductCategoryName"}
        ),
    #"Removed columns" =
        Table.RemoveColumns(
            #"Expanded DimProductCategory_raw",
            {
                "ProductSubcategoryKey",
                "ProductCategoryKey"
            }
        ),
    #"Get column names" = Table.ColumnNames(#"Removed columns"),
    // Select only columns where the text ID does not exist.
    #"Select non-ID columns" =
        List.Select(
            #"Get column names",
            each not Text.Contains(_, "ID", Comparer.Ordinal)
        ),
    #"Select columns" =
        Table.SelectColumns(
            #"Removed columns",
            #"Select non-ID columns"
        )
in
    #"Select columns";
shared FactOnlineSales = let
  Source = fxGetFact(),
  #"Changed column type" = Table.TransformColumnTypes(Source, {{"OnlineSalesKey", Int64.Type}, {"DateKey", type datetime}, {"DeliveryDate", type datetime}, {"StoreKey", Int64.Type}, {"ProductKey", Int64.Type}, {"CustomerKey", Int64.Type}, {"SalesQuantity", Int64.Type}, {"SalesAmount", type number}, {"ReturnQuantity", Int64.Type}, {"ReturnAmount", Int64.Type}, {"DiscountQuantity", Int64.Type}, {"DiscountAmount", type number}})
in
  #"Changed column type";
shared fxGetFile = let
    fxGetFile =
        (#"File Name" as text) =>
            let
                webAddress = "https://raw.githubusercontent.com/microsoft/pbiworkshops/main/Day%20After%20Dashboard%20in%20a%20Day/Source_Files",
                Source =
                    if
                        Text.AfterDelimiter(#"File Name", ".")
                        = "csv"
                    then
                        Table.PromoteHeaders(
                            Csv.Document(
                                Web.Contents(
                                    webAddress,
                                    [
                                        RelativePath = #"File Name",
                                        ManualStatusHandling = {
                                            404
                                        }
                                    ]
                                ),
                                [
                                    Delimiter = "|",
                                    Encoding = 65001,
                                    QuoteStyle = QuoteStyle.None
                                ]
                            )
                        )
                    else
                        Parquet.Document(
                            Binary.Buffer(
                                Web.Contents(
                                    webAddress,
                                    [
                                        RelativePath = #"File Name",
                                        ManualStatusHandling = {
                                            404
                                        }
                                    ]
                                )
                            ),
                            [
                                Compression = Compression.Snappy,
                                LegacyColumnNameEncoding = false,
                                MaxDepth = null
                            ]
                        )
            in
                Source,
    Documentation_Meta = [
        Documentation.Name = "Microsoft Fabric for Power BI users - Sample data",
        Documentation.Description = "Obtains the source files from the GitHub repository for Microsoft Fabric for Power BI users."
    ],
    #"Add Documentation" =
        Value.ReplaceType(
            fxGetFile,
            Value.ReplaceMetadata(
                Value.Type(fxGetFile),
                Documentation_Meta
            )
        )
in
    #"Add Documentation";
shared fxGetFact = let
    fxGetFact = () =>
let
    // A function that accept a file number value and concatenates text
    fileNameUpdate =
        (#"File number" as number) as text =>
            let
                Source =
                    Text.Combine(
                        {
                            "FactOnlineSales_",
                            Text.From(#"File number"),
                            ".parquet"
                        }
                    )
            in
                Source,
    tableReturn = [
        fileCount = 1,
        fileName = fileNameUpdate(fileCount),
        data = fxGetFile(fileName)
    ],
    Source =
        List.Generate(
            () => tableReturn,
            each try [fileCount] < 10 otherwise false,
            each
                [
                    fileCount = [fileCount] + 1,
                    fileName = fileNameUpdate(fileCount),
                    data = try fxGetFile(fileName) otherwise #table({}, {})
                ]
        ),
    #"Converted to table" =
        Table.FromList(
            Source,
            Splitter.SplitByNothing(),
            null,
            null,
            ExtraValues.Error
        ),
    #"Expanded Column1" =
        Table.ExpandRecordColumn(
            #"Converted to table",
            "Column1",
            {
                "fileCount",
                "fileName",
                "data"
            },
            {
                "fileCount",
                "fileName",
                "data"
            }
        ),
    #"Removed other columns" =
        Table.SelectColumns(
            #"Expanded Column1",
            {"data"}
        ),
    #"Expanded data" =
        Table.ExpandTableColumn(
            #"Removed other columns",
            "data",
            {
                "OnlineSalesKey",
                "DateKey",
                "DeliveryDate",
                "StoreKey",
                "ProductKey",
                "CustomerKey",
                "SalesQuantity",
                "SalesAmount",
                "ReturnQuantity",
                "ReturnAmount",
                "DiscountQuantity",
                "DiscountAmount"
            },
            {
                "OnlineSalesKey",
                "DateKey",
                "DeliveryDate",
                "StoreKey",
                "ProductKey",
                "CustomerKey",
                "SalesQuantity",
                "SalesAmount",
                "ReturnQuantity",
                "ReturnAmount",
                "DiscountQuantity",
                "DiscountAmount"
            }
        )
in
  #"Expanded data",
  Documentation_Meta = [
        Documentation.Name = "Microsoft Fabric for Power BI users - Sample data",
        Documentation.Description = "Obtains the source files from the GitHub repository for Microsoft Fabric for Power BI users."
    ],
    #"Add Documentation" =
        Value.ReplaceType(
            fxGetFact,
            Value.ReplaceMetadata(
                Value.Type(fxGetFact),
                Documentation_Meta
            )
        )
in
    #"Add Documentation";
