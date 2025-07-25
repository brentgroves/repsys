# **[](https://canonical-microceph.readthedocs-hosted.com/stable/explanation/security/full-disk-encryption/)**

Full disk encryption
MicroCeph supports automatic full disk encryption (FDE) on OSDs.

Full disk encryption is a security measure that protects the data on a storage device by encrypting all the information on the disk. FDE helps maintain data confidentiality in case the disk is lost or stolen by rendering the data inaccessible without the correct decryption key or password.

In the event of disk loss or theft, unauthorised individuals are unable to access the encrypted data, as the encryption renders the information unreadable without the proper credentials. This helps prevent data breaches and protects sensitive information from being misused.

FDE also eliminates the need for wiping or physically destroying a disk when it is replaced, as the encrypted data remains secure even if the disk is no longer in use. The data on the disk is effectively rendered useless without the decryption key.

Implementation
Full disk encryption for OSDs has to be requested when adding disks. MicroCeph will then generate a random key, store it in the Ceph cluster configuration, and use it to encrypt the given disk via LUKS/cryptsetup.

## Prerequisites

To use FDE, the following prerequisites must be met:

- The installed snapd daemon version must be >= 2.59.1
- The dm-crypt kernel module must be available. Note that some cloud-optimised kernels do not ship dm-crypt by default. Check by running `sudo modinfo dm-crypt`
- The snap dm-crypt plug has to be connected, and microceph.daemon subsequently restarted:

```bash
sudo snap connect microceph:dm-crypt
sudo snap restart microceph.daemon
```

## Limitations

Warning

It is important to note that MicroCeph FDE only encompasses OSDs. Other data, such as state information for monitors, logs, configuration etc., will not be encrypted by this mechanism.

Also note that the encryption key will be stored on the Ceph monitors as part of the Ceph key/value store

Usage
FDE for OSDs is activated by passing the optional --encrypt flag when adding disks:

sudo microceph disk add /dev/sdx --wipe --encrypt
Note there is no facility to encrypt an OSD that is already part of the cluster. To enable encryption you will have to take the OSD disk out of the cluster, ensure data is replicated and the cluster converged and is healthy, and then re-introduce the OSD with encryption.

## AI

Yes, MicroCeph, which is used by MicroCloud for distributed storage, supports dm-crypt for full disk encryption (FDE) of Object Storage Daemons (OSDs).
Here's how it generally works:
Enabling encryption: FDE needs to be requested when adding disks to MicroCeph.
Key management: When FDE is requested, MicroCeph generates a random key and stores it in the Ceph Monitor (MON).
LUKS setup: This key is then used to set up Linux Unified Key Setup (LUKS) via cryptsetup with AES-XTS-plain64 and SHA256 hashing.
dm-crypt Plug: To enable this functionality, the dm-crypt plug for MicroCeph must be connected, as it's not auto-connected by default. This means you need to explicitly connect the dm-crypt plug to MicroCeph after installing MicroCloud.
In essence, while MicroCloud itself drives the MicroCeph snap, you need to ensure the dm-crypt kernel module is available on the system and then connect the dm-crypt snap plug to MicroCeph before enabling full disk encryption during disk addition.
