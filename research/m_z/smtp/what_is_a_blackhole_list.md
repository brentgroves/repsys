# **[DNSBL (Domain Name System-based Blackhole List)](https://www.ionos.com/digitalguide/server/know-how/dnsbl/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

![ci](https://www.godaddy.com/resources/ae/wp-content/uploads/sites/11/how-to-connect-your-domain-name-hosting-account.jpg?size=1920x0)

Even in times of Facebook, WhatsApp, and endless kinds of collaboration tools, email plays a big role in digital communication. For a secure and pleasant experience in your inbox, it is just as relevant now as ever to know how to recognize and prevent spam. Even decades after the first spam messages were sent, it is important to maintain a certain sense of caution with your emails.

In practice, high-performance security mechanisms, such as **[greylisting](https://www.ionos.com/digitalguide/e-mail/e-mail-security/what-is-greylisting/)**, catch the most annoying or dangerous emails. One important part of these mechanisms are Domain Name System-based Blackhole Lists (DNSBL) – blocklists for questionable sender addresses that can be retrieved in real-time. Keep reading to find out what a DNS-based Blackhole List is, how exactly it works, and what advantages and disadvantages it has.

## What is a DNSBL (Domain Name System-based Blackhole List)?

A Domain Name System-based Blackhole List (DNS-based Blackhole List or DNSBL for short) is a service that email servers can use to quickly check the spam potential of IP addresses. A DNSBL has access to a list of addresses that are known senders of spam. A querying mail server can inspect the list in real-time using a DNS request. Most server software can be configured to consult several DNS-based Blackhole Lists, providing the user with even better protection against unwanted junk mail. If the DNSBL query comes up with a hit, the message coming from that **[email address will be blocked or marked as spam](https://www.ionos.com/digitalguide/e-mail/technical-matters/how-to-block-emails/)**.

## Note 1

In the context of computer networks, the term “blackhole” refers to a connection in which incoming or outgoing traffic is dropped rather than forwarded and the data source is not informed.

## Real-time Blackhole List: The first Domain Name System-based Blackhole List

When reading about DNSBL, you’ll probably come across the term Real-time Blackhole List (RBL). Sometimes the terms are used interchangeably, although this isn’t quite correct. A Real-time Blackhole List is one available DNSBL and admittedly a very important one. As a part of the anti-spam initiative Mail Abuse Prevention Systems (MAPS), it became the first official DNS-based Blackhole List in 1997.

Originally, the computer scientist behind RBL, Paul Vixie, published the spam blocklist (also known as “blacklist”, which is politically incorrect today) as BGP Feed (Border Gateway Protocol) rather than as a DNSBL. The feed contained a list of known spam addresses that was sent to subscribers’ routers using the BGP protocol. Eric Ziegast, a developer working with Vixie on the MAPS project, initiated the transition to the more effective DNS-based transmission.

## Note 2

In addition to RBL, there are now countless other DNSBLs, such as the Spamhouse Block List (SBL), SORBS (Spam and Open Relay Blocking System) and ASPEWS (Another Spam Prevention Early Warning System). These lists mostly differ with respect to their goals (which type of IP addresses are listed - individual, ISPs, proxies, etc.), their sources (where the IP addresses listed come from) and their lifespan (how long IPs are listed for).

## **How do DNS-based Blackhole Lists work?**

Three things are required to run a DNSBL query service:

1. A domain at which the Domain Name System-based Blackhole List can be hosted
2. A name server for this domain (for address resolution)
3. A list of IP addresses that should be made available (via DNS query)

The most difficult part of maintaining a DNSBL, without a doubt, is building the list itself. Operators need to develop a clear strategy and stick to it long-term to gain and maintain users’ trust. Specific policies that are made public give an impression of what it means to be listed in the DNSBL and how the list positions itself in terms of the three points listed above (goals, source(s), and lifespan).

On the side of the mail servers that have chosen a DNS-based Blackhole List to check for spam, the service is simple:

1. The order of the octets in the sender’s IP address are reversed. For example, 192.168.11.12 will become 12.11.168.192.
2. The domain name of the DNSBL is added - 12.11.168.192.dnsbl.example.net.
3. The name server of the blocklist is checked to see whether there is a fitting A record for the address. If so, the address is sent back to the mail server, indicating that the client is on the blocklist. If the address isn’t listed, the code “NXDOMAIN” is sent.
4. If an IP is listed in the DNSBL, the mail server also has the option of looking up the name as a text entry (TXT record). This is often a way to find out why the client in question is on the list.

## Note 3

Querying a DNS-based Blackhole List works similarly to a Reverse DNS Lookup. The main difference between the two query types lies in the record type: In the case of a rDNS query, the **[PTR record](https://www.ionos.com/digitalguide/hosting/technical-matters/ptr-record/)** is looked up instead of the A record.
