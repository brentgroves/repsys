# **[Supported snap hooks](https://snapcraft.io/docs/supported-snap-hooks)**

A hook is an executable file that runs within a snap’s confined environment when a certain action occurs.

Common examples of actions requiring hooks include:

- notifying a snap that something has happened
Example: If a snap has been upgraded, the snap may need to trigger a scripted migration process to port an old data format to the new one.

- notifying a snap that a specific operation is in progress
Example: A snap may need to know when a specific interface connects or disconnects.

A hook is defined as an executable within a snap’s meta/hooks/ directory, and consequently, also within snap/hooks/ when building with snapcraft. See Snapcraft hook support for more information.

The filename of the executable is based on the name of the hook. If this file exists, snapd will execute the file when required by that hook’s action.

The following hooks are currently implemented:

- configure hook
- default-configure hook
- full-disk-encryption hook
- gate-auto-refresh
- install hook
- install-device hook
- interface hooks
-prepare-device hook
- pre-refresh hook
- post-refresh hook
- remove hook

Default shell environment: A hook script can only assume a POSIX-compliant shell environment for its execution. If your script needs a specific shell, such as Bash or Zsh, it needs to be explicitly declared within the script’s hashbang header (#!/bin/bash, for example). Your snap also needs to ensure your chosen shell is available.

## Accessing resources

If a hook requires access to system resources outside of a snap’s confined environment, it will need to use slots and plugs via the interface mechanism to access those resources.

When using Snapcraft to build the snap, the interface definition will go inside snapcraft.yaml, and the snapcraft command create a snap.yaml within the snap to hold the required metadata.

For example, the following excerpt registers an install hook making use of a network plug:

```yaml
apps:
    ...

hooks:
    install:
        plugs: [network]
```

Hooks are called with no parameters. When a hook needs to request or modify information within snapd, they can do so via the snapctl tool, which is always available within a snap’s environment. See Using the snapctl tool for further details.

## Transactions and rollback

A hook is executed as a single transaction, where a transaction object holds all the configuration changes for that hook. These changes are invisible to the running system until the hook completely finishes.

This allows for changes to be rolled back or unset if errors occur during the execution of a hook. This happens if a non-zero value is returned with either the configure or default-configure hooks, for example, or if an error occurs with any hook involved with an interface auto-connection.

## The configure hook⚓

The configure hook is called every time one the following actions happen:

- initial snap installation
- snap refresh
- whenever the user runs snap set|unset to change a configuration option

Note that this hook will not get called when the snap itself changes configuration options using snapctl get|set|unset.

The hook should use snapctl get to retrieve configuration values from snapd. If the hook exits with a non-zero status code, the configuration will not be applied.

For example, given the following command:

`$ snap set mysnap username=foo password=bar`

The configure hook located within the mysnap snap at meta/hooks/configure would be called to apply the configuration changes, if necessary.

The hook might look similar to:

```bash
# !/bin/sh -e

username="$(snapctl get username)"
password="$(snapctl get password)"

if [ -z "$username" -o -z "$password" ]; then
    echo "Username and password are required."
    exit 1
fi

mkdir -m 0600 $SNAP_DATA/options
echo "username: $username" > $SNAP_DATA/options/credentials
echo "password: $password" >> $SNAP_DATA/options/credentials

```

The same hook can also modify the configuration of a snap within the context of the current transaction. This is accomplished using snapctl set and snapctl unset. For more information see **[Adding Snap configuration](https://forum.snapcraft.io/t/adding-snap-configuration/15246?_gl=1*1kpix8z*_ga*NDk2ODc4NTcxLjE3NTQ2ODQ1NzM.*_ga_5LTL1CNEJM*czE3NTczNTU3ODgkbzgkZzEkdDE3NTczNTc0OTYkajYwJGwwJGgw)** and Using the snapctl tool.
