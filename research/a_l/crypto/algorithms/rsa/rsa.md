# **[RSA Algorithm in Cryptography: Rivest Shamir Adleman Explained](https://www.splunk.com/en_us/blog/learn/rsa-algorithm-cryptography.html#:~:text=RSA%20encrypts%20communication%20between%20two,to%20encrypt%20and%20decrypt%20messages.)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../../research/research_list.md)**\
**[Back Main](../../../../../README.md)**

RSA is a popular and secure cryptographic algorithm that encrypts and decrypts data. It provides a secure method for transmitting sensitive data over the Internet. While RSA has some vulnerabilities, it is still utilized for various applications, like digital signatures to authenticate the source of a message.

This article describes RSA, how it works, and its major applications. It also explains the security vulnerabilities of RSA and how to mitigate them.

## What is RSA?

Rivest Shamir Adleman (RSA) is a well-known public-key or asymmetric cryptographic algorithm. It protects sensitive data through encryption and decryption using a private and public key pair.

## Brief history of RSA

First introduced in 1977 by Ron Rivest, Adi Shamir and Leonard Adleman of the Massachusetts Institute of Technology, RSA is named after their last initials.

The growing domain of computer networks required a solution to secure digital communication. RSA was initially developed in 1977 as one such solution. The primary focus of RSA was to allow data to be securely transmitted over unsecured networks, specifically to enable private communications over the Internet and other electronic systems.

In traditional cryptographic systems, secure key distribution was a challenge. It required both parties to share a secret key before sending or receiving a message. With RSA, public-key cryptography helps users to share their public key openly, while keeping their private key secret. This solved the problem of key distribution and allowed users to communicate securely without prior key sharing.

![rsa](https://www.splunk.com/content/dam/splunk-blogs/images/en_us/2023/01/pqe1.png)

## RSA today

This makes RSA one of the most widely used encryption mechanisms worldwide. However, the computational complexity of RSA, it is not ideal to encrypt a huge amount of data.

To manage this goal, RSA is used to encrypt a symmetric key. The key is then used to encrypt the actual huge data. This hybrid approach utilizes both asymmetric and symmetric cryptography for efficient encryption.

## **[(Read our primer on AES, another common encryption standard.)](https://www.splunk.com/en_us/blog/learn/aes-advanced-encryption-standard.html)**

## How does RSA work?

RSA is based on factorizing and factoring large integers. First, you must choose two large prime numbers for the key pair, which is difficult to factorize. Hence, the prime numbers must be selected randomly and with a substantial difference between them. For example, consider the two chosen prime numbers as p and q.

Then, the algorithm calculates their product, denoted by n = p * q. The values of p and q should be kept secret, while n, which is used as the modulus for public and private keys, must be made public.

Next, the Carmecheals’ totient function is calculated using p and q, and the integer e, whose value is used as the public exponent, is selected. Then the next step is calculating the value of d, which is used as the private exponent.

## How do encryption and decryption happen in RSA?

The public key is the pair (n, e), while the private key is the pair (n, d).

- **Encryption.** When encrypting a message, the sender uses the public key (n, e) of the recipient to compute the ciphertext, where the ciphertext = m^e mod n. The m indicates the plaintext message.
- **Decryption.** When decrypting an RSA encrypted message, the recipient uses their private key (n, d) to compute the plaintext message, where the plaintext message = c^d mod n.

## Can RSA be broken?

RSA relies on the difficulty of factoring large prime numbers. (More on this below.) The security of RSA relies on a key's size. Although RSA is currently considered to be secure, it is vulnerable to potential future threats like Quantum computing.

**Quantum algorithms**, for instance Shor's algorithm, can quickly factor large numbers, thus making RSA obsolete. Against traditional attacks, with large keys (2048 bit or more) RSA is secure. However, advancement in computing powers may prove to be a challenge to RSA's reliability in the future.

So, what happens if RSA is broken? The primary risk is obviously the exposure of sensitive data, like financial details or personal information. Digital signatures will no longer be trustworthy, negatively impacting financial and legal systems.

To handle this potential risk, post-quantum cryptography, like lattice-based encryption is currently being explored as a solution to ensure data security in a world where RSA is breakable.
