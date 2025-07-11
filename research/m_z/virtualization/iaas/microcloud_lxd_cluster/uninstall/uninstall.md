# **[uninstall](https://discuss.linuxcontainers.org/t/introducing-microcloud/15871/65?page=4)**

If while executing “microclound init” it failed with Timed out waiting for a response from all cluster members and one or more of the nodes failed to handle and/or parse the join token (see the errors I got in the previous comment), cancel the current execution, wipe out all snaps on all nodes, and run again, eventually it will succeed.
To wipe out, I executed what nkrapf suggested:

```bash
snap stop microcloud microceph lxd && snap disable microcloud && snap disable microceph && snap disable lxd && snap remove --purge microcloud && snap remove --purge microceph && snap remove --purge lxd
```
