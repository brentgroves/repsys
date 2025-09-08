# **[](https://wiki.ubuntu.com/DebuggingApparmor)

AppArmor is used by Ubuntu to protect the system from misbehaving or compromised applications. When looking at or creating bug reports, it is important to distinguish between bugs in the application and bugs in the apparmor profile for the application.

How to file a bug
When filing a bug report regarding an apparmor profile, you need three things:

The package containing the profile. Bugs should be filed against this package. Profiles are found in /etc/apparmor.d/ and you can find what package the profile belongs to with 'dpkg -S'. For example, to find out which package provides /etc/apparmor.d/usr.sbin.cupsd, use:

```bash
$ dpkg -S /etc/apparmor.d/usr.sbin.cupsd
dpkg -S /etc/apparmor.d/lxc-unshare
apparmor: /etc/apparmor.d/lxc-unshare
```

The 'audit' entries from /var/log/kern.log, and any files in /var/log/apparmor.

```bash
2025-09-08T14:30:57.256311-04:00 isdev kernel: audit: type=1400 audit(1757356257.254:207): apparmor="DENIED" operation="open" class="file" profile="snap.tree.tree" name="/snap/" pid=13371 comm="tree" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
```

The steps needs to trigger the bug in the profile

Bugs should be filed against the package shipping the profile, not simply against the apparmor package (the exception is when the profiling bug is against an abstraction shipped by the apparmor package). Please tag apparmor profile bugs with the apparmor tag.

Note: please remember that it is generally not a bug in the profile if a non-default configuration is being used by the application. One example might be having mysql store its databases in /home/mysql instead of /var/lib/mysql. In these cases, the profile should just be changed by the admin.

## Debugging procedure

To debug an apparmor profile, look in /var/log/kern.log for 'audit' entries. An example will look something like:

Feb  4 14:30:33 example-client kernel: [   73.459739] audit(1202153433.710:6): operation="file_mmap" request_mask="mrw::" denied_mask="m::" name="/var/lib/ldap/__db.005" pid=5375 profile="/usr/sbin/slapd" namespace="default"

If you have auditd installed, AppArmor messages are logged to /var/log/audit/audit.log instead, and have apparmor="DENIED" in the log entry

The important things to look for are:

'audit(...):' -- this tells you it is an apparmor generated log entry
'profile="/usr/sbin/slapd"' -- this tells you what profile generated this message. Profiles are located in /etc/apparmor.d, and when looking for the profile, substitute '.' for the '/' from the log entry. For example, the above entry's apparmor profile is located in /etc/apparmor.d/usr.sbin.slapd

```bash
cat /var/log/kern.log | grep audit
2025-09-08T14:30:57.256295-04:00 isdev kernel: kauditd_printk_skb: 196 callbacks suppressed
2025-09-08T14:30:57.256311-04:00 isdev kernel: audit: type=1400 audit(1757356257.254:207): apparmor="DENIED" operation="open" class="file" profile="snap.tree.tree" name="/snap/" pid=13371 comm="tree" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
2025-09-08T14:31:11.548288-04:00 isdev kernel: audit: type=1400 audit(1757356271.546:208): apparmor="DENIED" operation="capable" class="cap" profile="snap.tree.tree" pid=13463 comm="bash" capability=2  capname="dac_read_search"
2025-09-08T14:31:11.548299-04:00 isdev kernel: audit: type=1400 audit(1757356271.546:209): apparmor="DENIED" operation="capable" class="cap" profile="snap.tree.tree" pid=13463 comm="bash" capability=1  capname="dac_override"
2025-09-08T14:31:11.549285-04:00 isdev kernel: audit: type=1400 audit(1757356271.547:210): apparmor="DENIED" operation="open" class="file" profile="snap.tree.tree" name="/snap/" pid=13496 comm="tree" requested_mask="r" denied_mask="r" fsuid=0 ouid=0
2025-09-08T15:00:02.843288-04:00 isdev kernel: audit: type=1400 audit(1757358002.841:211): apparmor="DENIED" operation="open" class="file" profile="snap.firmware-updater.firmware-notifier" name="/proc/sys/vm/max_map_count" pid=16965 comm="firmware-notifi" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
```

IMPORTANT: If you do not have any 'audit' entries in /var/log/kern.log at the time the application had a problem, then this is not an apparmor bug. Please see DebuggingProcedures for more information on filing a bug.

When debugging, it may also be useful to put apparmor into 'complain' mode. This will allow your application to function normally while apparmor reports accesses that are not in the profile. To enable 'complain' mode, use:

sudo aa-complain /path/to/bin
where '/path/to/bin' is the absolute path to the binary, as reported in the 'profile=...' portion of the 'audit' entry. Eg:

sudo aa-complain /usr/sbin/slapd
To re-enable enforcing mode, use 'aa-enforce' instead:

sudo aa-enforce /path/to/bin
To disable a profile in Ubuntu 10.10 and earlier:

sudo touch /etc/apparmor.d/disable/path.to.bin
sudo apparmor_parser -R /etc/apparmor.d/path.to.bin
in 11.04 and later:

sudo aa-disable /etc/apparmor.d/path.to.bin
To disable all of AppArmor for testing purposes, boot with 'apparmor=0' on the kernel command line.

## Adjusting Tunables

AppArmor provides a mechanism for tuning your configuration without having to adjust your profiles. These tunables are stored in various files in /etc/apparmor.d/tunables. The most common tunable to adjust is /etc/apparmor.d/tunables/home. If AppArmor is denying access to files in your home directory and your home directory is not in /home, then you need to edit /etc/apparmor.d/tunables/home accordingly. For example, if your home directory is under /exports/home then change:

# @{HOMEDIRS} is a space-separated list of where user home directories

# are stored, for programs that must enumerate all home directories on a

# system

@{HOMEDIRS}=/home/
to be:

# @{HOMEDIRS} is a space-separated list of where user home directories

# are stored, for programs that must enumerate all home directories on a

# system

@{HOMEDIRS}=/home/ /exports/home/
There are other tunables available to you in /etc/apparmor.d/tunables. Most often, issues that are resolved by adjusted a tunable are not considered to be bugs in the profile.

Fixing profile bugs
When using the default kernel logging mechanism (ie, when not using auditd), you will want to be aware that the kernel will rate limit AppArmor log entries, which can lead to confusion when debugging an AppArmor profile. As such, it is recommended that you temporarily disable kernel rate limiting during this process with:

sudo sysctl -w kernel.printk_ratelimit=0
Fixing apparmor profile bugs is usually straightforward. Enable 'complain' mode (see above), then exercise your application. You can then either use 'aa-logprof' to walk you through the process of updating the profile, or simply edit the profile directly. Please use the 'tunables' found in /etc/apparmor.d/tunables when appropriate. Eg, rather than using a rule like:

  /home/*/ r,
use:

  @{HOME}/ r,
Once the profile is updated, reload the the profile with:

sudo apparmor_parser -r /etc/apparmor.d/<profile file>
After the profile is working as desired, you can attach it to the bug report, stating that you have a working profile. For more on editing and creating profiles, see the community AppArmor documentation.

Starting with Ubuntu 10.10, users can also use the local include mechanism by adding rules to the /etc/apparmor.d/local/... file instead of adjusting the profile directly. This is particular helpful for small additions that aren't suitable for all of Ubuntu, but there are caveats with this approach. Please see /etc/apparmor.d/local/README for details.
