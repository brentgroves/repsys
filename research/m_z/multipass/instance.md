# **[Multipass Instance](https://multipass.run/docs/instance)**

**[Back to Research List](../../research_list.md)**\
**[Back to Multipass Menu](./multipass_menu.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

See also **[how to manage instances](https://multipass.run/docs/how-to-guides#heading--manage-instances)**

An instance is a virtual machine created and managed by Multipass.

## Primary instance

The **[Multipass CLI](https://multipass.run/docs/multipass-cli-client)** provides a few shortcuts using one special instance, which is distinguished by name: the primary instance. By default, this is the instance named primary.

When invoked without positional arguments, state transition commands — **[start](https://multipass.run/docs/start-command)**, **[restart](https://multipass.run/docs/restart-command)**, **[stop](https://multipass.run/docs/stop-command)**, and **[suspend](https://multipass.run/docs/suspend-command)** — operate on this special instance. So does the **[shell](https://multipass.run/docs/shell-command)** command. Furthermore, start and shell create the primary instance if it does not yet exist.

When creating the primary instance, the Multipass CLI client mounts the user’s home directory automatically into it.

As with any other mount, it can be unmounted with multipass umount. For instance, multipass umount primary will unmount all mounts made by Multipass inside primary, including the auto-mounted Home. (On Windows, mounts are disabled by default for security reasons. See local.privileged-mounts for information on how to enable them if you need.)

In all other respects, the primary instance is the same as any other instance. Its properties are the same as if it had been launched manually with multipass launch --name primary.

## Selecting the primary instance

The name of the instance that the Multipass CLI treats as primary can be modified with the setting client.primary-name. This setting determines the name of the instance that Multipass creates and operates as primary, providing a mechanism to turn any existing instance into the primary instance, as well as disabling the primary feature.
