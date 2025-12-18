# Database and website security

Hi Team,

We have tools to identify SSL/TLS vulnerabilities in our databases and websites. If you have a database or website you would like checked, please ask.

What we can check for:

- Types of authentication supported
- SSL/TLS versions enabled
- Server name in the SAN extension field
- Certificate signer in system trust store
- Valid certificate key usage and expiration dates
- Server-side firewall ruleset IP range restrictions

I'm sharing what we found about the Structures Azure SQL database, repsys1.database.windows.com.

- MFA authentication support
- TLS 1.3 enabled
- server name in SAN, the extension field
- Certificate signer in system trust store
- Certificate not expired
- Only certain IP address allowed to connect

What we can aim for:

- TLS 1.3 enabled and used
- MFA authentication support
- Valid signer key usage
- No expired certificates
- Optional mTLS support for websites
- Server-side IP range restrictions

Team:

Christian. Trujillo, IT Structures Manager
Brent Hall, System Administrator Senior
Kevin Young, Information Systems Manager
Jared Davis, IT Manager
Hayley Rymer, IT Supervisor, Mills River
Mitch Harper, Desktop and Systems Support Technician, Mills River
Thomas.Creal, Desktop and Systems Support Technician, Mills River
Matthew Bump, Muscle Shoals, Engineering Supervisor II / IT
Sam Jackson, Information Systems Developer, Southfield
Matt Irey, Desktop and System Support Technician, Fruitport
David Maitner,  Desktop and System Support Technician, Fruitport
Carl Stangland, Desktop and System Support Technician, Indiana
Lucas Tuma, IT Administrator, Strakonice
Aleksandar Gavrilov, IT Administrator, Skopje

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/> by copying and pasting the contents below.

## SSL/TSL References

- **[Cipher suites](https://www.ssldragon.com/blog/cipher-suites/)** contain a key exchange, encryption, message authentication code, and pseudorandom function.
- **[Security Levels](https://www.feistyduck.com/library/openssl-cookbook/online/openssl-command-line/understanding-security-levels.html)** are used to catagorize each cypher suites.
- The reason to use **[TLS 1.3 instead of TLS 1.3](https://www.a10networks.com/glossary/key-differences-between-tls-1-2-and-tls-1-3/#:~:text=As%20with%20SSL%2C%20TLS%20relies,%E2%80%9D%20(0%2DRTT).)** is that it is faster, supports simpler and stronger cipher suites.
- The main tool used to implement Structures **[Public Key Infrastructure, PKI,](https://www.keyfactor.com/education-center/what-is-pki/)**  is **[OpenSSL](https://www.ssldragon.com/blog/what-is-openssl/)**
- **[SSL/TLS Analysis & Attacks](https://hackmd.io/@secureitmania/HJQIwoA9n)**
