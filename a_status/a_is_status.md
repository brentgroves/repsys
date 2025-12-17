# Information Systems Status

The following is in markdown format and can be viewed by copying and pasting the entire content of this email into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## Reports

- Shift Bad Part
- Part Dimension Index, $TotalDimensions/TotalParts$

## Q&A

- Checksheet
- Marposs gage network cable worked with the SDS, may need another cable to connect to the OT file server.
- The on-prem databases such as pd-avi-sql01 will need a service account or special username in order to be used as Power BI data sources through the data gateway.
- Can we find a rack location to setup 3 Dell R410 PowerEdge Servers for the MicroCloud/K8s disaster recovery and secondary data gateway. Approved by Jared to locate at Albion's server rack.

## **[Gage Project](./a_da_status.md)

-

## Platform Engineering

### Structures MicroCloud/K8S disaster recovery

Business Justification: This second MicroCloud/K8s cluster built from unused Dell 410 PowerEdge servers would be an inexpensive solution for backup/disaster recovery. It is used to run automated ETL to get on-prem/non-microsoft cloud data to the Structures gold data lake in conjuction with the Microsoft data gateway.

- MicroCloud Backup Cluster
- 3 Dell R410 PowerEdge Servers
  - resources
    - 3 sets of **[128 GB DDR3 ECC server memory](https://cloudninjas.com/collections/poweredge-r410-ram-memory-upgrade)**
    - 6 SSD drives
- Rack Location
  - Albion or Southfield

- **[MicroCloud Recovery](https://documentation.ubuntu.com/microcloud/stable/microcloud/how-to/recover/)**
- **[Remote Replication in MicroCeph: RBD and Beyond - Utkarsh Bhatt, Canonical](https://www.youtube.com/watch?v=Yjh8kV4ZHBM&t=226)**

## Fabric/Power BI/Notebooks Medallion Workflow

- Finished Bronze Layer and starting Silver Layer of Medallion Workflow (clean data)
- We are receiving approval Fabric approval requests from Structures employees
- Microsoft Data Gateway
  - Setup Windows 22 Server on Structures MicroCloud
  - Config request for data gateway
  - **[lxd forwarder](../research/m_z/virtualization/hypervisor/lxd/network/forwarders/forwarders.md)** to wins22
  - Connect to Plex from wins22
  - create chat or email group to keep team informed
  - Southfield, Cody Hudson, and other Plex reports.

- **[Structures Data Analytics Status](./a_da_status.md)**

## IS Team

Sadiq Basha Sr. Data Engineer, Data & Analytics
Tarek Mohamed, Data and Analytics IT, Supervisor
Cody Hudson, Fabric Administrator
Brent Hall, System Administrator Senior
Kevin Young, Information Systems Manager
Jared Davis, IT Manager
Hayley Rymer, IT Supervisor, Mills River
Sam Jackson, Information Systems Developer, Southfield
Brad D. Cook, Quality Engineer, Fruitport
Jared Eikenberry, Quality Engineer, Fruitport
Kent Cook, IT Administrator, Fruitport
Ricardo Baca. Senior Manufacturing Eng, Southfield
Mikael Boire, Operation Manager, Southfield
Michael Arney, Plex, IT
Mikita Gaskin, Analyst, EDI, IT
Abner Huang, Mach2, IT
