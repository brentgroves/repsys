# **[The TXT record](https://www.nslookup.io/learning/dns-record-types/txt/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[DNS Checker](https://dnschecker.org/)**
- **[DNS Provider Lookup](https://mxtoolbox.com/DnsLookup.aspx)**
- **[nslookup](https://www.nslookup.io/)**
- **[dns record types](https://www.nslookup.io/learning/dns-record-types/)**
- **[DNS Lookup](https://www.whoisfreaks.com/)**
- **[TXT lookup tool](https://www.nslookup.io/txt-lookup/)**
- **[MX lookup tool](https://www.nslookup.io/mx-lookup/)**
- **[NS lookup tool](https://www.nslookup.io/ns-lookup/)**
- **[SOA lookup tool](https://www.nslookup.io/soa-lookup/)**

The TXT or “descriptive text” DNS record type was created to hold human-readable text. It now plays a critical role in the prevention of spam on the Internet.
The TXT record type was introduced in the original DNS specifications (**[RFC 1034](https://datatracker.ietf.org/doc/html/rfc1034)** and **[RPF 1035](https://datatracker.ietf.org/doc/html/rfc1035)**) in 1987. They were to be used for notes and text created by DNS administrators. There was originally no definitive purpose for TXT records. They were used for whatever information the DNS administrator thought was useful. This included contact information, the locations and owners of machines, humorous messages, and other administrivia.

TXT records were used this way until 2003. In 2003 efforts began to fight back against spam and other abuses of email. This led to the creation of **[SPF (Sender Policy Framework)](https://www.nslookup.io/learning/spf-a-practical-guide/)**. SPF stores email authority information in TXT records. Other uses for the TXT record type have been added over the years.

Formatless TXT records have become messy over the years.

## TXT record format

The **[RPF 1035](https://datatracker.ietf.org/doc/html/rfc1035)** definition of the record data for TXT record is one or more “character-strings”. Each character string can be at most 255 characters long.

TXT records also have a Time-to-Live value in seconds, like all other DNS records. A simple example TXT record for example.org with a TTL of 3600 seconds (one hour) might look like this:

```example.org. 3600 TXT "Welcome to the example domain!"```

There are a few somewhat confusing aspects of TXT records. Namely, the use of quotation marks and multiple character strings. Quotation marks are not necessary if you are working with TXT records in a DNS provider's web portal. When editing a traditional zone file, quotation marks are required around each string.

Each TXT record can contain multiple character strings. Each character string may contain up to 255 characters. Multiple TXT records may also exist at a single name in the DNS. See our 'related questions' section below for more details.

The examples on this page will use DNS zone file format so will contain quotation marks.

## A real world TXT example

Let's examine the actual TXT response for icann.org. At the time this page was written, the TXT response using dig or our **[TXT lookup tool](https://www.nslookup.io/txt-lookup/)** is:

```text
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 18975
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;icann.org.                     IN      TXT

;; ANSWER SECTION:
icann.org.              600     IN      TXT     "v=spf1 ip4:192.0.32.0/20 ip4:199.91.192.0/21 ip4:64.78.40.0/27 ip4:162.216.194.0/27 ip4:64.78.33.5/32 ip4:64.78.33.6/31 ip4:64.78.48.205/32 ip4:64.78.48.206/31"
                                                " ip6:2620:0:2d0::0/48 ip6:2620:0:2830::0/48 ip6:2620:0:2ed0::0/48 include:salesforce.icann.org -all"
```

The DNS administrator for ICANN has followed SPF requirements and created a single TXT record with two strings. There are two strings because the total length of the SPF record is longer than 255 characters.

Also note that quotation marks surround each character string. These quotation marks are not part of the TXT data. Dig included them so we can see where each string begins and ends.

## Uses of the TXT record type

The TXT record was intended for free-form text entered by DNS administrators. Use of the TXT record has been expanded to other applications over the years.

Today, TXT records are mainly used for:

- SPF — Sender Policy Framework
- DKIM — Domain Keys Identified Mail
- DMARC — Domain-based Message Authentication, Reporting & Conformance
- MTA-STS — SMTP MTA Strict Transport Security
- Domain verification
- DNS-SD — DNS Service Discovery

## SMTP MTA Strict Transport Security (MTA-STS)

MTA-STS is specified in RFC 8461. MTA-STS allows a mail service provider to declare it accepts Transport Layer Security (TLS) to secure SMTP connections. It can also specify if other SMTP servers should refuse to deliver email to the domain if TLS is unavailable.

Below is a simple example of a TXT record for MTA-STS. The existence of this record signals that SMTP servers should attempt to retrieve the MTA-STS policy for the example.org domain using an HTTPS get request. This record also gives the current policy ID.

_mta-sts.example.org. 3600 TXT "v=STSv1; id=20220601120000Z;"

## Domain verification

In recent years it has become popular to use a DNS TXT record to prove ownership of a domain. A service provider gives the domain's administrator a challenge string. The administrator must publish the challenge string in a TXT record in their DNS zone. The service provider performs a DNS query for the TXT record and verifies that the challenge string has been published. This proves that the administrator controls DNS for the domain.

The format of the domain verification TXT record varies with provider. Always follow your provider's instructions exactly. The name of the service is usually included in the challenge string, so to verify a domain with Google the record might look something like this:

```example.org. 3600 TXT "google=6e6922db-e3e6-4a36-904e-a805c28087fa"```

The IETF draft **[sahib-domain-verification-techniques](https://www.ietf.org/archive/id/draft-sahib-domain-verification-techniques-03.html)** contains a survey of current uses of this method.

## DNS Service Discovery (DNS-SD)

DNS-SD is specified in **[RFC 6763](https://datatracker.ietf.org/doc/html/rfc6763)**. DNS-SD allows services to be discovered by application clients through the DNS. This is an alternative to SRV records. The record data of the TXT record contains a set of key/value pairs preceded by length bytes. DNS-SD is not currently in widespread use.

**DNS provider** is that hosts your domain and uses Domain Name System (DNS) records to unite your domain with email, websites, and other web services. You're able to access the DNS zone provided by your domain host to manage the DNS records. These records are absolutely essential to keep your website and emails running
