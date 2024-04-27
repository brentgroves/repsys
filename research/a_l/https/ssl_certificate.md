# SSL certificate

## references

<https://www.cloudflare.com/learning/ssl/what-is-an-ssl-certificate/>

## What is an SSL certificate?

An SSL certificate displays important information for verifying the owner of a website and encrypting web traffic with SSL/TLS, including the public key, the issuer of the certificate, and the associated subdomains.

## SSL Certificate Secure Browsing

SSL certificates are what enable websites to use HTTPS, which is more secure than HTTP. An SSL certificate is a data file hosted in a website's origin server. SSL certificates make SSL/TLS encryption possible, and they contain the website's public key and the website's identity, along with related information.

Devices attempting to communicate with the origin server will reference this file to obtain the public key and verify the server's identity. The private key is kept secret and secure.

## How do SSL certificates work?

SSL certificates include the following information in a single data file:

- The domain name that the certificate was issued for
- Which person, organization, or device it was issued to
- Which certificate authority issued it
- The certificate authority's digital signature
- Associated subdomains
- Issue date of the certificate
- Expiration date of the certificate
- The public key (the private key is kept secret)

The public and private keys used for SSL are essentially long strings of characters used for encrypting and signing data. Data encrypted with the public key can only be decrypted with the private key.

The certificate is hosted on a website's origin server, and is sent to any devices that request to load the website. Most browsers enable users to view the SSL certificate: in Chrome, this can be done by clicking on the padlock icon on the left side of the URL bar.
