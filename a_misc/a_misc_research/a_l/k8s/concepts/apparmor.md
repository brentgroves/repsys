# **[AppArmor](https://wiki.ubuntu.com/AppArmor)**

AppArmor is a Mandatory Access Control (MAC) system which is a kernel (LSM) enhancement to confine programs to a limited set of resources. AppArmor's security model is to bind access control attributes to programs rather than to users. AppArmor confinement is provided via profiles loaded into the kernel, typically on boot. AppArmor profiles can be in one of two modes: enforcement and complain. Profiles loaded in enforcement mode will result in enforcement of the policy defined in the profile as well as reporting policy violation attempts (either via syslog or auditd). Profiles in complain mode will not enforce policy but instead report policy violation attempts.

AppArmor differs from some other MAC systems on Linux: it is path-based, it allows mixing of enforcement and complain mode profiles, it uses include files to ease development, and it has a far lower barrier to entry than other popular MAC systems.

AppArmor is an established technology first seen in Immunix and later integrated into Ubuntu, Novell/SUSE, and Mandriva. Core AppArmor functionality is in the mainline Linux kernel from 2.6.36 onwards; work is ongoing by AppArmor, Ubuntu and other developers to merge additional AppArmor functionality into the mainline kernel.

## Example profile

From /etc/apparmor.d/usr.sbin.tcpdump on Ubuntu 9.04:

```bash
#include <tunables/global>

/usr/sbin/tcpdump {
  #include <abstractions/base>
  #include <abstractions/nameservice>
  #include <abstractions/user-tmp>

  capability net_raw,
  capability setuid,
  capability setgid,
  capability dac_override,
  network raw,
  network packet,

  # for -D
  capability sys_module,
  @{PROC}/bus/usb/ r,
  @{PROC}/bus/usb/** r,

  # for -F and -w
  audit deny @{HOME}/.* mrwkl,
  audit deny @{HOME}/.*/ rw,
  audit deny @{HOME}/.*/** mrwkl,
  audit deny @{HOME}/bin/ rw,
  audit deny @{HOME}/bin/** mrwkl,
  @{HOME}/ r,
  @{HOME}/** rw,

  /usr/sbin/tcpdump r,
}
```

The above profile for tcpdump demonstrates several properties of AppArmor:

- profiles are simple text files
- comments are supported in the profile
- absolute paths as well as file globbing can be used when specifying file access
- various access controls for files are present. From the profile we see 'r' (read), 'w' (write), 'm' (memory map as executable), 'k' (file locking), and 'l' (creation hard links). There are others not demonstrated in this profile, including (but not limited to) 'ix' (execute and inherit this profile), 'Px' (execute under another profile, after cleaning the environment), and 'Ux' (execute unconfined, after cleaning the environment)
- access controls for capabilities are present
- access controls for networking are present
- specificity in rule matching, ie the most specific rule matches (eg access to @{HOME}/bin/bad.sh is denied with auditing due to 'audit deny @{HOME}/bin/**mrwkl,' even though general access to @{HOME} is permitted with '@{HOME}/** rw,')

- include files are supported to ease development and simplify profiles (ie #include <abstractions/base>, #include <abstractions/nameservice>, #include <abstractions/user-tmp>)

- variables can be defined and manipulated outside the profile (#include <tunables/global> with @{PROC} and @{HOME})

- AppArmor profiles are easy to read and audit

Please see More information below for full details on updating and developing profiles as well as instructions using AppArmor.
