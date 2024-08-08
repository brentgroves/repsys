# Network Upgrade

**[Current Status](../weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

Hi Jared,

I know you will be super busy next week,so I would like to give you a list of items now I will need to run the Southfield Monthly Balance report which will be requested on Aug 5th or 6th. Thank you Jared and good luck with the network upgrade!

- Thank you
Brent
260-564-4868

The following is in markdown format it can be viewed better from <https://markdownlivepreview.com/>.

## Network Requests

- 50 static IP addresses.
- 8 network cables ran to each R620 currently I only have 3.
- New gateway address
- New name server addresses
- Need to be physically on the servers to change the IPs.
- I completely wipe these R620s occassionally so I would like a key to the server room.

## Important Windows VMs

- alb-utl.busche-cnc.com (10.1.1.150) has ETL ssis scripts which we run from Visual Studio
- alb-utl4 (10.1.1.151) Power BI Report Builder
- busche-sql.BUSCHE-CNC.com (10.1.2.74) Busche Tool List for the Busche Reporter.

## Azure SQL MI

May need rights to add our public IP to the database firewall rules.

## 3 Dell PowerEdge R620s

Will probably need to be physically on the servers to change the IPs.

### Netplan configuration for Repsys11 Ubuntu 24.04 server

```yaml
network:
    ethernets:
        eno1:
            addresses:
            - 10.1.0.125/22
            nameservers:
                addresses:
                - 10.1.2.69
                - 10.1.2.70
                - 172.20.0.39
                search: [BUSCHE-CNC.COM]
            routes:
            -   to: default
                via: 10.1.1.205
        eno2:
            dhcp4: no
        eno3:
            dhcp4: no
        eno4:
            dhcp4: true
        enp66s0f0:
            dhcp4: true
        enp66s0f1:
            dhcp4: true
        enp66s0f2:
            dhcp4: true
        enp66s0f3:
            dhcp4: true
    bridges:
        br0:
            dhcp4: no
            addresses:
            - 10.1.0.126/22
            nameservers:
                addresses:
                - 10.1.2.69
                - 10.1.2.70
                - 172.20.0.39
                search: [BUSCHE-CNC.COM]
            interfaces: [eno2]
        br1:
            dhcp4: no
            addresses:
            - 10.13.31.1/24
        br2:
            dhcp4: no
            addresses:
            - 10.1.0.127/22
            nameservers:
                addresses:
                - 10.1.2.69
                - 10.1.2.70
                - 172.20.0.39
                search: [BUSCHE-CNC.COM]
            interfaces: [eno3]
    version: 2
```

### Multipass VM - K8S with SQL Server

```yaml
network:
    ethernets:
        default:
            dhcp4: true
            match:
                macaddress: 52:54:00:b7:ef:90
        extra0:
            addresses:
            - 10.1.0.128/22
            nameservers:
                addresses:
                - 10.1.2.69
                - 10.1.2.70
                - 172.20.0.39
                search: [BUSCHE-CNC.COM]
            match:
                macaddress: 52:54:00:a6:3d:3e
            optional: true
    version: 2
```

### Multipass VM - K8S with MySQL Server

```yaml
network:
    ethernets:
        default:
            dhcp4: true
            match:
                macaddress: 52:54:00:a8:40:63
        extra0:
            addresses:
            - 10.1.0.129/22
            nameservers:
                addresses:
                - 10.1.2.69
                - 10.1.2.70
                - 172.20.0.39
                search: [BUSCHE-CNC.COM]
            match:
                macaddress: 52:54:00:90:6f:18
            optional: true
    version: 2
```

### Netplan configuration Repsys12

## **[Add Azure SQL MI public endpoints](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/public-endpoint-configure?view=azuresql&tabs=azure-portal)**

## **[Azure Firewall rules](https://learn.microsoft.com/en-us/azure/azure-sql/database/firewall-configure?view=azuresql#connections-from-the-internet)**

![](https://learn.microsoft.com/en-us/azure/azure-sql/database/media/firewall-configure/sqldb-firewall-1.png?view=azuresql)
