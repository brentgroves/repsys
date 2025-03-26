# Current Tasks

- tb verification
- Verify network performance between Southfield and K8s node 1 with iperf.
  - setup iperf on Southfield VM and k8sn211
  - ping to 10.185.250.1 is 19.6 ms

## Structures Information Systems, Kubernetes, or K8s, Platform Engineering Support

- deploying **[platform services](../k8s/mysql-statefulset-install.md)** to K8s cluster.
- on-going certificate management for each mach2 server
  - Created certificate for the Avilla Mach2 server.
  - Translated Structures intermediate and root CA certificates from PEM to **[PCKS#12](https://en.wikipedia.org/wiki/PKCS_12#:~:text=In%20cryptography%2C%20PKCS%20%2312%20defines,Filename%20extension)** for Windows import.
  - Creating a server certificate for Fruitport Mach2 server
  - created certificate management schema containing serial numbers, expiration dates, and alt names.
  - Johnathon Lapsley will bring up our request to his team.

## Transition from Multipass hypervisor to MicroCloud Hyper-converged infrastructure (HCI)

- Research Ceph storage **[Dynamic Cluster Management](../research/m_z/virtualization/storage/ceph/architecture.md#dynamic-cluster-management)** to optimize and trouble-shoot the MicroCloud HCI.
- Research **[Namespaces and CGroups](../research/m_z/virtualization/networking/namespaces/namespaces_cgroups.md)**
- Research **[Namespace Natting](../research/m_z/virtualization/networking/namespaces/firewalls/fun_with_namespaces.md)**
