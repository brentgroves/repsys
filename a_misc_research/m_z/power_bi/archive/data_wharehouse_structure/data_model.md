# **[Master Data Modeling in Power BI - Beginner to Pro Full Course](https://www.youtube.com/watch?v=air7T8wCYkU)**

Fact Table

- Lowest level of granularity
- What does 1 row represent
Sales at the transaction level.
We have millions of dollars worth of sales but what product.
but we don't have product information because are grain statement was just at the transaction.
if we want the information we have to make sure the row represents the product of a transaction.
you record every line item.
If you store data at a higher level you loose dimensionality.
You won't be able to filter by product.
Always store data at the lowest level of granularity because you never know what you will be asked to filter on.
We don't know how end users will filter the data or slice the data. you never know what kind of questions they will ask. and we want them to adopt the data model.
if you do this wrong you will have to start over.
what what where when that surrounds a business process.
dimension table is wider than a table in the relational model
dimension has primary/natural key
- Surragate key (unique key) in dimension table that has no relationship back to the source unique to the data warehouse is an advanced concepy
descriptive attributes not codes
start/end date
slowly changing data
is holiday season, boolean flag, in dimensional table.
date table
year over year
rolling totals

when building a star schema you are trying to consolidate as many attributes as you can into a single table.
architecture of a dimension table is very wide. category, sub category generally are added into the product table.
price is tricky. price today is not going to be the price in the future or the past.

slowly changing dimensions. dimensions that change over time.

Slowly changin dimensions is import. study this.
