# **[What Is a Cipher Suite?](https://www.ssldragon.com/blog/cipher-suites/)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Tasks](../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../README.md)**

A cipher suite is a set of cryptographic algorithms used to secure network communications in SSL/TLS protocols. It specifies how encryption, authentication, and data integrity are achieved by combining algorithms for key exchange, encryption, and message authentication. Cipher suites ensure secure data transmission over the internet.

The term ‘cipher suite’ might look complex, but it’s quite simple when you break it down. A cipher is a way to hide information by secretly changing the letters or symbols.

The suite or set, contains algorithms for key exchange, a bulk data encryption algorithm, and data integrity checks. Imagine a well-coordinated team where each member has a specific role, working together to protect your data from cyber threats. That’s what a cipher suite does.

When establishing a secure connection, your system and the server negotiate to use the strongest cipher suite they both support. It’s like deciding on the best safety gear before a dangerous mission. But remember, not all cipher suites offer the same level of security. Some are outdated and vulnerable.

## What Makes Up a Cipher Suite?

A cipher suite contains four components:

- Key exchange algorithm
- Key encryption algorithm
- Message Authentication Code (MAC algorithm)
- Pseudorandom Function (PRF).

The key exchange algorithm, such as **[RSA or Diffie-Hellman](https://www.ssldragon.com/blog/rsa-aes-encryption/)**, allows the client and server to exchange encryption keys safely. This secret key is then used in **[bulk encryption](https://www.ssldragon.com/blog/encryption-types-algorithms/)** algorithms, like AES or 3DES that employ symmetric keys to encrypt data in transit.

The MAC authentication algorithm, like **[SHA-256](https://www.ssldragon.com/blog/256-bit-encryption/)**, ensures the integrity of the data, confirming that it hasn’t been tampered with during transmission. The PRF, on the other hand, is used for key generation and data randomizing.

## Cipher Suites Supported in TLS 1.2 and TLS 1.3

When it comes to TLS 1.3, the approach is more streamlined. It has significantly reduced the number of supported cipher suites. It only supports five cipher suites, all with the same HMAC-based Extract-and-Expand Key Derivation Function (HKDF) and AEAD encryption mode. Here is the TLS 1.3 cipher suites list:

- TLS_AES_256_GCM_SHA384 (Enabled by default)
- TLS_CHACHA20_POLY1305_SHA256 (Enabled by default)
- TLS_AES_128_GCM_SHA256 (Enabled by default)
- TLS_AES_128_CCM_8_SHA256.
- TLS_AES_128_CCM_SHA256.

The main reason behind this simplification in TLS 1.3 is to enhance security. Fewer cipher suites mean fewer attacks and loopholes for hackers to exploit.

## Choosing Cipher Suites

When you select a cipher suite, understanding its components is the first step. You should balance security with performance and ensure compatibility with your existing infrastructure.

To choose the proper cipher suite, you must understand its components and how they work together to secure your data.

As you already know, most cipher suites include the following:

- a key exchange algorithm,
- a bulk encryption algorithm,
- a message authentication code (MAC),
- an encryption mode.
