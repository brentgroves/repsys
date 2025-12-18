# **[Creating a Windows Server 2019 instance in LXD](https://lxdware.com/creating-a-windows-server-2019-instance-in-lxd/)**

If you don’t already have an ISO file of the operating system, Microsoft allows users to download an evaluation copy of Windows Server 2019 . You will need a license key to use beyond the evaluation period. An ISO file needed for the virtual machine can be downloaded from <https://www.microsoft.com/en-US/evalcenter/evaluate-windows-server-2019?filetype=ISO>. The ISO filename was very long (17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso) so for the sake of this how-to guide, I renamed it to Server2019.iso.

In many virtual environments, the Windows operating system needs to have virtio drivers installed during the installation process to detect hardware such as the hard drive. You will need a copy of these drivers. An ISO file of the virtio drivers can be downloaded from <https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso>. The current stable version at the time of this guide is virtio-win-0.1.185.iso.

Now that we have all the necessary components downloaded let’s create the virtual machine. We will create an empty instance named win2019 and set the instance type to virtual machine. To create the instance use the command:

```bash
lxc init win2019 --empty --vm
```

Before we start the virtual machine, there are special configurations that need to be setup such as booting from the downloaded ISO files as well as allocating CPU, RAM, and disk space. We will achieve this by creating two profiles that will be attached to the virtual machine.

The first profile will set the necessary hardware resources required to run Windows. This can be adjusted for your environment. We will call this profile windows-required and configure the profile to use 2 CPUs, 4GB or memory, and 30GB of hard disk space. We will also need to turn secure boot off. For additional help on creating profiles see the guide Setting instance CPU and memory limits. To create the profile and add the necessary configurations use the following commands:

```bash
lxc profile create windows-required
lxc profile set windows-required limits.cpu=2 limits.memory=4GB security.secureboot=false

lxc profile device add windows-required root disk path=/ pool=default size=30GB
```

The second profile is designed to be removed once Windows is installed. This profile will contain the filepaths for the ISO images downloaded earlier. These filepaths will need to be adjusted for your environment, but will server a reference. We will also need to allow LXD read, write, and lock (rwk) access to our download location through apparmor. To create the profile and add both the Server2019.iso and virtio-win-0.1.185.iso files use the following commands:

```bash
lxc profile create windows-installation

 lxc profile set windows-installation raw.qemu="-drive file=/home/matthew/Downloads/Server2019.iso,index=0,media=cdrom,if=ide -drive file=/home/matthew/Downloads/virtio-win-0.1.185.iso,index=1,media=cdrom,if=ide"

 lxc profile set windows-installation raw.apparmor="/home/matthew/Downloads/** rwk,"
```

Both the windows-required and windows-installation profiles can now be added to the win2019 virtual machine. To add both profiles use the following commands:

```bash
lxc profile add win2019 windows-required
 lxc profile add win2019 windows-installation
```

Now it is time to start the virtual machine using the console option and bring up the boot menu to select the Windows ISO file as the boot device. This part can be a little tricky as you will need to press the Esc key immediately as the instance starts, similar to how you would get into the CMOS settings of a computer. Use the following command to start the virtual machine with a console:

```basj
$ lxc start win2019 --console
(Press Esc key after running command)
```

Select Boot Manager from the menu and then UEFI QEMU DVD-ROM QM00001 to boot. You may see the Windows “Press any key to boot from CD…” appear or it may just be a blank screen, either way press Enter a few times to begin the installation process. It will appear as those the screen has frozen, we now need to exit the console so that we can open up a new VGA console. To exit, press both the Ctrl and a keys together, then after that press the q key (Ctrl+a-q) to release the console.

The next step is to setup a VGA console connection to the virtual machine. If the Remote Viewer (virt-viewer) application is installed it should automatically open after running the lxc console command. If the application doesn’t start a spice+unix URI will be returned that can be entered into the Remote Viewer application to connect. To open a VGA console use the following command:

```bash
lxc console win2019 --type=vga
```

Click through the first few setup prompts until you get to the “Where do you want to install Windows” screen. Click the Load driver option, expand CD Drive (E:) virtio-win-0.1.185 and select E:\vioscsi\2k19\amd64. You should now see a disk drive to install the operating system on. You can also choose to install the network driver now or after login. If you choose to install the driver now, repeat the Load driver process and select E:\NetKVM\2k19\amd64.

Continue the installation process. If the disk drive is offline, click the”Windows can’t be installed on this drive” link to turn it online. When the operating system reboots you will need to reconnect to the VGA console (The screen will appear frozen). It will more than likely reboot once or twice during the installation process.

After you have logged in, finish installing the remaining virtio drivers by opening up the E:\drive and running the virtio-win-gt-x64 install package. Be sure to configure a remote connection option such as RDP or Powershell

When finished setting Windows up, power off the virtual machine and remove the windows-installation profile as it is no longer needed. To remove the profile from the virtual machine use the following command:

$ lxc stop win2019
 $ lxc profile remove win2019 windows-installation
Start the win2019 instance up and test to verify that you can connect to it’s IP address either through RDP or Powershell.

$ lxc start win2019
If you plan to use this virtual machine to spawn additional virtual machines be sure to run the Windows sysprep tool and then you can either use LXD to publish the virtual machine or copy it to a new instance.
