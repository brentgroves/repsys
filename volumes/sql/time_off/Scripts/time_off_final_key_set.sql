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
)
-- 7362 records
--select * from albion_key_set  
--select count(*) cnt
select tope.pcn,tope.pun,ei.customer_employee_no employee_no, ei.common_name, ei.payroll_no, tot.time_off_type

from personnel_v_time_off_period_e tope
join employee e
on tope.pcn=e.pcn
and tope.pun=e.pun
join personnel_v_employee_e ei 
on tope.pcn=ei.plexus_customer_no
and tope.pun=ei.plexus_user_no
join personnel_v_time_off_type_e tot
on tope.pcn=tot.pcn
and tope.time_off_type_key=tot.time_off_type_key
----where tope.pcn = 123681
--order by tope.pun,tope.time_off_type_key

