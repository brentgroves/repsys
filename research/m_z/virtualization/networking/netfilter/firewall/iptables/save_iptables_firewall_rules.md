# **[How to save iptables firewall rules permanently on Linux](https://www.cyberciti.biz/faq/how-to-save-iptables-firewall-rules-permanently-on-linux/)**

**[Back to Research List](../../../../../../research_list.md)**\
**[Back to Current Status](../../../../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../../../../README.md)**

## reference

- **[libvirt and network filtering with nat - iptables overrides](https://serverfault.com/questions/565871/libvirt-and-network-filtering-with-nat-iptables-overrides#:~:text=I%20feel%20your%20pain.,your%20hook%20set%20those%20up.)**

## **[Libvirt hooks](https://stackoverflow.com/questions/58766690/injecting-iptables-rule-after-libvirt-network-is-created-with-terraform-0-11)

Libvirt has a concept of "hooks" which are admin defined scripts to be run at certain key points in libvirt:

<https://libvirt.org/hooks.html>

There's an illustration of using hooks for port forwarding here:

<https://wiki.libvirt.org/page/Networking#Forwarding_Incoming_Connections>

## If libvirt is not controlling the firewall

am using Debian / Ubuntu Linux server. How do I save iptables rules permanently on Linux using the CLI added using the iptables command? How can I store iptables IPv4 and IPv6 rules permanently on the Debian Linux cloud server?

Linux system administrator and developers use iptables and ip6tables commands to set up, maintain, and inspect the firewall tables of IPv4 and IPv6 packet filter rules in the Linux kernel. Any modification made using these commands is lost when you reboot the Linux server. Hence, we need to store those rules across reboot permanently. This page examples how to save iptables firewall rules permanently either on Ubuntu or Debian Linux server.

## Saving iptables firewall rules permanently on Linux

You need to use the following commands to save iptables firewall rules forever:

1. iptables-save command or ip6tables-save command – Save or dump the contents of IPv4 or IPv6 Table in easily parseable format either to screen or to a specified file.

2. iptables-restore command or ip6tables-restore command – Restore IPv4 or IPv6 firewall rules and tables from a given file under Linux.

## Step 1 – Open the terminal

Open the terminal application and then type the following commands. For remote server login using the ssh command:

```bash
ssh vivek@server1.cyberciti.biz
ssh ec2-user@ec2-host-or-ip
```

You must type the following command as root user either using the sudo command or su command.

## Step 2 – Save IPv4 and IPv6 Linux firewall rules

Debian and Ubuntu Linux user type:

```bash
sudo sh -c '/sbin/iptables-save > /etc/iptables/rules.v4'
## IPv6 ##
sudo sh -c '/sbin/ip6tables-save > /etc/iptables/rules.v6'
```

## Step 3 – Restore IPv4 and IPv6 Linux filewall rules

We just reverse above commands as follows per operating system:

```bash
## Debian or Ubuntu ##
sudo sh -c '/sbin/iptables-restore < /etc/iptables/rules.v4'
sudo sh -c '/sbin/ip6tables-restore < /etc/iptables/rules.v6'
## CentOS/RHEL ##
sudo sh -c '/sbin/iptables-restore < /etc/sysconfig/iptables'
sudo sh -c '/sbin/ip6tables-restore < /etc/sysconfig/ip6tables'
```
