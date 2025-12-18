# **[]()**

lxc secure boot
LXC and Secure Boot
Can LXC containers use Secure Boot?
LXC containers can interact with Secure Boot in different ways depending on whether they are running as traditional system containers or as virtual machines (VMs).

1. Traditional LXC containers (sharing the host kernel)

**No direct Secure Boot support:** Traditional LXC containers share the host system's kernel.
**Host Secure Boot is the key:** The security of these containers relies on the host system's Secure Boot status. If the host is running with Secure Boot enabled, the host's boot chain and kernel modules will be verified.
**Impact of Host Secure Boot:** A Secure Boot enabled host will ensure that only trusted software runs during the boot process, including the host kernel that the LXC containers utilize.

2. LXD (LXC daemon) managing virtual machines

**UEFI and Secure Boot for VMs:** LXD, the management daemon for LXC, can also manage virtual machines (VMs) alongside containers.
**Secure Boot in VMs:** VMs created through LXD can leverage Secure Boot within their emulated UEFI environment.
**LXD and secureboot option:** LXD provides a "security.secureboot" option to control the Secure Boot behavior within VMs.

## In Summary

- Traditional LXC containers running on a Secure Boot enabled host benefit from the host's verified boot chain but don't directly utilize Secure Boot within the container itself.
- LXD-managed virtual machines can have Secure Boot enabled within their virtual environment for enhanced security.

To display the variables that are set for a specific VM:

```bash
lxc config uefi show <instance_name>
lxc config uefi show win11c
...
SecureBootEnable-f0a30bc7-af08-4556-99c4-001009c93a44:
    data: "01"
    attr: 3
    timestamp: ""
    digest: ""
```

## Example

You can use UEFI variables to disable secure boot, for example.

## Important

Use this method only for debugging purposes. LXD provides the security.secureboot option to control the secure boot behavior.

The following command checks the secure boot state:

```bash
lxc config uefi show <instance_name>
lxc config uefi show win11c
...
SecureBootEnable-f0a30bc7-af08-4556-99c4-001009c93a44:
    data: "01"
    attr: 3
    timestamp: ""
    digest: ""
```

```bash
lxc config uefi get win11c SecureBootEnable-f0a30bc7-af08-4556-99c4-001009c93a44

01
lxc config uefi get win11 SecureBootEnable-f0a30bc7-af08-4556-99c4-001009c93a44 

00
```

A value of 01 indicates that secure boot is active. You can then turn it off with the following command:

```bash
lxc config uefi set v1 SecureBootEnable-f0a30bc7-af08-4556-99c4-001009c93a44=00
```
