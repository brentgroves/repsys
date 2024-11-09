# **[SPF: A practical guide](https://www.nslookup.io/learning/spf-a-practical-guide/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[DNS Provider Lookup](https://mxtoolbox.com/DnsLookup.aspx)**
- **[nslookup](https://www.nslookup.io/)**
- **[dns record types](https://www.nslookup.io/learning/dns-record-types/)**
- **[DNS Lookup](https://www.whoisfreaks.com/)**
- **[TXT lookup tool](https://www.nslookup.io/txt-lookup/)**
- **[MX lookup tool](https://www.nslookup.io/mx-lookup/)**
- **[NS lookup tool](https://www.nslookup.io/ns-lookup/)**
- **[SOA lookup tool](https://www.nslookup.io/soa-lookup/)**

Sender Policy Framework (SPF) records in the DNS identify the mail servers allowed to send email for a domain. SPF protects domains and their brands from email abuse by spammers and hackers.
The Simple Mail Transfer Protocol (SMTP) is used to send email. SMTP does not include validation that the sending mail server is allowed to send mail for a domain. So, anyone can use SMTP to send email that appears to be from any domain they wish. For example, a hacker might try to send phishing emails to Bank of America customers from <accounts@bankofamerica.com> to gain access to their bank accounts.

SPF addresses this weakness in SMTP. It identifies the mail servers permitted to send email for the domain. Email from a server not permitted by the SPF record will be discarded, quarantined, or placed in a spam folder.

SPF is specified in **[RFC 7208](https://datatracker.ietf.org/doc/html/rfc7208)**.

Only mail servers with the correct identity can deliver email.

## How SPF works

SPF records appear in the DNS as TXT records. The TXT record contains text that follows the SPF format. This record identifies the mail servers allowed to send email for the domain.

The receiving mail server extracts the domain from the Return-Path field as it receives each email message. A DNS TXT lookup is performed on this domain to retrieve the domain's SPF record. The source server of the email must be among the mail servers identified by the SPF record.

The most straightforward way to identify a mail server in SPF is by IP address. Below is an SPF record that allows the mail server with IP address 10.0.0.1 to send email for the example.org domain. No other servers are permitted to send email for the domain.

```example.org. 3600 TXT "v=spf1 ip4:10.0.0.1 -all"```

## Return-Path versus From

Email headers contain several "from" fields that each serve a different purpose. SPF uses the "Return-Path" field during validation.

Return-Path is the email address where bounce messages are sent. Mail servers use the domain portion of Return-Path to find the domain's SPF record. However, email clients usually display the From field to the user. The From field may contain a different domain.

This limitation of SPF is mitigated in two ways:

- Domain-based Message Authentication, Reporting, and Conformance (DMARC) adds a domain alignment policy. This policy requires that the From and Return-Path domains match.
- Modern email clients often flag messages where the From and Return-Path domains are different as unsafe.
