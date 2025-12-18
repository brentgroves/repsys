# work setup

- dell vPro laptop
- <bgroves@linamar.com>
- secure boot disabled
- set HELLO piin
- `lxc config device remove win11 install` before restarting vm
- Did not install virtio drivers
- waited untill windows completed installing all work software.
- reboot

## result

works so far. Was the issue with the virtio driver, or time sync?

## enable bitlocker

works

## install ceph

- dokansetup.exe 2.3.0.1000
- install ceph_squid.msi
- reboot
- installed ceph.conf and keyring to c:\users\bgroves\ceph\
- create c:\users\bgroves\ceph\out
- ceph-dokan.exe -c C:\Users\bgroves\ceph\ceph.conf -l x --client_fs indFs

## result 2

works.
