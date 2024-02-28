CREATE VIEW Plex.accounting_account123
AS
    (SELECT *
    FROM Plex.accounting_account AS a
    WHERE  a.first_digit_123 = 1);

