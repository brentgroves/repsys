# **[Linux Authentication](https://learn.microsoft.com/en-us/previous-versions/technet-magazine/dd228986(v=msdn.10)#id0060048)**

Originally, Linux (and the GNU tools and libraries that run on it) was not built with a single authentication mechanism in mind. As a result of this, Linux application developers generally took to creating their own authentication scheme. They managed to accomplish this by either looking up names and password hashes in /etc/passwd (the traditional text file containing Linux user credentials) or providing an entirely different (and separate) mechanism.

The resulting plethora of authentication mechanisms was unmanageable. In 1995, Sun proposed a mechanism called Pluggable Authentication Modules (PAM). PAM provided a common set of authentication APIs that all application developers could use, along with an administrator-configured back end that allowed for multiple "pluggable" authentication schemes. By using the PAM APIs for authentication and the Name Server Switch (NSS) APIs for looking up user information, Linux application developers could write less code, and Linux administrators could have a single place to configure and manage the authentication process.

Most Linux distributions come with several PAM authentication modules, including modules that support authentication to an LDAP directory and authentication using Kerberos. You can use these modules to authenticate to Active Directory, but there are some significant limitations, as I will discuss later in this article.

## Three Authentication Strategies

Given the availability of LDAP, Kerberos, and Winbind on Linux machines, there are three different implementation strategies we can employ to allow our Linux machine to use Active Directory for authentication.

Using LDAP Authentication The easiest but least satisfactory way to use Active Directory for authentication is to configure PAM to use LDAP authentication, as shown in Figure 1. Although Active Directory is an LDAPv3 service, Windows clients use Kerberos (with fallback to NTLM), not LDAP, for authentication purposes.

LDAP authentication (called LDAP binding) passes the user name and password in clear text over the network. This is insecure and unacceptable for most purposes.

![i1](https://learn.microsoft.com/en-us/previous-versions/technet-magazine/images/dd228986.fig01.gif)

Figure 1 Authenticating to Active Directory using LDAP (Click the image for a larger view)

The only way to mitigate this risk of passing credentials in the clear is to encrypt the client-Active Directory communication channel using something such as SSL. While this is certainly doable, it imposes the additional burden of managing the SSL certificates on both the DC and the Linux machine. Furthermore, using the PAM LDAP module does not support changing reset or expired passwords.

Using LDAP and Kerberos Another strategy for leveraging Active Directory for Linux authentication is to configure PAM to use Kerberos authentication and NSS to use LDAP to look up user and group information, as shown in Figure 2. This scheme has the advantage of being relatively more secure, and it leverages the "in-the-box" capabilities of Linux. But it doesn't take advantage of the DNS Service Location (SRV) records that Active Directory DCs publish, so you are forced to pick a specific set of DCs to authenticate to. It also doesn't provide a very intuitive way of managing expiring Active Directory passwords or, until recently, for proper group membership lookups.

![i2](https://learn.microsoft.com/en-us/previous-versions/technet-magazine/images/dd228986.fig02.gif)

NSS, or Network Security Services, is a set of cryptographic libraries used for developing secure applications. It's a core component for many applications, including web browsers like Firefox and Chrome, and provides support for various security standards like TLS/SSL, PKCS #5, and X.509 certificates.

Figure 2 Authenticating to Active Directory using LDAP and Kerberos (Click the image for a larger view)

Using Winbind The third way to use Active Directory for Linux authentication is to configure PAM and NSS to make calls to the Winbind daemon. Winbind will translate the different PAM and NSS requests into the corresponding Active Directory calls, using either LDAP, Kerberos, or RPC, depending on which is most appropriate. Figure 3 shows this strategy.

![i3](https://learn.microsoft.com/en-us/previous-versions/technet-magazine/images/dd228986.fig03.gif)

Figure 3 Authenticating to Active Directory using Winbind (Click the image for a larger view)

Our Implementation Plan

Because of the enhanced integration with Active Directory, I chose to use Winbind on Red Hat Enterprise Linux 5 (RHEL5) for my Linux-to-Active Directory integration project. RHEL5 is the current version of the commercial Red Hat Linux distribution, and it is fairly popular in enterprise datacenters.

Getting RHEL5 to authenticate to Active Directory basically requires five separate steps, as follows:

Locate and download the appropriate Samba and other dependent components.
Build Samba.
Install and configure Samba.
Configure Linux, specifically PAM and NSS.
Configure Active Directory.
The next few sections in this article describe these steps in more detail.
