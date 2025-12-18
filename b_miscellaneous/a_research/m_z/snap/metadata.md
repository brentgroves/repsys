# **[snap metadata](https://snapcraft.io/docs/the-snap-format#heading--snapyaml)**

snap.yaml
Every snap package contains a meta/snap.yaml file that holds the basic metadata for the snap.

Please take note of this important distinction:

- snap.yaml lives inside every snap package, read by snapd
- snapcraft.yaml contains instructions to create a snap package, read by the snapcraft command used to build snaps

```bash
ls /snap/lxd/current/meta/snap.yaml
```

Most of the metadata supported by snap.yaml is optional. In fact, the simplest snap.yaml could contain as little as the following:

name: simplest
version: 1.0
An example snap.yaml that offers an application to run is still very simple:

name: simple
version: 1.0
apps:
    hello:
        command: bin/hello --world

```yaml
The following is the complete specification for the metadata in snap.yaml:

# The suggested snap name, constrained to the [a-z0-9] charset and inner
# dashes. The final name when the snap is installed is defined by the
# snap-declaration assertion associated with the snap, if any.
name: <name>

# An optional title for the snap, may contain uppercase letters and spaces.
title: <title>

# Version of the software packed inside the snap. Has no semantic value
# in the system (no greater/lower-than rules are ever applied to it).
version: <version>

# More details about what is contained in the snap.
summary: <line>
description: <text>

# License for the snap content, based on SPDX license expressions.
license: <expression>

# Type of snap, defaults to "app". The `core` type has been deprecated.
type: app | gadget | kernel | base

# List of architectures the snap may run on. Defaults to [all].
architectures:
    - all | amd64 | i386 | armhf | ...

# The base snap that defines the underlying filesystem this snap
# will be assembled on top of.
base: <name>


# A list of features that must be supported by the core for 
# the snap to install. For example, the following sets a requirement for
# snapd2.38 or later:
# assumes:
# - snapd2.38
assumes:
    - <feature>

# The epoch this release is intended for. For further details, see:
# https://forum.snapcraft.io/t/snap-epochs/10316
# (snapd 2.38+)
epoch: <value>

# Additional usernames the snap may use. Currently, the only supported
# values for <name> is '_daemon_' (snapd 2.61+), and the now deprecated
# 'snap-daemon'. For further details, see:
# https://forum.snapcraft.io/t/system-usernames/13386

system-usernames:
  <name>: shared

# Alternative form:
# system-usernames:
#   <name>:
#     scope: shared


# List of applications (commands, binaries, daemons) in the snap. 
apps:

  <app name>:

      # Path to executable (relative to snap base) and arguments to use
      # when this application is run.
      command: <command line>

      # A list of commands to be executed, in order, prior to the `command:` executable
      # or from within a hook (see below). 
      command-chain: <list of commands>

      # An identifier to a desktop-id within an external appstream file.
      # See https://docs.snapcraft.io/using-external-metadata
      common-id: <desktop file id>

      # Path to a bash snippet to use for tab completion.
      # (snapcraft 2.33+, snapd 2.30+)
      # See https://forum.snapcraft.io/t/2261
      completer: <path to file>

      # List of plug names the application is associated with.
      # When a plug is connected to one of these slots, the application
      # will be granted the permissions specified for that interface.
      # If attributes are required, or the plug name does not match the
      # interface name, more details must be declared under the top-level
      # "plugs" field (see below).
      plugs:
          - <plug name>

      # List of slot names this application is associated with.
      # Same details as described above, but for slots.
      slots:
          - <slot name>

      # If daemon is set, the command is a daemon to run as specified.
      # See systemd documentation for further details.
      daemon: simple | forking | oneshot | notify

      # Defines whether a freshly installed daemon is started automatically (enabled), 
      # or whether startup is deferred to the snap (disabled). Defaults to enable.
      install-mode: enable | disable
     
      # Controls whether the daemon should be restarted during a snap refresh. Defaults to 'restart'.
      refresh-mode:  endure | restart

      # Maps a daemon’s sockets to services and activates them.
     sockets:
          - <socket name>

      # The mode of a socket in octal, such as `0644`.
     socket-mode: <mode>
     
      # Controls how the daemon should be stopped.  The given signal is sent to the main PID 
      # (when used without -all) or to all PIDs in the process group when the -all suffix is used.
      stop-mode:  sigterm | sigterm-all | sighup | sighup-all | sigusr1 | sigusr1-all | sigusr2 | sigusr2-all

      # Optional command to stop a daemon.
      stop-command: <command line>

      # Optional time to wait for daemon to start.
      start-timeout: <n>ns | <n>us | <n>ms | <n>s | <n>m

      # Optional time to wait for daemon to stop.
      stop-timeout: <n>ns | <n>us | <n>ms | <n>s | <n>m

      # Optional command to run after daemon stops.
      post-stop-command: <command line>

      # Condition to restart the daemon under. Defaults to on-failure.
      # See the systemd.service manual on Restart for details.
      restart-condition: \
          on-failure | on-success | on-abnormal | on-abort | always | never

      # Delay between service restarts. Defaults to unset. 
      # See the systemd.service manual on RestartSec for details.
      # (snapd 2.36+)
      restart-delay: <n>ns | <n>us | <n>ms | <n>s | <n>m

      # Service watchdog timeout. For watchdog to work, the application
      # requires access to systemd notification socket, which can be 
      
      # declared by listing a daemon-notify plug in the plugs section.
      # Note, the interface is not auto connected  and needs to be
      # connected manually.
      # (snapd 2.33+)
      watchdog-timeout: <n>ns | <n>us | <n>ms | <n>s | <n>m

      # Command to use to ask the service to reload its configuration.
      # In the absence of this, when asked to reload  (e.g. via
      # `snap restart --reload snap.app`) the service is restarted instead.
      reload-command: <command line>

      # List of applications that are ordered to be started before
      # the current one. Applications must be part of the same snap.
      # (snapd 2.31+)
      before:
          - <other app name>

      # List of applications that are ordered to be started after
      # the current one. Applications must be part of the same snap.
      # (snapd 2.31+)
      after:
          - <other app name>

      # The service is activated by a timer, app must be a daemon. See timer
      # documentation for examples.
      # (snapd 2.33+)
      timer: <timer string>

      # Name of the desktop file placed by the application in 
      # $SNAP_USER_DATA/.config/autostart to indicate that application 
      # should be started with the user's desktop session. The application
      # is started using the app's command wrapper (<name>.<app>) plus
      # any arguments  present in the Exec=.. line inside the autostart
      # desktop file.
      # (snapd 2.32.4+)
      autostart: <command line>

```

## Hooks

Hooks provide a mechanism for snapd to alert snaps that something has happened, or to ask the snap to provide its opinion about an operation that is in progress. See the topic on **[supported hooks](https://snapcraft.io/docs/supported-snap-hooks)** for more details.

## Interfaces

Interfaces allow snaps to communicate or share resources according to the protocol established by the interface. They play an important part in security policy configuration.

See **[Supported interfaces](https://snapcraft.io/docs/supported-interfaces)** for more details.
