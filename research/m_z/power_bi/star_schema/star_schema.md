# fact vs dimension table

In Power BI, a fact table contains quantitative, measurable data (metrics) like sales and profit, while a dimension table provides the descriptive context (attributes) for those facts, such as product names, customer details, or dates. Fact tables are linked to dimension tables via relationships, which allows users to filter and analyze the measures in the fact table using the descriptive data from the dimensions. This two-part structure is the foundation of a dimensional model, commonly organized as a star schema  

This video explains the difference between fact and dimension tables:

## Fact table

Purpose: Stores the metrics, measurements, and numerical data from a business process.

- Data type: Primarily numeric values, but can also include keys that link to dimension tables.

## Characteristics

- Contains values that can be summed, averaged, or calculated (e.g., sales, revenue, units sold).
- Often has many rows, representing individual transactions or events.
- Acts as the central point in a dimensional model.

Example: A "Sales" fact table might include columns like ProductID, CustomerID, DateID, and SalesAmount.

## Dimension table

- Purpose: Provides descriptive information and context to the facts.
- Data type: Primarily descriptive text and other attributes.
- Characteristics:
Contains attributes that describe the "who," "what," "where," and "when" of a fact.
- Typically has fewer rows than a fact table.

Allows for filtering, grouping, and slicing of fact table data in reports.

Example: A "Products" dimension table could contain ProductID, ProductName, and Category.
