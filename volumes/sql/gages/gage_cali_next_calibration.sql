;with gage_record
as
(
select 
row_number() 
over 
(
partition by g.plexus_customer_no,g.gage_no 
order by g.plexus_customer_no,g.gage_no,gr.record_date desc
) row_num
,g.plexus_customer_no pcn
,g.gage_no
,gr.record_date actual_calibration
,g.calibration_frequency freq
,DATEADD(day, 365, gr.record_date) next_calibration_required
from quality_v_gage g
join quality_v_gage_record gr
on g.plexus_customer_no= gr.plexus_customer_no
and g.gage_no=gr.gage_no
where g.plexus_customer_no = 300757
--and g.gage_id = 'AD-117-1'
and g.gage_no between 349521 and 349522
and g.active=1
-- order by gr.record_date desc
)
select gr.pcn,gr.gage_no,gr.actual_calibration,gr.next_calibration_required 
from gage_record gr
where row_num <= 5
order by gr.pcn,gr.gage_no,gr.next_calibration_required desc

