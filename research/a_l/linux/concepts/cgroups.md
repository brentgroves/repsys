# **[cgroups](https://www.kernel.org/doc/Documentation/cgroup-v1/memory.txt#:~:text=Kernel%20memory%20limits%20are%20not,kmem.)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## list cgroups

```bash
ls /sys/fs/cgroup          
cgroup.controllers      cgroup.procs            cpu.pressure           cpu.stat             init.scope     io.prio.class     memory.reclaim          misc.current                   sys-kernel-debug.mount
cgroup.max.depth        cgroup.stat             cpuset.cpus.effective  cpu.stat.local       io.cost.model  io.stat           memory.stat             proc-sys-fs-binfmt_misc.mount  sys-kernel-tracing.mount
cgroup.max.descendants  cgroup.subtree_control  cpuset.cpus.isolated   dev-hugepages.mount  io.cost.qos    memory.numa_stat  memory.zswap.writeback  sys-fs-fuse-connections.mount  system.slice
cgroup.pressure         cgroup.threads          cpuset.mems.effective  dev-mqueue.mount     io.pressure    memory.pressure   misc.capacity           sys-kernel-config.mount        user.slice
```

```bash
sudo systemctl status snap.microk8s.daemon-kubelite

● snap.microk8s.daemon-kubelite.service - Service for snap application microk8s.daemon-kubelite
     Loaded: loaded (/etc/systemd/system/snap.microk8s.daemon-kubelite.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2024-08-27 22:40:12 UTC; 23h ago
   Main PID: 2122770 (kubelite)
      Tasks: 12 (limit: 19125)
     Memory: 223.4M
        CPU: 1h 43min 2.909s
     CGroup: /system.slice/snap.microk8s.daemon-kubelite.service
             └─2122770 /snap/microk8s/7040/kubelite --scheduler-args-file=/var/snap/microk8s/7040/args/kube-scheduler --controller-manager-args-file=/var/snap/microk8s/7040/args/kube-controller-manager ->

Aug 28 21:47:52 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 21:47:52.421564 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o>
Aug 28 21:49:22 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 21:49:22.420030 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o>
Aug 28 21:50:28 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 21:50:28.422347 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o>
Aug 28 21:51:54 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 21:51:54.422005 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o>
Aug 28 21:53:19 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 21:53:19.420928 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o>
Aug 28 21:54:39 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 21:54:39.422314 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o>
Aug 28 21:55:57 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 21:55:57.421760 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o>
Aug 28 21:57:20 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 21:57:20.421902 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o>
Aug 28 21:58:48 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 21:58:48.421390 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o>
Aug 28 22:00:12 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 22:00:12.421016 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o


```

```bash
cat /proc/2122770/cgroup
0::/system.slice/snap.microk8s.daemon-kubelite.service

```

## cgroups

The Linux kernel's control groups (cgroups) feature allows users to limit and monitor the resources used by groups of processes, including memory and CPU usage. Cgroups can also rate limit block and network IO, and control access to device nodes.

Cgroups can have memory limits, which can prevent processes from being killed by the OOM killer if they exceed a certain amount of memory. For example, if a cgroup has a memory limit of 15 GB, processes in that cgroup will be killed if they use more than 15 GB of memory.

Here are some examples of how cgroups can be used to manage memory:

- **Isolate applications:** Memory-hungry applications can be isolated and limited to a specific amount of memory.
- Create a cgroup with a limited amount of memory: This can be an alternative to booting with mem=XXXX.
- Use swap: When memory becomes scarce, using swap in conjunction with other tools can provide a more gradual failure mode. For example, a cgroup can be set to allocate 2 GB of memory, and then allocate another 2 GB of swap once the first 2 GB is exhausted. This can prevent hard memory limits from causing thrashing and OOM kills.

There are two versions of cgroups in common use:

- **Cgroups v1:** Sets resource limits for a process within separate hierarchies per resource class.
- **Cgroups v2:** The default in newer Linux distributions, this version implements a unified hierarchy, which simplifies the structure of resource limits on processes.

## **[Obtaining Information about Control Groups](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/resource_management_guide/sec-obtaining_information_about_control_groups)**

Use the systemctl command to list system units and to view their status. Also, the systemd-cgls command is provided to view the hierarchy of control groups and systemd-cgtop to monitor their resource consumption in real time.

## 2.4.1. Listing Units

Use the following command to list all active units on the system:

```bash
systemctl list-units
```

The list-units option is executed by default, which means that you will receive the same output when you omit this option and execute just:

