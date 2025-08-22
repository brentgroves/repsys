# **[Instance options](https://documentation.ubuntu.com/lxd/latest/reference/instance_options/#instance-security:security.secureboot)**

Instance options are configuration options that are directly related to the instance.

See **[Configure instance options](https://documentation.ubuntu.com/lxd/latest/howto/instances_configure/#instances-configure-options)** for instructions on how to set the instance options.

## **[Configure instance options](https://documentation.ubuntu.com/lxd/latest/howto/instances_configure/#instances-configure-options)**

You can specify instance options when you create an instance. Alternatively, you can update the instance options after the instance is created.

Use the lxc config set command to update instance options. Specify the instance name and the key and value of the instance option:

```bash
# lxc config set <instance_name> <option_key>=<option_value> <option_key>=<option_value> ...

lxc config set win11 security.secureboot=<option_value> 

security.secureboot
```

See **[Instance options](https://documentation.ubuntu.com/lxd/latest/reference/instance_options/#instance-security:security.secureboot)**
for a list of available options and information about which options are available for which instance type.

For example, change the memory limit for your container:

To set the memory limit to 8 GiB, enter the following command:

```bash
lxc config set my-container limits.memory=8GiB
```

Note

Some of the instance options are updated immediately while the instance is running. Others are updated only when the instance is restarted.

See the **[“Live update”](https://documentation.ubuntu.com/lxd/latest/reference/instance_options/#instance-options)** information in the Instance options reference for information about which options are applied immediately while the instance is running.

The key/value configuration is namespaced. The following options are available:

Miscellaneous options

Boot-related options

cloud-init configuration

Resource limits

Migration options

NVIDIA and CUDA configuration

Raw instance configuration overrides

Security policies

Snapshot scheduling and configuration

Volatile internal data

## secureboot

security.secureboot
Whether UEFI secure boot is enabled with the default Microsoft keys

Key: security.secureboot
Type: bool
Default: true
Live update: no
Condition: virtual machine
