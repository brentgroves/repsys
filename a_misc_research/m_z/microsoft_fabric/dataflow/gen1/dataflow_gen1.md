# **[dataflow gen 1](https://medium.com/@uzuntasgokberk/data-mart-data-flow-gen-1-bbbaf7eabe07)**

Introduction Data Flow Gen1
A dataflow is a collection of tables that are created and managed in workspaces in the Power BI service. A table is a set of columns that are used to store data, much like a table within a database. Also, experience to ingest data from different data sources, extract transform and load (ETL) the data using Power Query.

## Data Flow Gen1 benefits and features

Data Preparation and Transformation Efficiencies
Centralized Data Management and Reuse
Enhanced Data Refresh and Update Options
ML Scenario
Incremental refresh is available

![i31](https://miro.medium.com/v2/resize:fit:720/format:webp/1*gJYj8T00IiQR_ONT36_WRw.png)

With Data Flow that can be created lots of Scenerio. 2 Scenerios that mostly used widely will be given as Example. Both scenerio architecture, the data source is csv file in local.

![i32](https://miro.medium.com/v2/resize:fit:720/format:webp/1*oMRFvHroxTiXVnHff_9DWg.png)

Fetching the data that is csv file should be used “Define New Tables”.

![i33](https://miro.medium.com/v2/resize:fit:720/format:webp/1*z0Usf00I30ukbkDOSFWBsw.png)

Data Mart Power Query and Data Flow Power Query are same nothing different. Therefore, Clicking Get Data →New Source →Text/CSV.

Press enter or click to view image in full size

![i34](https://miro.medium.com/v2/resize:fit:720/format:webp/1*JnUZezqA9MqNXS2wPALL5g.png)
Upload the Country_Lookup to find 2 or 3 country digit code.

![i35](https://miro.medium.com/v2/resize:fit:720/format:webp/1*SKuaxc-cPQ3zJ6-2AD0oVw.png)

The data is demonstrated in Power Query.

Press enter or click to view image in full size

![i36](https://miro.medium.com/v2/resize:fit:720/format:webp/1*wjXjWAWF3zQ-PhcngGJI6w.png)

Example of some transform process.

![i37](https://miro.medium.com/v2/resize:fit:4800/format:webp/1*FiC8w9gI99bete6Bwtm5Hw.png)

Transformation has completed.

When Clicking Save button. Tables will be demonstrated. The importing thing is after closing Data Flow that must be refreshed. Otherwise, the tables wont be seeing in Power BI Desktop while getting data from Power BI.

Press enter or click to view image in full size

Clicking Power BI Data Flows(Legacy). Other Data Flows are not PBI Data Flows. Others are Power Apps Data Flow and Fabric Data Flow. In this scenerio that has been used PBI Data Flow.

Press enter or click to view image in full size

Lastly, the reports can be created.

Press enter or click to view image in full size

![i37](https://miro.medium.com/v2/resize:fit:720/format:webp/1*lHSV-8N4-LYaWg_rIkrq1Q.jpeg)

Scenerio 2

![i38](https://miro.medium.com/v2/resize:fit:720/format:webp/1*VuyunYVvg4FGxUYa5IwTRA.png)

Last time country_lookup ETL process has been completed in Data Flow. Hence, completed ETL process table can be used in Data Mart which means that can be stored in Azure SQL and doesn’t effect performance. Because ETL process hasn’t done in Data Mart Power Query.

Inside Data Mart get data from Data Flow that created.

![i39](https://miro.medium.com/v2/resize:fit:720/format:webp/1*NDPHSd_hHWtB9EuKgkme1g.png)

Connect to Power bı Data Flow(Legacy).

Contry_Lookup datas.

![i40](https://miro.medium.com/v2/resize:fit:720/format:webp/1*-lFpEqOM5H8a5OnmQiK0HQ.png)

In the next steps, that can be joins with Country_Lookup and Case_w_date and reporting.

Data Flow Limitation:
Semantic Model is not available
Comparison of Dataflow Gen1 Pro Workspace & Dataflow Gen1 Premium WorkSpace
Press enter or click to view image in full size

Comparison of Data Mart, Data Flow
Data Mart stores the results of all of the source tables and it extracts, stores new tables that are created as a result of data transformations.
Data Flow fetch data from different data sources and it can be created a new output table.
