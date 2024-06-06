# How to port forward

## search

iproute2 port forwarding

## references

<https://phoenixnap.com/kb/iptables-port-forwarding>

<https://www.redswitches.com/blog/linux-port-forwarding/>

<https://www.digitalocean.com/community/tutorials/how-to-forward-ports-through-a-linux-gateway-with-iptables>

## libvirt/qemu way

This method also uses iptables to accomplish this task.

**If you would like to make a service that is on a guest behind a NATed virtual network publicly available, you can setup libvirt's "hook" script for qemu to install the necessary iptables rules to forward incoming connections to the host on any given port HP to port GP on the guest GNAME:**

## Install Persistent Firewall Package

```bash
sudo apt update
sudo apt install iptables-persistent
```

## Set up Basic IPv4 Rules

After installing the persistent firewall, edit the firewall server's configuration to set up basic IPv4 rules.

1. Open the rules.v4 file in a text editor to add the rules.

```bash
sudo nano /etc/iptables/rules.v4
```
