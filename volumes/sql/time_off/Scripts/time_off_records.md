# Identify the records and fields in our final result

- Create a record for each time off type for every active or ADA employee.
- Must contain pcn,pun,employee_no,common_name,payroll_no, time_off_type, and sum of hours taken between '2023-01-01' and '2023-11-01'

## Time_Off_Period Plex view

- The period_begin and period_end columns can have any value
- An HR person creates the time_off_period record at the beginning of the year or when they are hired or switch jobs.
- The HR person does not create a time_off_period record for time_off_types unelligible to that person.
- So this Plex view is a good candidate for the final key set.
