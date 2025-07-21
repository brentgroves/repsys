# **[](https://discourse.ubuntu.com/t/update-2025-on-docker-inside-lxd-container-with-zfs-storage-with-gpu-passthrough/53609/5)**

Update [2025] on Docker inside LXD container with ZFS storage with GPU passthrough

Hey everyone

I realize that there has been some issues with docker on ZFS in the past. I just wanted to post a thread here incase anyone is searching the web for information on this.

It seems that with time ZFS now supports overlay2. I launched a container with the following profile settings

```bash
config:
  security.nesting: "true"
  security.syscalls.intercept.mknod: "true"
  security.syscalls.intercept.setxattr: "true"
```
