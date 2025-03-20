# Current Tasks

## connect Structures Avilla Dell PowerEdge servers to extreme core switches with 10GB SPF+ modules in truck mode to VLANs 50 and 220

- issue connecting to <https://10.97.219.76:16443> or <https://10.188.50.214:16443>
  - connected to <https://10.97.219.76:16443> from 10.188.50.214 and 10.188.50.202.
  - changed config ip to 10.188.50.214
  - could not connect from 10.188.50.202
  - could not ssh to 10.188.50.214
  - ssh to 10.188.50.202
  - multipass list
  k8sn211 suspended
AI overview: why would multipass vm say suspended
To resume a suspended VM, use the multipass start command.
multipass start k8sn211
start failed: cannot connect to the multipass socket

```bash
sudo journalctl -au snap.multipass
none
multipass stop k8sn211 
stop failed: Cannot shut down suspended instance k8sn211.

multipass stop k8sn211 --force

```

**[search](https://stackoverflow.com/questions/67776548/how-to-fix-multipass-error-list-failed-cannot-connect-to-the-multipass-socket)**

- Ask Jared to review Dell PowerEdge Network Config request. He gave me 3 10GB SPF+ daughter cards still need SPF+ modules.
- Verify network performance between Southfield and K8s node 1.
    Southfield core switch
    setup iperf on Southfield VM and k8sn211
    ping to 10.185.250.1 is 19.6 ms

## Transition from Multipass hypervisor to MicroCloud Hyper-converged infrastructure (HCI)

- Research Ceph storage **[CRUSH algorithm](../research/m_z/virtualization/storage/ceph/crush.md)** to optimize and trouble-shoot the MicroCloud HCI.
