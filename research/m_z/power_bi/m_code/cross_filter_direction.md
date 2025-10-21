# **[]()**

Cross-filter direction in Power BI relationships determines how filters applied to one table propagate to related tables in the data model. This is a crucial setting when defining relationships between tables, as it dictates the flow of filter context within your reports.

There are two primary cross-filter directions:

- **Single (Unidirectional):** This is the default and most common direction. Filters flow from the "one" side of a relationship to the "many" side. For example, in a relationship between a Customers table (one) and an Orders table (many), a filter applied to Customers (e.g., filtering by a specific customer) will filter the Orders table to show only orders placed by that customer. However, a filter applied to Orders will not filter the Customers table.
- **Both (Bidirectional):** This allows filters to flow in both directions between two related tables. In the Customers and Orders example, if the cross-filter direction is set to "Both", a filter on Orders (e.g., filtering by a specific product) would also filter the Customers table to show only customers who purchased that product. Bidirectional filtering is often used in specific scenarios, such as when dealing with many-to-many relationships using a bridge table, or when implementing row-level security.
