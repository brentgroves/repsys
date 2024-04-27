Error
SQL72014:
Core Microsoft SqlClient Data
Provider:
Msg 208, Level 16, State 1, Procedure daily_metrics_pivot_view, Line 158 Invalid object name 'Plex.daily_shift_report_get_aggregate_view'.
Error
SQL72045:
Script execution error.  The executed
script:
CREATE VIEW Report.daily_metrics_pivot_view
AS
WITH   part_pivot
AS     (    SELECT 5 AS id,
        'Gross Volume Produced' AS name,
        *
    FROM (SELECT part_no,
            m.parts_produced
        FROM Report.daily_metrics AS m) AS m PIVOT (sum (parts_produced) FOR part_no IN ([H2GC 5K652 AB], [H2GC 5K651 AB], [TR121895], [10103355], [10115487])) AS pvt
UNION
    SELECT 10 AS id,
        'Parts Scrapped' AS name,
        *
    FROM (SELECT part_no,
            m.parts_scrapped
        FROM Report.daily_metrics AS m) AS m PIVOT (sum (parts_scrapped) FOR part_no IN ([H2GC 5K652 AB], [H2GC 5K651 AB], [TR121895], [10103355], [10115487])) AS pvt
UNION
    SELECT 15 AS id,
               'Quantity_Produced' AS name,
               *
        FROM   (SELECT part_no,
            m.produced_minus_scrapped
        FROM Report.daily_metrics AS m) AS m PIVOT (sum (produced_minus_scrapped) FO
