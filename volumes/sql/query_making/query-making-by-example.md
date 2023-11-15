# Query Making by Example

- What do we want to know? How many hours of vacation each person took from Jan 1 to Oct 31, 2023.

## References

- Plex SDE
- Plex view summary screen

## Query Making Process

- Review Plex views

- Open Plex SDE and view summary screens.

```sql
-- Employee
-- What employees do we want to show on final result set
SELECT plexus_customer_no, plexus_user_no, customer_employee_no as employee_no, payroll_no,
employee_status, pay_type
FROM personnel_v_employee_e
WHERE employee_status = 'Active' or employee_status = 'ADA'

-- Time_Off
-- This is the total time off hours taken in a row and can span multiple days
select 
toe.time_off_key
,toe.pcn
,toe.pun
,toe.applied_date -- date hours off took effect for employee
,toe.hours
from personnel_v_time_off_e toe
where toe.pcn = 123681
-- and toe.pun = 104389
and toe.time_off_key = 1753520
and toe.applied_date between '2023-01-01' and '2023-11-01'
order by toe.pcn,toe.pun,toe.applied_date

-- Time_Off_Period
-- The period_begin and period_end columns can have any value
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
select tot.time_off_type_key,tot.pcn,tot.time_off_type,tot.negative_allow
from personnel_v_time_off_type_e tot
where tot.pcn = 123681
-- Do all pcn have the same time_off_types? no
-- Are the time_off_types called the same thing? no
-- Do all time_off_types have negative_allow = true? no
select tot.time_off_type_key,tot.pcn,tot.time_off_type,tot.negative_allow
from personnel_v_time_off_type_e tot
order by tot.time_off_type
where tot.pcn = 123681

-- Time_Off_Day
-- The same time_off_key can have multiple time_off_days
select tod.pcn,tod.time_off_day_key,tod.time_off_key,tod.time_off_day
from personnel_v_time_off_day_e tod
where tod.pcn = 123681
and tod.time_off_key = 1753520
order by tod.pcn,tod.time_off_key,tod.time_off_day

-- Time_Off_Day_Period
-- Joins the time_off_day to time_off_period
-- The time_off_key record can span periods
select todp.time_off_day_period_key,todp.pcn
,todp.time_off_day_key
,todp.time_off_period_key
from personnel_v_time_off_day_period_e todp
where todp.time_off_day_key in (2609694,2609695,	2609693)
```

Identify the records and fields in our final result.
- Create a record for each time off type for every active employee.

