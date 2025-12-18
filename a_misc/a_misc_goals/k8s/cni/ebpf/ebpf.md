# **[eBPF Documentation](<https://ebpf.io/what-is-ebpf/>)**

## What is eBPF?

eBPF is a revolutionary technology with origins in the Linux kernel that can run sandboxed programs in a privileged context such as the operating system kernel. It is used to safely and efficiently extend the capabilities of the kernel without requiring to change kernel source code or load kernel modules.

Historically, the operating system has always been an ideal place to implement observability, security, and networking functionality due to the kernel’s privileged ability to oversee and control the entire system. At the same time, an operating system kernel is hard to evolve due to its central role and high requirement towards stability and security. The rate of innovation at the operating system level has thus traditionally been lower compared to functionality implemented outside of the operating system.

![i](https://ebpf.io/static/e293240ecccb9d506587571007c36739/f2674/overview.png)

eBPF changes this formula fundamentally. It allows sandboxed programs to run within the operating system, which means that application developers can run eBPF programs to add additional capabilities to the operating system at runtime. The operating system then guarantees safety and execution efficiency as if natively compiled with the aid of a Just-In-Time (JIT) compiler and verification engine. This has led to a wave of eBPF-based projects covering a wide array of use cases, including next-generation networking, observability, and security functionality.

Today, eBPF is used extensively to drive a wide variety of use cases: Providing high-performance networking and load-balancing in modern data centers and cloud native environments, extracting fine-grained security observability data at low overhead, helping application developers trace applications, providing insights for performance troubleshooting, preventive application and container runtime security enforcement, and much more. The possibilities are endless, and the innovation that eBPF is unlocking has only just begun.

What is eBPF.io?
eBPF.io is a place for everybody to learn and collaborate on the topic of eBPF. eBPF is an open community and everybody can participate and share. Whether you want to read a first introduction to eBPF, find further reading material, or make your first steps to becoming contributors to major eBPF projects, eBPF.io will help you along the way.

What do eBPF and BPF stand for?
BPF originally stood for Berkeley Packet Filter, but now that eBPF (extended BPF) can do so much more than packet filtering, the acronym no longer makes sense. eBPF is now considered a standalone term that doesn’t stand for anything. In the Linux source code, the term BPF persists, and in tooling and in documentation, the terms BPF and eBPF are generally used interchangeably. The original BPF is sometimes referred to as cBPF (classic BPF) to distinguish it from eBPF.

What is the bee named?
The bee is the official logo for eBPF and was originally created by Vadim Shchekoldin. At the first eBPF Summit there was a vote taken and the bee was named eBee. (For details on acceptable uses of the logo, please see the eBPF Foundation Brand Guidelines.)
