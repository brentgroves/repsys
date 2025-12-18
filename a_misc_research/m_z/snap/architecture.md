# **[](https://snapcraft.io/docs/system-architecture)**

The snap packaging system consists of many components, from system-level Linux kernel security modules, managed by the snap daemon, snapd, to the network connected Snap Store for package retrieval and updates.

These components inter-communicate and operate together to create a secure and confined execution environment for application and service deployment. The overall process with these components and their communication is outlined below.

System process overview

![i1](https://forum-snapcraft-io.s3.us-east-1.amazonaws.com/original/2X/8/8f76a1f0aba689e4f298779787c2da7ec4bcd373.png)

Snap system process overview, showing how the snap daemon, snapd, manages snaps within a sandbox and configures the system security modules for access

The snap daemon, snapd, handles snap management to configure and maintain each snap.

The snap damon also maintains the security configuration that creates the sandbox for both snap executables and data. This is implemented using various security modules of the Linux kernel, including Seccomp, AppAmor and Cgroups.

Snaps have the least possible privileges by default. Additional system resources are permitted through the interfaces mechanism which changes the security profile for each snap.

A snap package is a self-contained and immutable SquashFS file carrying application-specific content alongside metadata to tell the system how it should be manipulated.

Package downloads and updates are managed through a connection to the remote Snap Store, which includes package integrity and validation.

## Security modules

The snap daemon uses privilege isolation mechanisms rooted in the Linux kernel through Cgroups and Namespaces, AppArmor and Seccomp.

Cgroups Limit the amount of resources and which devices the process confined to a snap can consume (CPU, memory, network bandwidth, and so on).

Namespaces Make sure processes in a snap see their own personal view of the system (files, processes, network interfaces, hostname, and so on).

AppArmor Allows system administrators to restrict snap capabilities with default security profiles that can be extended.

Seccomp Isolates processes running in a snap by limiting the system calls they are allowed to make.
