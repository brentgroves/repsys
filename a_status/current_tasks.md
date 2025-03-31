# Current Tasks

## Structures Information Systems, Kubernetes, or K8s, Platform Engineering Support

- K8s admin - ramarao guttikonda
- Structures K8s bandwidth is limited by VPN connection.
- - Verify and improve network performance between sites and the Avilla Structures K8s cluster.
  - setup iperf on Southfield VM and k8sn211
  - ping to 10.185.250.1 is 19.6 ms
- **[Set up MySQL InnoDB Cluster](https://medium.com/@aaxsh/mysql-innodb-cluster-bdba9af61b79#:~:text=InnoDB%20Cluster%20is%20a%20high%20availability%20solution,Master%20Server%20to%20the%20MySQL%20Workers%20Servers.)**
  - import mysql statefulset backup to new server.
  - **[Test TB from Linamar Azure SQL DB](../../Reporting3/prod/build_deploy_run/test-tb-sqldb.md)**
- Ongoing certificate management for each Mach2 server
and for the Structures Avilla Kubernetes Cluster
  - Created certificate for the Fruitport and Muscle Shoals Mach2 server.
  - Create GPO for intermediate and root certificates.
  - Create GPO for client certificate.
  - created certificate management schema containing serial numbers, expiration dates, and alt names.

## Transition from Multipass hypervisor to MicroCloud Hyper-converged infrastructure (HCI)

- Research Ceph storage **[Dynamic Cluster Management](../research/m_z/virtualization/storage/ceph/architecture.md#dynamic-cluster-management)** to optimize and trouble-shoot the MicroCloud HCI.
- Research **[Namespaces and CGroups](../research/m_z/virtualization/networking/namespaces/namespaces_cgroups.md)**
- Research **[Namespace Natting](../research/m_z/virtualization/networking/namespaces/veths/veths_and_namespaces.md#start-here)**
- Research **[Building a Linux container by hand using namespaces](../research/m_z/virtualization/networking/namespaces/building_containers/part1.md)**
- Research **[Linux Namespaces in Go](https://songrgg.github.io/programming/linux-namespace-part01-uts-pid/)**
- Research **[Writing a KVM hypervisor VMM in Python](../research/m_z/virtualization/hypervisor/kvm/writing_a_kvm_hypervisor_in_python/)**
