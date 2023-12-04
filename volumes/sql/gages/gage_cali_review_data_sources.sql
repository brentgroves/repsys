--Where are calibrations stored? quality_v_gage_record
--How to order gage_records? add_date
--
--## data sources
--
--quality_v_gage:
--
--- gage_no: primary key
--- calibration_frequency: required calibration frequency in days
--filter: active=1
--
--quality_v_gage_record:
--
--- add_date: what the next_calibration_date is based on.
--- type: "calibration"
--
--Quality_v_Gage_Measurement
--
--- status: pass/fail
--

-- Plex Screens

--gage control = master gage list

-- main gage view

select top 10 calibration_frequency,* 
from Quality_v_Gage g
where g.gage_id = 'AD-117-1'

-- history of calibrations

select 
top 10
* 
from quality_v_gage_record
