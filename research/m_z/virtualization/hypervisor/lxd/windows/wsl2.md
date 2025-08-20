# wsl install

The error code Wsl/InstallDistro/Service/RegisterDistro/CreateVm/HCS/HCS_E_SERVICE_NOT_AVAILABLE indicates that Windows Subsystem for Linux (WSL) is unable to create or start a virtual machine instance because a required service or feature, specifically related to the Hyper-V Compute Service (HCS), is not properly configured or available.

## Common causes and solutions

Virtual Machine Platform or Windows Hypervisor Platform not enabled:
Navigate to "Turn Windows features on or off" by searching for it in the Start menu or through Control Panel > Programs > Programs and Features.
Ensure that "Virtual Machine Platform" and "Windows Hypervisor Platform" are checked.
Click "OK" and restart your computer if prompted.
Hardware Virtualization disabled in BIOS/UEFI:
Restart your computer and enter your BIOS/UEFI settings (usually by pressing F2, Del, or a similar key during startup).
Locate the virtualization setting (often labeled "Intel VT-x," "AMD-V," "SVM Mode," or similar) and ensure it is enabled.
Save changes and exit BIOS/UEFI.
Corrupted WSL installation or distribution:
Unregister existing distributions: Open an elevated PowerShell or Command Prompt and use wsl --unregister <DistributionName> for any problematic distributions.
Uninstall and reinstall WSL:
dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux /norestart
Reboot your system.
wsl --install
Hyper-V issues:
If you are using Hyper-V, ensure it is correctly installed and functioning. You might try disabling and re-enabling the "Hyper-V" feature in "Turn Windows features on or off" followed by a restart.
Important Considerations:
After enabling or disabling Windows features, a system restart is often required for the changes to take effect.
Verify your system meets the minimum requirements for running WSL2, especially regarding virtualization support.
