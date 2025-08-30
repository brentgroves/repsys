# **[windows vm time sync issue](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/virtual-machine-time-not-synced)**

AI Overview
To resolve Windows VM time sync issues, ensure the hypervisor's time synchronization service is disabled for the guest VM, verify the guest's time zone and Windows Time service are set correctly, restart the Windows Time Service (services.msc), and manually sync the time or configure a reliable NTP server within the guest OS settings. For Hyper-V, disabling the time sync setting in the virtual machine's settings is a common first step.

1. Check Hypervisor Settings (for Hyper-V)
Disable Time Synchronization: In Hyper-V Manager, right-click the VM, select Settings.
Navigate to Management: Go to the Management section.
Uncheck the Option: Uncheck the Time synchronization option for the guest VM. Click Apply and OK.
2. Verify and Configure within the VM
Check Time Zone:
Open Settings > Time & language > Date & time within the VM and ensure the time zone is correct.
Enable Automatic Time:
Make sure Set time automatically is enabled in the Date & time settings.
Manually Sync Time:
In the same Date & time settings, scroll down to Additional settings and click Sync now.
Restart Windows Time Service:
Press Windows Key + R, type services.msc, and press Enter.
Find the Windows Time service, right-click it, and select Restart.
Ensure the Startup type is set to Automatic.
3. Troubleshoot the Windows Time Service (Advanced)
Register and Resync: Open an elevated Command Prompt (run as administrator) and execute these commands:
Code

    net stop w32time
    w32tm /unregister
    w32tm /register
    net start w32time
    w32tm /resync

Configure NTP Server: If manual sync fails, you can set up an NTP server.
In Settings, go to Time & language > Date & time.
Under Related settings, click on Additional date, time, & regional settings.
Click Internet Time > Change settings.
Check the box for Synchronize with an Internet time server and select a server, then click Update now.
4. Consider Other Factors
Firewall/Antivirus:
.
Temporarily disable third-party firewalls or antivirus software to see if they are blocking time synchronization.
Network Issues:
.
Ensure there's a stable internet connection, as your VM needs to reach a time server to sync.
