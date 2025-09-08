# **[Understanding Seccomp (and How It Compares to AppArmor) for Container Security](https://medium.com/@mughal.asim/understanding-seccomp-and-how-it-compares-to-apparmor-for-container-security-5317b3e9b1d6)**

When exploring Linux container security, it’s easy to get wrapped up in countless controls like AppArmor, SELinux, and seccomp. AppArmor is often the more familiar one if you’ve spent time on Ubuntu-based systems, so naturally the question arises: What exactly is seccomp, and how does it differ from AppArmor?

In this post, I’ll walk through the learning journey of discovering seccomp — from what problem it solves and how it works, to how you might apply it in a Kubernetes environment. I’ll also sprinkle in some comparisons to AppArmor to make it easier if you’re already familiar with AppArmor’s path-based restrictions.

## 1. Introduction to Seccomp

What is Seccomp?
Seccomp (short for Secure Computing Mode) is a Linux kernel feature that restricts the system calls (syscalls) a process can invoke. A “system call” is how a user-space application asks the OS kernel to do something like open a file, create a network socket, or spawn a new process. By limiting which syscalls are allowed, you reduce the kernel’s attack surface significantly.

Why is it important?
In containerized environments, multiple containers share the host’s kernel. If a process in one container can call allsyscalls, a kernel-level exploit might jeopardize the entire node. Seccomp helps mitigate this by denying or logging risky syscalls — like ptrace(), which lets you read or manipulate another process’s memory.

How does it work?
Seccomp uses Berkeley Packet Filter (BPF) programs as a “filter” on syscalls. You create a profile (usually JSON) listing syscalls you explicitly allow or deny. If a syscall isn’t allowed, the default action might be to kill the process or return an error (depending on your profile configuration).

## Default Profiles

Most container runtimes (Docker, containerd, CRI-O) ship with a default seccomp profile that blocks several known-dangerous syscalls but still permits commonly used ones (e.g., reading/writing files, networking, etc.). If you don’t specify a custom profile, your containers get this baseline protection out of the box.

## 2. How Seccomp Differs from AppArmor

If you’ve worked with AppArmor, you know it restricts which resources (like files and directories) a process can access. Meanwhile, seccomp restricts which system calls are allowed in the first place.

## Seccomp

Filters or restricts which syscalls a process can use.
Example: You might block ptrace() or mount(), disallowing entire categories of system-level operations.

## AppArmor

Controls which system resources (files, directories, network interfaces, etc.) the process can access.
Example: You could allow writing only to /tmp/ while denying any writes to /etc/.

These two can (and often do) work together: seccomp stops disallowed actions at the syscall boundary, while AppArmor controls where you can perform otherwise allowed actions.

A Simple Analogy
Syscalls are like menu orders at a restaurant.

Seccomp is the “menu rule” that says, “Only these types of orders can be placed.”

AppArmor is the layout that decides which areas of the restaurant you can enter or use.

3. Why Use Seccomp in Containerized Environments?
Reducing Attack Surface
Limiting syscalls narrows an attacker’s options if the container’s application is compromised. If someone injects malicious code, they can’t just call any obscure or privileged syscall to escalate privileges.

Additional Layer of Container Security
Containers running on the same node share a single kernel. Seccomp ensures a compromised container can’t perform kernel-level exploits from unexpected syscalls.

Default Profiles in Runtimes
Docker, containerd, and CRI-O each ship with a baseline profile.
By default, these profiles forbid many dangerous syscalls yet allow common ones used by typical applications.
