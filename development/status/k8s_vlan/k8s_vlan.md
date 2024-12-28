# Kubernetes VLAN request

The following is in markdown format it can be viewed better from <https://markdownlivepreview.com/> by copying and pasting the contents below.

## Purpose

This VLAN is for development of applications running in an On-Prem and Cloud based Kubernetes clusters. The On-Prem development and production K8s cluster would each have for 4 network ports and reside on Dell R620 servers running Ubuntu Server 24.04 with SentinelOne installed. The Ubuntu laptop and desktop development systems would also reside on the Kubernetes VLAN network.

## **What is the request?**

A VLAN like the desktop VLAN 10.x.40.0 with these Firewall changes.

- Browsing to github.com allowed. Need access to the worlds largest source of code to learn from.
- Allow both inbound and outbound tcp communication on port 19995. This is to establash an ODBC connection to the Plex ERP at test.odbc.plex.com,38.97.236.97, and odbc.plex.com,38.97.236.75.
- Allow UDP traffic from [NPort Serial Device Servers](https://www.moxa.com/en/products/industrial-edge-connectivity/serial-device-servers/general-device-servers/nport-p5150a-series) connected to CNC to UDP listener application running in K8s cluster.
![Serial Device Server](https://cdn-cms.azureedge.net/Moxa/media/PDIM/S100000208/moxa-nport-p5150a-series-appearance-image-eng.png)
- Allow **[mTLS](https://www.cloudflare.com/learning/access-management/what-is-mutual-tls/#:~:text=Mutual%20TLS%20(mTLS)%20is%20a,other%20using%20the%20TLS%20protocol.)** access to On-Prem production K8s through **[Istio zero-trust service mesh gateway](https://istio.io/latest/about/service-mesh/#what-is-istio)** from users to run reports.

## Applications running in K8s Clusters

- **[Istio zero-trust service mesh](https://istio.io/latest/about/service-mesh/#what-is-istio)**
- **[ETL](https://aws.amazon.com/what-is/etl/)** report system.
- Tool management system with MES tool operation time collection features.
- Excel to Power BI conversion projects
