# where does fog imaging server pull the efi file

A FOG imaging server pulls EFI files from its own /tftpboot directory, which is served via TFTP. Within this directory, the server can have separate subdirectories for different architectures, such as /tftpboot/i386-efi for 32-bit EFI files, but the primary location is the /tftpboot folder on the server itself.
Location of EFI files
Server directory: The EFI files are located on the FOG server in the /tftpboot directory.
Subdirectories: Different EFI files for various architectures are stored in subdirectories, such as /tftpboot/i386-efi for 32-bit systems.
Serving method: The FOG server uses the Trivial File Transfer Protocol (TFTP) to serve these files to client computers that are configured to network boot.
How it works
A client computer configured for a network boot begins the boot process.
The client requests the boot files from the FOG server via TFTP.
The FOG server sends the appropriate EFI boot file from the /tftpboot directory to the client.
The client's UEFI firmware loads and executes the EFI file, which then continues the boot process to the FOG menu.
