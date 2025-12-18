# **[ventoy](https://forums.ventoy.net/showthread.php?tid=2988)**

Sounds like a UEFI problem. If you have an U/EFI boot option and the BIOS allows you to create a boot entry by supplying the location of the EFI file which is located on the USB drive that might work.

The Ventoy EFI files are located in the small, hidden VTOYEFI partition (often ~34MB, FAT32) on your USB drive, specifically within the \EFI\BOOT\
