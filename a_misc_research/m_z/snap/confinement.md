# **[Snap Confinement](https://snapcraft.io/docs/snap-confinement)**

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## Confinement levels

A snap’s confinement level controls the degree of isolation it has from the user’s system. Application developers or packagers can adjust the confinement level to specify in broad terms how much access to system resources an application needs, either for normal use or during development.

There are two levels of snap confinement for published snaps:

1. Strict Used by the majority of snaps. Strictly confined snaps run in complete isolation, up to a minimal access level that’s deemed always safe. Consequently, strictly confined snaps can not access files, network, processes or any other system resource without requesting specific access via an interface **[(see below)](https://snapcraft.io/docs/snap-confinement#interfaces)**.
2. Classic Allows access to the system’s resources in much the same way traditional packages do. To safeguard against abuse, publishing a classic snap requires **[manual approval](https://snapcraft.io/docs/reviewing-classic-confinement-snaps)**, and installation requires the --classic command line argument.

An additional mode is useful during the development process:

- Devmode A special mode for snap creators and developers. A devmode snap runs as a strictly confined snap with full access to system resources, and produces debug output to identify unspecified interfaces. Installation requires the --devmode command line argument. Devmode snaps cannot be released to the stable channel, do not appear in search results, and do not automatically refresh.

Strict confinement uses security features of the Linux kernel, including AppArmor, seccomp and namespaces, to prevent applications and services accessing the wider system.

## Getting the confinement level

Use the snap command to discover the confinement level for a snap:

```bash
$ snap info --verbose vlc
[...]
  confinement:       strict
  devmode:           false
[...]

```

To see which installed snaps are using classic confinement, look for classic under the Notes column in the output of snap list:

```bash
$ snap list
Name      Version   Rev   Tracking  Publisher       Notes
vlc       3.0.6     770   stable    videolan✓       -
code      0dd516dd  5     stable    vscode✓         classic
wormhole  0.11.2    112   stable    snapcrafters    -

sudo snap install lxd --channel=5.21/stable --cohort="+"
getent group lxd | grep -qwF "$USER"
snap info --verbose lxd
```

Interfaces and confinement
Snaps with strict confinement must use **[interfaces](https://snapcraft.io/docs/interfaces)** to access resources on the user’s system, including those provided by other snaps.

![](https://assets.ubuntu.com/v1/59c290a8-snapd-interfaces.png)
