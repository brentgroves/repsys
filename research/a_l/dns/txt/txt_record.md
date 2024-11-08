# **[The TXT record](https://www.nslookup.io/learning/dns-record-types/txt/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[nslookup](https://www.nslookup.io/)**
- **[dns record types](https://www.nslookup.io/learning/dns-record-types/)**
- **[DNS Lookup](https://www.whoisfreaks.com/)**

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
