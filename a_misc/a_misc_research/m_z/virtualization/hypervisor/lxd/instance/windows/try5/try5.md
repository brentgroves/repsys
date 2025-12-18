# work setup

The last attempt to install Windows 11 vm on my laptop failed. This is another attempt.  In this attempt I will wait to install the virtio drivers and will wait overnight after installation completes before shutting the system off.

- dell vPro laptop
- <bgroves@linamar.com>
- secure boot disabled
- set HELLO piin
- Did not install virtio drivers
- waited untill windows completed installing all work software.
- shutdown
- startup
- remember to do a time sync each time you reboot

## result

works so far. Was the issue with the virtio driver, or time sync?

## install ceph

- dokansetup.exe 2.3.0.1000
- shutdown/restart
- install ceph_squid.msi
- shutdown/restart
- remember to do a time sync each time you reboot
- installed ceph.conf and keyring to c:\users\bgroves\ceph\
- create c:\users\bgroves\ceph\out
- ceph-dokan.exe -c C:\Users\bgroves\ceph\ceph.conf -l x --client_fs indFs
- shutdown / restart
- remember to do a time sync each time you reboot

## result 2

works.

- `lxc config device remove win11 install` before restarting vm

Drivers
Drivers might need to be updated. In my case only one display resolution was available. See <https://discuss.linuxcontainers.org/t/how-to-increase-display-resolution-of-windows-vm/23508>

Download virtio-win.iso from <https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.271-1/>

Add the downloaded ISO as a device to the VM

```bash
# lxc config device add win11c thedrivers disk source=/home/chris/Downloads/virtio-win-0.1.271.iso

lxc config device add win11 thedrivers disk source=/home/brent/Downloads/virtio-win-0.1.271.iso
Device thedrivers added to win11

```

Go to the CD Drive in Windows and run virtio-win-gt-x64.msi

- remember to do a time sync each time you reboot

There are alot of virtio drivers installed with this msi.

There is also virtio-win-guest-tools.
<https://forum.proxmox.com/threads/cant-get-copy-paste-between-windows-11-host-vm-to-work-even-in-spice.130753/>

## virtio-win-guest-tools

installs:
spice agent
qemu agent

Go to the CD Drive in Windows and run virtio-win-guest-tools.exe

CategoriesArticles
Tagslxd-lxc
Snap
Async Await

## remove disk

`lxc config device remove win11 thedrivers`
