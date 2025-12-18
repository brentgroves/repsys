# AI Overview

Creating a config.yaml for an LXD Ubuntu desktop image
To create a config.yaml for an LXD Ubuntu Desktop image, you'll generally be defining the characteristics of a LXD profile, which acts as a template for instances (containers or VMs). Here's a breakdown and an example:
Understanding LXD profiles and config.yaml
LXD uses profiles to define the configuration of instances, including things like resource limits, network settings, and attached devices. When you launch a new instance, you can apply one or more profiles to it. The configuration within a profile can be represented in a YAML format.
Example config.yaml for an Ubuntu Desktop
Here's an example of what a config.yaml might look like for an Ubuntu desktop LXD profile, along with explanations of the different sections:

```yaml
config:
  limits.cpu: "4"             # Allocate 4 CPU cores
  limits.memory: "8GB"       # Allocate 8GB of RAM
  nvidia.runtime: "true"    # Enable NVIDIA GPU passthrough if applicable
  user.user-data: |          # Cloud-init for initial setup
    #cloud-config
    users:
      - name: ubuntu
        groups: sudo
        shell: /bin/bash
        sudo: ALL=(ALL) NOPASSWD:ALL
        ssh_authorized_keys:
          - YOUR_SSH_PUBLIC_KEY  # Replace with your actual SSH public key

devices:
  eth0:
    name: eth0
    nictype: bridged
    parent: lxdbr0             #  Attach to the default LXD bridge
    type: nic
  root:
    path: /
    pool: default
    type: disk
    size: 25GB                  #  Allocate 25GB of disk space
  gpu:
    type: gpu
    id: "0"                     # Pass through the first GPU
    name: gpu
```
