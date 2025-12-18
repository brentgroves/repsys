# does windows 11 need a tpm

Yes, Windows 11 requires Trusted Platform Module (TPM) 2.0 by default for improved security and to support core features like BitLocker and Windows Hello. While an unsupported installation method exists that bypasses this check using the Windows Registry, it is not recommended as it can lead to future issues with updates or security.

## Why TPM is Required

Enhanced Security: TPM 2.0 provides a hardware-based security feature that securely stores encryption keys, passwords, and other sensitive data, making it harder for attackers to tamper with your system.

**Core Functionality:** It enables critical Windows 11 features such as:
**BitLocker Drive Encryption:** Protects your data by encrypting your hard drive.
**Windows Hello:** Secures your identity for logging in.

**Future-Proofing:** Microsoft mandates TPM 2.0 to ensure a baseline level of security and support for future Windows updates and features that will rely on these hardware protections.

If You Don't Have a Compatible PC

**Unsupported Installation:** You can bypass the TPM 2.0 requirement by modifying the Windows Registry during the installation process, according to HP Support Community.
**Risks of Unsupported Installation:** Microsoft does not recommend this method because it can lead to an unsupported installation. You might:

- Miss out on future Windows updates and security enhancements.
- Experience system instability or performance issues.
Have a watermark on your system indicating it is unsupported.
