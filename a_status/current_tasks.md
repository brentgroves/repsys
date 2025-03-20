# Current Tasks

## connect Structures Avilla Dell PowerEdge servers to extreme core switches with 10GB SPF+ modules in truck mode to VLANs 50 and 220

- Ask Jared to review Dell PowerEdge Network Config request. He gave me 3 10GB SPF+ daughter cards still need SPF+ modules.
- Verify network performance between Southfield and K8s node 1.
    Southfield core switch
    setup iperf on Southfield VM and k8sn211
    ping to 10.185.250.1 is 19.6 ms

## Transition from Multipass hypervisor to MicroCloud Hyper-converged infrastructure (HCI)

- Research Ceph storage **[CRUSH algorithm](../research/m_z/virtualization/storage/ceph/crush.md)** to optimize and trouble-shoot the MicroCloud HCI.
