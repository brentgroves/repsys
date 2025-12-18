# Access to the Structures Imaging Server using a self-signed certificate

Submitted : 2025-11-26 19:05:48
Request Number : REQ0229979

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

## Background

Structures has created a **[Fog imaging server](https://fogproject.org/)** so that IT can quickly image laptops. This imaging server creates a self-signed certificate. As part of the PXE boot process the imaging server directs the client to a PHP boot menu at <https://10.188.50.212/fog/service/ipxe/boot.php>. At the time of this https request the laptop client does not have an OS installed or any trust store. The error message displayed by the laptop is that it is not allowed access to this URL. To trouble-shoot this issue we tried to access this URL from Chrome on a laptop running on Avilla's desktop VLAN and got the following certificate error:

Certificate Viewer: 10.188.50.212

Common Name (CN) 10.188.50.212
Organization (O) <Not Part Of Certificate>
Organizational Unit (OU) <Not Part Of Certificate>
Common Name (CN) Fortinet Untrusted CA
Organization (O) Fortinet
Organizational Unit (OU) Certificate Authority
Issued On Thursday, November 20, 2025 at 5:11:33 PM
Expires On Sunday, November 18, 2035 at 5:11:33 PM
Certificate 5d9beb5aa5aa223bc84b25cd8b88335a0eac2d9a7b95b1a6cf9fdb562c4e3b93
Public Key 96d8b0b53fa93a96d09f7a89677ba9475624f302d630a86859fbcdbdef0ef2ab

Although I could see the PHP file using the following curl command:

`curl -k https://10.188.50.212/fog/service/ipxe/boot.php`

This IP address is from the range of IP address used by the Structures MicroCloud/K8S cluster.  And in the following completed network config request we asked that clients from all Structure desktop VLANs be granted access to TCP ports 80/443 in the IP range 10.188.50.[200-212].

Submitted : 2025-11-11 17:36:10
Request Number : REQ0228087

So, since we could see the PHP file using curl we are not sure if this is a network configuration issue or a certificate issue.  We have configured PXE boot scope options 066 and 067 in the Avilla desktop VLAN DHCP server and the laptop seems to be getting a valid desktop VLAN IP address. We have also verified the time on the client laptop is not out of the expiration range for the certificate.

## Issue

Can't access the Fog imaging server's menu PHP file which is running on the Avilla server VLAN from Avilla's desktop VLAN.

**Project:** Structures Imaging Server

**IP range:** 10.188.50.212

**Request:** Please help us determine why we can not access the Structures Image Server's PHP menu file from the laptop to be imaged which is assigned a desktop VLAN IP from the Avilla desktop VLAN's DHCP server as part of the PXI boot process.

**Reason:** So that IT can image laptops quickly using the Structures Imaging Server.

**Affected Application:** The Structures Imaging Server

**Business Justification:** The Structures IT team has been tasked to install and configure Windows 11 on around 50 laptops. This process would be considerably quicker and less error prone if we could use the **[fog imaging server](https://fogproject.org/)**.

## Requested Policy Change

Please help us troubleshoot why we can not access the Structures Imaging Server menu PHP file from laptop the goes through the PXI boot process and has been given an Avilla desktop VLAN IP address from the Avilla desktop DHCP server scoped with options 066 and 067 for PXI boot.

## Verify

From a PC running in any Structures desktop VLAN access <https://10.188.50.212/fog/service/ipxe/boot.php> image service menu from Chrome without getting the following error.

<https://10.188.50.212/fog/service/ipxe/boot.php>

Certificate Viewer: 10.188.50.212

Common Name (CN) 10.188.50.212
Organization (O) <Not Part Of Certificate>
Organizational Unit (OU) <Not Part Of Certificate>
Common Name (CN) Fortinet Untrusted CA
Organization (O) Fortinet
Organizational Unit (OU) Certificate Authority
Issued On Thursday, November 20, 2025 at 5:11:33 PM
Expires On Sunday, November 18, 2035 at 5:11:33 PM
Certificate 5d9beb5aa5aa223bc84b25cd8b88335a0eac2d9a7b95b1a6cf9fdb562c4e3b93
Public Key 96d8b0b53fa93a96d09f7a89677ba9475624f302d630a86859fbcdbdef0ef2ab
