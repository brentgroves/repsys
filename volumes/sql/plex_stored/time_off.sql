--What do we want to know? How many hours of vacation each person took

--SELECT tod.pcn, todp.time_off_period_key, SUM(tod.hours) as dayhours
--FROM personnel_v_time_off_day_e as tod
--
--JOIN TIMEOFF as toff
--ON tod.time_off_key = toff.time_off_key
--AND tod.pcn = toff.pcn
--
--JOIN personnel_v_time_off_day_period_e as todp
--ON tod.time_off_day_key = todp.time_off_day_key
--AND tod.pcn = todp.pcn
--
--GROUP BY tod.pcn, todp.time_off_period_key


--Review our Plex views

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