```sql
-- Create a record for each time off type for every active or ADA employee.
-- What employees do we want?
-- View name: EMPLOYEE_INFO
-- 1307 records
SELECT e.plexus_customer_no pcn, e.plexus_user_no pun, e.customer_employee_no employee_no, e.payroll_no,
employee_status, pay_type
FROM personnel_v_employee_e e
WHERE e.employee_status = 'Active' or employee_status = 'ADA'

-- What time_off_type do we want?
-- Time_Off_Type
-- 10 types of time off types for Albion but there are a different number for each pcn.
-- Only ADA marked as negative_allow in some pcn.
-- What does ADA time_off_type mean?
select tot.time_off_type_key,tot.pcn,tot.time_off_type,tot.negative_allow
from personnel_v_time_off_type_e tot
where tot.pcn = 123681
-- Do all pcn have the same time_off_types? no
-- Are the time_off_types called the same thing? no
-- Do all time_off_types have negative_allow = true? no
-- 77 records
select tot.time_off_type_key,tot.pcn,tot.time_off_type,tot.negative_allow
from personnel_v_time_off_type_e tot
order by tot.time_off_type
-- view name: TIME_OFF_TYPE
-- 77 records
select tot.pcn,tot.time_off_type_key,tot.pcn,tot.time_off_type,tot.negative_allow
from personnel_v_time_off_type_e tot
order by tot.pcn,tot.time_off_type

-- What time_off_periods do we want? 
-- The period_begin and period_end columns can have any value so this won't be used in creating the final_key_set but may be used elsewhere 
-- Time_Off_Period
-- 84 records
--
-- Put altogether

-- Filter view name: employee_info
-- 1307 records
;with employee
as
(

  SELECT e.plexus_customer_no pcn, e.plexus_user_no pun 
  FROM personnel_v_employee_e e
  WHERE (e.employee_status = 'Active' or employee_status = 'ADA')
--  and e.plexus_customer_no = 123681 -- 132 records
  
),
-- Filter view name: TIME_OFF_TYPE
-- 77 records
time_off_type
as
(
  select tot.pcn,tot.time_off_type_key
  from personnel_v_time_off_type_e tot
--  where tot.pcn = 123681 -- 10 records
),
albion_key_set
as
(
  select ae.pcn,ae.pun,atot.time_off_type_key
  from
  (
  SELECT e.pcn, e.pun
  FROM employee e
  where e.pcn = 123681
  ) ae --  132 records
  cross join
  (
    select tot.time_off_type_key
    from time_off_type tot
    where pcn = 123681
  ) atot
)
-- 132 * 10 = 1320 records
--select * from albion_key_set  
-- select count(*) cnt
select aks.pcn,aks.pun,e.customer_employee_no employee_no, e.common_name, e.payroll_no, tot.time_off_type
--  employee_status, pay_type
from albion_key_set aks
join personnel_v_employee_e e 
on aks.pcn=e.plexus_customer_no
and aks.pun=e.plexus_user_no
join personnel_v_time_off_type_e tot
on aks.pcn=tot.pcn
and aks.time_off_type_key=tot.time_off_type_key
order by aks.pun,aks.time_off_type_key

 	pcn	pun	employee_no	common_name	payroll_no	time_off_type
1	123681	104389	003287	Kim	P0Y003287	PTO
2	123681	104389	003287	Kim	P0Y003287	ADA
3	123681	104389	003287	Kim	P0Y003287	Non-Scheduled Day
4	123681	104389	003287	Kim	P0Y003287	Birthday
5	123681	104389	003287	Kim	P0Y003287	UPTO
6	123681	104389	003287	Kim	P0Y003287	PTO Rollover
7	123681	104389	003287	Kim	P0Y003287	LOA
8	123681	104389	003287	Kim	P0Y003287	Non-Scheduled Weekend Day
9	123681	104389	003287	Kim	P0Y003287	Sick Time Off
10	123681	104389	003287	Kim	P0Y003287	Holiday Float
11	123681	107037	003350	Dean	D63003350	PTO
12	123681	107037	003350	Dean	D63003350	ADA
13	123681	107037	003350	Dean	D63003350	Non-Scheduled Day
14	123681	107037	003350	Dean	D63003350	Birthday
15	123681	107037	003350	Dean	D63003350	UPTO
16	123681	107037	003350	Dean	D63003350	PTO Rollover
17	123681	107037	003350	Dean	D63003350	LOA
18	123681	107037	003350	Dean	D63003350	Non-Scheduled Weekend Day
19	123681	107037	003350	Dean	D63003350	Sick Time Off
20	123681	107037	003350	Dean	D63003350	Holiday Float
21	123681	107046	003385	Rocky	D63003385	PTO
22	123681	107046	003385	Rocky	D63003385	ADA
23	123681	107046	003385	Rocky	D63003385	Non-Scheduled Day
24	123681	107046	003385	Rocky	D63003385	Birthday
25	123681	107046	003385	Rocky	D63003385	UPTO
26	123681	107046	003385	Rocky	D63003385	PTO Rollover
27	123681	107046	003385	Rocky	D63003385	LOA
28	123681	107046	003385	Rocky	D63003385	Non-Scheduled Weekend Day
29	123681	107046	003385	Rocky	D63003385	Sick Time Off
30	123681	107046	003385	Rocky	D63003385	Holiday Float
1
1
```
## Create a single view chain, CTE, per desired aggregate function

Note: In the following process do not include any columns except for identifying keys and a way to visualize them. For example, if a filter view has a primary key of time-off-day-period-key only include the primary key and a very few columns such as the employee,period type, and period or date.

1. Identify the Plex view to perform aggregete function on, aggregate function view.
2. Identify the Plex views to filter on, filter views.
3. Identify all Plex views necessary to link the filter view to the agregate view.
4. Join the aggregate function view to the filter views forming all the records to be shown in the final result.
5. Create the final result set from the mininum view chain by using the identifying keys to join to Plex views.
(Only do step 6 on very complicated queries)
6. Only if you can not perform all of the aggregate functions in just one view chain insert the records of this result set into a temp table. Then repeat the steps above until all the aggregate functions have been ran and finally join the temp tables into the final result set.


