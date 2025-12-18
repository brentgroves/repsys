# **[What’s the difference between client certificates vs. server certificates?](https://www.digicert.com/faq/public-trust-and-certificates/whats-the-difference-between-client-certificates-vs-server-certificates)**

**[Back to Research List](../../../research/research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## References

- **[A Comprehensive Guide to PKI Client Certificate Authentication](https://www.portnox.com/blog/network-access-control/comprehensive-guide-to-pki-client-certificate-authentication/)**
- **[Sectigo Certificate Linter](https://crt.sh/lintcert)**
- **[Use an online certificate decoder to view](https://www.sslshopper.com/certificate-decoder.html)**
- **[CSR decoder](https://www.sslshopper.com/csr-decoder.html)**.

## What’s the difference between client certificates vs. server certificates?

**Client certificates** are digital certificates for users and individuals to prove their identity to a server. Client certificates tend to be used within private organizations to authenticate requests to remote servers. Whereas server certificates are more commonly known as TLS/SSL certificates and are used to protect servers and web domains. **Server certificates** perform a very similar role to Client certificates, except the latter is used to identify the client/individual and the former authenticates the owner of the site.

## What is a client certificate?

Client certificates are, as the name indicates, used to identify a client or a user, authenticating the client to the server and establishing precisely who they are. To some, the mention of PKI or ‘Client certificates’ may conjure up images of businesses protecting and completing their customers’ online transactions, yet such certificates are found throughout our daily lives, in any number of flavors; when we sign into a VPN, use a bank card at an ATM, or a card to gain access to a building or within public transport smart cards. These digital certificates are even found in petrol pumps, the robots on car assembly lines and even in our passports.

In Continental Europe and in many other countries, the use of client certificates is particularly widespread, with governments issuing ID cards that have multiple uses, such as to pay local taxes, electricity bills and for drivers’ licenses. And the reason why is simple—client certificates play a vital role in ensuring people are safe online.

What is a server certificate?
Server certificates typically are issued to hostnames, which could be a machine name (such as ‘XYZ-SERVER-01’) or domain name (such as ‘www.digicert.com’). A web browser reaching the server validates that the TLS/SSL server certificate is authentic. That tells the user that their interaction with the website has no eavesdroppers, and that the website is representing exactly who they claim they are. This security is critical for electronic commerce, which is why certificates are now in such widespread use.

## Understanding PKI Client Certificate Authentication

PKI client certificate authentication is a protocol that utilizes the power of public key cryptography to secure and authenticate data exchanges between systems. The operation of this protocol hinges on a pair of keys – a public key that is open to all and a private key that is kept confidential by the user. Paired with a digital certificate issued by a reputable Certificate Authority (CA), this duo forms a formidable security measure that enables communication that is not only secure, but also authenticated. It is this rigorous verification process that forms the cornerstone of PKI client certificate authentication, allowing it to adeptly deny access to unauthorized users or devices attempting to infiltrate the network.

## Implementing PKI Client Certificate Authentication

Initiating PKI client certificate authentication is a procedure that begins with procuring a digital certificate from a reliable Certificate Authority (CA). This certificate encompasses not only the public key but also the identity of the certificate owner. Following the acquisition, the certificate must be installed on the client device. Whenever this device attempts a connection to the network, it will present this certificate for validation. In return, the server cross-verify the certificate details with the original Certificate Authority. Upon successful validation, the server leverages the public key to code its response, which can then only be deciphered using the device’s private key, thus instituting a secure channel for communication. This approach ensures stringent access control, preventing unauthorized devices from connecting to the network.
