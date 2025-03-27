# Current Tasks

- tb verification
- Verify network performance between Southfield and K8s node 1 with iperf.
  - setup iperf on Southfield VM and k8sn211
  - ping to 10.185.250.1 is 19.6 ms

## Structures Information Systems, Kubernetes, or K8s, Platform Engineering Support

- **[Import Client Certificates](https://www.digicert.com/kb/managing-client-certificates.htm)**
- deploying **[platform services](../k8s/mysql-statefulset-install.md)** to K8s cluster.
- import mysql backup to new server.
- on-going certificate management for each mach2 server
  - Created certificate for the Fruitport Mach2 server.
  - Create GPO for intermediate and root certificates.
  - created certificate management schema containing serial numbers, expiration dates, and alt names.

## Transition from Multipass hypervisor to MicroCloud Hyper-converged infrastructure (HCI)

- Research Ceph storage **[Dynamic Cluster Management](../research/m_z/virtualization/storage/ceph/architecture.md#dynamic-cluster-management)** to optimize and trouble-shoot the MicroCloud HCI.
- Research **[Namespaces and CGroups](../research/m_z/virtualization/networking/namespaces/namespaces_cgroups.md)**
- Research **[Namespace Natting](../research/m_z/virtualization/networking/namespaces/firewalls/fun_with_namespaces.md)**
