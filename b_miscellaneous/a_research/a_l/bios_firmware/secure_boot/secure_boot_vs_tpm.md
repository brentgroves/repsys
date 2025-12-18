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
