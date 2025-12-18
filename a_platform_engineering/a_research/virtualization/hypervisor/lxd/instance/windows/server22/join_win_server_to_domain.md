# **[](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/join-computer-to-domain)**

## ref

- US Albion Servers

Joining a server or client device to a domain is an essential step for achieving centralized management and improved security within an organization's network. Whether you're configuring a new device or optimizing your network setup, follow this guide for a seamless integration into your domain environment.

KB5020276 is a Microsoft update that strengthens the security of the domain join process. This update introduces enhanced validation and authentication to help prevent unauthorized devices from joining a Windows domain, ensuring that only trusted devices can be added to your network. To learn more, see KB5020276 - Netjoin: Domain join hardening changes.

## Prerequisites

Server requirements

Your Windows Server device must have the Active Directory Domain Services role installed to use the Active Directory Users and Computers (ADUC) tool. To learn more, see Install or Uninstall Roles, Role Services, or Features.

You must be a member of the Administrators group or have administrative privileges on both the local account and domain account.

## Note

To keep time synchronized, organizations often use the Windows Time Service or a Network Time Protocol (NTP) server. Within a domain, computers typically sync their clocks with the Domain Controller, which should be aligned with a dependable time source. This process ensures consistent time settings across all devices in the domain, minimizing potential issues with Kerberos authentication.

## Prestage a device using ADUC

This step is optional and not mandatory for joining a device to a domain. However, prestaging a device in Active Directory can streamline the process by pre-assigning the computer account to the appropriate organizational unit (OU) and ensuring proper permissions are in place before the device joins the domain.

- In Server Manager, select the Tools button from the top right menu.
- In the drop-down menu, select Active Directory Users and Computers.
- In the left pane, navigate to and select the appropriate organizational unit (OU).
- Select the Actions tab, select New, then select Computer.
Enter the computer name and configure which user or group the device should belong to.

Select OK This can help prepare for when the client is ready to join the domain.
