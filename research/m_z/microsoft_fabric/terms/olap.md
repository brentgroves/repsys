# **[What is online analytical processing?](https://aws.amazon.com/what-is/olap/)**

Online analytical processing (OLAP) is software technology you can use to analyze business data from different points of view. Organizations collect and store data from multiple data sources, such as websites, applications, smart meters, and internal systems. OLAP combines and groups this data into categories to provide actionable insights for strategic planning. For example, a retailer stores data about all the products it sells, such as color, size, cost, and location. The retailer also collects customer purchase data, such as the name of the items ordered and total sales value, in a different system. OLAP combines the datasets to answer questions such as which color products are more popular or how product placement impacts sales.

Why is OLAP important?
Online analytical processing (OLAP) helps organizations process and benefit from a growing amount of digital information. Some benefits of OLAP include the following.

Faster decision making
Businesses use OLAP to make quick and accurate decisions to remain competitive in a fast-paced economy. Performing analytical queries on multiple relational databases is time consuming because the computer system searches through multiple data tables. On the other hand, OLAP systems precalculate and integrate data so business analysts can generate reports faster when needed.

Non-technical user support
OLAP systems make complex data analysis easier for non-technical business users. Business users can create complex analytical calculations and generate reports instead of learning how to operate databases.

Integrated data view
OLAP provides a unified platform for marketing, finance, production, and other business units. Managers and decision makers can see the bigger picture and effectively solve problems. They can perform what-if analysis, which shows the impact of decisions taken by one department on other areas of the business.

What is OLAP architecture?
Online analytical processing (OLAP) systems store multidimensional data by representing information in more than two dimensions, or categories. Two-dimensional data involves columns and rows, but multidimensional data has multiple characteristics. For example, multidimensional data for product sales might consist of the following dimensions:

Product type
Location
Time
Data engineers build a multidimensional OLAP system that consists of the following elements.

Data warehouse
A data warehouse collects information from different sources, including applications, files, and databases. It processes the information using various tools so that the data is ready for analytical purposes. For example, the data warehouse might collect information from a relational database that stores data in tables of rows and columns.

ETL tools
Extract, transform, and load (ETL) tools are database processes that automatically retrieve, change, and prepare the data to a format fit for analytical purposes. Data warehouses use ETL to convert and standardize information from various sources before making it available to OLAP tools.

OLAP server
An OLAP server is the underlying machine that powers the OLAP system. It uses ETL tools to transform information in the relational databases and prepare them for OLAP operations.

OLAP database
An OLAP database is a separate database that connects to the data warehouse. Data engineers sometimes use an OLAP database to prevent the data warehouse from being burdened by OLAP analysis. They also use an OLAP database to make it easier to create OLAP data models.

OLAP cubes
A data cube is a model representing a multidimensional array of information. While it’s easier to visualize it as a three-dimensional data model, most data cubes have more than three dimensions. An OLAP cube, or hypercube, is the term for data cubes in an OLAP system. OLAP cubes are rigid because you can't change the dimensions and underlying data once you model it. For example, if you add the warehouse dimension to a cube with product, location, and time dimensions, you have to remodel the entire cube.

OLAP analytic tools
Business analysts use OLAP tools to interact with the OLAP cube. They perform operations such as slicing, dicing, and pivoting to gain deeper insights into specific information within the OLAP cube.

## How does OLAP work?

How does OLAP work?
An online analytical processing (OLAP) system works by collecting, organizing, aggregating, and analyzing data using the following steps:

The OLAP server collects data from multiple data sources, including relational databases and data warehouses.
Then, the extract, transform, and load (ETL) tools clean, aggregate, precalculate, and store data in an OLAP cube according to the number of dimensions specified.
Business analysts use OLAP tools to query and generate reports from the multidimensional data in the OLAP cube.
OLAP uses Multidimensional Expressions (MDX) to query the OLAP cube. MDX is a query, like SQL, that provides a set of instructions for manipulating databases.

## What are the types of OLAP?

Online analytical processing (OLAP) systems operate in three main ways.

MOLAP
Multidimensional online analytical processing (MOLAP) involves creating a data cube that represents multidimensional data from a data warehouse. The MOLAP system stores precalculated data in the hypercube. Data engineers use MOLAP because this type of OLAP technology provides fast analysis.

