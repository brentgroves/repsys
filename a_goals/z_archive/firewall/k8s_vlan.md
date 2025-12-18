# Kubernetes VLAN request

The following is in markdown it can be viewed better from <https://markdownlivepreview.com/> by copying and pasting the contents below.

## VLAN description

This VLAN is for the development of applications running in an On-Prem and Cloud based Kubernetes cluster. The On-Prem development and production K8s cluster would each have four network ports and reside on Dell R620 servers running Ubuntu Server 24.04 with SentinelOne installed. The Ubuntu laptop and desktop development systems would also reside on the Kubernetes VLAN network.

## Question

- How did MicroK8s admin access cluster?
- Like Linus VLAN.

## Request

structures network. config request.
recommend:

- windows sub system.
- vm ubuntu server
- mill river.
- repsys, tool management,

A VLAN like the desktop VLAN 10.x.40.0 with these Firewall changes.

- Browsing to github.com allowed.

  Need access to the world's largest source of code to learn from.

- Allow both inbound and outbound TCP communication on port 19995.

  This establishes an ODBC connection to the Plex ERP at test.odbc.plex.com,38.97.236.97, and odbc.plex.com,38.97.236.75.

- Allow UDP traffic from [NPort Serial Device Servers](https://www.moxa.com/en/products/industrial-edge-connectivity/serial-device-servers/general-device-servers/nport-p5150a-series) connected to CNC to UDP listener application running in K8s cluster.

  ![Serial Device Server](https://cdn-cms.azureedge.net/Moxa/media/PDIM/S100000208/moxa-nport-p5150a-series-appearance-image-eng.png)

- Allow **[mTLS](https://www.cloudflare.com/learning/access-management/what-is-mutual-tls/#:~:text=Mutual%20TLS%20(mTLS)%20is%20a,other%20using%20the%20TLS%20protocol.)** access to On-Prem production K8s through **[Istio zero-trust service mesh gateway](https://istio.io/latest/about/service-mesh/#what-is-istio)**

    This allows secure access from a browser or command line.

- Allow inbound/outbound TCP traffic on port 1433 to/from vending machines.

## IS Projects

- Automatic end-user requestable Excel from Plex ERP

  - **[End-user request kicks off scripts to extract data from the Plex ERP, transforms it, and then loads the result into a database table in the data warehouse.](https://grpc.io/docs/what-is-grpc/introduction/)**

  - Produce Excel, archive result set, and email to end user.

- **[Tool Management](https://en.wikipedia.org/wiki/Tool_management)**

  Move away managing tooling in Excel and the Busche Tool List to a more rubust and easy to use system.

- **[Tool Tracker](https://en.wikipedia.org/wiki/Manufacturing_execution_system)**

  Automatically collect CNC, job, and start/end tool operation times for problematic tooling.

- **INC0417507 - Excel VBA to Power BI**

  I suggest we migrate this VBA Excel program to a Web App, SQL database, and Power BI. The downside to this suggestion is that it would take some time. The upside is that the Web App can perform validation on the dates and other information before being saved to the database. Using VBA it is easy to create complex programs to solve business needs quickly, but it is difficult to make these programs robust.

- Linus **[Platform](https://platformengineering.org/blog/what-is-platform-engineering)** and **[Site Reliability Engineering (SRE)](https://aws.amazon.com/what-is/sre/#:~:text=Site%20reliability%20engineering%20(SRE)%20teams%20collect%20critical%20information%20that%20reflects,application%20responds%20to%20a%20request.)**

  - Research and make recommendations to improve platform reliability.
  - Use MicroK8s on-prem cluster for research and testing.
  - Prove **[security](https://www.infracloud.io/blogs/request-level-authentication-authorization-istio-keycloak/)** and reliability of **[Azure AKS](https://learn.microsoft.com/en-us/azure/aks/what-is-aks#:~:text=Azure%20Kubernetes%20Service%20(AKS)%20is,of%20that%20responsibility%20to%20Azure.)**.

  - **[Istio Service Mesh SRE monitoring](https://sysdig.com/blog/monitor-istio/)**

    ![isre](https://sysdig.com/wp-content/uploads/image8-6.png)

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
