# **[Launch](https://multipass.run/docs/launch-command)**

`multipass launch` command
The multipass launch command without any argument will create and start a new instance based on the default image, using a random generated name:

## references

<https://discourse.ubuntu.com/t/multipass-launch-command/10846>

## **[Multipass Launch](https://discourse.ubuntu.com/t/multipass-launch-command/10846)**

The multipass launch command without any argument will create and start a new instance based on the default image, using a random generated name:

```bash
$ multipass launch
…
Launched: relishing-lionfish
```

You can then shell into that instance by its name:

```bash
$ multipass shell relishing-lionfish
…
multipass@relishing-lionfish:~$ 
```

The full multipass help launch output explains the available options:

```bash
$  multipass help launch
Usage: multipass launch [options] [[<remote:>]<image> | <url>]
Create and start a new instance.

Options:
  -h, --help                            Displays help on commandline options
  -v, --verbose                         Increase logging verbosity. Repeat the
                                        'v' in the short option for more detail.
                                        Maximum verbosity is obtained with 4 (or
                                        more) v's, i.e. -vvvv.
  -c, --cpus <cpus>                     Number of CPUs to allocate.
                                        Minimum: 1, default: 1.
  -d, --disk <disk>                     Disk space to allocate. Positive
                                        integers, in bytes, or decimals, with K,
                                        M, G suffix.
                                        Minimum: 512M, default: 5G.
  -m, --memory <memory>                 Amount of memory to allocate. Positive
                                        integers, in bytes, or decimals, with K,
                                        M, G suffix.
                                        Minimum: 128M, default: 1G.
  -n, --name <name>                     Name for the instance. If it is
                                        'primary' (the configured primary
                                        instance name), the user's home
                                        directory is mounted inside the newly
                                        launched instance, in 'Home'.
                                        Valid names must consist of letters,
                                        numbers, or hyphens, must start with a
                                        letter, and must end with an
                                        alphanumeric character.
  --cloud-init <file> | <url>           Path or URL to a user-data cloud-init
                                        configuration, or '-' for stdin
  --network <spec>                      Add a network interface to the
                                        instance, where <spec> is in the
                                        "key=value,key=value" format, with the
                                        following keys available:
                                         name: the network to connect to
                                        (required), use the networks command for
                                        a list of possible values, or use
                                        'bridged' to use the interface
                                        configured via `multipass set
                                        local.bridged-network`.
                                         mode: auto|manual (default: auto)
                                         mac: hardware address (default:
                                        random).
                                        You can also use a shortcut of "<name>"
                                        to mean "name=<name>".
  --bridged                             Adds one `--network bridged` network.
  --mount <local-path>:<instance-path>  Mount a local directory inside the
                                        instance. If <instance-path> is omitted,
                                        the mount point will be the same as the
                                        absolute path of <local-path>
  --timeout <timeout>                   Maximum time, in seconds, to wait for
                                        the command to complete. Note that some
                                        background operations may continue
                                        beyond that. By default, instance
                                        startup and initialization is limited to
                                        5 minutes each.

Arguments:
  image                                 Optional image to launch. If omitted,
                                        then the default Ubuntu LTS will be
                                        used.
                                        <remote> can be either ‘release’ or
                                        ‘daily‘. If <remote> is omitted,
                                        ‘release’ will be used.
                                        <image> can be a partial image hash or
                                        an Ubuntu release version, codename or
                                        alias.
                                        <url> is a custom image URL that is in
                                        http://, https://, or file:// format.
```

The only, optional, positional argument is the image to launch an instance from. See the multipass find documentation for information on what images are available. It’s also possible to provide a full URL to the image (use file:// for an image available on the host running multipassd).

You can change the resources made available to the instance by passing any of --cpus, --disk, --memory options, allowing for more CPU cores, disk space or RAM, respectively.

If you want your instance to have a name of your choice, use --name. It has to be unique and conforms to a certain format.

By passing a filename or an URL to --cloud-init, you can provide “user data” to cloud-init 343 to customize the instance on first boot. See their documentation 533 for examples.

The --network option allows launching instances with additional network interfaces 5.

Passing --bridged and --network bridged are shortcuts to --network <name>, where <name> is configured via multipass set local.bridged-interface.

The --mount option allows mounting several folders in the instance by calling the mount command after the instances is launched. It can be specified multiple times, with different mount paths.

Use --timeout if you need to change how long Multipass waits for the machine to boot and initialize.

```bash
$ multipass launch
…
Launched: relishing-lionfish
```

You can then shell into that instance by its name:

```bash
$ multipass shell relishing-lionfish
…
multipass@relishing-lionfish:~$ 
```

The full multipass help launch output explains the available options:

```bash
$  multipass help launch
Usage: multipass launch [options] [[<remote:>]<image> | <url>]
Create and start a new instance.

Options:
  -h, --help                            Displays help on commandline options
  -v, --verbose                         Increase logging verbosity. Repeat the
                                        'v' in the short option for more detail.
                                        Maximum verbosity is obtained with 4 (or
                                        more) v's, i.e. -vvvv.
  -c, --cpus <cpus>                     Number of CPUs to allocate.
                                        Minimum: 1, default: 1.
  -d, --disk <disk>                     Disk space to allocate. Positive
                                        integers, in bytes, or decimals, with K,
                                        M, G suffix.
                                        Minimum: 512M, default: 5G.
  -m, --memory <memory>                 Amount of memory to allocate. Positive
                                        integers, in bytes, or decimals, with K,
                                        M, G suffix.
                                        Minimum: 128M, default: 1G.
  -n, --name <name>                     Name for the instance. If it is
                                        'primary' (the configured primary
                                        instance name), the user's home
                                        directory is mounted inside the newly
                                        launched instance, in 'Home'.
                                        Valid names must consist of letters,
                                        numbers, or hyphens, must start with a
                                        letter, and must end with an
                                        alphanumeric character.
  --cloud-init <file> | <url>           Path or URL to a user-data cloud-init
                                        configuration, or '-' for stdin
  --network <spec>                      Add a network interface to the
                                        instance, where <spec> is in the
                                        "key=value,key=value" format, with the
                                        following keys available:
                                         name: the network to connect to
                                        (required), use the networks command for
                                        a list of possible values, or use
                                        'bridged' to use the interface
                                        configured via `multipass set
                                        local.bridged-network`.
                                         mode: auto|manual (default: auto)
                                         mac: hardware address (default:
                                        random).
                                        You can also use a shortcut of "<name>"
                                        to mean "name=<name>".
  --bridged                             Adds one `--network bridged` network.
  --mount <local-path>:<instance-path>  Mount a local directory inside the
                                        instance. If <instance-path> is omitted,
                                        the mount point will be the same as the
                                        absolute path of <local-path>
  --timeout <timeout>                   Maximum time, in seconds, to wait for
                                        the command to complete. Note that some
                                        background operations may continue
                                        beyond that. By default, instance
                                        startup and initialization is limited to
                                        5 minutes each.

Arguments:
  image                                 Optional image to launch. If omitted,
                                        then the default Ubuntu LTS will be
                                        used.
                                        <remote> can be either ‘release’ or
                                        ‘daily‘. If <remote> is omitted,
                                        ‘release’ will be used.
                                        <image> can be a partial image hash or
                                        an Ubuntu release version, codename or
                                        alias.
                                        <url> is a custom image URL that is in
                                        http://, https://, or file:// format.
```

With multipass, you remove all VMs, then multipass purge to expunge them.
