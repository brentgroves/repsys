# **[volume](https://documentation.ubuntu.com/lxd/stable-5.21/howto/cluster_config_storage/#create-storage-volumes)**

Create storage volumes
For most storage drivers (all except for Ceph-based storage drivers), storage volumes are not replicated across the cluster and exist only on the member for which they were created. Run lxc storage volume list <pool_name> to see on which member a certain volume is located.

When creating a storage volume, use the --target flag to create a storage volume on a specific cluster member. Without the flag, the volume is created on the cluster member on which you run the command. For example, to create a volume on the current cluster member server1:

lxc storage volume create local vol1
To create a volume with the same name on another cluster member:

lxc storage volume create local vol1 --target server2
Different volumes can have the same name as long as they live on different cluster members. Typical examples for this are image volumes.

You can manage storage volumes in a cluster in the same way as you do in non-clustered deployments, except that you must pass the --target flag to your commands if more than one cluster member has a volume with the given name. For example, to show information about the storage volumes:

lxc storage volume show local vol1 --target server1
lxc storage volume show local vol1 --target server2
