# **[Build a MAAS and LXD environment in 30 minutes with Multipass on Ubuntu](https://maas.io/docs/maas-in-thirty-minutes)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../README.md)**

## reference

- **[add route](https://discourse.ubuntu.com/t/how-to-use-multipass-remotely/26360/2)**
- **[ebook](https://pages.ubuntu.com/eBook-MAAS.html)**
- **[remote management](https://dev.to/adityapratapbh1/a-comprehensive-guide-to-multipass-simplifying-virtual-machine-management-b0c)**

## What is MAAS?

MAAS, or “Metal As A Service,” morphs your bare-metal servers into an agile cloud-like environment. Forget fussing over individual hardware; treat them as fluid resources similar to instances in AWS, GCE, or Azure. MAAS is adept as a standalone PXE/preseed service, but it truly shines when paired with Juju, streamlining both machine and service management. Network booting via PXE? Even virtual machines can join the MAAS ecosystem.

Time to try MAAS! We wanted to make it easier to go hands on with MAAS, so we created this tutorial to enable people to do that, right on their own PC or laptop. Below, we’ll explain a bit about how MAAS works and then dive straight into it.

Hang in there, because you’ll be up and running in no time, installing operating systems with ease and without breaking a sweat!

![m](https://discourse-maas-io-uploads.s3.us-east-1.amazonaws.com/original/2X/5/593e7b1b7952b582215b49c92f35de7eb63a9b85.jpeg)

Installing MAAS itself is easy, but building an environment to play with it is more involved. MAAS works by detecting servers that attempt to boot via a network (called PXE booting). This means that MAAS needs to be on the same network as the servers.

Having MAAS on the same network as the servers can be problematic at home or the office, because MAAS also provides a DHCP server and it can (will) create issues if target servers and MAAS try to interact on your usual network.

## A potential MAAS test setup

One way to try MAAS is to have a separate network, such as a simple switch+router, with several servers attached. One of these servers runs MAAS, and the others are target servers that MAAS can provision. Such a setup might look like this:

![ms](https://assets.ubuntu.com/v1/948323ca-MAAS+tutorial+diagram-01.svg)

In this tutorial, we’re going to build all of this automatically for you inside a virtual machine, using Multipass. No need to build all of this infrastructure just to try MAAS, we’ll take care of it for you.

## Multipass
Multipass is a tool from Canonical that can help you easily create virtual machines (VMs). This tutorial uses Multipass to create a self-contained VM that includes MAAS and an LXD host right on your desktop or laptop.

## LXD

Inside the VM, Multipass will use LXD and Linux configuration to build a virtual private switch and router, and provide a way to create what are called “nested VMs”, or virtual machines inside the virtual machine made by Multipass. These nested VMs will represent servers that MAAS can provision.

When we’re finished, you’ll be able to log in to the MAAS server running inside the VM on your computer, compose nested VMs using LXD, and then commission and deploy them. It will then be simple to spin up a quick MAAS environment without needing to build a complete real environment.

![l](https://assets.ubuntu.com/v1/6e132859-MAAS+tutorial+diagram-02.svg)

## Requirements

You will need:

- Ubuntu 18.04 LTS or higher OR Windows with Hyper-V
(Note: this tutorial has been tested with Ubuntu, but there are reports it works with Hyper-V on Windows. Read more about enabling Hyper-V here.)
16 GB of RAM
- A quad core CPU with virtualisation support (Intel VT or AMD-V)
- Virtualisation support enabled in the BIOS
30 GB of free disk space

The memory and disk space is required because we will later be launching nested VMs inside our new environment using MAAS and LXD.

## Don’t have the right machine?

If you don’t have the right machine or OS to try the tutorial, don’t worry - we have created a quick video of ourselves running through the tutorial which you can watch **[here](https://www.youtube.com/watch?v=5mjEbQ5Jb1Y)**.

## Install Multipass

In this tutorial, we’ll be entering quite a few commands in a terminal. Open a terminal of your choice, and let’s get started.

First up, let’s install Multipass:

```bash
sudo snap install multipass

## multipass install create a new network device mpqemubr0

ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 78:2b:cb:23:45:b0 brd ff:ff:ff:ff:ff:ff
    altname enp1s0f0
3: eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 78:2b:cb:23:45:b1 brd ff:ff:ff:ff:ff:ff
    altname enp1s0f1
4: mpqemubr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
    link/ether 52:54:00:de:03:a8 brd ff:ff:ff:ff:ff:ff

ip route list table main
default via 192.168.1.1 dev eno1 proto static 
10.195.222.0/24 dev mpqemubr0 proto kernel scope link src 10.195.222.1 linkdown 
192.168.1.0/24 dev eno1 proto kernel scope link src 192.168.1.65 
192.168.1.0/24 dev eno2 proto kernel scope link src 192.168.1.66 

ip route list table local
local 10.195.222.1 dev mpqemubr0 proto kernel scope host src 10.195.222.1 
broadcast 10.195.222.255 dev mpqemubr0 proto kernel scope link src 10.195.222.1 linkdown 
local 127.0.0.0/8 dev lo proto kernel scope host src 127.0.0.1 
local 127.0.0.1 dev lo proto kernel scope host src 127.0.0.1 
broadcast 127.255.255.255 dev lo proto kernel scope link src 127.0.0.1 
local 192.168.1.65 dev eno1 proto kernel scope host src 192.168.1.65 
local 192.168.1.66 dev eno2 proto kernel scope host src 192.168.1.66 
broadcast 192.168.1.255 dev eno1 proto kernel scope link src 192.168.1.65 
broadcast 192.168.1.255 dev eno2 proto kernel scope link src 192.168.1.66 
```

Check whether Multipass was installed and is functioning correctly by launching an instance, running the following commands:

```bash
multipass launch --name foo
multipass list
Name                    State             IPv4             Image
foo                     Running           10.195.222.149   Ubuntu 24.04 LTS

kenneth@laptop:~$ multipass stop foo 
kenneth@laptop:~$ multipass set local.foo.disk=32G  
kenneth@laptop:~$ multipass start foo 

multipass shell foo

# https://canonical.com/multipass/docs/set-up-a-graphical-interface
sudo apt update
sudo apt install ubuntu-desktop xrdp

# Now we need a user with a password to log in. One possibility is setting a password for the default ubuntu user:
sudo passwd ubuntu
# set password to ubuntu

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
# you may need to force install
sudo apt -f install ./google-chrome-stable_current_amd64.deb
```

On Linux, there are applications such as Remmina to visualize the desktop (make sure the package remmina-plugin-rdp is installed in your host along with remmina).

To directly launch the client, run the following command:

```bash
multipass exec foo -- bash -c "echo `cat ~/.ssh/id_rsa.pub` >> ~/.ssh/authorized_keys"
ssh -X ubuntu@10.195.222.149
sudo apt -y install x11-apps
xlogo &

remmina -c rdp://10.195.222.149 
```
The system will ask for a username (ubuntu) and the password set above, and then the Ubuntu desktop on the instance will be displayed.



# created a tap device for the mpqemubr0 bridge
# 5: tap-85a8e535edf: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast master mpqemubr0 state UP group default qlen 1000
#     link/ether 62:75:a3:8a:1a:53 brd ff:ff:ff:ff:ff:ff
#     inet6 fe80::6075:a3ff:fe8a:1a53/64 scope link 
#        valid_lft forever preferred_lft forever

multipass exec foo -- lsb_release -a
# The lsb_release command prints certain LSB (Linux Standard Base) and Distribution information. If no options are given, the -v option is the default.

# An LSB module is a plugin module for the LSF scheduler and resource broker. The Linux Standard Base (LSB) is a core system that standardizes the software structure for Linux. 

No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 24.04.1 LTS
Release:        24.04
Codename:       noble
```

Delete the test VM, and purge it:

```bash
multipass delete --purge foo
```
Congratulations, you’ve just run a test VM with Multipass! Now it’s time to create your MAAS and LXD environment.

## Check whether virtualisation is working

We now need to check whether virtualisation is working correctly. This is a relatively simple process. In your terminal, run:

```bash
sudo apt install cpu-checker
kvm-ok
INFO: /dev/kvm exists
KVM acceleration can be used
```

QEMU is primarily a Type-2 hypervisor. It runs on top of a host operating system and provides virtualization capabilities for various guest operating systems and architectures. However, it can also be used in combination with KVM (Kernel-based Virtual Machine) to function as a Type-1 hypervisor.

LXD VMs are based on QEMU and KVM 

Assuming your machine supports hardware virtualisation, we are ready to move on and launch MAAS.

Note
The tutorial will not work unless you have ensured virtualisation support is enabled.
The first place to check if you don’t see the expected output is your BIOS - consult your motherboard or laptop manufacturer documentation if you are uncertain.

## Launch the MAAS and LXD Multipass environment

Launching the MAAS and LXD VM is as simple as the test VM was to launch, except that this time you will pass a **[cloud-init config file](https://github.com/canonical/maas-multipass/blob/main/maas.yml)**, and a few other parameters for CPU cores, memory, and disk space.

The following command looks a bit long, so let’s break it down:

- wget will pull down the config file from a Canonical GitHub repository and pipe it to the multipass command
- multipass accepts the output from wget as input for the cloud-init parameter

Feel free to check the contents of the cloud-init config file before running this. Copy the entire command below (both lines) and run it:

```bash
wget -qO- https://raw.githubusercontent.com/canonical/maas-multipass/main/maas.yml \
 | multipass launch --name maas -c4 -m8GB -d32GB --cloud-init -

# The pipe symbol at the end of a line in YAML signifies that any indented text that follows should be interpreted as a multi-line scalar value. See the YAML spec. 

 launch failed: The following errors occurred:
timed out waiting for initialization to complete

# Ran list a little later and everything looks ok
multipass list              
Name                    State             IPv4             Image
maas                    Running           10.72.173.107    Ubuntu 24.04 LTS
                                          10.10.10.1
```

Here you can see two IP addresses. One belongs to the internal network (10.10.10.1) for MAAS and LXD guest VMs to communicate. You can use the other to connect to MAAS from your computer.

The internal network is 10.10.10.0/24. Take note of the other IP address; you will need it in the following steps. In the above output, that IP address is 10.97.28.47. Later on, we will refer to this IP as <MAAS IP>, and you will need to replace it with yours.

Great work! Now you’re ready to try out MAAS.

## Log into MAAS

Now that MAAS is running, you need to log in and finalise the setup for MAAS by configuring the DNS and verifying the installation.

From a browser on your computer, go to:

```bash
# http://<MAAS_IP>:5240/MAAS
http://ump1:5240/MAAS