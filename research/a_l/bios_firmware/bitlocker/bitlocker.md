# BitLocker

BitLocker architecture relies on the Advanced Encryption Standard (AES) to encrypt entire volumes with 128-bit or 256-bit keys, using a full volume encryption key (FVEK) protected by a volume master key (VMK). This VMK is then further protected by key protectors, often leveraging a Trusted Platform Module (TPM) for hardware-based security, ensuring data remains inaccessible without proper authentication, even when the operating system is offline. It also requires a specific disk configuration with a separate, unencrypted system partition to boot the operating system before BitLocker takes control of the encrypted operating system volume.

## Key Components & Processes

**Advanced Encryption Standard (AES):** The core encryption algorithm used to secure the data on the encrypted volume.
**Full Volume Encryption Key (FVEK):** A unique key used to encrypt all data on the volume.
**Volume Master Key (VMK):** The FVEK is encrypted by the VMK, providing a layer of indirection that allows for easier re-keying of the system if the upstream keys are compromised.
**Key Protectors:** The VMK is protected by a key protector, which can be a password, a recovery key, a smart card, or, most securely, the Trusted Platform Module (TPM).
**Trusted Platform Module (TPM):** A microchip in the computer that stores the encryption keys and can interact with the BIOS/UEFI firmware to ensure the system hasn't been tampered with during the boot process.
**Secure Boot:** A feature that works with the TPM to ensure only trusted firmware and bootloaders can run, preventing unauthorized access to the BitLocker key during startup.

## How It Works

1. **Boot Process:** When the computer starts, the BIOS/UEFI initializes the hardware, and the TPM performs measurements of the boot environment to ensure its integrity.
2. **[Key Unlock:](https://www.youtube.com/watch?v=2mFeoiExeX0&pp=ygUHI2FzazRwYw%3D%3D&t=385)** The TPM then unlocks the BitLocker encryption keys, allowing access to the unencrypted system partition, which contains the files needed to load the operating system.
3. **Operating System Loading:** The operating system's bootloader starts from the system partition.
4. **BitLocker Driver Activation:** Once the OS is running, the BitLocker driver becomes active and handles the decryption of the rest of the volume using the previously unlocked VMK.
