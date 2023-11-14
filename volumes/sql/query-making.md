# SQL Query Making

## Create a single view chain, CTE, per desired aggregate function

Note: In the following process do not include any columns except for identifying keys and a way to visualize them. For example, if a filter view has a primary key of time-off-day-period-key only include the primary key and a very few columns such as the employee,period type, and period or date.

1. Identify the Plex view to perform aggregete function on, aggregate function view.
2. Identify the Plex views to filter on, filter views.
3. Identify all Plex views necessary to link the filter view to the agregate view.
4. Join the aggregate function view to the filter views forming all the records to be shown in the final result.
5. Create the final result set from the mininum view chain by using the identifying keys to join to Plex views.
(Only do step 6 on very complicated queries)
6. Only if you can not perform all of the aggregate functions in just one view chain insert the records of this result set into a temp table. Then repeat the steps above until all the aggregate functions have been ran and finally join the temp tables into the final result set.


