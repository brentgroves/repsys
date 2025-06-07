# Mobex Azure SQL MI to Linamar Azure SQL database migration

## summary

The Microsoft ODBC driver works for Azure SQL database.
The Plex DataDirect OpenAccess ODBC driver gives a segmentation fault every time. The driver was written in C, and Python is written in C, so I'm not surprised since the Plex ODBC driver has not been updated in a long time, while the Python ODBC modules have. We catch the error and continue the pipeline.

3 of 8 scripts and work tables validated.

## details

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
