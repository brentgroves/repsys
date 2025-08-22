# secure boot

To manage secure boot with LXD for VMs, you can disable it by setting security.secureboot=false in the LXD configuration or by adding it to the lxc init or lxc launch command, like lxc config set VM-name security.secureboot=false. You can also use lxc config uefi get and lxc config uefi set to directly interact with UEFI variables for a VM, including the Secure Boot enable flag. You might need to disable secure boot when installing operating systems from an ISO image that doesn't support it.

## Disabling Secure Boot in LXD

For new VMs (during initialization):
Use the -c flag with lxc init or lxc launch:
Code

`lxc init VM-name --empty --vm -c security.secureboot=false`

`lxc launch ubuntu:22.04 VM-name --vm -c security.secureboot=false`

This will add the configuration key security.secureboot with the value false to the VM's settings.
For existing VMs (modifying configuration):
Set the configuration key using the lxc config set command:

```bash
lxc config get win11c security.secureboot
lxc config set VM-name security.secureboot=false
```

This command modifies the security configuration for the existing VM.
Using UEFI variables directly:
For more direct control or debugging, you can manage UEFI variables, including the Secure Boot flag, using lxc config uefi.
To check the current secure boot state (a value of 01 means enabled):
Code

```bash
lxc config uefi get v1 SecureBootEnable-f0a30bc7-af08-4556-99c4-001009c93a44
```

(Replace the long alphanumeric string with the actual UEFI variable name for your VM).
To disable it, set the variable to 00:
Code

```bash
lxc config uefi set v1 SecureBootEnable-f0a30bc7-af08-4556-99c4-001009c93a44=00
```
