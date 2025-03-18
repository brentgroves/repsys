# Status

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/> by copying and pasting the contents below.

**[All Status](../weekly/status_list.md)**\
**[Back to Main](../../../README.md)**

![np](https://cdn.prod.website-files.com/65a5be30bf4809bb3a2e8aff/65de6a24f3bc7cfdb5711e46_ethernet2.jpeg)

## Informational

- MRP is transitioning from MSC vending machines and are anxious about the tool management system.
- We manually run scripts to update the data warehouse that Power BI reports use as its data source.  The automated report system could be used to to run the scripts automatically.

## IS Support

### K8s Support

Request: Please update all 3 PowerEdge R620s at our Avilla location with a **[DELL Mt09V Broadcom 57800S Quadport Sfp+ Rack Converged Network Daughter Card](https://www.ebay.com/itm/DELL-Mt09V-Broadcom-57800S-Quadport-Sfp-Rack-Converged-Network-Daughter-Card/303465861553?epid=1622568435&hash=item46a7f991b1:g:wlEAAOSw5eNeMc9-)** to support two 10GB SPF+ modules.  Then connect to the extreme core switches in a bond configuration to the Fortigate Firewall pair.  Then configure the bonded pair in trunk mode on VLANs 50 and 220.

- MicroK8s install internet access testing on r620_202.
- MicroCloud install on r620_201,r620_203.
- Working with Justin L. to get needed internet access.
- Created MicroK8s VLAN github bug report.
Compiled a resource list to help us troubleshoot Kubernetes issues.

- K3s and K8s upstream github
- **[Build and Debug MicroK8s](https://github.com/canonical/microk8s/blob/master/docs/build.md)**
- **[Configure Services](https://microk8s.io/docs/configuring-services)**
- **[Configuring CNI](https://microk8s.io/docs/change-cidr)**
Given our complex network start learning this networking part of K8s.
- **[Configuring Host Interfaces](https://microk8s.io/docs/configure-host-interfaces)**

### Azure SQL database

- Modify TB scripts to work on the Azure SQL db running on Linamar's tenant.
- transfer report system schema from Mobex tenant
- test scripts on Linamar Azure tenant SQL database

time: 1 month
due date: June 2025

### Certificate Management Support

1. create server certificate for fruitport mach2 server
2. install certificate chain on jboss server
3. verify jboss is serving certificate chain
4. Give intermediate and root CA certificate to Matt Irey and David Maitner.
5. update thin clients one by one.
6. create server and client certificates for Structure Avilla Kubernetes Cluster.

time: 1 month, initial setup
due date: June 2025
recurrence: yearly

## IS Projects

### Automated Report System

- Request kicks off scripts to extract data from the Plex ERP, transform it, and then load the result into a database table in the data warehouse.
- Produce Excel, archive result set, and email to end user.
- Used for reports requiring long-running scripts or live data.
- Used to enable the creation of PowerBI dashboards for Plex ERP.

  Users: Anyone needing live or long-running reports, Excel, or Power BI dashboards.
  Status: Recently, approved for Azure resources needed for this project.

  time: 3 months
  due date: Nov 2025

### Tool Management System

  Move from managing CNC tooling in Excel and the Busche Tool List to a more robust and easy-to-use system.

  Users: Albion MRP and Engineering

  time: 6 months
  due date: Jun 2026

### Tool Tracker MES

  Automatically collect CNC, job, and start/end tool operation times for problematic tooling.
  Users: Albion Engineering and MRP
  time: 6 months
  due date: Jun 2027

## Research

- **[Setting Up Virtual Machines with QEMU, KVM, and Virt-Manager on Debian/Ubuntu](https://linuxconfig.org/setting-up-virtual-machines-with-qemu-kvm-and-virt-manager-on-debian-ubuntu)**
- **[Linux VLAN Filtering](https://www.youtube.com/watch?v=a8ghZoBZcE0&list=PLmZU6NElARbZtvrVbfz9rVpWRt5HyCeO7&index=3)**
