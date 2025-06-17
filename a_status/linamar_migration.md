# Mobex Azure SQL MI to Linamar Azure SQL database migration

## summary

- done.
- 8 of 8 scripts and work tables validated.
- Checked 200 of 4000 result set values by hand.
todo:
- Completed diff of result set.

## Azure SQL database changes made

- Created an archive schema to backup hard-to-replace tables.
- The last account_activity_summary period was 202501, but the last valid period was 202410. When we run this script now, it will update 202505 and 202506 period records, leaving a gap from 202502 to 202504. This is ok. If we need the 202502 to 202504 account activity records, we will modify the Plex SPROC to pull that date range.

We need an anchor period from which to start calculating running totals. This anchor period must contain account totals from the beginning of the year or back to the first Plex period at Southfield.

The Azure SQL database was created from a Linux SQL server backup of an Azure SQL MI backup. The last 13-period TB script set ran on the Azure SQL MI before the backup was run in 202501 for 202312 to 202412.

|id   |pcn    |start_period|end_period|start_open_period|end_open_period|no_update|
|-----|-------|------------|----------|-----------------|---------------|---------|
|1,739|123,681|202401      |202410    |202411           |202,501        |0        |

We could delete account_activity_summary records after each TB script is set to save a lot of storage space.

When we run the 13-period TB script set now, it will delete the accounting_balance records from 202406 to 202504 and repopulate with the current Plex account balances.

- accounting_account_year_category_type match.
- accounting_account  match
- accounting_period both match
- accounting_period_ranges match
- The last good anchor period is 202311
- add 3 accounts to 202401
- add 13 accounts to 202404
- add 6 accounts on 202405
When we run the 13-period TB from 202406 to 202506
- We will use 202405 as the anchor period.
- 202405 will have the same number of accounts.

-

## process

1. Created a backup of Linamar's Azure SQL MI and imported it into an on-prem SQL Server database. Then, created a backup of the OnPrem database and imported it into the Azure SQL database. Importing of backups from Azure SQL MI to Azure SQL database is not supported. Done.
2. Connect to Plex using the OpenAccess data direct ODBC driver from the second system running a newer version of Ubuntu and OpenSSL, which does not support the preferred TLS 1.2 cipher suite that the DataDirect driver uses by default. Done.
3. Create Linamar Azure SQL database DSN. Done.
4. Run Southfield's Trial Balance ETL scripts pointing to Mobex Azure SQL MI as usual.
5. Run Southfield's Trial Balance ETL scripts pointing to the Linamar Azure SQL database.
6. Compare row counts and a few values of all 5 work tables in Mobex Azure SQL MI to the same tables in Linamar's Azure SQL database.
7. Import the Mobex Azure SQL MI Trial Balance result into Linamar's Azure SQL database and compare the result set using SQL.
8. Run Southfield's Trial Balance Power BI report pointing to Linamar's Azure SQL database result set, export Excel for the last 13 periods, and send to Dan Martin for verification.

## update lastpass for mi

```bash
pushd .. 
cd ~/src/Reporting2/prod/k8s/secrets/lastpass
./print-etc-lastpass.sh
# on dev system update local passwords in /etc/lastpass
./sed-lastpass-sh.sh reports31 30031 reports32 30332 reports 1
ls /etc/lastpass
# ssh to dev system
./lastpass_mi.sh
./print-etc-lastpass.sh

```

## run tb

## update lastpass for repsys1

```bash
pushd .. 
cd ~/src/Reporting2/prod/k8s/secrets/lastpass
./print-etc-lastpass.sh
# on dev system update local passwords in /etc/lastpass
./sed-lastpass-sh.sh reports31 30031 reports32 30332 reports 1
ls /etc/lastpass
# ssh to dev system
./lastpass_repsys1.sh
./print-etc-lastpass.sh

```
