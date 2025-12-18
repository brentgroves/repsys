# **[Install Windows 11](https://ubuntu.com/tutorials/how-to-install-a-windows-11-vm-using-lxd#1-overview)**

## How to install a Windows 11 VM using LXD

If you are using a Linux environment but want to run a Windows 11 virtual machine, you can easily do so using LXD. Windows 11 is somewhat strict in its requirements (needs UEFI SecureBoot, having a TPM, and having a modern CPU), but LXD supports that out of the box, and there’s no need for any complex configuration in order to enable a Windows VM. In this tutorial, we will walk through the process of installing Windows in an LXD virtual machine. We will be installing Windows 11, but the same procedure also applies to Windows server machines.

A TPM, or Trusted Platform Module, improves the security of your PC by securely creating and storing cryptographic keys. TPM 2.0 is a key part of making ...

## What you’ll learn

- How to repackage an iso image with distrobuilder
- How to install a Windows VM

## What you’ll need

- Ubuntu Desktop 16.04 or above
- LXD snap (version 4.2 or above) installed and running
- Some basic command-line knowledge

## Prepare your Windows image

To start, we need to **[download](https://www.microsoft.com/software-download/windows11)** a Windows 11 Disk Image (ISO) from the official website.

![](https://lh6.googleusercontent.com/aVQUjj1IkyZF6imgoVdXyEQJ0kJYgV1MWqUbEcKoHZr7mBCYn7A4kUFEufPeTwnmsm3N8y5TebNvM_xQAKSv4WTL7HtKYdYFKUJo_yjMVnWc_i_uo52MFCPMsKv5FKQUYeenBojuHep2EiqWNA)

To proceed with the installation, we need to prepare the downloaded image, by repackaging it with a tool called distrobuilder. Distrobuilder is an image-building tool for LXC and LXD, used to build all our official images.

First, we need to install distrobuilder

```bash
sudo snap install distrobuilder --classic
distrobuilder 3.0 from Stéphane Graber (stgraber) installed
```

Then we need to locate our downloads directory and find our Windows 11 iso file

```bash
cd Downloads/
ls WindowsIsoImage.iso
Win11_23H2_English_x64v2.iso
```

We can then repackage the file, and give it a new file name (let’s call it “win11.lxd.iso”)

This needs to be run as root

```bash
sudo distrobuilder repack-windows WindowsIsoImage.iso win11.lxd.iso
err="Failed to check dependencies: Required tool \"hivexregedit\" is missing"
```

You might get a message “Required tool “hivexregedit” is missing” and “Required tool “wimlib-imagex” is missing”. You can easily install the first one using the following command: apt-get install libwin-hivex-perl and the second one using apt-get install wimtools

```bash
sudo apt-get install libwin-hivex-perl
sudo apt-get install wimtools
```

ⓘYou might also get a message “failed to create overlay” depending on the file system you use. This does not hinder the process, rather it will just do things the alternative way which may take a few min longer

## try again

```bash
sudo distrobuilder repack-windows Win11_23H2_English_x64v2.iso win11.lxd.iso
...
 99.64% done, estimate finish Wed Jul 31 18:29:12 2024
 99.78% done, estimate finish Wed Jul 31 18:29:12 2024
 99.93% done, estimate finish Wed Jul 31 18:29:12 2024
Total translation table size: 2048
Total rockridge attributes bytes: 0
Total directory bytes: 217088
Path table size(bytes): 2464
Max brk space used e9000
3457526 extents written (6752 MB)
INFO   [2024-07-31T18:30:14-04:00] Removing cache directory  
```

The result is a new iso image that will work seamlessly with LXD.

We can now locate the new iso file

```bash
ls -lh win11.lxd.iso
-rw-r--r-- 1 root root 6.6G Jul 31 18:29 win11.lxd.iso
```

## Create a new VM

After we create the Windows image, We can create a new empty VM that we can call ”win11”

```bash
lxc init win11 --vm --empty
Creating win11
Error: Failed creating instance record: Failed initialising instance: Failed getting root disk: No root device could be found
```

## initialize lxc

```bash
sudo apt install lxc-utils

lxc-checkconfig           
LXC version 5.0.0
Kernel configuration not found at /proc/config.gz; searching...
Kernel configuration found at /boot/config-6.5.0-45-generic
--- Namespaces ---
Namespaces: enabled
Utsname namespace: enabled
Ipc namespace: enabled
Pid namespace: enabled
User namespace: enabled
Network namespace: enabled

--- Control groups ---
Cgroups: enabled
Cgroup namespace: enabled

Cgroup v1 mount points: 


Cgroup v2 mount points: 
/sys/fs/cgroup

Cgroup v1 systemd controller: missing
Cgroup v1 freezer controller: missing
Cgroup ns_cgroup: required
Cgroup device: enabled
Cgroup sched: enabled
Cgroup cpu account: enabled
Cgroup memory controller: enabled
Cgroup cpuset: enabled

--- Misc ---
Veth pair device: enabled, not loaded
Macvlan: enabled, not loaded
Vlan: enabled, not loaded
Bridges: enabled, loaded
Advanced netfilter: enabled, loaded
CONFIG_IP_NF_TARGET_MASQUERADE: enabled, not loaded
CONFIG_IP6_NF_TARGET_MASQUERADE: enabled, not loaded
CONFIG_NETFILTER_XT_TARGET_CHECKSUM: enabled, not loaded
CONFIG_NETFILTER_XT_MATCH_COMMENT: enabled, not loaded
FUSE (for use with lxcfs): enabled, not loaded

--- Checkpoint/Restore ---
checkpoint restore: enabled
CONFIG_FHANDLE: enabled
CONFIG_EVENTFD: enabled
CONFIG_EPOLL: enabled
CONFIG_UNIX_DIAG: enabled
CONFIG_INET_DIAG: enabled
CONFIG_PACKET_DIAG: enabled
CONFIG_NETLINK_DIAG: enabled
File capabilities: 

Note : Before booting a new kernel, you can check its configuration
usage : CONFIG=/path/to/config /bin/lxc-checkconfig

sudo lxd init
Would you like to use LXD clustering? (yes/no) [default=no]: 
Do you want to configure a new storage pool? (yes/no) [default=yes]: 
Name of the new storage pool [default=default]: 
Name of the storage backend to use (zfs, btrfs, ceph, dir, lvm, powerflex) [default=zfs]: 
Create a new ZFS pool? (yes/no) [default=yes]: 
Would you like to use an existing empty block device (e.g. a disk or partition)? (yes/no) [default=no]: 
Size in GiB of the new loop device (1GiB minimum) [default=30GiB]: 
Would you like to connect to a MAAS server? (yes/no) [default=no]: 
Would you like to create a new local network bridge? (yes/no) [default=yes]: 
What should the new bridge be called? [default=lxdbr0]: 
What IPv4 address should be used? (CIDR subnet notation, “auto” or “none”) [default=auto]: 
What IPv6 address should be used? (CIDR subnet notation, “auto” or “none”) [default=auto]: 
Would you like the LXD server to be available over the network? (yes/no) [default=no]: 
Would you like stale cached images to be updated automatically? (yes/no) [default=yes]: 
Would you like a YAML "lxd init" preseed to be printed? (yes/no) [default=no]: 
```

## **[error](https://medium.com/@blackgem/errors-when-building-linux-containers-lxc-and-lxd-a9e58a62a67d)**

If when you are trying to create the container for your image you get

Error: Failed creating instance record: Failed initialising instance: Failed getting root disk: No root device could be found

it’s because you have nothing in the storage

```bash
sudo lxc storage ls

+-----------+--------+--------------------------------------------------+----------------------------+---------+---------+
|   NAME    | DRIVER |                      SOURCE                      |        DESCRIPTION         | USED BY |  STATE  |
+-----------+--------+--------------------------------------------------+----------------------------+---------+---------+
| default   | zfs    | /var/snap/lxd/common/lxd/disks/default.img       |                            | 1       | CREATED |
+-----------+--------+--------------------------------------------------+----------------------------+---------+---------+
| multipass | dir    | /var/snap/lxd/common/lxd/storage-pools/multipass | Storage pool for Multipass | 0       | CREATED |
+-----------+--------+--------------------------------------------------+----------------------------+---------+---------+
```

you can also check if you have a project

```bash
sudo lxc project ls

+-------------------+--------+----------+-----------------+-----------------+----------+---------------+---------------------------------+---------+
|       NAME        | IMAGES | PROFILES | STORAGE VOLUMES | STORAGE BUCKETS | NETWORKS | NETWORK ZONES |           DESCRIPTION           | USED BY |
+-------------------+--------+----------+-----------------+-----------------+----------+---------------+---------------------------------+---------+
| default (current) | YES    | YES      | YES             | YES             | YES      | YES           | Default LXD project             | 3       |
+-------------------+--------+----------+-----------------+-----------------+----------+---------------+---------------------------------+---------+
| multipass         | YES    | YES      | YES             | YES             | NO       | NO            | Project for Multipass instances | 1       |
+-------------------+--------+----------+-----------------+-----------------+----------+---------------+---------------------------------+---------+
```

## try again

```bash
lxc init win11 --vm --empty

Creating win11
```

The default storage/disk provided to new VMs is 10GB, which is not enough for Windows so we need to increase the size of the disk to 50GB with the following command before proceeding

```bash
# increased this to 70GiB because windows 11 pro required 52GB
lxc config device override win11 root size=70GiB
Device root overridden for win11
```

## **[remove container](https://www.cyberciti.biz/faq/delete-container-with-lxc-lxd-command-on-linux/)**

```bash
The syntax is simple:
lxc delete instance
lxc delete instance/snapshot
lxc delete instance {options}
## rm is alias for delete ##
lxc rm container/snapshot

lxc stop {container1} && lxc delete {container1}
## OR ##
lxc delete {container1} --force

The gracefull method to use, lxc stop <vm_name> --force, you can kill the process as well which you can find ps -ef | grep -i <container_name>, process name begins with “lxc monitor” and kill the process like that.
sudo kill -9 <pid>

Error: Failed shutting down instance, status is "Running": context deadline exceeded
Try `lxc info --show-log win11` for more info
Name: win11
Status: RUNNING
Type: virtual-machine
Architecture: x86_64
PID: 33546
Created: 2024/07/31 18:47 EDT
Last Used: 2024/07/31 18:56 EDT

Resources:
  Processes: -1
  Disk usage:
    root: 23.00KiB
  Network usage:
    eth0:
      Type: broadcast
      State: UP
      Host interface: tap8746644f
      MAC address: 00:16:3e:d6:cb:4a
      MTU: 1500
      Bytes received: 8.97kB
      Bytes sent: 5.39kB
      Packets received: 52
      Packets sent: 27
      IP addresses:
        inet6: fd42:9d25:8ccd:5ac8:216:3eff:fed6:cb4a/64 (global)
        inet6: fe80::216:3eff:fed6:cb4a/64 (link)

Log:

# https://forum.proxmox.com/threads/cant-shutdown-lxc-container.78718/
ps aux | grep CTID
```

you can force shutdown the unresponsive container if you kill the respective lxc process, ps aux | grep CTID will give you a list of processes, you can kill the respective /usr/bin/lxc-start process to kill the container.

however this shouldn't be necessary most of the time. it's a better idea to figure out why the container won't shutdown normally.

the command you used:
Code:
root@server:/usr/bin# pct exec 108 stop
is not what you're looking for. pct exec is for running a command inside the container. you can try with pct stop CTID instead.

```

## Listing all containers / instances

Open the terminal application and then type the following command:

```bash
lxc list                                        
+-------+---------+------+-----------------------------------------------+-----------------+-----------+
| NAME  |  STATE  | IPV4 |                     IPV6                      |      TYPE       | SNAPSHOTS |
+-------+---------+------+-----------------------------------------------+-----------------+-----------+
| win11 | RUNNING |      | fd42:9d25:8ccd:5ac8:216:3eff:fed6:cb4a (eth0) | VIRTUAL-MACHINE | 0         |
+-------+---------+------+-----------------------------------------------+-----------------+-----------+

lxc ls
## list container name, state and snapshots ##
lxc list -c nsS
```

We should also increase the CPU limits for optimal performance

```bash
lxc config set win11 limits.cpu=4 limits.memory=8GiB
```

Next, we need to add TPM (Trusted Platform Module) as it’s one of the things Windows requires. We can call it vtpm as it is a virtual TPM after all. Adding TPM will also enable you to enable things like bitlocker inside of your VM.

```bash
lxc config device add win11 vtpm tpm path=/dev/tpm0
Device vtpm added to win11
```

The last thing we need to do is add the install media Itself and make it a boot priority (so it boots automatically)

```bash
lxc config device add win11 install disk source=/home/brent/Downloads/win11.lxd.iso boot.priority=10
lxc config show win11 --expanded
```

ⓘReplace /home/mionaalex/Downloads/ with your own path to the repackaged file

Now we can start the installer.

ⓘYou will need to manually provide a VGA console access by installing either remote-viewer or spicy. If neither of these is found in the system, you will get a message instructing you to install them.

```bash
lxc start win11 --console=vga
LXD relies on either remote-viewer or spicy to provide VGA console access.
Those can't be bundled with the LXD snap and so need to be manually installed.

 - "remote-viewer" usually comes in a package called virt-viewer
 - "spicy" usually comes in a package called spice-client-gtk

Install either of those and they will automatically start.
Alternatively you may use another SPICE client using the following URI:
  spice+unix:///home/brent/snap/lxd/common/config/sockets/1312683793.spice
```

## install vga console access

```bash
sudo apt install virt-viewer
```

If needed, install remote-viewer or spicy as prompted

sudo apt install virt-viewer

The rest of the installation will proceed automatically.

## Install Windows

You should now see the Windows installer screen.

You can select “I don’t have a key” (or add a key if you have one), select Windows 11 Pro, select the option Custom: Install Windows Pro only (Custom/advanced) and click install.

Once the first stage is done, you will need to restart. That will close the terminal for the console, so you need to open it again.

```bash
lxc console win11 --type=vga
lxc network show lxdbr0
name: lxdbr0
description: ""
type: bridge
managed: true
status: Created
config:
  ipv4.address: 10.223.105.1/24
  ipv4.nat: "true"
  ipv6.address: fd42:9d25:8ccd:5ac8::1/64
  ipv6.nat: "true"
used_by:
- /1.0/instances/win11
- /1.0/profiles/default
locations:
- none

```

This will now look like a regular Windows installation process. You will see a boot window with “getting ready”. If it needs to reboot again, just run the command above.

You will get another standard setup screen, choose your options (date format, keyboard layout etc.) or skip through it.

## error

Windows drive needs to be 52GB or greater.

## **[more errors](https://medium.com/@blackgem/errors-when-building-linux-containers-lxc-and-lxd-a9e58a62a67d)**

## **[Incus](https://blog.simos.info/how-to-run-a-windows-virtual-machine-on-incus-on-linux/)**

Incus is a next generation system container and virtual machine manager. It provides a user experience similar to that of a public cloud. With it, you can easily mix and match both containers and virtual machines, sharing the same underlying storage and network.

The Incus project was created by Aleksa Sarai as a community driven alternative to Canonical's LXD.
Today, it's led and maintained by many of the same people that once created LXD.
