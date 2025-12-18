# **[Add or remove roles and features in Windows Server](https://learn.microsoft.com/en-us/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features)**

In Windows Server, the Server Manager console and Windows PowerShell cmdlets for Server Manager enable you to add roles and features to a local or remote server, or offline virtual hard disk (VHD). You can add multiple roles and features at the same time. This article describes how to add or remove roles and features in Windows Server, including multiple servers concurrently.

For more information about what roles and features are available in Windows Server, see **[Comparison of Windows Server editions](https://learn.microsoft.com/en-us/windows-server/get-started/editions-comparison)**.

## Prerequisites

Before you add or remove roles, role services, and features, ensure that you meet the following prerequisites:

- Use a user account that's an administrator. You also need to be an administrator on any remote servers that you're managing by using Server Manager, or offline VHDs that you're mounting.
- Review and understand any dependencies or prerequisites specific to the roles or features you plan to add, as some roles might require extra configuration or services to function correctly. For more information, see **[Configure Features on Demand in Windows Server](https://learn.microsoft.com/en-us/windows-server/administration/server-manager/configure-features-on-demand-in-windows-server)**.
- Provide the installation media or an alternate source path for the files that are required to add certain features, such as .NET Framework 3.5.
- To add roles and features on remote servers, add them to Server Manager. For more information about how to add servers to Server Manager, see Add Servers to Server Manager.

## Note

You can add roles and features on remote servers with Server Manager on same version of Windows Server or earlier. This requirement includes using the equivalent Windows client version with Remote Server Administration Tools (RSAT). For example, Windows Server 2025 can also add roles and features on Windows Server 2022, but Windows Server 2022 can't add roles and features on Windows Server 2025.

This article doesn't cover adding Remote Desktop Services (RDS) roles, which has a different installation process in Server Manager. For more information about adding RDS roles, see **[Deploy a Remote Desktop Services](https://learn.microsoft.com/en-us/windows-server/remote/remote-desktop-services/rds-deploy-infrastructure)** environment.

## Add roles and features to Windows Server

You can add roles and features on a local server, a remote server that is added to Server Manager, or an offline VHD, using the Add Roles and Features Wizard in Server Manager, or by using Windows PowerShell cmdlets.

To add roles and features using the Windows PowerShell module for Server Manager, follow these steps. Be sure to replace any <placeholder> values with your own.

- 1. Open a PowerShell session as an administrator.

## 2. Run the following command to get a list of all the roles and features available in Windows Server

```bash
Get-WindowsFeature
```

If you want to check roles and features on a remote server, use the -ComputerName parameter. You can use this parameter even if the remote server isn't added to Server Manager.

```PowerShell
Get-WindowsFeature -ComputerName <ComputerName>
```

Run the following commands to add a role or feature with the Install-WindowsFeature cmdlet. You need to specify the name of one or more roles or features you want to add, as shown in the following examples. You can find the complete documentation for the cmdlet at **[Install-WindowsFeature](https://learn.microsoft.com/en-us/powershell/module/servermanager/install-windowsfeature)**.

 Tip

Management tools and snap-ins for a role aren't included by default. To include management tools as part of a role installation, add the -IncludeManagementTools parameter to the cmdlet. If you're adding roles and features on a server that is running the Server Core installation option of Windows Server, you can add a role's management tools to an installation, but GUI-based management tools and snap-ins aren't installed. Only command-line and Windows PowerShell management tools are installed.

If the role or feature you add needs the server to be restarted to complete the installation, add the -Restart parameter to restart automatically without prompting.

To add DNS and DHCP roles on the local server, including management tools, run the following command:

```PowerShell
Install-WindowsFeature -Name DNS,DHCP -IncludeManagementTools
```

The output of the cmdlet shows the result of the installation, as shown in the following example. If the value for the parameter Restart Needed is Yes, restart the server to complete the installation.

Output

Copy
Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             Success        {DHCP Server, DNS Server}
You can get a list of all the installed roles and features by running the following command:

```PowerShell
Get-WindowsFeature | ? Installed -eq $true
```
