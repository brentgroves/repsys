CREATE VIEW Scratch.accounting_period_balance_low (
    period,
    account_no,
    debit,
    ytd_debit,
    credit,
    ytd_credit,
    balance,
    ytd_balance
)
AS
WITH   account_period_low (pcn, account_key, account_no, period, next_period)
AS     (SELECT a.pcn,
    a.account_key,
    a.account_no,
    a.start_period AS period,
    CASE WHEN a.start_period % 100 < 12 THEN a.start_period + 1 ELSE ((a.start_period / 100 + 1) * 100) + 1 END AS next_period
FROM Plex.accounting_account AS a
    INNER JOIN
    Scratch.ytd_problem AS p
    ON a.account_no = p.account_no
WHERE  a.pcn = 123681
    AND a.low_account = 1
    AND a.start_period != 0
        UNION ALL
        SELECT p.pcn,
               p.account_key,
               p.account_no,
               CASE WHEN p.period % 100 < 12 THEN p.period + 1 ELSE ((p.period / 100 + 1) * 100) + 1 END AS period,
               CASE WHEN p.next_period % 

