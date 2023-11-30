# final key set

What records do we want in the final key set?

- every active gage
- last x gage calibration records

Where are calibrations stored? quality_v_gage_record
How to order gage_records? add_date

## data sources

quality_v_gage:

- gage_no: primary key
- calibration_frequency

quality_v_gage_record:

- add_date: what the next_calibration_date is based on.
- type: "calibration"

Quality_v_Gage_Measurement

- status: pass/fail

## Plex Screens

master gage list
calibration manager
gage control

