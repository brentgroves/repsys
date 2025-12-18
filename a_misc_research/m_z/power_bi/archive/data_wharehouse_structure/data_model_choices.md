# **[Data Modeling: One Big Table vs Kimball vs Relational for data engineers](https://www.youtube.com/watch?v=ltQgbSs99WU)**

- one big table
- kimball
- relational

- how does it happen
- why is there so many ways
- when does kimball fail

## one big table

- Extension of kimball and denormalizing even more.
- Not much different than kimball.
- a table within a table. use complex data types: array and struct. Actually an array of structs. Essentially put a table in a column.
- do aggregation and sums without groupby. just sum the array.
- long term analysis minimize shuffle and makes queries more performant.
- suck all the fact data into the dimensional
- trading storage for compute. saving a lot on compute by not having to do joins. storage in data lake is cheap. compute is more expensive.

- pros
  - answer questions without joins.

- kimball
the standard for analytics
  - pros
    - most important as data engineer
    - dim/fact tables
    - good for analytics
    - good for historic
  - cons
    - no transactions
- relational
The standard for production databases.
  - pros
    - production application
    - enforces data integrity
  - cons
    - join a lot of tables for analysis
    - poorly for analytics
    - only latest state of data
