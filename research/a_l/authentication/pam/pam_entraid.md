# **[Himmelblau](https://github.com/himmelblau-idm/himmelblau#:~:text=Himmelblau%20is%20an%20interoperability%20suite,work%20isn't%20completed%20yet.)**

## **[pam_aad](https://github.com/aad-for-linux/pam_aad)**

In their own words
Himmelblau Idm Project. Himmelblau has 15 repositories available. Himmelblau, Github

AI Overview
Learn more
The Duality of the Pluggable Authentication Module | Group ...
To use Microsoft Entra ID (formerly Azure Active Directory) authentication with a Linux Pluggable Authentication Module (PAM), you need to configure PAM to use a module that interacts with Entra ID. This typically involves a daemon that handles authentication requests and a PAM module that uses that daemon. Here's a breakdown of the process and some common approaches:

1. Understanding the Components:
Pluggable Authentication Modules (PAM):
.
PAM is a framework that allows Linux systems to use various authentication methods. It's like a plug-and-play system for authentication.
Entra ID (formerly Azure Active Directory):
.
Microsoft's cloud-based identity and access management service.
Daemon:
.
A program that runs in the background and handles the communication between the PAM module and Entra ID.
PAM Module:
.
A specific PAM module that interacts with the Entra ID daemon to authenticate users.
2. Common Approaches and Tools:
Himmelblau:
An interoperability suite that provides Linux authentication to Entra ID using PAM and NSS modules. Himmelblau uses a daemon to communicate with Entra ID.
AADSSHLogin:
A Microsoft extension for Azure VMs that allows authentication using Microsoft Entra ID for SSH login. This approach uses a daemon and certificate-based authentication.
pam-keycloak-oidc:
A PAM module that supports OpenID Connect (OIDC) authentication, including support for MFA (Multi-Factor Authentication) using a token or password. While not specifically designed for Entra ID, it can be used with Entra ID configurations that support OIDC.
Azure AD Connect (or other synchronization tools):
If you have an on-premises Active Directory, you can synchronize it with Entra ID using Azure AD Connect. This allows you to use your on-premises identities for authentication on your Linux systems.
3. Configuration Steps (General):
Install the required modules:
Install the necessary PAM modules (e.g., Himmelblau, a specific OIDC module) and the Entra ID daemon.
Configure the daemon:
Set up the Entra ID daemon with the details of your Entra ID tenant (e.g., tenant ID, application client ID, secret).
Configure PAM:
Modify the PAM configuration files (e.g., /etc/pam.d/sshd, /etc/pam.d/login) to include the Entra ID PAM module and its parameters.
Test the configuration:
Verify that users can authenticate successfully using Entra ID credentials.
4. Example using Himmelblau:
Install Himmelblau: Install the Himmelblau package and its dependencies.
Configure the daemon: Set up the Himmelblau daemon with your Entra ID tenant information.
Configure PAM: Modify the PAM configuration files (e.g., /etc/pam.d/sshd) to include the Himmelblau PAM module.
Test: Verify that users can authenticate with their Entra ID credentials.
5. Considerations:
MFA:
.
If you need MFA support, ensure that the PAM module or the Entra ID daemon supports it. Some modules might support MFA through the use of a token or password, while others might delegate MFA to Entra ID policies.
On-premises vs. Cloud:
.
If you have on-premises Active Directory, you might need to synchronize it with Entra ID using tools like Azure AD Connect.
Offline Authentication:
.
Some PAM modules can cache credentials locally for offline authentication. However, make sure to configure this feature carefully, especially if you have strict security requirements.
In summary, authenticating Linux systems with Entra ID using PAM requires a combination of the right tools (like Himmelblau, AADSSHLogin, or OIDC modules), a well-configured daemon, and appropriate PAM configuration. The specific steps will vary depending on the chosen method, but the general principles remain the same.
