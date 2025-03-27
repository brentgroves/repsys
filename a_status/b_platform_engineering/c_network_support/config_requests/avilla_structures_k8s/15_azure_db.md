# Linamar Azure DB Network Config Request

Submitted : 2025-03-27 16:38:00
Request Number : REQ0195975

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

Project: Avilla Structures Kubernetes Cluster

Request: Please update the Avilla Structures "Kubernetes" policy to allow TCP port 1433 to our **[Azure SQL DB](https://learn.microsoft.com/en-us/azure/azure-sql/database/connectivity-architecture?view=azuresql#:~:text=For%20connections%20to%20use%20this%20mode%2C%20clients%20need%20to%20allow,IP%20addresses%20on%20port%201433.)**.

Reason: The applications below all need access to the Linamar Structures Azure SQL DB.

Affected Application: Automated ETL and Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Avilla Structures Kubernetes Cluster will be used to run Structures Information System software such as the Automated ETL and Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Requested Policy Change

Request TCP port 1433 access to the Structures **[Azure SQL DB](https://learn.microsoft.com/en-us/azure/azure-sql/database/connectivity-architecture?view=azuresql#:~:text=For%20connections%20to%20use%20this%20mode%2C%20clients%20need%20to%20allow,IP%20addresses%20on%20port%201433.)**.

## Key points about the firewall rule

- Protocol: TCP
- Port: 1433
- Action: Allow
- Destinations:
  - repsys1.database.windows.net
  - *database.windows.net

## Details

```bash
# OCI container registries
curl -vv telnet://repsys1.database.windows.net:1433
curl -vv telnet://repsys.database.windows.net:443

sudo tcpdump -i any -nn dst host repsys1.database.windows.net
sudo tcpdump -i any -nn dst host repsys.database.windows.net
```

## Test Process

1. Add firewall rule
2. connect to database

```bash
# run mssql server client
# connect to repsys1.database.windows.net:1433
```

John Biel
