# **[What is a Domain-based Message Authentication, Reporting & Conformance (DMARC) policy?](https://www.cloudflare.com/learning/dns/dns-records/dns-dmarc-record/#:~:text=What%20is%20a%20DMARC%20policy,delivered%20to%20its%20intended%20recipient.)**

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

## Domain-based Message Authentication, Reporting & Conformance (DMARC)

DMARC is specified in **[RFC 7489](https://datatracker.ietf.org/doc/html/rfc7489)**. DMARC uses DNS TXT records to specify email policy for a domain. The policy specifies what action to take if SPF or DKIM checks fail on email received from the domain.

Like the DKIM record, the DMARC record is not created at root of the domain. An example is shown below. This example specifies that mail which does not pass DMARC checks should be placed in quarantine. Reports should be sent to <admin@example.org>.

```_dmarc.example.org. 3600 TXT "v=DMARC1; p=quarantine; rua=mailto:admin@example.org"```

## What is DMARC?

Domain-based Message Authentication Reporting and Conformance (DMARC) is a method of authenticating email messages. A DMARC policy tells a receiving email server what to do after checking a domain's Sender Policy Framework (SPF) and DomainKeys Identified Mail (DKIM) records, which are additional email authentication methods.

DMARC and other email authentication methods are necessary in order to prevent email spoofing. Every email address has a domain, which is the portion of the address that comes after the "@" symbol. Malicious parties and spammers sometimes try to send emails from a domain that they are not authorized to use — like someone writing the wrong return address on a letter. They may do this to try to trick users (as in a phishing attack), among other reasons.

Together, DMARC, DKIM, and SPF function like a background check on email senders, to make sure they really are who they say they are.

For example, imagine a spammer sends an email from the address,"<trustworthy@example.com>," despite the fact that they are not authorized to send email from the "example.com" domain. The spammer would do this by replacing the "From" header in the email with "<trustworthy@example.com>" — they would not send an email from the actual example.com email server. Email servers that receive this email can use DMARC, SPF, and DKIM to discover that this is an unauthorized email, and they can mark the email message as spam or refuse to deliver it.

## What is a DMARC policy?

A DMARC policy determines what happens to an email after it is checked against SPF and DKIM records. An email either passes or fails SPF and DKIM. The DMARC policy determines if failure results in the email being marked as spam, getting blocked, or being delivered to its intended recipient. (Email servers may still mark emails as spam if there is no DMARC record, but DMARC provides clearer instructions on when to do so.)

Example.com's domain policy could be:

"If an email fails the DKIM and SPF tests, mark it as spam."

These policies are not recorded as human-readable sentences, but rather as machine-readable commands so that email services can interpret them automatically. That DMARC policy would actually look like:

```v=DMARC1; p=quarantine; adkim=s; aspf=s;```

What does this mean?

- v=DMARC1 indicates that this TXT record contains a DMARC policy and should be interpreted as such by email servers.
- p=quarantine indicates that email servers should "quarantine" emails that fail DKIM and SPF — considering them to be potentially spam. Other possible settings for this include p=none, which allows emails that fail to still go through, and p=reject, which instructs email servers to block emails that fail.
- adkim=s means that DKIM checks are "strict." This can also be set to "relaxed" by changing the s to an r, like adkim=r.
- aspf=s is the same as adkim=s, but for SPF.
- Note that aspf and adkim are optional settings. The p= attribute is what indicates what email servers should do with emails that fail SPF and DKIM.

If the example.com administrator wanted to make this policy even stricter and signal more strongly to email servers to consider unauthorized messages spam, they would adjust the "p=" attribute like so:

```v=DMARC1; p=reject; adkim=s; aspf=s;```

Essentially, this says: "If an email fails the DKIM and SPF tests, do not deliver it."

## What is a DMARC report?

DMARC policies can contain instructions to send reports about emails that pass or fail DKIM or SPF. Typically, administrators set up reports to be sent to a third-party service that boils them down to a more digestible form, so administrators are not overwhelmed with information. DMARC reports are extremely important because they give administrators the information they need to decide how to adjust their DMARC policies — for instance, if their legitimate emails are failing SPF and DKIM, or if a spammer is trying to send illegitimate emails.

The example.com administrator would add the rua part of this policy to send their DMARC reports to a third-party service (with an email address of "<example@third-party-example.com>"):

```v=DMARC1; p=reject; adkim=s; aspf=s; rua=mailto:example@third-party-example.com;```

## What is a DMARC record?

A DMARC record stores a domain's DMARC policy. DMARC records are stored in the Domain Name System (DNS) as DNS TXT records. A DNS TXT record can contain almost any text a domain administrator wants to associate with their domain. One of the ways DNS TXT records are used is to store DMARC policies.

(Note that a DMARC record is a DNS TXT record that contains a DMARC policy, not a specialized type of DNS record.)

Example.com's DMARC policy might look like this:

| Name               | Type | Content                                                                              | TTL   |
|--------------------|------|--------------------------------------------------------------------------------------|-------|
| _dmarc.example.com | TXT  | v=DMARC1; p=quarantine; adkim=r; aspf=r; rua=mailto:example@third-party-example.com; | 32600 |

Within this TXT record, the DMARC policy is contained in the "Content" field.

## What about domains that do not send emails?

Domains that do not send emails should still have a DMARC record in order to prevent spammers from using the domain. The DMARC record should have a DMARC policy that rejects all emails that fail SPF and DKIM — which should be all emails sent by that domain.

In other words, if example.com was not configured to send email, all emails would fail SPF and DKIM and be rejected.
