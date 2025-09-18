# **[How to configure an authoritative time server in Windows Server](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/configure-authoritative-time-server)**

**[ref](https://learn.microsoft.com/en-us/windows-server/networking/windows-time-service/windows-time-service-tools-and-settings?tabs=config)**

03/20/2025
Applies to: Supported versions of Windows Server
This article describes how to configure the Windows Time service and troubleshoot when the Windows Time service doesn't work correctly.

Applies to:   Windows Server (All supported versions) Original KB number:   816042

To configure an internal time server to synchronize with an external time source, use the following method:

To configure the PDC in the root of an Active Directory forest to synchronize with an external time source, follow these steps:

1. Change the server type to NTP. To do this, follow these steps:

Select Start > Run, type regedit, and then select OK.

Locate and then select the following registry subkey:
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Parameters

In the pane on the right, right-click Type, and then select Modify.

In Edit Value, type NTP in the Value data box, and then select OK.

## Set AnnounceFlags to 5. To do this, follow these steps

Locate and then select the following registry subkey: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config

In the pane on the right, right-click AnnounceFlags, and then select Modify.

In Edit DWORD Value, type 5 in the Value data box, and then select OK.

 Note

If an authoritative time server that is configured to use an AnnounceFlag value of 0x5 does not synchronize with an upstream time server, a client server may not correctly synchronize with the authoritative time server when the time synchronization between the authoritative time server and the upstream time server resumes. Therefore, if you have a poor network connection or other concerns that may cause time synchronization failure of the authoritative server to an upstream server, set the AnnounceFlag value to 0xA instead of to 0x5.
If an authoritative time server that is configured to use an AnnounceFlag value of 0x5 and to synchronize with an upstream time server at a fixed interval that is specified in SpecialPollInterval, a client server may not correctly synchronize with the authoritative time server after the authoritative time server restarts. Therefore, if you configure your authoritative time server to synchronize with an upstream NTP server at a fixed interval that is specified in SpecialPollInterval, set the AnnounceFlag value to 0xA instead of 0x5.

## Enable NTPServer. To do this, follow these steps

Locate and then select the following registry subkey:
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer

In the pane on the right, right-click Enabled, and then select Modify.

In Edit DWORD Value, type 1 in the Value data box, and then select OK.

Specify the time sources. To do this, follow these steps:

Locate and then click the following registry subkey:
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Parameters

In the pane on the right, right-click NtpServer, and then select Modify.

In Edit Value, type Peers in the Value data box, and then select OK.
