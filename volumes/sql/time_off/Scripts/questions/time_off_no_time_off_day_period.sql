;with time_off
-- This is the total time off hours requested by the employee
-- We loss time_off_day records unless we change the 
-- applied_date range to start one month before the earliest time_off_day
-- 1 to many relationship with time_off_day hours which has at most 8 hours
as
(
   select toff.time_off_key,toff.pcn,toff.pun
-- 10451 records
--  select count(*) cnt
  from personnel_v_time_off_e as toff
  where toff.applied_date between '2022-01-01' and '2023-11-01'
)
,time_off_day
as
(
   select tod.time_off_day_key,tod.time_off_key,tod.pcn,tod.hours
   -- ,toff.time_off_type_key,tod.hours 
-- 16601 records
--  select count(*) cnt
  from personnel_v_time_off_day_e as tod
  where tod.time_off_day between '2023-01-01' and '2023-11-01'
)
,time_off_day_time_off
as
(
  select tod.pcn,tod.time_off_day_key,toff.time_off_key,toff.pun
  from time_off_day tod
  join time_off toff
  on tod.pcn=toff.pcn
  and tod.time_off_key=toff.time_off_key
)
-- records: 16,601 we loss time_off_day records unless we change the 
-- applied_date range to start one month before the earliest time_off_day
-- select count(*) cnt from timeoffday_timeoff
-- still need time_off_type and this info is in the time_off_period_view
,time_off_day_period
as
(
  select todp.pcn,todp.time_off_period_key,tod.time_off_day_key,tod.hours
  from time_off_day tod
  join personnel_v_time_off_day_period_e todp
  on tod.pcn=todp.pcn
  and tod.time_off_day_key=todp.time_off_day_key
)
-- records 13,222
-- WHY: more than 3000 time_off_day_records do not have a time_off_day_period record
-- select count(*) cnt from time_off_day_period
,time_off_employee
as
(
  select tope.pcn,tope.time_off_period_key,tope.pun,tope.time_off_type_key,todp.hours
  from time_off_day_period todp
  join personnel_v_time_off_period_e tope
  on todp.pcn=tope.pcn
  and todp.time_off_period_key=tope.time_off_period_key
)
-- records: 13222
select count(*) cnt from time_off_employee
