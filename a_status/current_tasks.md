# Current Tasks

- SystemD socket activation unit listens for connection and then start a one-shot unit. The one-shot unit runs many tasks consequatively such as those in an ETL pipeline. Test it on TB.
- Had issue accessing our Albion Mach2 server from our Avilla K8s Cluster so as a temp fix I setup port forwarding with DNAT/SNATting from an Albion Ubuntu on the desktop VLAN. Will work with Jared to get Albion's 1220 VLan accessable from Avilla K8s which will have our certificate management services.
- Python uv from systemd unit file example
- Run scripts from Linamar Azure SQL tennant.
- Access all of the Mach2 servers and clients as well as the K8s clients which use the Structures PKI certificate management system.

- **[SystemD service unit file with journal logging](../research/m_z/systemd/logging/mytest1.md)**

  Once we had the ability to connect from the Avilla Structures K8s Cluster to the Albion Mach2 server through the Albion Ubuntu desktop we needed a way to ensure iptable rules survived a reboot.  For this we used a SystemD service oneshot unit file. We also researched SystemD's socket activation feature which listens for client socket connections and starts a service handler dynamically.  This will help running services which are only needed occasionally from the Ubuntu desktop which has limited resources.
- SystemD vs Kubernetes
  - SystemD is better at starting programs.
  - Kubernetes is better at keeping them running.

- Make GoLang and Python dev container to create base docker image for ETL scripts.
- ETL API and CLI
- Compare K8s mail service options.
  - Postfix with public key security and Amazon programmatic DNS txt record creation.
  - Mailtrap service.

- **[file descriptors](https://copyconstruct.medium.com/bash-redirection-fun-with-descriptors-e799ec5a3c16)**

## Misc

- Migrate from MSC to new vending machines.
- Muscle Shoals thin client certificates.
- Use cloud.plex.com to locate new accounts for TB web services such as account_nos_gets and account_nos_picker_get.

## Questions

- Can setup HyperV Ubuntu 24.04 server VM in 50 and 1220 VLans on core server. To access Albion subnets from R620s using port forwarding.
- Ask for Plex web service account from Sam or Kevin
- Does any location besides Indiana have vending machines?

## **[Research](../research/research_list.md)**

- port forwarding with OVS
- Use cloud.plex.com to locate new accounts for TB web services such as account_nos_gets and account_nos_picker_get.

## **[Data Analysis](./a_data_analysis/is_data_analysis.md)**

- days on hand formula

## **[Automated Certificate Management System](./a_certificate_management/certificate_management_status.md)**

- Add Nancy Swank and Jamie Pyle computers to PKI GPO.

## Automated ETL and Report System

- Python base data source docker image.
- Move schema and ETL scripts from Mobex Azure SQL MI to the Linamar Azure SQL DB and Avilla K8s servers.
- Write scripts to compare Mobex Azure SQL result sets to Linamar Azure SQL DB result set.

## Tool Management System

- Access to vending machine schema

## Structures Information Systems, Kubernetes, or K8s, Platform Engineering Support

- Jared made config request to move Dell R620s to core server using link aggregation and 10 GP SPF+ modules.
- **[Access VLAN 1220](../research/m_z/virtualization/networking/linamar/avilla/isdev/vlan1220/edge/try2.md)** to check Albion Mach2 certificate chain.
