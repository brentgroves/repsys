# **[try this video](https://www.google.com/search?q=how+to+add+networking+to+windows+vm+in+lxd&oq=how+to+add+networking+to+windows+vm+in+lxd&gs_lcrp=EgZjaHJvbWUyBggAEEUYOdIBCTM1NDE1ajBqNKgCALACAQ&sourceid=chrome&ie=UTF-8)**

**[LXD with Win11 - no network adapter driver](https://discourse.ubuntu.com/t/lxd-with-win11-no-network-adapter-driver/57538)**

**[issue](https://discourse.ubuntu.com/t/how-to-install-a-windows-11-vm-using-lxd/28940/22?page=2)**

EDIT: For now, I have found how to bypass the connection step doing this:
<https://learn.microsoft.com/en-us/answers/questions/1179311/windows-11-setup-without-internet#answer-1174644> 49

In the “Let’s connect you to a network” screen, press Shift+F10 to launch cmd;
Type the following command: OOBE\BYPASSNRO
After successful execution, the system will restart and restart the OOBE session box, when you reach the “Let’s connect you to a network” screen, click “I don’t have Internet”, continue to click “limited setup”, accept the license agreement and continue to create a local user account.

hi,
some hiccups i had

had to configure project to allow 'Disk devices (except the root one)
had problems on using lxc config device when instance is in a different node than where you’re operating Request for enhancement on lxd-windows tutorial · Issue #14429 · canonical/ubuntu.com · GitHub 10
suggested root disk image size is 50Gb, but recent download needs 56Gb at least. I made it work with 60Gb

## **[LXD with Win11 - no network adapter driver](https://discourse.ubuntu.com/t/lxd-with-win11-no-network-adapter-driver/57538)**

I am following the tutorial **[‘How to install a Windows 11 VM using LXD’](https://ubuntu.com/tutorials/how-to-install-a-windows-11-vm-using-lxd#1-overview)** at How to install a Windows 11 VM using LXD | Ubuntu 6. My version of LXD is 5.21.3 LTS. My version of Ubuntu is 24.04.2 LTS

Everything is OK until I get to the Windows Installer screen. The Installer asks me for a network adapter driver (screenshot below). Where are these drivers? I assumed that LXD itself would provide all the required drivers? How can I proceed to install Win11 in LXD?

![i1](https://ubuntucommunity.s3.us-east-2.amazonaws.com/optimized/3X/0/b/0b7fea646ac14e372aa0807274dc791718e8eb5d_2_800x547.jpeg)

```bash
lxd init
lxc network list
networkctl list
lxc list
lxc config show win11
lxc profile show default
lxc profile edit default
devices:
  enp1s0:
    name: eth0
    network: lxdbr0
    type: nic
but also bridge could be

devices:
  enp1s0:
    nictype: bridged
    parent: lxdbr0
    type: nic
```

<https://docs.ubuntu.com> 6

it could also be some ufw forward between interfaces or allow ports or dhcp port things or other network issues… But winbind, wsdd and similar services are not part of Linux best practices how to handle Windows issues.
