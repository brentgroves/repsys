# **[](https://github.com/virtio-win/kvm-guest-drivers-windows)**

Win11 VM - which tools to install: virtio-win-gt-x64, virtio-guest-tools, qemu-ga-x86_64
Does someone have a decoder ring for these utilities? I think I only need the qemu-ga-x86_64, but not sure about the other ones.

I update the drivers in Device Manager and point to the virtio drive.

Do I need to install the other two?

SOLVED

Turns out you only need to install virtio-win-guest-tools and it takes care of everything including drivers and guest agent.
