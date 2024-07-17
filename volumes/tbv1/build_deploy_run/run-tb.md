# Linamar change notes

From Alb-utl Download the TRIALBALANCE report from plex and import it into the DW
Run Power BI report from Alb-utl4.

## Idea

/*

* Try to find any new accounts by comparing Plex.account_period_balance to Plex.accounting_account_year_category_type
* after the AccountingYearCategoryType.sh script and before the AccountPeriodBalanceRecreatePeriodRange.sh script
 */

select top 10 b.pcn,b.account_no, c.pcn,c.[year],c.account_no
from Plex.accounting_account_year_category_type c
left outer join Plex.account_period_balance b
on c.pcn = b.pcn
and c.account_no = b.account_no
where c.pcn = 123681 -- 23,063
and c.[year] = 2024
order by b.pcn

## Issue

Timeout issue with the "AccountActivitySummaryGetOpenPeriodRange"
SOAP web service script.
20240507:
open-period range was 202403 to 202405. It worked on 202403 and 202404 but failed on 202405 the active period. I shutdown all apps on my dev system and ran again with no error. There maybe an issue when more than 2 Plex SOAP web services are called one after another. Or there maybe some issue with running the scripts while memory resources are low.

## **Format of file name**

## Note call to web service did not work until I stopped the MSSQL Server docker container

"Heather Luttrell" <Heather.Luttrell@Linamar.com>

TB-202306_to_202406_on_07-07_DM_HL
TB-202305_to_202405_on_06-07_DM
TB-202304_to_202404_on_05-08_DM
TB-202304_to_202404_on_05-07_DM
TB-202303_to_202403_on_04-05_DM
TB-202302_to_202402_on_03-08_DM
TB-202301_to_202401_on_02-09_DM
TB-202301_to_202401_on_02-08B_DM
TB-202301_to_202401_on_02-08_DM
TB-202212_to_202312_on_01-09_DM
TB-202212_to_202312_on_01-03_DM_LR
TB-202211_to_202311_on_12-12_DM_LR_JS
TB-202211_to_202311_on_12-08_DM_LR_JS
TB-202210_to_202310_on_11-21_DM_GP_LR
TB-202210_to_202310_on_11-20_DM_GP_LR
TB-202210_to_202310_on_11-13_DM_GP_LR
TB-202210_to_202310_on_11-07_DM_GP
TB-202209_to_202309_on_10-24_DM_GP

TB-202209_to_202309_on_10-18_DM_GP

TB-202209_to_202309_on_10-17_DM
TB-202209_to_202309_on_10-17_GP

TB-202209_to_202309_on_10-10_DM
TB-202209_to_202309_on_10-10_GP

## install lastpass in k8s and on dev system

```bash
pushd ~/src/Reporting/prod/k8s/secrets/lastpass
./print-etc-lastpass.sh
mysql_host=$1
mysql_port=$2
mongo_host=$3
mongo_port=$4
mongo_db=$5
azure_dw=$6
./sed-lastpass-yaml.sh reports31 30031 reports32 30332 reports 1
ssh to cluster
kubectl apply -f lastpass.yaml
on dev system update local passwords in /etc/lastpass
./sed-lastpass-sh.sh reports31 30031 reports32 30332 reports 1
ls /etc/lastpass
ssh to dev system
./lastpass.sh
```

**initailize the scripts for prod or dev
pushd ~/src/Reporting/prod/volume
mysql_host=$2
mysql_port=$3
azure_dw=$4
mongo_host=$5
mongo_port=$6
mongo_db=$7

if debugging the python script then
./sed-volume.sh dev reports31 30031 1 reports32 30332 reports
if running the TrialBalance.sh or TrialBalance-test.sh script manually then:  
./sed-volume.sh prod reports31 30031 1 reports32 30332 reports

## run trial balance scripts

```bash
pushd ~/src/Reporting/prod/volume/PipeLine

TB-202306_to_202406_on_07-07_DM_HL
TB-202305_to_202405_on_06-07_DM
TB-202304_to_202404_on_05-08_DM
TB-202304_to_202404_on_05-07_DM
TB-202303_to_202403_on_04-05_DM
TB-202302_to_202402_on_03-08_DM
TB-202301_to_202401_on_02-12_DM
TB-202301_to_202401_on_02-09_DM
TB-202301_to_202401_on_02-08B_DM
TB-202212_to_202312_on_01-18_BG // to test bug fix
TB-202212_to_202312_on_01-09b_DM // This was after a bug fix and ran sprocs manually
TB-202212_to_202312_on_01-04_DM_LR
TB-202212_to_202312_on_01-03_DM_LR
TB-202211_to_202311_on_12-12_DM_LR_JS
TB-202211_to_202311_on_12-08_DM_LR_JS // time: 15:00, period 202311 was not closed
TB-202210_to_202310_on_11-21_DM_GP_LR
TB-202210_to_202310_on_11-20_DM_GP_LR
TB-202210_to_202310_on_11-13_DM_GP_LR
TB-202210_to_202310_on_11-07_DM_GP
TB-202209_to_202309_on_10-24_DM_GP

TB-202209_to_202309_on_10-18_DM_GP

conda activate reports

# usage ./TrialBalance-test.sh "TB" "<bgroves@buschegroup.com>" "202201" "202301" 0 "once"

# If start_period_update = 1 the AccountingStartPeriodUpdate script will run

./TrialBalance-test.sh "TB" "bgroves@buschegroup.com" "202306" "202406" 0 "once"

```

