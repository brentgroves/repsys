-- final key set
-- What records do we want in the final key set?
-- every active gage
--select top 10 * 
--from quality_v_gage_e g
--where g.active = 1
-- What key columns do we need?
-- quality_v_gage primary key g.plexus_customer_no , g.gage_no 

;with final_key_set
as 
(
  select g.plexus_customer_no,g.gage_no 
--  select top 10 * 
--  select count(*) cnt
  from quality_v_gage_e g
  where g.active = 1  -- 8,265
)

-- select fks.plexus_customer_no ,fks.gage_no
select count(*) cnt -- 8,265
from final_key_set fks
