# **[Domain Keys Identified Mail (DKIM)](https://www.nslookup.io/learning/dns-record-types/txt/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[nslookup](https://www.nslookup.io/)**
- **[dns record types](https://www.nslookup.io/learning/dns-record-types/)**
- **[DNS Lookup](https://www.whoisfreaks.com/)**

## Domain Keys Identified Mail (DKIM)

DKIM is specified in RFC 6376. DKIM uses DNS TXT records to publish the public key from a domain's public-private key pair. This public key is used to securely validate emails signed with a digital signature.

Unlike SPF records, the DNS TXT record for DKIM is not created at the root of the domain. The string following "p=" in the record data of the TXT is a public key. An example DKIM record for the example.org domain is shown below. (The public key is truncated for readability.)

```default._domainkey.example.org. 3600 TXT "v=DKIM1;t=s;p=MIGfMA0GCSqGS..."```

## How it dkim may be used

- Before sending an email the header is hashed and encrypted using an assymetrical encryption algorith's private key.
- The email is delivered to the recipient's smtp server.
- The recipient server retrieves DKIM public key by using a DNS TXT lookup from the appropriate zone database.
- The recipient server uses DKIM public key to decrypt and then dehashes the signature.
- The recipient server compares the actual email header with the decrypted and dehashed signature and if these match we know the email was sent by that domain/zone.
