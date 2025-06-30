# **[Multi node install](https://canonical-microceph.readthedocs-hosted.com/en/latest/how-to/multi-node/)**

This tutorial will show how to install MicroCeph on three machines, thereby creating a multi-node cluster. For this tutorial, we will utilise physical block devices for storage.

## Ensure storage requirements

Three OSDs will be required to form a minimal Ceph cluster. This means that, on each of the three machines, one entire disk must be allocated for storage.

ceph-osd is the object storage daemon for the Ceph distributed file system. It manages data on local storage with redundancy and provides access to that data ...
