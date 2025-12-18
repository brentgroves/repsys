-- Intelli Scrap Report 2
-- select top 10 * from Accelerated_Production_v

/*
table: part_v_production 
primary key: plexus_customer_no,Production_No
indexes:
1. PK_Production_PT	
Plexus_Customer_No,Production_No
2. Report_Date	
Plexus_Customer_No
Report_Date
Workcenter_Key
Quantity
*/

/*
SELECT top 10 *
FROM part_v_production WITH (INDEX("[Report_Date]"))

SELECT top 10 *
FROM Accelerated_Production_v

;WITH prepod as (
select plexus_customer_no
,report_date  
--,rejected
--,note
--,quantity
from part_v_production WITH (INDEX("[Report_Date]"))
WHERE report_date > dateadd(day, -32, current_timestamp)
AND report_date < dateadd(day, -1, current_timestamp))
select top 10 * from prepod
*/

;WITH
    prepod
    as
    (
        select report_date, workcenter_key, part_key,
            CASE
  WHEN rejected = 1 then convert(numeric, REPLACE(TRANSLATE(note, 'abcdefghijklmnopqrstuvwxyz+()- ,#+:', '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'), '@', ''))
  ELSE quantity end as 'Quantity'
        from part_v_production
        WHERE report_date > dateadd(day, -32, current_timestamp)
            AND report_date < dateadd(day, -1, current_timestamp)
    )


SELECT report_date, part_no, sum(cast) as cast, sum(scrap) as scrap
FROM(
                        SELECT
            p.report_date,
            pa.part_no,
            sum(p.quantity) as 'cast',
            null as 'scrap'
        from prepod as p
            JOIN part_v_workcenter as w
            on p.workcenter_key = w.workcenter_key
            join part_v_part as pa
            on p.part_key = pa.part_key
        WHERE w.workcenter_type = 'Caster'
            AND p.report_date > dateadd(day, -32, current_timestamp)
            AND p.report_date < dateadd(day, -1, current_timestamp)
            AND pa.part_no LIKE '5___'
        group by p.report_date, pa.part_no

    UNION ALL

        SELECT
            s.report_date,
            p.part_no,
            null as 'cast',
            sum(s.quantity) as 'scrap'
        from part_v_scrap as s
            join part_v_part as p
            on s.part_key = p.part_key
        WHERE s.scrap_reason NOT IN ('Destruct Test','Inventory Adjust')
            AND s.report_date > dateadd(day, -32, current_timestamp)
            AND s.report_date < dateadd(day, -1, current_timestamp)
        group by s.report_date, p.part_no)TBL
WHERE part_no LIKE '5___'
group by report_date, part_no
order by report_date desc