```bash
systemctl
UNIT                     LOAD   ACTIVE SUB     DESCRIPTION
abrt-ccpp.service        loaded active exited  Install ABRT coredump hook
abrt-oops.service        loaded active running ABRT kernel log watcher
abrt-vmcore.service      loaded active exited  Harvest vmcores for ABRT
abrt-xorg.service        loaded active running ABRT Xorg log watcher
...
```

The output displayed above contains five columns:

- UNIT — the name of the unit that also reflects the unit's position in the cgroup tree. As mentioned in the section called “Systemd Unit Types”, three unit types are relevant for resource control: slice, scope, and service. For a complete list of systemd's unit types, see the chapter called Managing Services with systemd in Red Hat Enterprise Linux 7 System Administrators Guide.
- LOAD — indicates whether the unit configuration file was properly loaded. If the unit file failed to load, the field contains the state error instead of loaded. Other unit load states are: stub, merged, and masked.
- ACTIVE — the high-level unit activation state, which is a generalization of SUB.
- SUB — the low-level unit activation state. The range of possible values depends on the unit type.
- DESCRIPTION — the description of the unit's content and functionality.

By default, systemctl lists only active units (in terms of high-level activations state in the ACTIVE field). Use the --all option to see inactive units too. To limit the amount of information in the output list, use the --type (-t) parameter that requires a comma-separated list of unit types such as service and slice, or unit load states such as loaded and masked.
Example 2.8. Using systemctl list-units

To view a list of all slices used on the system, type:

```bash
systemctl -t slice 
systemctl -t slice 
  UNIT                         LOAD   ACTIVE SUB    DESCRIPTION               
  -.slice                      loaded active active Root Slice
  system-getty.slice           loaded active active Slice /system/getty
  system-modprobe.slice        loaded active active Slice /system/modprobe
  system-serial\x2dgetty.slice loaded active active Slice /system/serial-getty
  system-systemd\x2dfsck.slice loaded active active Slice /system/systemd-fsck
  system.slice                 loaded active active System Slice
  user-1000.slice              loaded active active User Slice of UID 1000
  user.slice                   loaded active active User and Session Slice

LOAD   = Reflects whether the unit definition was properly loaded.
ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
SUB    = The low-level unit activation state, values depend on unit type.
8 loaded units listed. Pass --all to see loaded but inactive units, too.
To show all installed unit files use 'systemctl list-unit-files'.

```

To list all active masked services, type:

```bash
systemctl -t service,masked
```

Systemctl is a command-line tool in Linux that manages the systemd system and service manager. It's a central tool for controlling the init system and is used to examine and control the state of the systemd system and service manager. Systemctl is a key tool for system management because it helps ensure services run smoothly and start automatically at boot if set up that way.

## 2.4.2. Viewing the Control Group Hierarchy

The aforementioned listing commands do not go beyond the unit level to show the actual processes running in cgroups. Also, the output of systemctl does not show the hierarchy of units. You can achieve both by using the systemd-cgls command that groups the running process according to cgroups. To display the whole cgroup hierarchy on your system, type:

```bash
systemd-cgls
```

When systemd-cgls is issued without parameters, it returns the entire cgroup hierarchy. The highest level of the cgroup tree is formed by slices and can look as follows:

├─system
│ ├─1 /usr/lib/systemd/systemd --switched-root --system --deserialize 20  
│ ...
│
├─user
│ ├─user-1000
│ │ └─ ...
│ ├─user-2000
│ │ └─ ...
│ ...
│
└─machine  
  ├─machine-1000
  │ └─ ...
  ...

Note that machine slice is present only if you are running a virtual machine or a container. For more information on the cgroup tree, see the section called “Systemd Unit Types”.

To reduce the output of systemd-cgls, and to view a specified part of the hierarchy, execute:

```bash
systemd-cgls name
```

Replace name with a name of the resource controller you want to inspect.
As an alternative, use the systemctl status command to display detailed information about a system unit. A cgroup subtree is a part of the output of this command.

```bash
systemctl name
```

To learn more about systemctl status, see the chapter called Managing Services with systemd in Red Hat Enterprise Linux 7 System Administrators Guide.
Example 2.9. Viewing the Control Group Hierarchy

To see a cgroup tree of the memory resource controller, execute:

```bash
systemd-cgls memory
memory:
├─    1 /usr/lib/systemd/systemd --switched-root --system --deserialize 23
├─  475 /usr/lib/systemd/systemd-journald
...
```

The output of the above command lists the services that interact with the selected controller. A different approach is to view a part of the cgroup tree for a certain service, slice, or scope unit:

