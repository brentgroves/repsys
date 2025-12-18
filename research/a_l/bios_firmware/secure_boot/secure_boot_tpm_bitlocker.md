# AI Overview

Device Attestation & Secure Boot — Do I Need a TPM Chip | by ...
Secure boot and TPM (Trusted Platform Module) are both security features designed to protect a computer, but they function differently. Secure boot, a feature in UEFI firmware, verifies that the bootloader and other boot components are digitally signed by a trusted authority before allowing them to load. This prevents malware from hijacking the boot process. TPM, on the other hand, is a hardware security module that provides cryptographic key storage and platform integrity verification. It's often used with secure boot to enhance security by verifying the integrity of the system and protecting sensitive data.

## Secure Boot

**Function:** Prevents unauthorized software, like malware, from loading during the boot process by verifying the digital signatures of boot components.
**Implementation:** Relies on digital signatures stored in the UEFI firmware.
**Benefit:** Protects against bootkit and rootkit attacks, ensuring a trusted operating system environment.
**Does not require TPM:** Secure Boot can operate independently of a TPM chip.

## TPM

**Function:** Provides a secure hardware-based storage for cryptographic keys and performs platform integrity checks.
**Implementation:** Typically a dedicated chip on the motherboard.
**Benefit:** Enhances security by protecting sensitive data, verifying the identity of the device, and enabling features like BitLocker encryption.
**Often used with Secure Boot:** TPM can be used to enhance the security of Secure Boot by providing a hardware-rooted trust.

## Key Differences

- Secure Boot is a feature of UEFI firmware, while TPM is a hardware component.
- Secure Boot primarily focuses on preventing malware from loading during boot, while TPM focuses on providing a secure environment for cryptographic operations and platform integrity.
- Secure Boot can function without a TPM, but TPM enhances the overall security posture when used with Secure Boot.
This video explains **[how secure boot and TPM work together](https://m.youtube.com/watch?v=WRFnOh_pqX8&pp=ygUGI254dHBt&t=424)** to enhance security:

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
