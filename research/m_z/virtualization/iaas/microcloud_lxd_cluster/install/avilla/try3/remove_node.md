# **[](https://documentation.ubuntu.com/microcloud/stable/microcloud/how-to/remove_machine/)**

How to remove a machine
If you want to remove a machine from the MicroCloud cluster after the initialisation, use the microcloud remove command:

sudo microcloud remove <name>
Before removing the machine, ensure that there are no LXD instances or storage volumes located on the machine, and that there are no MicroCeph OSDs located on the machine.

See how to remove instances in the LXD documentation. See how to remove OSDs in the MicroCeph documentation.

Note

If local storage was created, MicroCloud will have also added some default storage volumes that will need to be cleaned up:

```bash
lxc config unset storage.images_volume --target <name>
lxc config unset storage.backups_volume --target <name>
lxc storage volume delete local images --target <name>
lxc storage volume delete local backups --target <name>
```

Any additional storage volumes belonging to this machine must also be deleted before removal without the --force flag.

If the machine is no longer reachable over the network, you can also add the --force flag to bypass removal restrictions and skip attempting to clean up the machine. Note that MicroCeph requires --force to be used if the remaining cluster size will be less than 3.

Caution

Removing a cluster member with --force will not attempt to perform any clean-up of the removed machine. All services will need to be fully re-installed before they can be re-initialised. Resources allocated to the MicroCloud like disks and network interfaces may need to be re-initialised as well.

Reducing the cluster to 1 machine
When shrinking the cluster down to 1 machine, you must also clean up the Ceph monmap before proceeding, even when using the --force flag.

sudo microceph.ceph mon remove <name>
sudo microceph cluster sql "delete from services where member_id = (select id from core_cluster_members where name='<name>') and service='mon'"
sudo microcloud remove <name> --force
