# **[Design MICROSOFT FABRIC Data Project with Medallion Architecture | Lakehouse + Spark + Power BI](https://www.youtube.com/watch?v=qG65DUcSjws)**

## code

- **[](https://github.com/nextgendatahub/MedallionLakehouseFabric)**
- **[](https://github.com/nextgendatahub/MedallionLakehouseFabric/tree/main/ShoppingMart_StructuredData)**
- **[](https://github.com/nextgendatahub/MedallionLakehouseFabric/tree/main/ShoppingMart_UnstructuredData)**

## medalion

created by databricks now industry standard

- bronze - raw
  - enriched zone
  - stores source data in original format, including unstructured, semi-structured, or structured data types
- silver - validated
  - data is cleansed and standardized
  - validate and deduplicate your data
- gold - business ready
  - curated zone
  - data is refined to meet specific downstream business and analytics requirements

- ![med](https://blog.bismart.com/hs-fs/hubfs/Arquitectura_Medallion_Pasos.jpg?width=1754&height=656&name=Arquitectura_Medallion_Pasos.jpg)

## ShoppingMartAnalytics Workspace

- select medallion task flow
Organize data in your lakehouse or warehouse while progressively improving its structure and quality in each layer from Bronze to silver to gold. resulting in quality data that is easy to analyze.

**[lakehouse](https://learn.microsoft.com/en-us/fabric/data-engineering/lakehouse-overview)**
