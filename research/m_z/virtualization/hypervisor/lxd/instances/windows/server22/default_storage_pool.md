# **[](https://documentation.ubuntu.com/lxd/latest/explanation/storage/#storage-default-pool)**

Default storage pool
There is no concept of a default storage pool in LXD.

When you create a storage volume, you must specify the storage pool to use.

When LXD automatically creates a storage volume during instance creation, it uses the storage pool that is configured for the instance. This configuration can be set in either of the following ways:

Directly on an instance: lxc launch <image> <instance_name> --storage <storage_pool>

Through a profile: lxc profile device add <profile_name> root disk path=/ pool=<storage_pool> and lxc launch <image> <instance_name> --profile <profile_name>

Through the default profile

In a profile, the storage pool to use is defined by the pool for the root disk device:

  root:
    type: disk
    path: /
    pool: default
In the default profile, this pool is set to the storage pool that was created during initialization.

<https://documentation.ubuntu.com/lxd/latest/howto/storage_create_instance/>

How to create an instance in a specific storage pool
Instance storage volumes are created in the storage pool that is specified by the instance’s root disk device. This configuration is normally provided by the profile or profiles applied to the instance. See Default storage pool for detailed information.