```bash
systemctl status lxcfs.service

● lxcfs.service - FUSE filesystem for LXC
     Loaded: loaded (/lib/systemd/system/lxcfs.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2024-08-27 18:53:34 EDT; 22h ago
       Docs: man:lxcfs(1)
   Main PID: 772 (lxcfs)
      Tasks: 3 (limit: 38364)
     Memory: 1.4M
        CPU: 9ms
     CGroup: /system.slice/lxcfs.service
             └─772 /usr/bin/lxcfs /var/lib/lxcfs

Aug 27 18:53:37 reports-alb.busche-cnc.com lxcfs[772]: - proc_loadavg
Aug 27 18:53:37 reports-alb.busche-cnc.com lxcfs[772]: - proc_meminfo
Aug 27 18:53:37 reports-alb.busche-cnc.com lxcfs[772]: - proc_stat
Aug 27 18:53:37 reports-alb.busche-cnc.com lxcfs[772]: - proc_swaps
Aug 27 18:53:37 reports-alb.busche-cnc.com lxcfs[772]: - proc_uptime
Aug 27 18:53:37 reports-alb.busche-cnc.com lxcfs[772]: - proc_slabinfo

# 
systemctl status httpd.service
httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled)
   Active: active (running) since Sun 2014-03-23 08:01:14 MDT; 33min ago
  Process: 3385 ExecReload=/usr/sbin/httpd $OPTIONS -k graceful (code=exited, status=0/SUCCESS)
 Main PID: 1205 (httpd)
   Status: "Total requests: 0; Current requests/sec: 0; Current traffic:   0 B/sec"
   CGroup: /system.slice/httpd.service
           ├─1205 /usr/sbin/httpd -DFOREGROUND
           ├─3387 /usr/sbin/httpd -DFOREGROUND
           ├─3388 /usr/sbin/httpd -DFOREGROUND
           ├─3389 /usr/sbin/httpd -DFOREGROUND
           ├─3390 /usr/sbin/httpd -DFOREGROUND
           └─3391 /usr/sbin/httpd -DFOREGROUND
```

## 2.4.3. Viewing Resource Controllers

The aforementioned systemctl commands enable monitoring the higher-level unit hierarchy, but do not show which resource controllers in Linux kernel are actually used by which processes. This information is stored in dedicated process files, to view it, type as root:

<!-- https://manpages.ubuntu.com/manpages/bionic/man5/proc.5.html -->
```bash
cat /proc/PID/cgroup
```

Where PID stands for the ID of the process you wish to examine. By default, the list is the same for all units started by systemd, since it automatically mounts all default controllers. See the following example:

```bash
cat /proc/772/cgroup
0::/system.slice/lxcfs.service

cat /proc/27/cgroup
10:hugetlb:/
9:perf_event:/
8:blkio:/
7:net_cls:/
6:freezer:/
5:devices:/
4:memory:/
3:cpuacct,cpu:/
2:cpuset:/
1:name=systemd:/
```

By examining this file, you can determine if the process has been placed in the correct cgroups as defined by the systemd unit file specifications.

## 2.4.4. Monitoring Resource Consumption

The systemd-cgls command provides a static snapshot of the cgroup hierarchy. To see a dynamic account of currently running cgroups ordered by their resource usage (CPU, Memory, and IO), use:

```bash
systemd-cgtop
Control Group                                                                                                                                                                      Tasks   %CPU   Memory  Input/s Output/s
/                                                                                                                                                                                   1198   79.8     6.0G        -        -
user.slice                                                                                                                                                                           838   73.8     6.9G        -        -
user.slice/user-1000.slice                                                                                                                                                           838   73.7     6.7G        -        -
user.slice/user-1000.slice/user@1000.service                                                                                                                                         824   73.7     6.7G        -        -
system.slice                                                                                                                                                                         155   10.2     2.4G        -        -
system.slice/sentinelone.service                                                                                                                                                      33    9.8   952.4M        -        -
system.slice/systemd-oomd.service                                                                                                                                                      1    0.2     1.7M        -        -
system.slice/NetworkManager.service                                                                                                                                                    3    0.2    12.0M        -        -
init.scope                                                                                                                                                                             1    0.0    13.5M        -        -
system.slice/containerd.service                                                                                                                                                        9    0.0    12.9M        -        -
system.slice/snap.multipass.multipassd.service                                                                                                                                        12    0.0   249.8M        -        -
system.slice/rtkit-daemon.service                                                                                                                                                      3    0.0   676.0K        -        -
dev-hugepages.mount                                                                                                                                                                    -      -    28.0K        -        -
dev-mqueue.mount                                                                                                                                                                       -      -     4.0K        -        -
proc-sys-fs-binfmt_misc.mount                                                                                                                                                          -      -     4.0K        -        -
```

