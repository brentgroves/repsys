# **[Resolving the Error “The following packages have been kept back”](https://www.baeldung.com/linux/apt-packages-kept-back)**

**[Research List](../../research_list.md)**\
**[Detailed Status](../../../a_status/detailed_status.md)**\
**[Curent Tasks](../../../a_status/current_tasks.md)**\
**[Back to Main](../../../README.md)**

In the intricate landscape of Linux package management, users often encounter challenges that require a keen understanding of system dynamics. One such problem is the error message that cryptically states The following packages have been kept back. This message can leave even seasoned users scratching their heads.

In this tutorial, we’ll explore ways to resolve this error while navigating the complexities of package management.

## 2. Understanding the Error

When confronted with the message The following packages have been kept back, our first task is to comprehend the underlying issue. Essentially, this notification indicates that some packages on our system couldn’t get an upgrade, even though newer versions are available. The reasons for this can be manifold, including dependency issues, conflicts, or other intricacies within the package management system.

## 3. Exploring Common Causes

Let’s delve deeper into the common causes behind this error message in the Linux package management system.

## 3.1. Dependency Issues

We often struggle with numerous issues that underpin Linux packages. When the Linux package management system blocks certain packages, it might be due to unresolved dependency issues.

Imagine we have a Linux system with Package A (version 1.0) installed. There is also a Library X (version 1.2) installed to meet the dependency of Package A. We want to upgrade Package A to version 2.0 and Library X to version 2.0.

## Dependency Conflict

The new version of Package A (2.0) requires Library X version 2.0.
However, other packages on your system still depend on Library X version 1.2.

## Dilemma for Package Manager

The package manager faces a dilemma. Upgrading Package A to version 2.0 would mean upgrading Library X to version 2.0 as well.
Upgrading Library X could potentially break compatibility with other installed packages relying on version 1.2.

## Packages Kept Back

To maintain system stability and prevent potential conflicts, the package manager decides to keep both Package A and Library X at their current versions.
The error message The following packages have been kept back is displayed to inform the user about this decision.

## 3.2. Pin Preferences

Imagine we’re managing a server environment, and one critical component of our application relies on a specific version of a package, say, Package B (version 1.5). Our package manager detects an update when a new version of Package B (version 2.0) is available. But, we want to maintain stability by configuring pinning preferences to prevent automatic upgrades of the package to newer versions.

## Package Pinning Preferences

- The package manager consults the package pinning preferences, which explicitly list and hold Package B at its current version.
- These preferences could be set in a configuration file, such as /etc/apt/preferences on Debian-based systems.

## Dilemma for Package Manager

The package manager recognizes the newer version of Package B but respects the pinning preferences that indicate not to automatically upgrade it.

- Despite the availability of an update, Package B remains at version 1.5 as per the pinning rules.
- Packages Kept Back:
  - The package manager, therefore, displays an error message indicating that Package B couldn’t upgrade.

## 3.3. Incomplete Upgrades

In some instances, Linux may hold packages due to incomplete upgrades or interrupted package installations. As a result, Linux blocks updates midway, leaving the system in a state of limbo.

Imagine we’re in the process of updating our Linux system with Package C from version 2.0 to version 3.0 using a package manager. During this update, an interruption occurs, such as a sudden power outage, network failure, or manual termination of the update process.

- System in Limbo:
  - The interruption leaves the system in a state of limbo. Consequently, some packages get a partial upgrade, while others remain at their previous versions.
  - In the next attempt to upgrade, the package manager detects that the system is in an inconsistent state.

- Dependency Mismatch:
  - The interrupted upgrade may have led to a situation where some packages are at newer versions, while others are still at their previous versions.
  - The mismatch in the dependencies between these packages might create uncertainty about the stability of the system.

- Packages Kept Back:
  - To prevent potential conflicts and ensure a consistent system state, the package manager may decide to keep certain packages, including Package C, at their current versions.
  - Therefore, the package manager displays an error message to inform the user about this decision.

## 3.4. Phased Updates

Phased updates can be a notable factor contributing to error messages in Linux package management. With phased updates, software packages are gradually made available to different subsets of users.

Phased Updates Enabled:
If we enable phased updates on our system, we may find that certain packages aren’t updating because our specific machine, based on /etc/machine-id, isn’t scheduled yet to receive the update.
Package Manager Decision:
Since we belong to a subset of users not scheduled to receive the update, the package manager refrains from updating certain packages.
Error Message Indication:
Consequently, users may encounter the same error message, indicating that specific packages have been kept back.

## 4. Resolving the Problem

Resolving this problem requires a systematic approach to address the underlying issues. These can be dependency conflicts, pin preferences, incomplete upgrades, or conflicting packages. Let’s walk through the different steps to overcome this challenge.

