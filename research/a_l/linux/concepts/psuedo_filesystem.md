# **[What is a pseudo filesystem?](https://superuser.com/questions/1198292/what-is-a-pseudo-file-system-in-linux)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## **[Synthetic file system](https://en.wikipedia.org/wiki/Synthetic_file_system)**

In computer science, a synthetic file system or a pseudo file system is a hierarchical interface to non-file objects that appear as if they were regular files in the tree of a disk-based or long-term-storage file system. These non-file objects may be accessed with the same system calls or utility programs as regular files and directories. **The common term for both regular files and the non-file objects is node.**

The benefit of synthetic file systems is that well-known file system semantics can be reused for a universal and easily implementable approach to **interprocess communication**. Clients can use such a file system to perform simple file operations on its nodes and do not have to implement complex message encoding and passing methods and other aspects of **protocol engineering**. For most operations, common file utilities can be used, so even scripting is quite easy.

This is commonly known as everything is a file and is generally regarded to have originated from Unix.

## Examples

**/proc filesystem**\
In the Unix-world, there is commonly a special filesystem mounted at /proc. This filesystem is implemented within the kernel and publishes information about processes. For each process, there is a directory (named by the process ID), containing detailed information about the process: status, open files, memory maps, mounts, etc.

/proc first appeared in Unix 8th Edition,[1] and its functionality was greatly expanded in Plan 9 from Bell Labs.[2]

**Linux /sys filesystem**\
The /sys filesystem on Linux complements /proc, by providing a lot of (non-process related) detailed information about the in-kernel status to userspace. More traditional Unix systems locate this information in sysctl calls.

## Plan 9 file servers

On the Plan 9 from Bell Labs operating system family, the concept of 9P synthetic filesystem is used as a generic IPC method. Contrary to most other operating systems, Plan 9's design is heavily distributed: while in other OS worlds, there are many (and often large) libraries and frameworks for common things, Plan 9 encapsulates them into fileservers. The most important benefit is that applications can be much simpler and that services run network and platform agnostic - they can reside on virtually any host and platform in the network, and virtually any kind of network, as long the fileserver can be mounted by the application.

Plan 9 drives this concept expansively: most operating system services, e.g. hardware access and networking stack are presented as fileservers. This way it is trivial to use these resources remotely (e.g. one host directly accessing another host's block devices or network interfaces) without the need of additional protocols.

Other implementations of the 9P file system protocol also exists for many other systems and environments.[3]

Robert Pike is a Canadian programmer and author. He is best known for his work on the Go programming language while working at Google and the Plan 9 operating system while working at Bell Labs, where he was a member of the Unix team. Pike wrote the first window system for Unix in 1981. Wikipedia

## What is a pseudo file system in Linux?

A pseudo file system maintains information about the currently running system.

This information doesn't persist across reboots. It exists while the system in running only in RAM; in Window this would be the HKLM.

In linux /dev this includes things like /dev/tty# /dev/ttyS# they indicate devices as they are connected and they be created dynamically.

/sys shows a representation of the physical devices in the machine.

/proc maintain a lot of info about the current control set.

Example: free command is just importing info from /proc/meminfo file.

'Pseudo-' means false, pretend. So "pseudo-filesystem" means a filesystem that doesn't have actual files – rather, it has virtual entries that the filesystem itself makes up on the spot.

For example, /proc on many OSes is a procfs which dynamically generates directories for every process. Similarly, /sys on Linux generates files and directories to represent hardware layouts. There are FUSE-based pseudo-filesystems for a lot of things.

/dev may be a real filesystem (just a subdirectory of /), or a virtual pseudo-filesystem (e.g. devfs), or a middle point such as Linux devtmpfs (which is a full in-memory filesystem but still creates device nodes out of nowhere).

```bash
ls /sys/fs/cgroup/user.slice
cgroup.controllers      cgroup.procs            cpu.max.burst                    cpuset.mems            cpu.weight.nice  memory.events        memory.oom.group     memory.swap.high        pids.events
cgroup.events           cgroup.stat             cpu.pressure                     cpuset.mems.effective  io.max           memory.events.local  memory.peak          memory.swap.max         pids.max
cgroup.freeze           cgroup.subtree_control  cpuset.cpus                      cpu.stat               io.pressure      memory.high          memory.pressure      memory.swap.peak        pids.peak
cgroup.kill             cgroup.threads          cpuset.cpus.effective            cpu.stat.local         io.prio.class    memory.low           memory.reclaim       memory.zswap.current    user-1000.slice
cgroup.max.depth        cgroup.type             cpuset.cpus.exclusive            cpu.uclamp.max         io.stat          memory.max           memory.stat          memory.zswap.max
cgroup.max.descendants  cpu.idle                cpuset.cpus.exclusive.effective  cpu.uclamp.min         io.weight        memory.min           memory.swap.current  memory.zswap.writeback
cgroup.pressure         cpu.max                 cpuset.cpus.partition            cpu.weight             memory.current   memory.numa_stat     memory.swap.events   pids.current

ls /sys/fs/cgroup
cgroup.controllers      cgroup.procs            cpu.pressure           cpu.stat             init.scope     io.prio.class     memory.reclaim          misc.current                   sys-kernel-debug.mount
cgroup.max.depth        cgroup.stat             cpuset.cpus.effective  cpu.stat.local       io.cost.model  io.stat           memory.stat             proc-sys-fs-binfmt_misc.mount  sys-kernel-tracing.mount
cgroup.max.descendants  cgroup.subtree_control  cpuset.cpus.isolated   dev-hugepages.mount  io.cost.qos    memory.numa_stat  memory.zswap.writeback  sys-fs-fuse-connections.mount  system.slice
cgroup.pressure         cgroup.threads          cpuset.mems.effective  dev-mqueue.mount     io.pressure    memory.pressure   misc.capacity           sys-kernel-config.mount        user.slice
```
