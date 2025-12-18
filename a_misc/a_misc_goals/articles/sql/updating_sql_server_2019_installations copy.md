# SQL Server 2019 Log4j vulnerability issue

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## Security issue

A vulnerability scanner flagged Log4j on our SQL Server. This should only be an issues for SQL Server 2019 and beyond.

```bash
Apache Log4j SEoL (<= 1.x) (182252)
IP Address: 10.188.50.13 ( TCP )
DNS: pd-avi-sql01.linamar.com
Steps to Remediate
Upgrade to a version of Apache Log4j that is currently supported:
```

## **[Updating Apache Log4j on SQL 2019 installations?](https://learn.microsoft.com/en-us/answers/questions/707615/updating-apache-log4j-on-sql-2019-installations)**

Microsoft released CU16 that includes this log4j resolution.

`14669019`

Removes log4j2 used by SQL Server 2019 Integration Services (SSIS) to avoid any potential security issues.

you need to apply this:
<https://support.microsoft.com/en-us/topic/kb5011644-cumulative-update-16-for-sql-server-2019-74377be1-4340-4445-93a7-ff843d346896>

| Bug reference | Description                                                                                                | Fix area             | Component | Platform |
|---------------|------------------------------------------------------------------------------------------------------------|----------------------|-----------|----------|
| **[14669019](https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2019/cumulativeupdate16#14669019)**      | Removes log4j2 used by SQL Server 2019 Integration Services (SSIS) to avoid any potential security issues. | Integration Services | DTS       | All      |

## Team

- Christian Trujillo, IT Structures Manager
- Jared Davis, IT Manager
- Kevin Young, Information Systems Manager
- Sam Jackson, Information Systems Developer, Southfield
- Angelina Shadder, Muscle Shoals, Cyber Securtity, Desktop and Systems Support Technician
- Carl Stangland, Desktop and System Support Technician, Indiana

```bash
Thanks,
Brent 
260.564.4868
```
