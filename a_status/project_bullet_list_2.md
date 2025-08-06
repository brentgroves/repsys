# IS Project Bullet List

Hi Christian, Kevin, and Jared

This is a revised bullet list for the Structures information systems projects. It is suitable for our Bi-Weekly meeting.

Thank you.

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## Set up and administer the Structures Microsoft Fabric workspace

The Structures Information Systems group is setting up and administering the Structures Microsoft Fabric workspace. This workspace will help us achieve the goal of centralizing our business data to give us previously impossible insights.  

Time: ongoing

## Set up a data gateway

This **[data gateway](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-onprem)** will enable the Microsoft Fabric **[Data Factory](https://azure.microsoft.com/en-us/products/data-factory)** to access on-premise data and data sources available through ODBC connections, such as the Plex ERP. A high-availability gateway cluster can be set up on our Structures MicroCloud.  This gateway will help us achieve the goal of centralizing our business data in Linamar's Microsoft Fabric OneLake.

Time: 1 to 3 months

## Set up an automated and on-demand ETL pipeline in K8s

We manually run scripts to update the data warehouse and data lake that Power BI reports use as their raw and golden data sources.  The Automated and on-demand [ETL pipeline](https://www.informatica.com/resources/articles/what-is-etl-pipeline.html)** runs these scripts automatically or on demand.

time: 6 months to 1 year

## Administer Structures MicroCloud

Structures **[MicroCloud](https://canonical.com/microcloud)** has the following components:

- **[LXD system container and VM Cluster manager](https://documentation.ubuntu.com/lxd/stable-5.21/explanation/instances/)**
- **[OVN Cluster for SDN](https://www.ovn.org/en/architecture/)**
- **[Ceph Storage Cluster](https://docs.ceph.com/en/reef/architecture/)**

**[MicroCloud Demo](https://www.youtube.com/watch?v=M0y0hQ16YuE&t=409s)**

Time: ongoing

### Manage Structures Storage Cluster

![i1](https://docs.ceph.com/en/reef/_images/stack.png)

![i2](https://docs.ceph.com/en/reef/_images/ditaa-db39e087bb6fb671969d38bd44c9e71ff716334d.png)

- higher availability and fault tolerance
- self-healing
- 50 nodes max
- Configurable network interfaces for both public and internal traffic.
- **[S3 compatible object storage](https://www.nakivo.com/blog/wp-content/uploads/2020/06/Accessing-files-stored-in-the-S3-bucket-from-Windows-Explorer-and-a-web-browser.webp)**
- **[RBD block storage](https://docs.ceph.com/en/reef/rbd/#ceph-block-device)** for VM root file system.
- **[CephFS POSIX-compliant file system](https://docs.ceph.com/en/squid/cephfs/)**.

Time: ongoing