4.1. Update the Package Lists
To tackle this challenge, we begin by ensuring that our package lists are up to date:

```bash
sudo apt update
sudo apt upgrade
```

The sudo apt update command refreshes the package lists with the latest information, while the sudo apt upgrade command initiates the upgrade process for installed packages.

## 4.2. Remove Obsolete Packages

We scour our systems for obsolete packages that might hinder the upgrade process. Running the sudo apt autoremove command helps efficiently clean up obsolete packages, freeing up disk space and maintaining an optimized Linux system:

`sudo apt autoremove`

## 4.3. Install the Held Back Packages

Finally, we can release the packages that the Linux system blocks:

`sudo apt dist-upgrade`

Executing sudo apt dist-upgrade command not only upgrades installed packages but also handles dependencies and resolves conflicts, ensuring a seamless system upgrade.

## 4.4. Adjust Pin Preferences

We can find the configuration files for package pinning in /etc/apt/preferences or similar directories, depending on the Linux distribution. With configured package pinning preferences, we might need to delve into the configuration files to adjust and align them with specific upgrade goals.

We can adjust pin preferences by specifying version numbers, release names, or other attributes to guide the package manager’s behavior during upgrades:

Package: my-package
Pin: version 2.0
Copy
If such a package requires an upgrade, we temporarily unpin it for the duration of the upgrade:

Package: my-package
Pin: release a=axy
Copy
By carefully adjusting package pinning preferences, we strike a balance between maintaining system stability and enabling necessary upgrades. This also ensures resolving conflicts and contributing to a more efficient Linux package management system.

## 4.5. Install Full Update

In some instances when incomplete upgrades or interrupted package installations lead to packages being held back, we may need to perform a complete system upgrade to resolve any inconsistencies:

```bash
sudo apt update
sudo apt full-upgrade
```

This ensures updating the packages to their latest versions to correctly resolve the dependencies.

```bash

sudo apt update -y && sudo apt upgrade -y
...
# The following upgrades have been deferred due to phasing:
#   libsnmp-base libsnmp40t64 pci.ids python3-software-properties software-properties-common software-properties-gtk ubuntu-drivers-common
# The following packages have been kept back:
#   libclang-cpp18 libllvm18
...
apt remove --simulate libclang-cpp18

# NOTE: This is only a simulation!
#       apt needs root privileges for real execution.
#       Keep also in mind that locking is deactivated,
#       so don't depend on the relevance to the real current situation!
# Reading package lists... Done
# Building dependency tree... Done
# Reading state information... Done
# The following packages were automatically installed and are no longer required:
#   ieee-data libclang1-18 libllvm18 python3-netaddr
# Use 'apt autoremove' to remove them.
# The following packages will be REMOVED:
#   bpfcc-tools bpftrace libbpfcc libclang-cpp18 python3-bpfcc
# 0 upgraded, 0 newly installed, 5 to remove and 8 not upgraded.
# Remv bpfcc-tools [0.29.1+ds-1ubuntu7]
# Remv bpftrace [0.20.2-1ubuntu4.3]
# Remv python3-bpfcc [0.29.1+ds-1ubuntu7]
# Remv libbpfcc [0.29.1+ds-1ubuntu7]
# Remv libclang-cpp18 [1:18.1.3-1ubuntu1]

sudo apt list --upgradable
Listing... Done
libclang-cpp18/focal-security 1:18.1.8-11~20.04.2 amd64 [upgradable from: 1:18.1.3-1ubuntu1]
libllvm18/focal-security 1:18.1.8-11~20.04.2 amd64 [upgradable from: 1:18.1.3-1ubuntu1]
libsnmp-base/noble-updates,noble-updates 5.9.4+dfsg-1.1ubuntu3.1 all [upgradable from: 5.9.4+dfsg-1.1ubuntu3]
libsnmp40t64/noble-updates 5.9.4+dfsg-1.1ubuntu3.1 amd64 [upgradable from: 5.9.4+dfsg-1.1ubuntu3]
pci.ids/noble-updates,noble-updates 0.0~2024.03.31-1ubuntu0.1 all [upgradable from: 0.0~2024.03.31-1]
python3-software-properties/noble-updates,noble-updates 0.99.49.2 all [upgradable from: 0.99.49.1]
software-properties-common/noble-updates,noble-updates 0.99.49.2 all [upgradable from: 0.99.49.1]
software-properties-gtk/noble-updates,noble-updates 0.99.49.2 all [upgradable from: 0.99.49.1]
ubuntu-drivers-common/noble-updates 1:0.9.7.6ubuntu3.2 amd64 [upgradable from: 1:0.9.7.6ubuntu3.1]
```
