# **[1.3.2 Understanding Security Levels](https://www.feistyduck.com/library/openssl-cookbook/online/openssl-command-line/understanding-security-levels.html)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Tasks](../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../README.md)**

In the previous section, we discussed how to get a complete list of supported suites—but that list is deceptive. Just because something is supported doesn’t mean it’s going to be enabled. Unless you tell it otherwise, the ciphers command outputs even the suites that will not be allowed. The trick is to use the -s switch, after which the number of suites will go down from 162 to only 77.

Granted, the reduction is in large part due to the removal of PSK and SRP suites, which removes 66 entries (down to 96). The remaining difference of 21 entries is due to the concept called security level, which OpenSSL now uses.1

Cipher suite configuration is complex, and most people are not experts in cryptography. For example, it’s very easy to follow some outdated advice from the Internet and add an insecure element to your configuration. Additionally, there are some aspects of security that cannot be configured via cipher suites and previously couldn’t be controlled at all. Security levels therefore are designed to guarantee minimum security requirements, even if incorrect configuration is requested. They are a very useful safety net.

## Table  1.3.2.1 OpenSSL security levels

| Security Level | Meaning                                                                   |
|----------------|---------------------------------------------------------------------------|
| Level 0        | No restrictions. Allows all features enabled at compile time. Insecure.   |
| Level 1        | The security level corresponds to a minimum of 80 bits of security. Weak. |
| Level 2        | Security level set to 112 bits of security.                               |
| Level 3        | Security level set to 128 bits of security.                               |
| Level 4        | Security level set to 192 bits of security.                               |
| Level 5        | Security level set to 256 bits of security.                               |

The most important aspect of security levels is knowing what not to use, and that’s the first two levels. Level 0 imposes no restrictions and is potentially insecure (depending on what features were enabled at compile time). You aren’t very likely to need this level in practice. Level 1 is slightly better but still allows weak elements. You may need this level for interoperability purposes with legacy systems. Level 1 is the default security level in OpenSSL.

In practice, you should aim to use level 2 as your baseline. This level supports 2,048-bit RSA keys, which most web sites use today. Weak protocols such as SSL 2 and SSL 3 won’t be allowed, along with RC4 and SHA1. If you’re not using stock OpenSSL, you may find that your distribution already made this choice for you; for example, Ubuntu 20.04 LTS chooses level 2 as the default.

Levels 3 and up are levels you should consider if you have specific security requirements and want to enforce stronger encryption. For example, if you enable level 3, 2,048-bit RSA keys won’t be allowed. Because keys stronger than this are quite slow, this choice of security level implicitly restricts you to ECDSA keys.

You can gain a better understanding of security levels by using the -s switch along with the @SECLEVEL keyword as part of your suite configuration. For an example, let’s see how the switch from level 3 to level 4 affects one arbitrary suite configuration. At level 3, there are four suites in the output:

```bash
openssl ciphers -v -s -tls1_2 'EECDH+AESGCM @SECLEVEL=3'
ECDHE-ECDSA-AES256-GCM-SHA384 TLSv1.2 Kx=ECDH Au=ECDSA Enc=AESGCM(256) Mac=AEAD
ECDHE-RSA-AES256-GCM-SHA384   TLSv1.2 Kx=ECDH Au=RSA   Enc=AESGCM(256) Mac=AEAD
ECDHE-ECDSA-AES128-GCM-SHA256 TLSv1.2 Kx=ECDH Au=ECDSA Enc=AESGCM(128) Mac=AEAD
ECDHE-RSA-AES128-GCM-SHA256   TLSv1.2 Kx=ECDH Au=RSA   Enc=AESGCM(128) Mac=AEAD
```

However, at level 4 there are only two suites in the output, because the 128-bit suites were removed:

```bash
openssl ciphers -v -s -tls1_2 'EECDH+AESGCM @SECLEVEL=4'
ECDHE-ECDSA-AES256-GCM-SHA384 TLSv1.2 Kx=ECDH Au=ECDSA Enc=AESGCM(256) Mac=AEAD
ECDHE-RSA-AES256-GCM-SHA384   TLSv1.2 Kx=ECDH Au=RSA   Enc=AESGCM(256) Mac=AEAD
```

You may have noticed that the previous example introduces the -tls1_2 switch, which outputs only suites that can be negotiated with TLS 1.2. This switch, along with -tls1_3, -tls1_1, -tls1, and -ssl3, is very useful for removing unwanted output when you’re interested in only one protocol.
