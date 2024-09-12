# **[What is eBPF?](https://www.tigera.io/learn/guides/ebpf/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## What Is eBPF?

The Linux kernel is useful for implementing networking, observability, and security features, but it can also present difficulties. Whether adding modules or modifying kernel source code, developers have typically found they need to deal with abstracted layers and intricate infrastructure that are hard to debug. **Extended Berkeley Packet Filter** (eBPF) addresses both these issues.

eBPF is a kernel technology (fully available since Linux 4.4). It lets programs run without needing to add additional modules or modify the kernel source code. You can conceive of it as a lightweight, sandboxed virtual machine (VM) within the Linux kernel. It allows programmers to run Berkeley Packet Filter (BPF) bytecode that makes use of certain kernel resources.

Utilizing eBPF removes the necessity to modify the kernel source code and improves the capacity of software to make use of existing layers. Consequently, this technology can fundamentally change how services such as observability, security, and networking are delivered.

This is part of an extensive series of guides about observability.

## eBPF Use Cases

Here are some of the important use cases for eBPF.

## Security

Extending the basic capabilities of seeing and interpreting all system calls and providing packet and socket-level views of all networking operations enables the development of revolutionary approaches to system security.

Typically, entirely independent systems have handled different aspects of system call filtering, process context tracing, and network-level filtering. On the other hand, eBPF facilitates the combination of control and visibility over all aspects. This allows you to develop security systems that operate with more context and an improved level of control.

## Networking
The combination of efficiency and programmability makes eBPF a good candidate for all networking solutions’ packet processing requirements. The programmability of eBPF provides a means of adding additional protocol parsers, and smoothly programs any forwarding logic to address changing requirements without ever exiting the Linux kernel’s packet processing context. The effectiveness offered by the JIT compiler offers execution performance near that of natively compiled in-kernel code.

## Tracing and Profiling
The ability to attach eBPF programs to trace points in addition to kernel and user application probe points enables visibility into the runtime behavior of applications as well as the system.

By providing introspection capabilities to both the system and the application side, both views can be combined. This gives unique and powerful insights to troubleshoot system performance issues. Advanced statistical data structures let you extract useful visibility data in an effective way, without needing the export of huge amounts of sampling data that is typical for similar systems.

## Observability and Monitoring

Rather than relying on gauges and static counters exposed by the operating system, eBPF allows for the generation of visibility events and the collection and in-kernel aggregation of custom metrics based on a broad range of potential sources.

This increases the depth of visibility that might be attained and decreases the overall system overhead dramatically. This is achieved by collecting only the required visibility data and by producing histograms and similar data structures at the source of the event, rather than depending on the export of samples.

## How eBPF Works

eBPF programs are used to access hardware and services from the Linux kernel area. These programs are used for debugging, tracing, firewalls, networking, and more.

Developed out of a need for improved Linux tracing tools, eBPF was influenced by dtrace, a dynamic tracing tool available mainly for BSD and Solaris operating systems. Unlike dtrace, Linux was not able to achieve a global overview of running systems. Rather, it was restricted to specific frameworks for library calls, functions, and system calls.

eBPF is an extension of its precursor, BPF. BPF is a tool used for writing packer-filtering code via an in-kernel VM. A group of engineers started to build on the BPF backend to offer a similar series of features as dtrace, which eventually evolved into eBPF. Although initially released in limited capacity in 2014 with Linux 3.18, you need at least Linux 4.4 or above to make full use of eBPF.

The diagram below is a simplified illustration of eBPF architecture. Prior to being loaded into the kernel, the eBPF program needs to pass a particular series of requirements. Verification includes executing the eBPF program in the virtual machine.

![](https://www.tigera.io/app/uploads/2021/07/eBPF-diagram.png)

This permits the verifier, with 10,000+ lines of code, to carry out a set of checks. The verifier will go over the potential paths the eBPF program might take when executed in the kernel, to ensure the program runs to completion without any looping, which would result in a kernel lockup.

Additional checks—from program size, to valid register state, to out-of-bound jumps—should also be made. eBPF distinguishes itself from Linux Loadable Kernel Modules (LKM) by adding these additional safety controls.

If all checks are cleared, the eBPF program is loaded and compiled into the kernel at a location in a code path, and waits for the appropriate signal. When the signal is received in the form of an event, the eBPF program is loaded in the code path. Once initiated, the bytecode collects and executes information according to its instructions.

To summarize, the role of eBPF is to allow programmers to execute custom bytecode safely within the Linux kernel, without adding to or changing the kernel source code. Though it cannot replace LKMs altogether, eBPF programs introduce custom code that relates to protected hardware resources, with limited threat to the kernel.

## How Are eBPF Programs Written?

In many cases, you might use eBPF indirectly through a project like bpftrace or Cilium. These projects offer abstractions on top of eBPF, so you don’t have to write the program directly. You can specify definitions based on intent, which eBPF then implements.

If there isn’t a higher level of abstraction that exists, you need to write the programs directly. The Linux kernel requires that you load eBPF programs in bytecode form. While it is technically possible to directly write in bytecode, this is not a popular option. Instead, developers usually prefer to compile pseudo-C code into eBPF bytecode using a compiler suite, such as LLVM.

LLVM is a set of compiler and toolchain technologies that can be used to develop a frontend for any programming language and a backend for any instruction set architecture.
