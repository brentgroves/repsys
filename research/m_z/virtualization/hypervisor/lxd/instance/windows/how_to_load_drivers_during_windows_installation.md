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
