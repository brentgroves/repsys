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

- **[Structures Data Analytics Status](./a_da_status.md)**

## Moxa’s Second-generation SoC

The MiiNe was created to provide manufacturers with a competitive embedded serial-to-Ethernet solution. The MiiNePort E3, which uses the MiiNe for its SoC, is a compact embedded device server that has the lowest power consumption among similar products. The MiiNe has the following features:

- Designed for serial-to-Ethernet applications
- Uses an Arm core
- Uses Moxa’s own advanced UART technology
- 2 MB Flash and 4 MB SDRAM memory built in

![i](https://cdn-cms-frontdoor-dfc8ebanh6bkb3hs.a02.azurefd.net/Moxa/media/PDIM/S100000221/moxa-miineport-e3-series-application-image-eng.png)

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

Business Justification: This second MicroCloud/K8s cluster built from unused Dell 410 PowerEdge servers would be an inexpensive solution for backup/disaster recovery.
