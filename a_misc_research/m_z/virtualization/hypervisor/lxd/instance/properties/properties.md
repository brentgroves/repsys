# **[properties](https://documentation.ubuntu.com/lxd/latest/reference/instance_properties/#instance-properties)**

## Instance properties

Instance properties are set when the instance is created. They cannot be part of a profile.

The following instance properties are available:

⤋⤊
architecture
Instance architecture

Key: architecture
Type: string
Read-only: no
name
Instance name

Key: name
Type: string
Read-only: yes
See Instance name requirements.

Instance name requirements
The instance name can be changed only by renaming the instance with the lxc rename command.

Valid instance names must fulfill the following requirements:

The name must be between 1 and 63 characters long.

The name must contain only letters, numbers and dashes from the ASCII table.

The name must not start with a digit or a dash.

The name must not end with a dash.

The purpose of these requirements is to ensure that the instance name can be used in DNS records, on the file system, in various security profiles and as the host name of the instance itself.
