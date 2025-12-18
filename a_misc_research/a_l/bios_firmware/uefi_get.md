# UEFI variables for VMs

UEFI variables store and represent configuration settings of the UEFI firmware. See UEFI for more information.

You can see a list of UEFI variables on your system by running ls -l /sys/firmware/efi/efivars/. Usually, you don’t need to touch these variables, but in specific cases they can be useful to debug UEFI, SHIM, or boot loader issues in virtual machines.

```bash
sudo cat /sys/firmware/efi/efivars/SecureBootEnable-f0a30bc7-af08-4556-99c4-001009c93a44
```

To configure UEFI variables for a VM, use the lxc config uefi command or the /1.0/instances/<instance_name>/uefi-vars endpoint.

For example, to set a variable to a value (hexadecimal):

```bash
lxc config uefi set <instance_name> <variable_name>-<GUID>=<value>
```

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
