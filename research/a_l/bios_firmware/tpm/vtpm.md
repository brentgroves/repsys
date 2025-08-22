# does a virtual tpm access a physical tpm

1. **Boot Process:** When the computer starts, the BIOS/UEFI initializes the hardware, and the TPM performs measurements of the boot environment to ensure its integrity.
2. **[Key Unlock:](https://www.youtube.com/watch?v=2mFeoiExeX0&pp=ygUHI2FzazRwYw%3D%3D&t=385)** The TPM then unlocks the BitLocker encryption keys, allowing access to the unencrypted system partition, which contains the files needed to load the operating system.
3. **Operating System Loading:** The operating system's bootloader starts from the system partition.
4. **BitLocker Driver Activation:** Once the OS is running, the BitLocker driver becomes active and handles the decryption of the rest of the volume using the previously unlocked VMK.
