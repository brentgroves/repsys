# personal setup

- dell laptop vPro enterprise
- setup for personal use.
- secure boot disabled

## result

This works.

## install virtio driver

Download virtio-win.iso from <https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.271-1/>

Add the downloaded ISO as a device to the VM

```bash
# lxc config device add win11c thedrivers disk source=/home/chris/Downloads/virtio-win-0.1.271.iso

lxc config device add win11 thedrivers disk source=/home/brent/Downloads/virtio-win-0.1.271.iso
Device thedrivers added to win11

```

Go to the CD Drive in Windows and run virtio-win-gt-x64.msi

CategoriesArticles
Tagslxd-lxc
Snap
Async Await
