# Albion PKI engineering system TCP access to Albion's Mach2 MES servers

Request: RITM0187718

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

Project: Structures **[Public Key Infrastructure](https://www.okta.com/identity-101/public-key-infrastructure/#:~:text=PKI%2C%20or%20public%20key%20infrastructure,store%2C%20and%20revoke%20digital%20certificates.)**

Request: Please give the Albion Information System PKI engineering system access to Albion's Mach2 **[MES](https://en.wikipedia.org/wiki/Manufacturing_execution_system#:~:text=Manufacturing%20execution%20systems%20(MES)%20are,and%20actions%20may%20be%20required.)** servers.

Reason: So our PKI **[platform engineer](https://spacelift.io/blog/what-is-a-platform-engineer)** can use **[OpenSSL](https://www.ssldragon.com/blog/what-is-openssl/#:~:text=Frequently%20Asked%20Questions,Copy%20Link)** to debug a current server certifcate issue and monitor its status in the future.

Business Justification: The Structures Information System department has been tasked to manage a Public Key Infrastructure (PKI) to establish trust and secure digital communications by verifying identities, enabling encryption, and ensuring data integrity, ultimately enhancing security and compliance.

## Requested Policy Change

Please give the Albion Information System **[PKI](<https://en.wikipedia.org/wiki/Public_key_infrastructure#:~:text=A%20public%20key%20infrastructure%20(PKI,of%20a%20public%20key%20infrastructure)>** engineering system TCP access to Albion's Mach2 **[MES](https://en.wikipedia.org/wiki/Manufacturing_execution_system#:~:text=Manufacturing%20execution%20systems%20(MES)%20are,and%20actions%20may%20be%20required.)** servers.

## Key points about the firewall rule

- Protocol: TCP
- Port: 80/443
- Action: Allow
- Source: 10.187.40.123
- Destinations: 10.187.220.[50-60]

## Test Process

1. Create server certifcate using the structures PKI for each Albion Mach2 MES server.
2. Bundle private key, server certifcate, intermediate and root CA certificates in PEM file format.
3. Import new certificate bundle into each Mach2 MES server.
4. Use OpenSSL to verify each Mach2 MES server is serving the correct certificate bundle.

## Certificate chain verification

```bash
# Verify certificate is being used
openssl s_client -showcerts -connect 10.187.220.51:443 -servername pd-alb-mach2-s1 -CApath /etc/ssl/certs -
```
