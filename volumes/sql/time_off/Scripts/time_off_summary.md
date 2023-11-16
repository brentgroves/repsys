# Time Off Summary

## References

## Time Off queries

- **[Review data sources](./time_off_review_data_sources.sql)**
- **[Final key set](./time_off_final_key_set.sql)**
- **[Aggregate time off hours](time_off_aggegate_hours.sql)**

## Summary

- Dropped some records when joining time_off_day to time_off_day_period which contains the pun and time_off_type_key

```sql
-- records 16,601
--select count(*) cnt from time_off_day
,time_off_day_period
as
(
  select todp.pcn,todp.time_off_period_key,tod.time_off_day_key,tod.hours
  from time_off_day tod
  join personnel_v_time_off_day_period_e as todp
  on tod.pcn=todp.pcn
  and tod.time_off_day_key=todp.time_off_day_key
)
-- records 13,222
-- WHY: more than 3000 time_off_day_records do not have a time_off_day_period record
--select count(*) cnt from time_off_day_period
,time_off_employee
as
(
  select tope.pcn,tope.time_off_period_key,tope.pun,tope.time_off_type_key,todp.hours
  from time_off_day_period todp
  join personnel_v_time_off_period_e as tope
  on todp.pcn=tope.pcn
  and todp.time_off_period_key=tope.time_off_period_key
)
```

- Reviewing the Plex time_off views allowed us see that we should use the time_off_day instead of time_off view to filter the date range.

- Troubled that we did not to join certain views by pcn.  

```sql
,time_off_day
as
(
   select tod.time_off_day_key,tod.pcn,tod.hours
   -- ,toff.time_off_type_key,tod.hours 
-- 16601 records
--  select count(*) cnt
  from personnel_v_time_off_day_e as tod
  where tod.time_off_day between '2023-01-01' and '2023-11-01'
-- 13222 records
--  join personnel_v_time_off_day_period_e as todp
--  on tod.pcn=todp.pcn
--  and tod.time_off_day_key=todp.time_off_day_key
--  where tod.time_off_day between '2023-01-01' and '2023-11-01'

)
-- still need a pun and a time_off_type and this info is in the time_off_period_view
-- records 16,601
--select count(*) cnt from time_off_day
,time_off_day_period
as
(
  select todp.pcn,todp.time_off_period_key,tod.time_off_day_key,tod.hours
  from time_off_day tod
  join personnel_v_time_off_day_period_e as todp
  on tod.pcn=todp.pcn
  and tod.time_off_day_key=todp.time_off_day_key
)
-- records 13,222
-- WHY: more than 3000 time_off_day_records do not have a time_off_day_period record
--select count(*) cnt from time_off_day_period
,time_off_employee
as
(
  select tope.pcn,tope.time_off_period_key,tope.pun,tope.time_off_type_key,todp.hours
  from time_off_day_period todp
  join personnel_v_time_off_period_e as tope
  on todp.pcn=tope.pcn
  and todp.time_off_period_key=tope.time_off_period_key
)
-- records: 13222
-- select count(*) cnt from time_off_employee
,time_off_type_hours
as
(
  select toe.pcn,toe.pun,toe.time_off_period_key,toe.time_off_type_key,SUM(toe.hours) as time_off_type_hours
  from time_off_employee as toe
  group by toe.pcn,toe.time_off_period_key,toe.pun,toe.time_off_type_key
)

``````

- Dropped many records when joining to the plexus_control_v_plexus_user_e  view.

```sql
SELECT cgm.plexus_customer_code, fks.pun, e.customer_employee_no  employee_no
,e.payroll_no, e.employee_status, usr.last_name, usr.first_name, e.pay_type
,tot.time_off_type
from final_key_set fks
left outer join time_off_type_hours toth
on fks.pcn=toth.pcn
and fks.pun=toth.pun
and fks.time_off_period_key=toth.time_off_period_key
and fks.time_off_type_key=toth.time_off_type_key
-- records: 7362
JOIN plexus_control_v_customer_group_member as cgm
on fks.pcn = cgm.plexus_customer_no
-- records: 1978
JOIN plexus_control_v_plexus_user_e as usr
on fks.pun = usr.plexus_user_no
and fks.pcn = usr.plexus_customer_no
```
