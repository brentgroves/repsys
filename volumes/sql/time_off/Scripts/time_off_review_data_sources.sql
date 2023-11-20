--What do we want to know? How many hours of vacation each person took

--Review our Plex views

-- Employee
-- What employees do we want to show on final result set
--SELECT plexus_customer_no, plexus_user_no, customer_employee_no as employee_no, payroll_no,
--employee_status, pay_type
--FROM personnel_v_employee_e
--WHERE employee_status = 'Active' or employee_status = 'ADA'

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
-- The period_begin and period_end columns can have any value
-- An HR person creates the time_off_period record at the beginning of the year or when they are hired or switch jobs.
-- The HR person does not create a time_off_period record for time_off_types unelligible to that person.
-- So this Plex view is a good candidate for the final key set.
select tope.time_off_period_key,tope.pcn
,tope.pun
,tope.time_off_type_key
,tope.allowed_hours
,tope.accrued_hours
,tope.period_begin
,tope.period_end
from personnel_v_time_off_period_e tope
where tope.pcn = 123681
and tope.time_off_period_key = 446008

-- Time_Off_Type
-- 10 types of time off types for Albion but there are a different number for each pcn.
-- Only one marked as negative_allow
-- What does ADA time_off_type mean?
--select tot.time_off_type_key,tot.pcn,tot.time_off_type,tot.negative_allow
--from personnel_v_time_off_type_e tot
--where tot.pcn = 123681
-- Do all pcn have the same time_off_types? no
-- Are the time_off_types called the same thing? no
-- Do all time_off_types have negative_allow = true? no
--select tot.time_off_type_key,tot.pcn,tot.time_off_type,tot.negative_allow
--from personnel_v_time_off_type_e tot
--order by tot.time_off_type
--where tot.pcn = 123681

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

