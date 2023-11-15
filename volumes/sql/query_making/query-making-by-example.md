# Query Making by Example

- What do we want to know? How many hours of vacation each person took from Jan 1 to Oct 31, 2023.

## References

- Plex SDE
- Plex view summary screen

## Query Making Process

- Review Plex views

- Open Plex SDE and view summary screens.

```bash
-- Time_Off
-- This is the total time off hours taken in a row and can span multiple days
--select 
--toe.time_off_key
--,toe.pcn
--,toe.pun
--,toe.applied_date -- date hours off took effect for employee
--,toe.hours
--from personnel_v_time_off_e toe
--where toe.pcn = 123681
---- and toe.pun = 104389
--and toe.time_off_key = 1753520
--and toe.applied_date between '2023-01-01' and '2023-11-01'
--order by toe.pcn,toe.pun,toe.applied_date

-- Time_Off_Period
select tope.time_off_period_key,tope.pcn
,tope.pun
,time_off_type_key
,period_begin
,period_end
from personnel_v_time_off_period_e tope
where tope.pcn = 123681
and tope.time_off_period_key = 446008


-- Time_Off_Day
-- The same time_off_key can have multiple time_off_days
--select tod.pcn,tod.time_off_day_key,tod.time_off_key,tod.time_off_day
--from personnel_v_time_off_day_e tod
--where tod.pcn = 123681
--and tod.time_off_key = 1753520
--order by tod.pcn,tod.time_off_key,tod.time_off_day

-- Time_Off_Day_Period
-- Joins the time_off_day to time_off_period
-- The time_off_key record can span periods
--select todp.time_off_day_period_key,todp.pcn
--,todp.time_off_day_key
--,todp.time_off_period_key
--from personnel_v_time_off_day_period_e todp
--where todp.time_off_day_key in (2609694,2609695,	2609693)
```

- Identify the records and fields in our final result.

Create a record for each time off type for each time_off_period for every active employee.





## Create a single view chain, CTE, per desired aggregate function

Note: In the following process do not include any columns except for identifying keys and a way to visualize them. For example, if a filter view has a primary key of time-off-day-period-key only include the primary key and a very few columns such as the employee,period type, and period or date.

1. Identify the Plex view to perform aggregete function on, aggregate function view.
2. Identify the Plex views to filter on, filter views.
3. Identify all Plex views necessary to link the filter view to the agregate view.
4. Join the aggregate function view to the filter views forming all the records to be shown in the final result.
5. Create the final result set from the mininum view chain by using the identifying keys to join to Plex views.
(Only do step 6 on very complicated queries)
6. Only if you can not perform all of the aggregate functions in just one view chain insert the records of this result set into a temp table. Then repeat the steps above until all the aggregate functions have been ran and finally join the temp tables into the final result set.


