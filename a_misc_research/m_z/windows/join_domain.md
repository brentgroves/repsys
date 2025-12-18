# **[Join a device to a domain](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/join-computer-to-domain?tabs=cmd&pivots=windows-server-2022#join-a-device-to-a-domain)**

Joining a device to a domain can be done using either graphical user interface (GUI) methods or command-line tools, depending on your preference and the needs of your environment. Both approaches ensure integration into the domain.

## Server Manager method

1. In Server Manager, select Local Server, under Workgroup, select the workgroup or domain name hyperlink.

2. Under the Computer Name tab, select Change.

3. Under Member of, select Domain, type the name of the domain that you wish the computer to join, and then select OK.

4. Provide the credentials needed to join the domain, then select OK.

5. After the device successfully joins the domain, a notification confirms the device's domain membership. Select OK, and you're prompted to restart your device.

## Command line method

Adding a device to a domain can be performed through the command prompt or PowerShell.

## Open an elevated PowerShell window

Run the following command replacing YourDomainName with your value:

### PowerShell

```PowerShell
Add-Computer -DomainName "YourDomainName" -Credential (Get-Credential)

Add-Computer -DomainName "linamar.com" -Credential (Get-Credential)

```

Restart-Computer
You're prompted to enter the domain credentials.

Your device restarts after entering the domain credentials to join the domain.
