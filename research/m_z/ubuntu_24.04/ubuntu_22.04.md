# [Ubuntu 22.04]

## Updated R620s from ubuntu 22.04 desktop to 24.04 server

Using a lightweight command line hypervisor Multipass which Canonical makes.

- Did this to test netplan 1.0. It is more integrated with NetworkManagager.
- **[Install Microk8s on Multipass VM](https://microk8s.io/docs/install-multipass)**\
```multipass launch --network br0 --name microk8s-vm --mem 4G --disk 40G```
