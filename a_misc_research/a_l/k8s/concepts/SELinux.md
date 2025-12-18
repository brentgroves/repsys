# **[SELinux](https://en.wikipedia.org/wiki/Security-Enhanced_Linux#:~:text=SELinux%20is%20a%20set%20of,involved%20with%20security%20policy%20enforcement.)**

## references

<https://kubernetes.io/docs/tasks/configure-pod-container/security-context/>

## SELinux

SELinux is a set of kernel modifications and user-space tools that have been added to various Linux distributions. Its architecture strives to separate enforcement of security decisions from the security policy, and streamlines the amount of software involved with security policy enforcement.

The NSA Security-enhanced Linux Team describes NSA SELinux as[5]

a set of patches to the Linux kernel and utilities to provide a strong, flexible, mandatory access control (MAC) architecture into the major subsystems of the kernel. It provides an enhanced mechanism to enforce the separation of information based on confidentiality and integrity requirements, which allows threats of tampering, and bypassing of application security mechanisms, to be addressed and enables the confinement of damage that can be caused by malicious or flawed applications. It includes a set of sample security policy configuration files designed to meet common, general-purpose security goals.

A Linux kernel integrating SELinux enforces mandatory access control policies that confine user programs and system services, as well as access to files and network resources. Limiting privilege to the minimum required to work reduces or eliminates the ability of these programs and daemons to cause harm if faulty or compromised (for example via buffer overflows or misconfigurations). This confinement mechanism operates independently of the traditional Linux (discretionary) access control mechanisms. It has no concept of a "root" superuser, and does not share the well-known shortcomings of the traditional Linux security mechanisms, such as a dependence on setuid/setgid binaries.

The security of an "unmodified" Linux system (a system without SELinux) depends on the correctness of the kernel, of all the privileged applications, and of each of their configurations. A fault in any one of these areas may allow the compromise of the entire system. In contrast, the security of a "modified" system (based on an SELinux kernel) depends primarily on the correctness of the kernel and its security-policy configuration. While problems with the correctness or configuration of applications may allow the limited compromise of individual user programs and system daemons, they do not necessarily pose a threat to the security of other user programs and system daemons or to the security of the system as a whole.

From a purist perspective, SELinux provides a hybrid of concepts and capabilities drawn from mandatory access controls, mandatory integrity controls, role-based access control (RBAC), and type enforcement architecture. Third-party tools enable one to build a variety of security policies.

## **[ubuntu selinux](https://wiki.ubuntu.com/SELinux)**

Warning

The Ubuntu-specific "selinux" and "selinux-policy-ubuntu" packages documented here have not received much attention since Karmic, and appear to be effectively broken in Precise.

If you wish to use SELinux in Ubuntu, the "selinux-basics" and "selinux-policy-default" packages from Debian are still being actively maintained. Documentation relevant to those packages can be found at <http://wiki.debian.org/SELinux>

Alternatives
**[AppArmor](https://wiki.debian.org/AppArmor)**

Tomoyo
