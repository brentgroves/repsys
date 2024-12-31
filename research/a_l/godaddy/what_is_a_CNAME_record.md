# **[What is a DNS CNAME record?](https://www.cloudflare.com/learning/dns/dns-records/dns-cname-record/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

![ci](https://www.godaddy.com/resources/ae/wp-content/uploads/sites/11/how-to-connect-your-domain-name-hosting-account.jpg?size=1920x0)

A "canonical name" (CNAME) record points from an alias domain to a "canonical" domain. A CNAME record is used in lieu of an **[A record](https://www.cloudflare.com/learning/dns/dns-records/dns-a-record/)**, when a domain or subdomain is an alias of another domain. All CNAME records must point to a domain, never to an IP address. Imagine a scavenger hunt where each clue points to another clue, and the final clue points to the treasure. A domain with a CNAME record is like a clue that can point you to another clue (another domain with a CNAME record) or to the treasure (a domain with an A record).

For example, suppose blog.example.com has a CNAME record with a value of "example.com" (without the "blog"). This means when a DNS server hits the DNS records for blog.example.com, it actually triggers another DNS lookup to example.com, returning example.com’s IP address via its A record. In this case we would say that example.com is the canonical name (or true name) of blog.example.com.

Oftentimes, when sites have subdomains such as blog.example.com or shop.example.com, those subdomains will have CNAME records that point to a root domain (example.com). This way if the IP address of the host changes, only the DNS A record for the root domain needs to be updated and all the CNAME records will follow along with whatever changes are made to the root.

A frequent misconception is that a CNAME record must always resolve to the same website as the domain it points to, but this is not the case. The CNAME record only points the client to the same IP address as the root domain. Once the client hits that IP address, the web server will still handle the URL accordingly. So for instance, blog.example.com might have a CNAME that points to example.com, directing the client to example.com’s IP address. But when the client actually connects to that IP address, the web server will look at the URL, see that it is blog.example.com, and deliver the blog page rather than the home page.

Example of a CNAME record:

| blog.example.com | record type: | value:                     | TTL   |
|------------------|--------------|----------------------------|-------|
| @                | CNAME        | is an alias of example.com | 32600 |

In this example you can see that blog.example.com points to example.com, and assuming it is based on our **[example A record](https://www.cloudflare.com/learning/dns/dns-records/dns-a-record/)** we know that it will eventually resolve to the IP address 192.0.2.1.

```bash
dig rwmt1._domainkey.repsys.dev cname


; <<>> DiG 9.18.28-0ubuntu0.22.04.1-Ubuntu <<>> rwmt1._domainkey.repsys.dev cname
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 13475
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;rwmt1._domainkey.repsys.dev.   IN      CNAME

;; ANSWER SECTION:
rwmt1._domainkey.repsys.dev. 3600 IN    CNAME   rwmt1.dkim.smtp.mailtrap.live.

;; Query time: 81 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Tue Dec 31 13:57:27 EST 2024
;; MSG SIZE  rcvd: 99

```

```bash
dig email.repsys.dev cname 


; <<>> DiG 9.18.28-0ubuntu0.22.04.1-Ubuntu <<>> email.repsys.dev cname
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 37742
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;email.repsys.dev.              IN      CNAME

;; ANSWER SECTION:
email.repsys.dev.       3600    IN      CNAME   email.secureserver.net.

;; Query time: 86 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Tue Dec 31 13:55:09 EST 2024
;; MSG SIZE  rcvd: 81


```
