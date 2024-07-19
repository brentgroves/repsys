# **[product_uuid and machine-id](https://stackoverflow.com/questions/72506495/install-k8s-on-ubuntu-product-uuid-or-machine-id)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

product_uuid is main board product UUID(set by the board manufacturer) and may be used to identify a mainboard.

machine-id is a unique id specific to a linux installation.

```bash
ubuntu@k3s:~$ sudo dmidecode --type 1

# dmidecode 3.3

Getting SMBIOS data from sysfs.
SMBIOS 3.0.0 present.

Handle 0x0100, DMI type 1, 27 bytes
System Information
    Manufacturer: QEMU
    Product Name: QEMU Virtual Machine
    Version: virt-6.2
    Serial Number: Not Specified
    UUID: Not Settable
```
