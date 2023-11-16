--What do we want to know? How many hours of vacation each person took between a date range.
-- pcn,pun,employee_no,common_name,payroll_no, time_off_type, sum of hours taken between '2023-01-01' and '2023-11-01'

-- Time_Off_Period
-- The period_begin and period_end columns can have any value
-- HR creates the time_off_period record at the beginning of the year or when an employed is hired or switch jobs.
-- HR does not create a time_off_period record for time_off_types unelligible to that person.
-- So this Plex view is a good candidate for the final key set.

-- What employees do we want?
-- Filter view name: employee
-- 1307 records
--SELECT e.plexus_customer_no pcn, e.plexus_user_no pun, e.customer_employee_no employee_no, e.payroll_no,
--employee_status, pay_type
--FROM personnel_v_employee_e e
--WHERE e.employee_status = 'Active' or employee_status = 'ADA'

-- Filter view name: employee
-- 1307 records
;with employee
as
(

--  SELECT e.plexus_customer_no pcn, e.plexus_user_no pun, e.customer_employee_no employee_no, e.payroll_no,
--  employee_status, pay_type
--  FROM personnel_v_employee_e e
--  WHERE e.employee_status = 'Active' or employee_status = 'ADA'
--  select distinct pcn, pun from
--  (
--    SELECT e.plexus_customer_no pcn, e.plexus_user_no pun 
--    FROM personnel_v_employee_e e
--    WHERE e.employee_status = 'Active' or employee_status = 'ADA'
--  ) a
  
--  select count(*) cnt
  SELECT e.plexus_customer_no pcn, e.plexus_user_no pun 
  FROM personnel_v_employee_e e
  -- 1315 records
  WHERE (e.employee_status = 'Active' or employee_status = 'ADA')
--  and e.plexus_customer_no = 123681 -- 132 records
),
final_key_set
as
(
--  select count(*) cnt
  select tope.pcn,tope.time_off_period_key,tope.pun,tope.time_off_type_key
  from personnel_v_time_off_period_e tope
  join employee e
  on tope.pcn=e.pcn
  and tope.pun=e.pun

)
-- records 7362
--select count(*) cnt from final_key_set
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
  select toe.pcn,toe.pun,toe.time_off_period_key,toe.time_off_type_key,SUM(toe.hours) hours
  from time_off_employee as toe
  group by toe.pcn,toe.time_off_period_key,toe.pun,toe.time_off_type_key
)
-- 2636 records
--select count(*) from time_off_type_hours
SELECT cgm.plexus_customer_code, fks.pun, e.customer_employee_no  employee_no
,e.payroll_no, e.employee_status, usr.last_name, usr.first_name, e.pay_type
,tot.time_off_type,p.active period_active,p.time_off_period_key,p.period_begin,p.period_end
,p.allowed_hours,p.accrued_hours,isnull(toth.hours,0) used_before_november
-- records: 7362
-- select count(*) cnt
from final_key_set fks
left outer join time_off_type_hours toth
on fks.pcn=toth.pcn
and fks.pun=toth.pun
and fks.time_off_period_key=toth.time_off_period_key
and fks.time_off_type_key=toth.time_off_type_key
-- records: 7361
-- records: 1978 the reduction went away after I ran the query about 20 times
JOIN plexus_control_v_customer_group_member as cgm
on fks.pcn = cgm.plexus_customer_no

JOIN plexus_control_v_plexus_user_e as usr
on fks.pun = usr.plexus_user_no
and fks.pcn = usr.plexus_customer_no

join personnel_v_employee_e e
on fks.pcn=e.plexus_customer_no
and fks.pun=e.plexus_user_no

join personnel_v_time_off_type_e tot
on fks.pcn=tot.pcn
and fks.time_off_type_key=tot.time_off_type_key

join personnel_v_time_off_period_e p
on fks.pcn = p.pcn
and fks.time_off_period_key=p.time_off_period_key

