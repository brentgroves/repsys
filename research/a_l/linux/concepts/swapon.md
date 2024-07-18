# **[swapon](https://www.computerhope.com/unix/swapon.htm)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Linux swapon and swapoff command

On Linux operating systems, the swapon and swapoff commands enable and disable, respectively, devices and files for paging and swapping.

## Description

swapon is used to specify devices on which paging and swapping are to take place.

The device or file used is given by the specialfile parameter. It may be of the form "-L label" or "-U uuid" to indicate a device by label or uuid.

Calls to swapon normally occur in the system boot scripts making all swap devices available, so that the paging and swapping activity is interleaved across several devices and files.

swapoff disables swapping on the specified devices and files. When the -a flag is given, swapping is disabled on all known swap devices and files (as found in /proc/swaps or /etc/fstab).
