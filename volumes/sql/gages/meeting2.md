# gage report

## Gage report and plex admin, Intelliplex, or SQL tech share from anyone

- Plex admin, Intelliplex, or SQL tech share from anyone
- **[final_key_set](./gage_cali_final_key_set.sql)**
- **[required columns](./gage_cali_required_columns.sql)**
- **[Ask Sam to go over his recursive function](./sj_get_gage2.sql)**
- **[next_calibration](./gage_cali_next_calibration.sql)**
- **[Smoothing techniques](../../../linux/time-series-analysis/smoothing-techniques.md)**

Notes from this meeting will be located at: ~/src/repsys/volumes/sql/gages/meeting2.md
To get a fresh copy please run ~/freshstart.sh at a command prompt.
It can be viewed by logging into devcon2 as bcieslik,bcook,sjackson,cstangland,jdavis,or kyoung with password k8sAdmin1! and opening meeting1.md from visual studio code and pressing shift-ctrl-v

**[How to compute MA in SQL](https://learnsql.com/blog/moving-average-in-sql/)**

```sql
select *,
  avg(Price) OVER(ORDER BY Date
     ROWS BETWEEN 2 PRECEDING AND CURRENT ROW )
     as moving_average
from stock_price;
```

To explain the code in detail:

- We use a window function, denoted with an OVER clause. As explained earlier, the rows are not collapsed, and each row has its own window over which a calculation is performed.
- The size of the window in our example is three. For each given row, we take the row itself and the two previous rows, and we calculate the average price from those three rows. This is denoted by the ROW keyword in the statement: ROWS BETWEEN 2 PRECEDING AND CURRENT ROW. This statement says that, for each row in the table, something is calculated as an aggregation of the current and the previous two rows. This means that the moving average for each row is calculated as the mean price from the given day and the two previous days.
- We have a different window frame for each day. Below, you can see an illustration of the window frame used for the row corresponding to January 9 (in green) and the window frame used for the row corresponding to June 27 (in blue):

![calc](https://learnsql.com/blog/moving-average-in-sql/Image-5.png)

- It is important that the data not have any gaps in dates. For each day, we need to calculate the average of the prices from that day and the two previous days. If there are missing dates in the data, this analysis will not make sense.
- The ORDER BY keyword inside the OVER clause defines the order of the rows over which the moving average should be calculated. In our example, the rows are first sorted by the date column, then the window frame is defined, and the calculation is performed.
- For this example, we do not use the PARTITION BY keyword in the OVER clause. PARTITION BY groups rows into logical chunks by some category, but we are not grouping rows that way here. In effect, our whole data set is just one large partition. Later in this article, we will see an example with a PARTITION BY.
