# Kubernetes VLAN request

The following is in markdown format it can be viewed better from <https://markdownlivepreview.com/> by copying and pasting the contents below.

## Players

- Adrian Wise
- Kristian Smith
- Aamir Ghaffar
- Christian Trujillo
- Brent Hall
- Kevin Young
- Jared Davis
- Dan Martin
- Heather Luttrell
- Jake Kunkel
- Nancy Swank
- Mike Percel
- Vladimir Chevtchenko
- Elden Maynard

## For

- Automatic end-user requestable Excel from Plex ERP

  **[End-user request kicks off scripts to extract data from the Plex ERP, transforms it, and then loads the result into a database table in the data warehouse.](https://grpc.io/docs/what-is-grpc/introduction/)**
- **[Tool Management](https://en.wikipedia.org/wiki/Tool_management)**

  Move away from managing tooling in Excel and the Busche Tool List to a more robust system using Plex and/or custom software.
- **[Tool Tracker](https://en.wikipedia.org/wiki/Manufacturing_execution_system)**

  Automatically collect CNC, job, and start/end tool operation times for problematic tooling.
- INC0417507 "ppar excel macro file error message"

  Migrate this VBA Excel program to a Web App, SQL database, and Power BI.



## What

This VLAN is for the development of applications running in an On-Prem and Cloud based Kubernetes cluster. The On-Prem development and production K8s cluster would each have four network ports and reside on Dell R620 servers running Ubuntu Server 24.04 with SentinelOne installed. The Ubuntu laptop and desktop development systems would also reside on the Kubernetes VLAN network.



## Players

- Adrian Wise
- Kristian Smith
- Aamir Ghaffar
- Christian Trujillo
- Brent Hall
- Kevin Young
- Jared Davis
- Dan Martin
- Heather Luttrell
- Jake Kunkel
- Nancy Swank
- Mike Percel
- Vladimir Chevtchenko
- Elden Maynard

## Request

A VLAN like the desktop VLAN 10.x.40.0 with these Firewall changes.

- Browsing to github.com allowed. 

  Need access to the world's largest source of code to learn from.
- Allow both inbound and outbound TCP communication on port 19995. 

  This is to establish an ODBC connection to the Plex ERP at test.odbc.plex.com,38.97.236.97, and odbc.plex.com,38.97.236.75.
- Allow UDP traffic from [NPort Serial Device Servers](https://www.moxa.com/en/products/industrial-edge-connectivity/serial-device-servers/general-device-servers/nport-p5150a-series) connected to CNC to UDP listener application running in K8s cluster.

  ![Serial Device Server](https://cdn-cms.azureedge.net/Moxa/media/PDIM/S100000208/moxa-nport-p5150a-series-appearance-image-eng.png)
- Allow **[mTLS](https://www.cloudflare.com/learning/access-management/what-is-mutual-tls/#:~:text=Mutual%20TLS%20(mTLS)%20is%20a,other%20using%20the%20TLS%20protocol.)** access to On-Prem production K8s through **[Istio zero-trust service mesh gateway](https://istio.io/latest/about/service-mesh/#what-is-istio)**

  For users to access IS apps from a browser or command line.

- Allow inbound/outbound TCP traffic on port 1433 to/from vending machines.



