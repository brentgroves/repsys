# **[](https://christaylordeveloper.co.uk/articles/run-win11-in-lxd-lxc-virtual-machine/)**

Run Win11 in LXD LXC virtual machine
19 April 2025 by Chris Taylor
Updated: 22 July 2025

See <https://ubuntu.com/tutorials/how-to-install-a-windows-11-vm-using-lxd#1-overview>

Install LXD snap

sudo snap install lxd --channel=latest/stable
lxd --version # 6.3 at the time of writing
Install the LXD imagebuilder

sudo snap install lxd-imagebuilder --classic --edge
Initialise lxd and accept all the defaults

lxd init
If your Win11 VM has no internet access, it may be necessary to adjust the Firewall rules of the LXD bridge network.
See <https://www.cloudwizard.nl/lxd-ufw-configuration-ubuntu-22-04/>
This was necessary with an Ubuntu 24.04.2 LXD host, April 2024

sudo ufw allow in on lxdbr0
sudo ufw route allow in on lxdbr0
sudo ufw route allow out on lxdbr0
sudo ufw disable && sudo ufw enable
From the directory where the Windows ISO file has been downloaded

sudo lxd-imagebuilder repack-windows Win11_24H2_English_x64.iso win11.lxd.iso
Create the empty vm

lxc init win11c --vm --empty
Using 80GiB here instead of 50GiB

lxc config device override win11c root size=80GiB
Set CPU and RAM

lxc config set win11c limits.cpu=4 limits.memory=8GiB
Set TPM

lxc config device add win11c vtpm tpm path=/dev/tpm0
Insert the ISO

lxc config device add win11c install disk source=/home/chris/win11.lxd.iso boot.priority=10
Start the container. Hit Enter key (immediately) inside the console (on this first occasion only) to boot from the ISO

lxc start win11c --console=vga
Reconnect via the console, each time Windows reboots

lxc console win11c --type vga
Windows setup
Choose Windows 11 Pro N
Skip setting device name
Choose ‘Set up for work or school’
Select ‘Sign in options’
Select ‘Domain join instead’
Choose ‘Join domain’

Clean up
Remove the install ISO disk

lxc config device remove win11c install
Drivers
Drivers might need to be updated. In my case only one display resolution was available. See <https://discuss.linuxcontainers.org/t/how-to-increase-display-resolution-of-windows-vm/23508>

Download virtio-win.iso from <https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.271-1/>

Add the downloaded ISO as a device to the VM

```bash
# lxc config device add win11c thedrivers disk source=/home/chris/Downloads/virtio-win-0.1.271.iso

lxc config device add win11 thedrivers disk source=/home/brent/virtio-win-0.1.271.iso

lxc config device add wins22 thedrivers disk source=/home/brent/virtio-win-0.1.271.iso
Device thedrivers added to win11

```

# **[how to load drivers during windows installation](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/add-device-drivers-to-windows-during-windows-setup?view=windows-11)**

- **[load drivers](https://www.youtube.com/watch?v=N-oAi9qTUAA&t=345)**

1. add the virtio iso disk to lxd vm

2. start windows installation

During Windows Installation:
Start the installation: Boot your computer from the Windows installation USB or DVD.
Reach the drive selection: Proceed with the installation until you reach the screen where you choose the drive to install Windows on.
Click "Load driver": If you don't see any drives listed, or if your storage controller is not compatible with the installer, select "Load driver".
Browse for the driver: Click "Browse" and navigate to the folder on your USB drive that contains the extracted driver files.
Select the .inf file: Select the .inf file to install the driver.
Complete the installation: The driver will install, and your drives should now be detected. Continue with the Windows installation as normal.
This video shows how to load drivers during the Windows installation process, including navigating to the driver folder and selecting the .inf file:

Go to the CD Drive in Windows and run virtio-win-gt-x64.msi

There are alot of virtio drivers installed with this msi.

There is also virtio-win-guest-tools.

CategoriesArticles
Tagslxd-lxc
Snap
Async Await

## remove disk

`lxc config device remove win11 thedrivers`
