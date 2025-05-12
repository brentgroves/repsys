# Current Tasks

- SystemD socket activation unit listens for connection and then start a one-shot unit. The one-shot unit runs many tasks consequatively such as those in an ETL pipeline. Test it on Linamar Azure SQL TB.
- Suggested Mach2 Linux GW on server VLAN using Netfilter port forwarding and Natting features. mTLS option requires proxy.
- The **[socat](https://www.baeldung.com/linux/socat-command)** utility is a relay for bidirectional data transfers between two independent data channels. Socat is useful for connecting applications inside separate boxes. Imagine we have Box A and Box B, and inside Box A, there’s a database server application running. Furthermore, Box A is closed to the public, but Box B is open. Our network will allow a connection from Box B to Box A.

- Run scripts from Linamar Azure SQL tennant.
- SystemD vs Kubernetes
  - SystemD is better at starting programs after other programs.
  - Kubernetes uses yaml SystemD used TOML.
  - Kubernetes manages scalability of services.
  
- Make GoLang and Python dev container to create base docker image for ETL scripts.
- Compare mail service options.
  You might wonder, “Why go through the effort when third-party services exist?” The answer lies in control. Self-hosting lets you tailor spam filters, encrypt communications your way, and ensure compliance with regional data laws.

  - Postfix with public key security and Amazon programmatic DNS txt record creation.
  - Mailtrap service.

## info

- Yes, Linus Torvalds, the creator and leader of the Linux kernel project, has approved the use of Rust in the kernel. While it wasn't an immediate shift to exclusively using Rust, Rust's integration into the kernel began with a pull request approved by Torvalds in October 2022. Rust is now being used for specific areas like device drivers and some kernel infrastructure.

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