ROLAP
Instead of using a data cube, relational online analytical processing (ROLAP) allows data engineers to perform multidimensional data analysis on a relational database. In other words, data engineers use SQL queries to search for and retrieve specific information based on the required dimensions. ROLAP is suitable for analyzing extensive and detailed data. However, ROLAP has slow query performance compared to MOLAP.

HOLAP
Hybrid online analytical processing (HOLAP) combines MOLAP and ROLAP to provide the best of both architectures. HOLAP allows data engineers to quickly retrieve analytical results from a data cube and extract detailed information from relational databases.

## What is data modeling in OLAP?

Data modeling is the representation of data in data warehouses or online analytical processing (OLAP) databases. Data modeling is essential in relational online analytical processing (ROLAP) because it analyzes data straight from the relational database. It stores multidimensional data as a star or snowflake schema.

## Star schema

The star schema consists of a fact table and multiple dimension tables. The fact table is a data table that contains numerical values related to a business process, and the dimension table contains values that describe each attribute in the fact table. The fact table refers to dimensional tables with foreign keys—unique identifiers that correlate to the respective information in the dimension table.

In a star schema, a fact table connects to several dimension tables so the data model looks like a star. The following is an example of a fact table for product sales:

- Product ID
- Location ID
- Salesperson ID
- Sales amount

The product ID tells the database system to retrieve information from the product dimension table, which might look as follows:

- Product ID
- Product name
- Product type
- Product cost

Likewise, the location ID points to a location dimension table, which could consist of the following:

- Location ID
- Country
- City

The salesperson table might look as follows:

- Salesperson ID
- First name
- Last name
- Email

Snowflake schema
The snowflake schema is an extension of the star schema. Some dimension tables might lead to one or more secondary dimension tables. This results in a snowflake-like shape when the dimension tables are put together.

For example, the product dimension table might contain the following fields:

- Product ID
- Product name
- Product type ID
- Product cost

The product type ID connects to another dimension table as shown in the following example:

- Product type ID
- Type name
- Version
- Variant

What are OLAP operations?
Business analysts perform several basic analytical operations with a multidimensional online analytical processing (MOLAP) cube.

Roll up
In roll up, the online analytical processing (OLAP) system summarizes the data for specific attributes. In other words, it shows less-detailed data. For example, you might view product sales according to New York, California, London, and Tokyo. A roll-up operation would provide a view of the sales data based on countries, such as the US, the UK, and Japan.

Drill down
Drill down is the opposite of the roll-up operation. Business analysts move downward in the concept hierarchy and extract the details they require. For example, they can move from viewing sales data by years to visualizing it by months.

Slice
Data engineers use the slice operation to create a two-dimensional view from the OLAP cube. For example, a MOLAP cube sorts data according to products, cities, and months. By slicing the cube, data engineers can create a spreadsheet-like table consisting of products and cities for a specific month.

Dice
Data engineers use the dice operation to create a smaller subcube from an OLAP cube. They determine the required dimensions and build a smaller cube from the original hypercube.

Pivot
The pivot operation involves rotating the OLAP cube along one of its dimensions to get a different perspective on the multidimensional data model. For example, a three-dimensional OLAP cube has the following dimensions on the respective axes:

X-axis—product
Y-axis—location
Z-axis—time
Upon a pivot, the OLAP cube has the following configuration:

X-axis—location
Y-axis—time
Z-axis—product

## How does OLAP compare with other data analytics methods?

Data mining
Data mining is analytics technology that processes large volumes of historical data to find patterns and insights. Business analysts use data-mining tools to discover relationships within the data and make accurate predictions of future trends.

OLAP and data mining
Online analytical processing (OLAP) is a database analysis technology that involves querying, extracting, and studying summarized data. On the other hand, data mining involves looking deeply into unprocessed information. For example, marketers could use data-mining tools to analyze user behaviors from records of every website visit. They might then use OLAP software to inspect those behaviors from various angles, such as duration, device, country, language, and browser type.

OLTP
Online transaction processing (OLTP) is a data technology that stores information quickly and reliably in a database. Data engineers use OLTP tools to store transactional data, such as financial records, service subscriptions, and customer feedback, in a relational database. OLTP systems involve creating, updating, and deleting records in relational tables.

OLAP and OLTP
OLTP is great for handling and storing multiple streams of transactions in databases. However, it cannot perform complex queries from the database. Therefore, business analysts use an OLAP system to analyze multidimensional data. For example, data scientists connect an OLTP database to a cloud-based OLAP cube to perform compute-intensive queries on historical data.
