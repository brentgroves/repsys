# **[semantic model](https://www.youtube.com/watch?v=uioqDxQQrfY&t=307s)**

A Power BI semantic model is a data model that organizes raw data into a consistent and reusable source for reporting and analysis. It acts as an intermediary between data sources and visualizations by defining relationships between tables, incorporating business logic, and including calculations. By publishing a semantic model, organizations can ensure consistency, simplify analysis, and enable collaboration across multiple reports that all connect to the same trusted data foundation.

## Key components and functions

- Relationships: Defines how different tables are connected, allowing for easy navigation of data.
- Business logic: Incorporates business terms and definitions, making complex data easier to understand and use.
- Calculations: Includes measures, calculated columns, and other calculations created using DAX.
- Row-level security: Can be used to set up security rules to control access to data for different users.

## Benefits of using semantic models

- Consistency: Ensures that everyone across the organization is using the same data and definitions for their reports and dashboards.
- Simplified analysis: Transforms complex data into an organized, user-friendly format that is easier to analyze.
- Enhanced collaboration: Provides a single, trusted data source that multiple users can leverage to build their own reports without having to create their own models.
- Maintenance: Simplifies data model updates. Changes to a single published semantic model are automatically reflected in all downstream reports that use it.

## How they are used

- A business analyst can build and publish a semantic model to the Power BI service.
- Other users can then create their own reports by connecting to this shared semantic model instead of building a new one from scratch.
- This allows for a more efficient workflow, where the data model is managed centrally and reports can be built independently.

## fabric

Semantic Models become more powerful.
