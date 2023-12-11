;with gage
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
,DATEADD(day, g.calibration_frequency, gr.record_date) calc_next_calibration
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
,gage_record
as
(
--IIF(condition, true_value, false_value);
  select ng.*,pg.calc_next_calibration calibration_required
--  , IIF(ng.actual_calibration>pg.next_calibration_required,'late','ok') status
  from gage ng
  left outer join gage pg
  on ng.pcn=pg.pcn
  and ng.gage_no=pg.gage_no
  and ng.row_num=pg.row_num-1
  
)
select gr.row_num,gr.pcn,gr.gage_no
,IIF(((gr.calibration_required is not null) and gr.actual_calibration>gr.calibration_required),'late','ok') status
,gr.calibration_required
,gr.actual_calibration
,gr.freq
,gr.calc_next_calibration 
from gage_record gr
where row_num <= 5
order by gr.pcn,gr.gage_no,gr.calibration_required desc
--select g.row_num,g.pcn,g.gage_no,g.actual_calibration,g.freq,g.next_calibration_required 
--from gage g
--where row_num <= 5
--order by g.pcn,g.gage_no,g.next_calibration_required desc