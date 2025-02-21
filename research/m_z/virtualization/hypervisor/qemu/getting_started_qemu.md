# **[Getting started with qemu](https://drewdevault.com/2018/09/10/Getting-started-with-qemu.html)**

**[Back to Research List](../../../../research_list.md)**\
**[Back to Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../../README.md)**

I often get asked questions about using my software, particularly sway, on hypervisors like VirtualBox and VMWare, as well as for general advice on which hypervisor to choose. My answer is always the same: qemu. There’s no excuse to use anything other than qemu, in my books. But I can admit that it might be a bit obtuse to understand at first. qemu’s greatest strength is also its greatest weakness: it has so many options that it’s hard to know which ones you need just to get started.

qemu is the swiss army knife of virtualisation, much like ffmpeg is the swiss army knife of multimedia (which comes as no surprise, given that both are written by Fabrice Bellard). I run a dozen permanent VMs with qemu, as well as all of the ephemeral VMs used on **[builds.sr.ht](https://meta.sr.ht/)**. Why is it better than all of the other options? Well, in short: qemu is fast, portable, better supported by guests, and has more features than Hollywood. There’s nothing other hypervisors can do that qemu can’t, and there’s plenty qemu can that they cannot.

Studying the full breadth of qemu’s featureset is something you can do over time. For now, let’s break down a simple Linux guest installation. We’ll start by downloading some install media (how about **[Alpine Linux](https://alpinelinux.org/)**, I like Alpine Linux) and preparing a virtual hard drive.

```bash
curl -O https://nl.alpinelinux.org/alpine/v3.8/releases/x86_64/alpine-standard-3.8.0-x86_64.iso
qemu-img create -f qcow2 alpine.qcow2 16G
```

This makes a 16G virtual hard disk in a file named alpine.qcow2, the qcow2 format being a format which appears to be 16G to the guest (VM), but only actually writes to the host any sectors which were written to by the guest in practice. You can also expose this as a block device on your local system (or a remote system!) with qemu-nbd if you need to. Now let’s boot up a VM using our install media and virtual hard disk:

```bash
qemu-system-x86_64 \
    -enable-kvm \
    -m 2048 \
    -nic user,model=virtio \
    -drive file=alpine.qcow2,media=disk,if=virtio \
    -cdrom alpine-standard-3.8.0-x86_64.iso \
    -sdl
```