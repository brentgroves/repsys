# **[What are Power BI Semantic Models?](https://www.datacamp.com/blog/what-are-power-bi-semantic-models)**

A semantic model in Power BI can be considered a logical layer containing the transformations, calculations, and relationships between data sources needed to create reports and dashboards. A semantic model serves as the single source of truth for reports across an organization.

![i1](https://media.datacamp.com/legacy/v1703768377/image_d8c69fdb8a.png)**

While a semantic model can be built using Power BI Desktop (in a .pbix file), it does not need to contain any visuals. Think of a semantic model as the last stop in the data pipeline before reports and dashboards are built. Thereafter, once you share a semantic model with other members of the organization, they can build any number of reports and dashboards from just that one semantic model.

Semantic models hide the complex technical details behind reports so that both technical and non-technical users can concentrate on analyzing the data and answering business questions. Sharing and reusability are two stand-out features of semantic models.

## What Makes Up a Semantic Model?

Semantic models consist of several different elements:

Data connections to one or more data sources, either imported, through DirectQuery, or as part of a composite model.
Transformations that clean and prepare the data for reporting.
Defined calculations and metrics based on business rules to ensure consistent reports built from the semantic model. This ensures clarity and avoids discrepancies between analyses and reports.
Defined relationships between tables allow users to focus on designing reports without knowing the underlying database structures and data models beforehand.

## Semantic Model Modes

Choosing the right mode when connecting to your data in Power BI is an important first step in creating a semantic model since each has benefits and drawbacks that you must be aware of.

There are three modes of semantic models in Power BI:

- Import mode
- DirectQuery mode
- Composite mode

## Import mode

This fully loads the data into the Power BI (.pbix) file. Whenever the Power BI report refreshes, the Vertipaq storage engine compresses, optimizes, and stores the data to disk. This leads to fast performance and flexible design options for report creators. In addition, import mode allows semantic model creators to use the full set of the Power Query M language functions to transform and prepare data as well as DAX functions to create calculations and measures.

## DirectQuery mode

This mode only stores metadata about the model structure rather than the data itself. When the model is queried (such as by rendering a visual), the data is retrieved from the underlying data source. This is especially useful with large volumes of data or when there is a business requirement for near real-time data in a report.

## Composite mode

Composite mode is a combination of import and DirectQuery mode. This mode is useful when the power and performance of import mode are needed, along with the ability to view real-time data. A table can be set to Dual storage mode, allowing the Power BI service to pick a more efficient mode depending on the nature of the query.

## 5 Steps to Creating Power BI Semantic Models

Creating a semantic model involves the same steps you may already be following in the initial stages of developing reports using Power BI desktop. If you’re an aspiring data analyst, you can learn the Power BI Fundamentals with our skill track, where you’ll learn about data visualization, DAX, and how to transform your data.

Naturally, the exact steps you would follow when creating a semantic model depend on your business needs and goal for the model. However, on a high level, these five steps are commonly encountered when creating a semantic model:

![i1](https://media.datacamp.com/legacy/v1722015372/image_9c1154969d.png)

- Import or connect to the required data sources using import mode, DirectQuery, or composite models.
- Clean and transform the data to make it useful for users. This involves removing duplicates, addressing missing data, cleaning up text-based data columns, etc. The exact transformation steps depend on your data's unique requirements.
- Define relationships between your data tables using good data modeling principles like the star schema. We have a course that will teach you the foundations of data modeling in Power BI.
- Create measures and calculations based on your unique business requirements.

Once you are happy with your semantic model, publish it to the Power BI service.
