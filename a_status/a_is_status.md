# Information Systems Status

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

- **[Structures Data Analytics Status](../volumes/python/oam/TODO.md)**

### Questions

- Can Plex collect CNC# and 9 tool counts along with the run data?

## Platform Engineering

### Structures MicroCloud/K8S disaster recovery

- MicroCloud Backup Cluster
- 3 Dell R410 PowerEdge Servers
  - resources
    - 3 sets of **[128 GB DDR3 ECC server memory](https://cloudninjas.com/collections/poweredge-r410-ram-memory-upgrade)**
    - 6 SSD drives
- Rack Location
  - Albion or Southfield

- **[MicroCloud Recovery](https://documentation.ubuntu.com/microcloud/stable/microcloud/how-to/recover/)**
- **[Remote Replication in MicroCeph: RBD and Beyond - Utkarsh Bhatt, Canonical](https://www.youtube.com/watch?v=Yjh8kV4ZHBM&t=226)**

Business Justification:
