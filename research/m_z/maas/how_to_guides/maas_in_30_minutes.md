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

Ubuntu 18.04 LTS or higher OR Windows with Hyper-V
(Note: this tutorial has been tested with Ubuntu, but there are reports it works with Hyper-V on Windows. Read more about enabling Hyper-V here.)
16 GB of RAM
A quad core CPU with virtualisation support (Intel VT or AMD-V)
Virtualisation support enabled in the BIOS
30 GB of free disk space

The memory and disk space is required because we will later be launching nested VMs inside our new environment using MAAS and LXD.

## Don’t have the right machine?

If you don’t have the right machine or OS to try the tutorial, don’t worry - we have created a quick video of ourselves running through the tutorial which you can watch **[here](https://www.youtube.com/watch?v=5mjEbQ5Jb1Y)**.

## Install Multipass

In this tutorial, we’ll be entering quite a few commands in a terminal. Open a terminal of your choice, and let’s get started.

First up, let’s install Multipass:

`sudo snap install multipass`

Check whether Multipass was installed and is functioning correctly by launching an instance, running the following commands:

```bash
multipass launch --name foo
multipass exec foo -- lsb_release -a
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