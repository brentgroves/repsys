# **[What’s the difference between client certificates vs. server certificates?](https://www.digicert.com/faq/public-trust-and-certificates/whats-the-difference-between-client-certificates-vs-server-certificates)**

**[Back to Research List](../../../research/research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## References

- **[How does SMTP work](https://aws.amazon.com/what-is/smtp/#:~:text=Gmail%20account%20credentials.-,How%20does%20SMTP%20work%3F,details%2C%20subject%2C%20and%20body)**.
- **[](https://www.cloudflare.com/learning/email-security/what-is-smtp/)**

## **[What are DMARC, DKIM, and SPF?](https://www.cloudflare.com/learning/email-security/dmarc-dkim-spf/#:~:text=Specifically%2C%20DKIM%20uses%20public%20key,email's%20header%20with%20this%20key)**

DMARC, DKIM, and SPF are three email authentication methods. Together, they help prevent spammers, phishers, and other unauthorized parties from sending emails on behalf of a domain* they do not own.

DKIM and SPF can be compared to a business license or a doctor's medical degree displayed on the wall of an office — they help demonstrate legitimacy.

Meanwhile, DMARC tells mail servers what to do when DKIM or SPF fail, whether that is marking the failing emails as "spam," delivering the emails anyway, or dropping the emails altogether.

Domains that have not set up SPF, DKIM, and DMARC correctly may find that their emails get quarantined as spam, or are not delivered to their recipients. They are also in danger of having spammers impersonate them.

*A domain, roughly speaking, is a website address like "example.com". Domains form the second half of an email address: <alice@example.com>, for instance.

## How does SPF work?

Sender Policy Framework (SPF) is a way for a domain to list all the servers they send emails from. Think of it like a publicly available employee directory that helps someone to confirm if an employee works for an organization.

SPF records list all the IP addresses of all the servers that are allowed to send emails from the domain, just as an employee directory lists the names of all employees for an organization. Mail servers that receive an email message can check it against the SPF record before passing it on to the recipient's inbox.

## How does DKIM work?

DomainKeys Identified Mail (DKIM) enables domain owners to automatically "sign" emails from their domain, just as the signature on a check helps confirm who wrote the check. The DKIM "signature" is a digital signature that uses cryptography to mathematically verify that the email came from the domain.

Specifically, DKIM uses public key cryptography:

- A DKIM record stores the domain's public key, and mail servers receiving emails from the domain can check this record to obtain the public key
- The private key is kept secret by the sender, who signs the email's header with this key
- Mail servers receiving the email can verify that the sender's private key was used by applying the public key

## How does DMARC work?

Domain-based Message Authentication Reporting and Conformance (DMARC) tells a receiving email server what to do given the results after checking SPF and DKIM. A domain's DMARC policy can be set in a variety of ways — it can instruct mail servers to quarantine emails that fail SPF or DKIM (or both), to reject such emails, or to deliver them.

DMARC policies are stored in DMARC records. A DMARC record can also contain instructions to send reports to domain administrators about which emails are passing and failing these checks. DMARC reports give administrators the information they need to decide how to adjust their DMARC policies (for example, what to do if legitimate emails are erroneously getting marked as spam).

## Specifically, DKIM uses public key cryptography

A DKIM record stores the domain's public key, and mail servers receiving emails from the domain can check this record to obtain the public key
The private key is kept secret by the sender, who signs the email's header with this key
Mail servers receiving the email can verify that the sender's private key was used by applying the public key

## Where are SPF, DKIM, and DMARC records stored?

SPF, DKIM, and DMARC records are stored in the Domain Name System (DNS), which is publicly available. The DNS's main use is matching web addresses to IP addresses, so that computers can find the correct servers for loading content over the Internet without human users having to memorize long alphanumeric addresses. The DNS can also store a variety of records associated with a domain, including alternate names for that domain (CNAME records), IPv6 addresses (AAAA records), and reverse DNS records for domain lookups (PTR records).

DKIM, SPF, and DMARC records are all stored as DNS TXT records. A DNS TXT record stores text that a domain owner wants to associate with the domain. This record can be used in a variety of ways, since it can contain any arbitrary text. DKIM, SPF, and DMARC are three of several applications for DNS TXT records.

## What is the Simple Mail Transfer Protocol (SMTP)?

The Simple Mail Transfer Protocol (SMTP) is a technical standard for transmitting electronic mail (email) over a network. Like other networking protocols, SMTP allows computers and servers to exchange data regardless of their underlying hardware or software. Just as the use of a standardized form of addressing an envelope allows the postal service to operate, SMTP standardizes the way email travels from sender to recipient, making widespread email delivery possible.

SMTP is a mail delivery protocol, not a mail retrieval protocol. A postal service delivers mail to a mailbox, but the recipient still has to retrieve the mail from the mailbox. Similarly, SMTP delivers an email to an email provider's mail server, but separate protocols are used to retrieve that email from the mail server so the recipient can read it.

## How does SMTP work?

All networking protocols follow a predefined process for exchanging data. SMTP defines a process for exchanging data between an email client and a mail server. An email client is what a user interacts with: the computer or web application where they access and send emails. A mail server is a specialized computer for sending, receiving, and forwarding emails; users do not interact directly with mail servers.

Here is a summary of what passes between the email client and the mail server for an email to begin sending:

- **SMTP connection opened:** Since SMTP uses the Transmission Control Protocol (TCP) as its transport protocol, this first step begins with a TCP connection between client and server. Next, the email client begins the email sending process with a specialized "Hello" command (HELO or EHLO, described below).
- **Email data transferred:** The client sends the server a series of commands accompanied with the actual content of the email: the email header (including its destination and subject line), the email body, and any additional components.
- **Mail Transfer Agent (MTA):** The server runs a program called a Mail Transfer Agent (MTA). The MTA checks the domain of the recipient's email address, and if it differs from the sender's, it queries the Domain Name System (DNS) to find the recipient's IP address. This is like a post office looking up a mail recipient's zip code.
- **Connection closed:** The client alerts the server when transmission of data is complete, and the server closes the connection. At this point the server will not receive additional email data from the client unless the client opens a new SMTP connection.

Usually, this first email server is not the actual email's final destination. The server, having received the email from the client, repeats this SMTP connection process with another mail server. That second server does the same, until finally the email reaches the recipient's inbox on a mail server controlled by the recipient's email provider.

Compare this process to the way a piece of mail travels from sender to recipient. A mail carrier does not take a letter directly from the sender to its recipient. Instead, the mail carrier brings the letter back to their post office. The post office ships the letter to another post office in another town, then another, and so on until the letter reaches the recipient. Similarly, emails go from server to server via SMTP until they arrive at the recipient's inbox.

## What is an SMTP envelope?

The SMTP "envelope" is the set of information that the email client sends the mail server about where the email comes from and where it is going. The SMTP envelope is distinct from the email header and body and is not visible to the email recipient.

## What are SMTP commands?

SMTP commands are predefined text-based instructions that tell a client or server what to do and how to handle any accompanying data. Think of them as buttons the client can press to get the server to accept data correctly.

HELO/EHLO: These commands say "Hello" and start off the SMTP connection between client and server. "HELO" is the basic version of this command; "EHLO" is for a specialized type of SMTP.
MAIL FROM: This tells the server who is sending the email. If Alice were trying to email her friend Bob, a client might send "MAIL FROM:<alice@example.com>".
RCPT TO: This command is for listing the email's recipients. A client can send this command multiple times if there are multiple recipients. In the example above, Alice's email client would send "RCPT TO:<bob@example.com>".
DATA: This precedes the content of the email, like:

DATA
Date: Mon, 4 April 2022
From: Alice <alice@example.com>
Subject: Eggs benedict casserole
To: Bob <bob@example.com>

Hi Bob,
I will bring the eggs benedict casserole recipe on Friday.
-Alice
.
RSET: This command resets the connection, removing all previously transferred information without closing the SMTP connection. RSET is used if the client sent incorrect information.
QUIT: This ends the connection.

## What is an SMTP server?

An SMTP server is a mail server that can send and receive emails using the SMTP protocol. Email clients connect directly with the email provider's SMTP server to begin sending an email. Several different software programs run on an SMTP server:

- **Mail submission agent (MSA):** The MSA receives emails from the email client.
- **Mail transfer agent (MTA):** The MTA transfers emails to the next server in the delivery chain. As described above, it may query the DNS to find the recipient domain's mail exchange (MX) DNS record if necessary.
- **Mail delivery agent (MDA):** The MDA receives emails from MTAs and stores them in the recipient's email inbox.

DNS records (SPF, DKIM, DMARC). DKIM keys are rotated quarterly

## What is Extended SMTP (ESMTP)?

Extended Simple Mail Transfer Protocol (ESMTP) is a version of the protocol that expands upon its original capabilities, enabling the sending of email attachments, the use of TLS, and other capabilities. Almost all email clients and email services use ESMTP, not basic SMTP.

ESMTP has some additional commands, including "EHLO", an "extended hello" message that enables the use of ESMTP at the start of the connection.

**DomainKeys Identified Mail (DKIM)** is an email security standard that uses public-key cryptography to verify the authenticity of emails. DKIM works by attaching a digital signature to an email, which is then checked by the recipient's mail server to ensure the email is genuine:
Signing: The sender uses their private key to sign the email's header.
Storing: The domain's public key is stored in a DKIM record.
Verifying: The recipient's mail server uses the public key from the DKIM record to verify that the sender's private key was used to sign the email. If the signature verifies, the email is considered authentic and passes DKIM.

## How does SMTP work?

In the Simple Mail Transfer Protocol (SMTP) model, the sender's email client or server acts as the SMTP client, and the sender’s email server acts as the SMTP server. This client initiates a connection to the server and transmits the email, complete with recipient details, subject, and body. The server processes this email and determines the suitable next server based on the recipient's address. This next server could either be another SMTP server in the transmission route or the final destination, i.e., the recipient's email server. Once the message arrives at the recipient's server, it's delivered to the recipient's inbox using a different protocol, such as POP or IMAP.

## How do SMTP servers send emails?

SMTP servers send emails by following a series of steps. First, the sender's email client or server establishes a connection with the recipient's SMTP server and supplies necessary information, such as the recipient’s email address. The SMTP server then processes this information and verifies the recipient's address to decide whether accept the email or not. If the recipient's address is valid, the email is queued for delivery. The recipient's server then attempts to deliver the email to the recipient's email inbox or a designated folder.
