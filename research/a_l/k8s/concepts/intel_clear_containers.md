# **[Intel Clear Containers](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-clear-containers-1-the-container-landscape.html)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

Best of Both Worlds: Intel Clear Containers
Intel has developed a new, open source method of launching containerized workloads called Intel Clear Containers. An Intel Clear Container, running on Intel architecture with Intel® Virtualization Technology enabled, is:

- A highly-customized version of the QEMU-KVM* hypervisor, called qemu-lite.
  - Most of the boot-time probes and early system setup associated with a full-fledged hypervisor are unnecessary and stripped away.
  - This reduces startup time to be on a par with a normal container process.
- A mini-OS that consists of:
  - A highly-optimized Linux kernel.
  - An optimized version of systemd.
    - Just enough drivers and additional binaries to bring up an overlay filesystem, set up networking, and attach volumes.
- The correct tooling to bring up containerized workload images exactly as a normal container process would.

Intel Clear Containers can also be integrated with Docker 1.12, allowing the use of Docker just exactly as though operating normal OS containers via the native Docker execution engine. This drop-in is possible because the runtime is compatible with the Open Container Initiative*(OCI*). The important point is that from the application developer perspective, where “container” means the containerized workload, an Intel Clear Container looks and behaves just like a “normal” OS container.

There are some additional but less obvious benefits. Since the mini-OS uses a 4.0+ Linux kernel, it can take advantage of the “direct access” (DAX) feature of the kernel to replace what would be overhead associated with VM memory page cache management. The result is faster performance by the mini-OS kernel and a significant reduction in the memory footprint of the base OS and filesystem; only one copy needs to be resident in memory on a host that could be running thousands of containers.

In addition, Kernel Shared Memory (KSM) allows the containerized VMs to share memory securely for static information that is not already shared by DAX via a process of de-duplication. This results in an even more efficient memory profile. The upshot of these two combined technologies is that the system's memory gets used for the actual workloads, rather than redundant copies of the same OS and library data.

Intel Clear Containers offer a means of combining the best features of VMs with the power and flexibility that containers bring to application developers.

You can find more information about **[Intel Clear Containers](http://clearlinux.org/features/intel%C2%AE-clear-containers)** at the official website.
