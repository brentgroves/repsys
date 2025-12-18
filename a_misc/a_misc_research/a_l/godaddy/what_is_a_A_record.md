# **[What is a DNS A record?](https://www.cloudflare.com/learning/dns/dns-records/dns-a-record/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

![ci](https://www.godaddy.com/resources/ae/wp-content/uploads/sites/11/how-to-connect-your-domain-name-hosting-account.jpg?size=1920x0)

The "A" stands for "address" and this is the most fundamental type of DNS record: it indicates the IP address of a given domain. For example, if you pull the DNS records of cloudflare.com, the A record currently returns an IP address of: 104.17.210.9.

A records only hold IPv4 addresses. If a website has an IPv6 address, it will instead use an **["AAAA" record](https://www.cloudflare.com/learning/dns/dns-records/dns-aaaa-record/)**.

Here is an example of an A record:

| example.com | record type: |   value:  |  TTL  |
|:-----------:|:------------:|:---------:|:-----:|
|      @      |       A      | 192.0.2.1 | 14400 |

The "@" symbol in this example indicates that this is a record for the root domain, and the "14400" value is the **[TTL (time to live)](https://www.cloudflare.com/learning/cdn/glossary/time-to-live-ttl/)**, listed in seconds. The default TTL for A records is 14,400 seconds. This means that if an A record gets updated, it takes 240 minutes (14,400 seconds) to take effect.

The vast majority of websites only have one A record, but it is possible to have several. Some higher profile websites will have several different A records as part of a technique called round robin load balancing, which can distribute request traffic to one of several IP addresses, each hosting identical content.

## When are DNS A records used?

The most common usage of A records is IP address lookups: matching a domain name (like "cloudflare.com") to an IPv4 address. This enables a user's device to connect with and load a website, without the user memorizing and typing in the actual IP address. The user's web browser automatically carries this out by sending a query to a DNS resolver.

DNS A records are also used for operating a Domain Name System-based Blackhole List (DNSBL). DNSBLs can help mail servers identify and block email messages from known spammer domains.

If you want to learn more about DNS A records, you can see the original 1987 RFC where A records and several other DNS record types are defined here. To learn more about how the Domain Name System works, see What is DNS?

```bash
dig repsys.dev a 

; <<>> DiG 9.18.28-0ubuntu0.22.04.1-Ubuntu <<>> repsys.dev a
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 19784
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;repsys.dev.                    IN      A

;; ANSWER SECTION:
repsys.dev.             600     IN      A       15.197.148.33
repsys.dev.             600     IN      A       3.33.130.190

;; Query time: 81 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Tue Dec 31 13:46:56 EST 2024
;; MSG SIZE  rcvd: 71
```
