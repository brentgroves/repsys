<https://www.cyberciti.biz/faq/linux-find-windows-10-oem-product-key-command/>

Linux find Windows 10/11 OEM product key command
Author: Vivek Gite Last updated: July 19, 2025 16 comments
See all Microsoft Windows related FAQIremoved and installed Ubuntu Linux 20.04 LTS on my development Lenovo laptop. However, I need to use my Windows 10/11 pro in KVM VM for running the accounting app. How do I find and print my embedded Windows 10 pro key from a Linux command line option? How can I retrieve Microsoft Windows 8 and 10/11 OEM product key from BIOS?

Most modern desktop and laptop comes with Windows 8 or 10 keys embedded in BIOS. Thinkpad, Dell, and many other BIOS vendors expose these keys to Linux, too, along with tons of data. So one can find and retrieve Windows 10/11 or Windows 8 key using Linux. The key helps to activate the Windows version without any input from users.
Tutorial details
Difficulty level Easy
Root privileges Yes
Requirements Linux terminal
OS compatibility AlmaLinux • Alpine • Arch • CentOS • Debian • Fedora • Linux • Mint • openSUSE • Pop!_OS • RHEL • Rocky • Stream • SUSE • Ubuntu
Est. reading time 3 minutes
How To – Linux find Windows 10/11 OEM product key
To find your original Windows 10/11 product key from Linux:

Open the terminal application.
You must run the Linux command as the root user.
Type ‘sudo strings /sys/firmware/acpi/tables/MSDM‘ to print Windows 10/11 or Windows 8 OEM product key
You can also use the acpidump command to get the same information under Linux.
Let us see all the commands and examples in detail to located Windows 10/11 OEM serial number or key.

Say hello to /sys/firmware/acpi/tables
ACPI tables can be retrieved via sysfs in latest Linux kernels. For example, type the following ls command:
ls -l /sys/firmware/acpi/tables/

Sample outputs:

total 0
-r-------- 1 root root    300 Jan 17 17:01  APIC
-r-------- 1 root root    160 Jan 17 17:01 'ASF!'
-r-------- 1 root root     74 Jan 17 17:01  BATB
-r-------- 1 root root     56 Jan 17 17:01  BGRT
-r-------- 1 root root     40 Jan 17 17:01  BOOT
drwxr-xr-x 2 root root      0 Jan 17 17:01  data
-r-------- 1 root root     84 Jan 17 17:01  DBG2
-r-------- 1 root root     52 Jan 17 17:01  DBGP
-r-------- 1 root root    144 Jan 17 17:01  DMAR
-r-------- 1 root root 157823 Jan 17 17:01  DSDT
drwxr-xr-x 2 root root      0 Jan 17 17:01  dynamic
-r-------- 1 root root     83 Jan 17 17:01  ECDT
-r-------- 1 root root    276 Jan 17 17:01  FACP
-r-------- 1 root root     64 Jan 17 17:01  FACS
-r-------- 1 root root     68 Jan 15 15:04  FPDT
-r-------- 1 root root     56 Jan 17 17:01  HPET
-r-------- 1 root root    148 Jan 17 17:01  LPIT
-r-------- 1 root root     60 Jan 17 17:01  MCFG
-r-------- 1 root root     85 Jan 17 17:01  MSDM
-r-------- 1 root root     45 Jan 17 17:01  NHLT
-r-------- 1 root root   6950 Jan 17 17:01  SSDT1
-r-------- 1 root root   3817 Jan 17 17:01  SSDT10
-r-------- 1 root root   5759 Jan 17 17:01  SSDT11
-r-------- 1 root root   7036 Jan 17 17:01  SSDT12
-r-------- 1 root root    244 Jan 17 17:01  SSDT13
-r-------- 1 root root   1389 Jan 17 17:01  SSDT2
-r-------- 1 root root  21120 Jan 17 17:01  SSDT3
-r-------- 1 root root  12605 Jan 17 17:01  SSDT4
-r-------- 1 root root  10844 Jan 17 17:01  SSDT5
-r-------- 1 root root   1554 Jan 17 17:01  SSDT6
-r-------- 1 root root   1328 Jan 17 17:01  SSDT7
-r-------- 1 root root   6725 Jan 17 17:01  SSDT8
-r-------- 1 root root  10433 Jan 17 17:01  SSDT9
-r-------- 1 root root     52 Jan 17 17:01  TPM2
-r-------- 1 root root     66 Jan 17 17:01  UEFI1
-r-------- 1 root root    298 Jan 17 17:01  UEFI2
-r-------- 1 root root     40 Jan 17 17:01  WSMT
The /sys/firmware/acpi/tables facility can be used by platform/BIOS vendors to provide a Linux compatible environment without modifying the underlying platform firmware. This facility also provides a powerful feature to debug and test ACPI BIOS table compatibility quickly with the Linux kernel by changing the old platform provided ACPI tables or inserting new ACPI tables.

How to retrieve Windows 8 and Windows 10/11 OEM product key from BIOS when using Linux
First, open the terminal application by pressing Ctrl – Alt + T keyboard shortcut. Then type the following cat command or bat command:
sudo cat /sys/firmware/acpi/tables/MSDM

Feel free to use the tail command as shell pipe:
sudo cat /sys/firmware/acpi/tables/MSDM | tail -1

Linux find Windows 10/11 or Windows 8 OEM Product Key command
Retrieve an embedded Windows OEM key using Linux operating system

A note about retrieving the product key in Windows 10/11 or Windows 8 itself
Open a new command prompt window (cmd.exec) and type the following command:
wmic path softwarelicensingservice get OA3xOriginalProductKey

How to retrieve and print the product key in Windows 10 or Windows 8
Find Windows 10 OEM product key using CMD app (cmd.exec)

Conclusion
You learned how to find your embedded Windows 8 or Windows 10/11 OEM product key from a Linux command line option or when Linux installed. I have not tested these commands with Windows 11 as I don’t have access. But, over X (formally Twitter), several users confirmed that commands work on Windows 11 OEM key.
