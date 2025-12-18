# **[](https://learn.microsoft.com/en-us/windows-server/administration/server-manager/add-remove-roles-features?tabs=powershell)**

To add roles and features using the Windows PowerShell module for Server Manager, follow these steps. Be sure to replace any <placeholder> values with your own.

Open a PowerShell session as an administrator.

Run the following command to get a list of all the roles and features available in Windows Server:

```PowerShell
Get-WindowsFeature
```

If you want to check roles and features on a remote server, use the -ComputerName parameter. You can use this parameter even if the remote server isn't added to Server Manager.

```PowerShell
Get-WindowsFeature -ComputerName <ComputerName>
```

Run the following commands to add a role or feature with the Install-WindowsFeature cmdlet. You need to specify the name of one or more roles or features you want to add, as shown in the following examples. You can find the complete documentation for the cmdlet at Install-WindowsFeature.

 Tip

Management tools and snap-ins for a role aren't included by default. To include management tools as part of a role installation, add the -IncludeManagementTools parameter to the cmdlet. If you're adding roles and features on a server that is running the Server Core installation option of Windows Server, you can add a role's management tools to an installation, but GUI-based management tools and snap-ins aren't installed. Only command-line and Windows PowerShell management tools are installed.

If the role or feature you add needs the server to be restarted to complete the installation, add the -Restart parameter to restart automatically without prompting.

- To add DNS and DHCP roles on the local server, including management tools, run the following command:

```PowerShell
Install-WindowsFeature -Name DNS,DHCP -IncludeManagementTools
```

The output of the cmdlet shows the result of the installation, as shown in the following example. If the value for the parameter Restart Needed is Yes, restart the server to complete the installation.

Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             Success        {DHCP Server, DNS Server}
You can get a list of all the installed roles and features by running the following command:

```PowerShell
Get-WindowsFeature | ? Installed -eq $true
```

```PowerShell
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             Success        {Active Directory Domain Services, Group P...
```

## remove role

```PowerShell
Uninstall-WindowsFeature -Name DNS,DHCP -IncludeManagementTools
Uninstall-WindowsFeature -Name AD-Domain-Services
```
