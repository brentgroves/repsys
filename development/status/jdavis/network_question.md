# Network Questions

**[Current Status](../weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

1. Is it possible to have a faster connection from Albion to Avilla to RDP from Albion to Avilla and to run ETL scripts from Albion that accesses Cloud and Avilla data sources?

2. Is it possible to create a VM in SF to test connection speed to Albion/Avilla web server.

This markdown can be viewed by copying this entire document into <https://markdownlivepreview.com/>.

## references

- **[Network Speed Testing](https://www.baeldung.com/linux/network-speed-testing)**

## Using iperf

iperf is a tool for measuring the maximum TCP and UDP bandwidth performance over IP. Hence, it helps to identify the network’s throughput capacity by generating traffic and measuring the data transfer rates between systems.

## Network details

```bash
# from Albion box
traceroute reports-avi  
traceroute to reports-avi (172.20.88.64), 30 hops max, 60 byte packets
 1  _gateway (10.1.1.205)  0.768 ms  0.686 ms  0.652 ms
 2  reports-avi (172.20.88.64)  29.900 ms  29.867 ms  29.835 ms
```

## Route from Albion to Avilla

From Albion box
to 10.1.1.205 Albion firewall connected to ligtel
Going over vpn to avilla Firewall 172.20.88.1
Firewall 172.20.88.1 connected to comcast (maybe why connection from Albion to Avilla is slow)
Firewall 10.188.250.? Ligtel located in Avilla connect (good speed)
<!-- From Avilla ping 10.187.10.12 switch in albion  1 to 2 ms -->

## vlan 2nd octet

187 albion
188 avilla
185 southfield

## vlan 3rd octet

50 - server
48 - desktop/laptom
30 - printer

## IP address for k8s development cluster on R620s

10.188.50.125-145 server vlan

## IP address for k8s production cluster on Nutanix

10.188.50.145-165 server vlan

## Summary

| From   | To       | Protocol | speed                         |
|--------|----------|----------|-------------------------------|
| Albion | Internet | Http/s   | 825.4 mbps down/810.1 mbps up |
| Albion | Albion   | RDP      | good                          |
| Avilla | Internet | TDS      | same as always - good         |
| Avilla | Avilla   | TDS      | good                          |
| Albion | Avilla   | SSH      | usable                        |
| Albion | Avilla   | TDS      | very poor                     |
| Albion | Avilla   | RDP      | very poor                     |
| SF     | Alb/Avi  | Http/s   | not tested                    |

## RDP

- We can RDP from Albion desktop to Albion VM as expected.
- We can ssh from Albion (10.1.0.113) to Avilla (172.20.88.64) ok.
- We can not RDP from Albion (10.1.0.113) to Avilla (172.20.88.64) very well because the connection is so slow that it is almost unusable.

## RDP Details

- Albion Ubuntu desktop (10.1.0.113)
- Albion Ubuntu VM (10.1.0.120)
- Albion Windows VM alb-utl (10.1.1.150)
- Albion Windows VM alb-utl4 (10.1.1.151)
- Avilla Ubuntu desktop (172.20.88.64)

## Script time comparison

This is a comparison of this month's and last month's Python scripts.  These scripts pull data from Cloud data sources and push data to a cloud and on-prem data source.

## Script Details

- Run Python scripts from Albion (10.1.0.113) and Avilla (172.20.88.64)
- Copy data from Plex (odbc.plex.com)
- Write data to Azure SQL DB (mgsqlmi.public.48d444e7f69b.database.windows.net)
- Write data to Avilla MySQL DB (172.20.88.61)

| Name                                     | Script_History_Key | Script_Key | Start_Time              | End_Time                | Done | Error | Time |

|------------------------------------------|--------------------|------------|-------------------------|-------------------------|------|-------|------|

| AccountingYearCategoryType.dtsx          | 82,521             | 3          | 2024-08-08 17:26:21.130 | 2024-08-08 17:26:32.900 | 1    | 0     | 11   |

| AccountingYearCategoryType.dtsx          | 82,520             | 3          | 2024-08-08 17:19:48.207 | 2024-08-08 17:24:49.627 | 1    | 0     | 301  |

| AccountingYearCategoryType.dtsx          | 82,519             | 3          | 2024-08-08 17:18:06.910 | 2024-08-08 17:18:17.820 | 1    | 0     | 11   |

| AccountingYearCategoryType.dtsx          | 82,513             | 3          | 2024-08-08 16:59:33.333 | 2024-08-08 17:04:40.460 | 1    | 0     | 307  |

| AccountingYearCategoryType.dtsx          | 82,512             | 3          | 2024-08-08 16:51:54.953 | 2024-08-08 16:52:09.130 | 1    | 0     | 15   |

| AccountingYearCategoryType.dtsx          | 82,431             | 3          | 2024-08-07 17:22:59.310 | 2024-08-07 17:28:18.100 | 1    | 0     | 319  |

| AccountingYearCategoryType.dtsx          | 82,423             | 3          | 2024-08-07 15:06:28.527 | 2024-08-07 15:12:43.083 | 1    | 0     | 375  |

| AccountingYearCategoryType.dtsx          | 82,337             | 3          | 2024-08-06 17:50:30.850 | 2024-08-06 17:55:58.280 | 1    | 0     | 328  |

| AccountingYearCategoryType.dtsx          | 79,615             | 3          | 2024-07-05 16:55:30.893 | 2024-07-05 16:56:07.553 | 1    | 0     | 37   |

| AccountingPeriodRanges                   | 82,342             | 4          | 2024-08-06 18:05:32.950 | 2024-08-06 18:05:39.237 | 1    | 0     | 7    |

| AccountingPeriodRanges                   | 79,618             | 4          | 2024-07-05 16:56:43.030 | 2024-07-05 16:56:46.903 | 1    | 0     | 3    |

| AccountingPeriod                         | 82,341             | 5          | 2024-08-06 18:03:45.047 | 2024-08-06 18:04:11.447 | 1    | 0     | 26   |

| AccountingPeriod                         | 79,617             | 5          | 2024-07-05 16:56:31.847 | 2024-07-05 16:56:42.087 | 1    | 0     | 11   |

| AccountingBalanceAppendPeriodRange       | 82,343             | 6          | 2024-08-06 18:07:00.540 | 2024-08-06 18:08:22.187 | 1    | 0     | 82   |

| AccountingBalanceAppendPeriodRange       | 79,624             | 6          | 2024-07-05 17:44:18.320 | 2024-07-05 17:44:34.190 | 1    | 0     | 16   |

| AccountingAccount.dtsx                   | 82,338             | 1          | 2024-08-06 17:58:29.127 | 2024-08-06 18:02:21.053 | 1    | 0     | 232  |

| AccountingAccount.dtsx                   | 79,616             | 1          | 2024-07-05 16:56:08.563 | 2024-07-05 16:56:30.880 | 1    | 0     | 22   |

| AccountActivitySummaryGetOpenPeriodRange | 82,344             | 7          | 2024-08-06 18:12:22.533 | 2024-08-06 18:21:21.157 | 1    | 0     | 539  |

| AccountActivitySummaryGetOpenPeriodRange | 79,625             | 7          | 2024-07-05 17:44:35.160 | 2024-07-05 17:46:00.760 | 1    | 0     | 85   |
