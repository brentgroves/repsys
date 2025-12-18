# REQ0193020/RITM0193066

Good Afternoon, John

The following is background information on the Plex ERP ODBC and the upcoming Plex SOAP web service network configuration requests. Thank you.

Players:

- John Biel - Manager, Network IT - Executive
- Justin Langille - Network Technician, Junior IT - Networking
- Pat Baxter, General Manager
- Christian. Trujillo, IT Structures Manager
- Kevin Young, Information Systems Manager
- Jared Davis, IT Manager
- Michael Percell, Manufacturing Engineering Manager
- Dan Martin, Plant Controller Southfield
- Jami Pyle, MP&L Manager
- Nancy Swank, Material Planner
- Hayley Rymer, IT Supervisor

The following is in markdown format.  It can be viewed better from <https://markdownlivepreview.com/> by copying and pasting the contents below.

## Summary

### Short version

The Structures Information System team creates Plex reports using an ODBC connection to the Plex ERP database when running reports requiring long-running SQL queries.

- Protocol: TCP
- Port: 19995
- Action: Allow
- Destination: "test.odbc.plex.com:19995 and odbc.plex.com:19995"

### Additional SOAP config request

We will be submitting an additional request for micro services running on our Structures Avilla Kubernetes cluster to have access to the Plex **[SOAP](https://www.techtarget.com/searchapparchitecture/definition/SOAP-Simple-Object-Access-Protocol)** server. Both the SOAP web service and an ODBC connection access the Plex database.  The differences are that Plex maintains the SQL SPROCs of the SOAP web services, which access the live database, and Structures Information System maintains the SQL queries in a snapshot of the database when connecting via ODBC.  

### Detailed version

The automated report service deployed into the Structures Avilla Kubernetes cluster will collect requests from **[authenticated and authorized](https://learn.microsoft.com/en-us/entra/identity-platform/authentication-vs-authorization)** Linamar employees and then run a sequence of **[ETL scripts](https://www.ibm.com/think/topics/etl#:~:text=ETL%E2%80%94meaning%20extract%2C%20transform%2C,lake%20or%20other%20target%20system.)** to produce a result set residing on our Public IP secured data warehouse. Another script is then processed that generates an Excel file from the result set and uses a **[Linamar registered app service](https://docs.cloudblue.com/connect/connectors/Microsoft_SaaS/18.4/Office365_Distributor/Registering%20and%20Configuring%20the%20Azure%20App%20Service.htm)** to email it to the Linamar employee.

## Requested Policy Change

Request TCP connection to Plex test and production databases.

## Key points about the firewall rule

- Protocol: TCP
- Port: 19995
- Action: Allow
- Destination: "test.odbc.plex.com:19995 and odbc.plex.com:19995"

## Details

```bash
# From system with access to Plex databases
telnet test.odbc.plex.com 19995
Trying 38.97.236.97...
Connected to test.odbc.plex.com.
Escape character is '^]'.
# From Structures Avilla Kubernetes system.
telnet test.odbc.plex.com 19995
Trying 38.97.236.97...
```