2.3. Modifying Control Groups
 PDF
Each persistent unit supervised by systemd has a unit configuration file in the /usr/lib/systemd/system/ directory. To change parameters of a service unit, modify this configuration file. This can be done either manually or from the command-line interface by using the systemctl set-property command.
2.3.1. Setting Parameters from the Command-Line Interface
The systemctl set-property command allows you to persistently change resource control settings during the application runtime. To do so, use the following syntax as root:
~]# systemctl set-property name parameter=value
Replace name with the name of the systemd unit you wish to modify, parameter with a name of the parameter to be changed, and value with a new value you want to assign to this parameter.
Not all unit parameters can be changed at runtime, but most of those related to resource control may, see Section 2.3.2, “Modifying Unit Files” for a complete list. Note that systemctl set-property allows you to change multiple properties at once, which is preferable over setting them individually.
The changes are applied instantly, and written into the unit file so that they are preserved after reboot. You can change this behavior by passing the --runtime option that makes your settings transient:
~]# systemctl set-property --runtime name property=value
Example 2.2. Using systemctl set-property

To limit the CPU and memory usage of httpd.service from the command line, type:
~]# systemctl set-property httpd.service CPUShares=600 MemoryLimit=500M
To make this a temporary change, add the --runtime option:
~]# systemctl set-property --runtime httpd.service CPUShares=600 MemoryLimit=500M
2.3.2. Modifying Unit Files
Systemd service unit files provide a number of high-level configuration parameters useful for resource management. These parameters communicate with Linux cgroup controllers, that have to be enabled in the kernel. With these parameters, you can manage CPU, memory consumption, block IO, as well as some more fine-grained unit properties.
Managing CPU
The cpu controller is enabled by default in the kernel, and consequently every system service receives the same amount of CPU time, regardless of how many processes it contains. This default behavior can be changed with the DefaultControllers parameter in the /etc/systemd/system.conf configuration file. To manage CPU allocation, use the following directive in the [Service] section of the unit configuration file:
CPUShares=value
Replace value with a number of CPU shares. The default value is 1024. By increasing the number, you assign more CPU time to the unit. Setting the value of the CPUShares parameter automatically turns CPUAccounting on in the unit file. Users can thus monitor the usage of the processor with the systemd-cgtop command.
The CPUShares parameter controls the cpu.shares control group parameter. See the description of the cpu controller in Controller-Specific Kernel Documentation to see other CPU-related control parameters.
Example 2.3. Limiting CPU Consumption of a Unit

To assign the Apache service 1500 CPU shares instead of the default 1024, create a new /etc/systemd/system/httpd.service.d/cpu.conf configuration file with the following content:
[Service]
CPUShares=1500
To apply the changes, reload systemd's configuration and restart Apache so that the modified service file is taken into account:
~]# systemctl daemon-reload
~]# systemctl restart httpd.service
CPUQuota=value
Replace value with a value of CPU time quota to assign the specified CPU time quota to the processes executed. The value of the CPUQuota parameter, which is expressed in percentage, specifies how much CPU time the unit gets at maximum, relative to the total CPU time available on one CPU.
Values higher than 100% indicate that more than one CPU is used. CPUQuota controls the cpu.max attribute on the unified control group hierarchy, and the legacy cpu.cfs_quota_us attribute. Setting the value of the CPUQuota parameter automatically turns CPUAccounting on in the unit file. Users can thus monitor the usage of the processor with the systemd-cgtop command.
Example 2.4. Using CPUQuota

Setting CPUQuota to 20% ensures that the executed processes never get more than 20% CPU time on a single CPU.
To assign the Apache service CPU quota of 20%, add the following content to the /etc/systemd/system/httpd.service.d/cpu.conf configuration file:
[Service]
CPUQuota=20%
To apply the changes, reload systemd's configuration and restart Apache so that the modified service file is taken into account:
~]# systemctl daemon-reload
~]# systemctl restart httpd.service
Managing Memory
To enforce limits on the unit's memory consumption, use the following directives in the [Service] section of the unit configuration file:
MemoryLimit=value
Replace value with a limit on maximum memory usage of the processes executed in the cgroup. Use suffixes K, M, G, or T to identify Kilobyte, Megabyte, Gigabyte, or Terabyte as the unit of measurement. Also, the MemoryAccounting parameter has to be enabled for the unit.
The MemoryLimit parameter controls the memory.limit_in_bytes control group parameter. For more information, see the description of the memory controller in Controller-Specific Kernel Documentation.