run dbeaver
open azure_account_period_balance_validate.sql and mysql_trial_balace_validation.sql
follow steps

/*

* Detected an error on 03/09/2023:
* no_update = 1 but there were no 2023-01 balance records at all.
* The daily scripts were not running during this period.
* Until the scripts are running again run the TrialBalance pipeline
* with start_period_update = 0 so all the balance records will be
* pulled from Plex everytime.
 */
 TB-202306_to_202406_on_07-07_DM_HL

TB-202211_to_202311_on_12-12_DM_LR_JS
TB-202211_to_202311_on_12-08_DM_LR_JS
TB-202207_to_202307_on_08-24_DM
TB-202207_to_202307_on_08-24_GP
TB-202203_to_202303_on_04-11_DM
TB-202203_to_202303_on_04-11_GP
export report_name=$1
export email=$2
export start_period=$3
export end_period=$4
export start_period_update=$5
export frequency=$5
./TrialBalance-test.sh TB <bgroves@buschegroup.com> 202203 202303 0 once

## Update MySQL Trialbalance table with Plex CSV

Still working on this CsvToTrialBalanceMultiLevel script. Delete and inserts are working so next pass start_period and end_period to shell script. Copy Trial_Balance to ~/src/Reporting directory for now.
It looks like it inserts the records ok now I need to delete the periods in the table before inserting the new records.

## From Alb-utl Download the TRIALBALANCE report from plex and import it into the DW

goto azure_account_period_balance_validate.sql
/*

* Decide which TB periods to pull by  
* each period has 2 records. ordinal 1 is the most recent
* goto Main Compare: section and locate the last period to have any differences
* and import all periods after and including that one for both balance and activity_summary records.
* TB-202211_to_202311_on_12-12_DM_LR_JS pull just 202311
* TB-202211_to_202311_on_12-08_DM_LR_JS
* TB-202210_to_202310_on_11-13_DM_GP_LR
* TB-202210_to_202310_on_11-07_DM_GP
* TB-202209_to_202309_on_10-17_DM found 1 diff between 202210 and 202308 from the trial_balance_multi_level so i imported 202308 again
* TB-202209_to_202309_on_10-10_DM found no diff between 202210 and 202308 from the trial_balance_multi_level so did not import 202308 again
* TB-202208_to_202308_on_09-18_DM found no diff between 202209 and 202307 from the trial_balance_multi_level so did not import 202307 again
* TB-202208_to_202308_on_09-13_DM found no diff between 202208 and 202307 from the trial_balance_multi_level so did not import 202307 again
* TB-202208_to_202308_on_09-11_DM found no diff between 202208 and 202307 from the trial_balance_multi_level so did not import 202307 again
* TB-202207_to_202307_on_08-24_DM found no diff between 202207 and 202307 from the trial_balance_multi_level so did not import 202307 again
* TB-202207_to_202307_on_08-09_DM found no diff between 202207 and 202306 so just need to import 202307
* TB-202206_to_202306_on_07-11_DM found no diff between 202206 and 202305 so just need to import 202306
* TB-202205_to_202305_on_06-13_DM dan made minor adjustments to 202305
* TB-202205_to_202305_on_06-09_DM found no diff between 202205 and 202304 so just need to import 202305
* 05-09-2023: diff found in 202303 between trial_balance_multi-level and accounting_period_balance
* 04-11-2023: diff found in 202303 between trial_balance_multi-level and accounting_period_balance
* TB-202203_to_202303_on_04-11_DM
* TB-202203_to_202303_on_04-11_GP
* 03-09-2023: Pulled 202302 to 202303 since there where no updates on 202301 since 2023-02-27
* 03-02-2023: Pulled 202212 to 202301
 */

Thank you Father for the peace that you have given me in troubles, pain, and sorrow!

## run TB report

Run TB report, trial_balance.rdl, from any Windows machine with the Power BI report builder installed. Use YYYYMM format for period range parameters.

go to ~/src/secrets/namespaces/credentials
and use username2/password2 to authenticate.

**Format of file name**
TB-202306_to_202406_on_07-07_DM_HL

TB-202301_to_202401_on_02-12_DM
TB-202301_to_202401_on_02-09_DM
TB-202301_to_202401_on_02-08B_DM
TB-202301_to_202401_on_02-08_DM
TB-202212_to_202312_on_01-03_DM_LR
TB-202211_to_202311_on_12-12_DM_LR_JS
TB-202211_to_202311_on_12-08_DM_LR_JS
TB-202210_to_202310_on_11-20_DM_GP_LR
TB-202210_to_202310_on_11-13_LR_DM_GP
TB-202210_to_202310_on_11-07_DM_GP
TB-202209_to_202309_on_10-24_DM_GP

TB-202209_to_202309_on_10-18_DM_GP
TB-202209_to_202309_on_10-17_DM

Hi Dan,
Are you expecting to see any changes between this TB and the one I sent you on the 13th? I'm asking because I didn't see any changes between the two but that does not mean there could not have been updates it only means there were no updates that show up in the Plex version of the TB.  So, if the changes happened on accounts that are not displayed in the Plex version of the TB then there could still be changes between this TB and the one I sent on the 13th.
