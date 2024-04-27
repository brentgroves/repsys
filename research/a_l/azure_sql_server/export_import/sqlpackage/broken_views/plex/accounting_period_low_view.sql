Error
SQL72014:
Core Microsoft SqlClient Data
Provider:
Msg 207, Level 16, State 1, Procedure accounting_period_low_view, Line 39 Invalid column name 'low_account'.
Error
SQL72045:
Script execution error.  The executed
script:
CREATE VIEW Plex.accounting_period_low_view (
    pcn,
    account_key,
    account_no,
    period,
    next_period
)
AS
WITH   fiscal_period (pcn, year, period)
AS
(
    SELECT pcn,
        year(begin_date) AS year,
        period
    FROM Plex.accounting_period
    WHERE  pcn = 123681
),
       max_fiscal_period (pcn, year, max_fiscal_period)
AS
(
    SELECT pcn,
        year,
        max(period) AS max_fiscal_period
    FROM fiscal_period
    GROUP BY pcn, year
),
       anchor_member (pcn, account_key, account_no, period, next_period)
AS     (SELECT a.pcn,
    a.account_key,
    a.account_no,
    a.start_period AS period,
    CASE WHEN a.start_period < m.max_fiscal_period THEN a.start_period + 1 ELSE ((a.start_period / 100 + 1) * 100) + 1 END AS next_period
FROM Plex.accounting_account AS a
    INNER JOIN
    Plex.max_fiscal_period AS m
    ON a.pcn = m.pcn
    