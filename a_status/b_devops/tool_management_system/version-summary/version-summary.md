# Version Features

## Report System Version 1

Going to deploy this to Nutanix K8s cluster and have asked for an IT person interested in administoring a Kubernetes Cluster.

- Only 1 table to hold the result set.
- 1 set of tables to hold intermediate result sets.
- Scripts are in Bash and Python.
- Cron job starts ETL scripts.
- Working on REST API to run scripts from Curl.
- React.js app to allow custumers to request reports parameters include email address.
- Feather.js API inserts customer request into table.
- Go program monitors request table and launches main report ETL scripts.
- Result set includes date/time ran field to show in the report.
- An excel file is created from the report result set and emailed to the customer.
- Can view the report from Power BI or React.js which displays the date/time the ETL scripts were ran.  

## Report System Version 2

This is designed to be scalable.

- There are multiple worker databases since any report run blocks other reports from being ran until completions.
- Cron jobs ensure the source tables needed for each report are uptodate as much as possible.
- Go threads are each assigned to each worker database. The number of worker databases is scalable.
- Report runs are archived and can be used for regular reports, diff reports, or emailing excel files of past reports.
