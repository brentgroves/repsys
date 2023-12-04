-- List a description of the columns needed on each record of the final key set.
-- pcn
-- gage_id
-- calibration_frequency, 
-- last_calibration_date_required: calculated from quality_v_gage_record.add_date and quality_v_gage.calibration_frequency (required calibration frequency in days)	

select top 10 g.plexus_customer_no,g.gage_no,g.gage_id,
gr.record_date,g.calibration_frequency, 
--SELECT DATEADD(year, 1, '2017/08/25') AS DateAdd;
DATEADD(day, 365, gr.record_date) calibration_date_required
from Quality_v_Gage g
join quality_v_gage_record gr
on g.plexus_customer_no= gr.plexus_customer_no
and g.gage_no=gr.gage_no
where g.plexus_customer_no = 300757
and g.gage_id = 'AD-117-1'
order by gr.record_date desc

-- last_calibration_date_actual, 
-- pass/fail
-- next_calibration_date, 

