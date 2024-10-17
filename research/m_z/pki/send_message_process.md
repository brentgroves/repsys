# **[How is the message digest related to Signatures and Encryption?](https://crypto.stackexchange.com/questions/33864/how-is-the-message-digest-related-to-signatures-and-encryption)**

**[Back to Research List](../../../research/research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## References

- **[Sectigo Certificate Linter](https://crt.sh/lintcert)**
- **[Use an online certificate decoder to view](https://www.sslshopper.com/certificate-decoder.html)**
- **[CSR decoder](https://www.sslshopper.com/csr-decoder.html)**.

## question

I was studying about 'Data Security' and I found out this one thing confusing.

What is a message digest? I got it is the hash of the message.

Is the message here referring to the plaintext or cipher text? I believe when using Digital Signatures, the message itself is also encrypted with a public key.

First of all, yes, the message digest is the hash of the message.

Secondly, do not mix things up. You are talking about public key encryption and signature. Let's redefine them to make sure we have everything right.

Alice and Bob got pairs of key (Apub, Apriv), (Bpub, Bpriv). Alice knows Bpub and Bob knows Apub.

Alice wants to send a message m to Bob ⟹  She encrypts it with Bpub.

Alice wants to prove to Bob that it was she who sent the message ⟹ She signs it with her private key Apriv.

How does the message digest appear in all that ? Continue reading.

**Problem:** signing and encryption using RSA (standard procedure) is slow. How to speed up the process?

Alice encrypts the message with a symmetric cipher (AES) using a random generated key Ksym. Then, encrypt Ksym with the Bpub.

Alice does not sign the message, she signs the message digest. Smaller therefore faster.

All this together? Here are the steps :

1. Alice hashes the message m ⟹ she gets the message digest. H(m)→MD
2. Alice signs MD with her private key. EApriv(MD)→Sig
3. Alice generates a random key for the symmetric encryption. rdm()→Ksym.
4. Alice encrypts the message and the signature with a symmetric cypher. EKsym(m∥Sig)→c
5. Alice encrypts the symmetric key with Bob's public key. EBpub(KSym)→Kcipher
6. Alice sends (c,Kcipher) to Bob.

Remark: It is a good practice to have 2 pairs of keys : one for encryption, one for signatures.

There are two encryption methods: asymmetric and symmetric. Asymmetric encryption uses public-private key infrastructure. Signing uses the hashing algorithm to generate a hash digest that utilizes the public-private keys for sender authentication

## **[Differences Between Encryption and Signing](https://signmycode.com/blog/what-are-the-differences-between-encryption-and-signing#:~:text=There%20are%20two%20encryption%20methods,private%20keys%20for%20sender%20authentication.)**

| Encryption                                                                                                                                  | Signing                                                                                                                               |
|---------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------|
| Encryption technology is used for encoding sensitive information sent in an email or document.                                              | Signing is used for verifying the identity of the source of the information sent over the Internet.                                   |
| There are two encryption methods: asymmetric and symmetric. Asymmetric encryption uses public-private key infrastructure.                   | Signing uses the hashing algorithm to generate a hash digest that utilizes the public-private keys for sender authentication.         |
| Here, the sender uses the public key to encrypt the data while forwarding it to the recipient who uses the private key to decrypt the same. | In digital signing, the sender uses the private key while the public key is used by the receiver to verify the sender’s authenticity. |
| Encryption is enforced by a digital security certificate such as SSL/TLS for sender data verification.                                      | Digital signing is enforced by a digital signature which is stored in a code signing certificate for sender identity verification.    |
| Senders need to acquire such certificates from Certificate Authorities (CAs) to successfully encrypt their messages.                        | Here, the sender also needs to acquire the code signing certificate from CAs like Sectigo or Comodo or their distributors.            |
