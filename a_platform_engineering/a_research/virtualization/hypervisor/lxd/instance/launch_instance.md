# **[](https://documentation.ubuntu.com/lxd/latest/howto/instances_configure/#instances-configure-devices)**

## lxc launch

Create and start instances from images

## Synopsis

Description: Create and start instances from images

`lxc launch [<remote>:]<image> [<remote>:][<name>] [flags]`

## Examples

```bash
  lxc launch ubuntu:24.04 u1
      # Create and start a container

  lxc launch ubuntu:24.04 u1 < config.yaml
      # Create and start a container with configuration from config.yaml

  lxc launch ubuntu:24.04 u2 -t aws:t2.micro
      # Create and start a container using the same size as an AWS t2.micro (1 vCPU, 1GiB of RAM)

  lxc launch ubuntu:24.04 v1 --vm -c limits.cpu=4 -c limits.memory=4GiB
      # Create and start a virtual machine with 4 vCPUs and 4GiB of RAM

  lxc launch ubuntu:24.04 v1 --vm -c limits.cpu=2 -c limits.memory=8GiB -d root,size=32GiB
      # Create and start a virtual machine with 2 vCPUs, 8GiB of RAM and a root disk of 32GiB
  ```
