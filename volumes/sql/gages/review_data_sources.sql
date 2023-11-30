-- What do we want to do? 
Add a required date for past calibrations.

-- Plex data sources

-- Get_Gage2
-- type: sproc
-- Purpose: For displaying the grid on the gage list page 
-- Used In: Gage_Control/Gage.asp -- 06/07/05 tmcg: changed variable char param sizes to match table, removed UDFs in order by.  Changed big case in order by to be multiple single when cases. 

-- dbo.Gage
-- G.Last_Calibration_Date, 
-- G.Next_Calibration_Date, 
-- G.Calibration_Frequency, 

-- quality_v_gage_record:
-- - add_date: what the next_calibration_date is based on.

--Review our Plex views
Gage_Record
select top 1000 * from Quality_v_Gage_Record
-- Add Date = Record By Date
-- Return Date = Issue Date
-- Record Date = Record Date
-- Gage_Record_Type has table with Calibration flag
-- Gage Frequency, is it based on first calibration, or latest calibration?
-- After testing, it's based on latest ADD_DATE (record by date) date
-- Pass or Fail -> Quality_v_Gage_Measurement
-- Last Due Date = Previous Record_Date + gage calibration frequency


