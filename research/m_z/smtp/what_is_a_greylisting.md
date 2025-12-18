# **[What is greylisting? Definition, advantages and disadvantages](https://www.ionos.com/digitalguide/e-mail/e-mail-security/what-is-greylisting/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

![ci](https://www.godaddy.com/resources/ae/wp-content/uploads/sites/11/how-to-connect-your-domain-name-hosting-account.jpg?size=1920x0)

Greylisting is an effective method for preventing spam emails from being sent out. It runs on the email recipient’s mail server and does not require the sender or recipient to perform any configurations.

In theory, no legitimate emails should get lost due to greylisting. It is, therefore, one of the most widely used techniques in the global fight against spam.

Use a **[private or company email address with its own domain](https://www.ionos.com/office-solutions/create-an-email-address)**.

If you run your own mail server, you should consider using greylisting to provide basic protection against spam.

## Scope of application for greylisting

Spam filters are complex pieces of software that use heuristics to try to detect spam emails. In contrast to these elaborate procedures, greylisting is intended to prevent blatant spam from even being delivered. Since greylisting is based on a simple process, it does not require a significant amount of resources to perform.

Greylisting is used in particular to combat the illegitimate mass sending of spam emails. Unsolicited bulk email (UBE) refers to non-personalized mass emails. Lists of purchased or stolen email addresses are often used for this purpose.

These emails are usually sent from the hijacked computers of unsuspecting users. The computers are connected in remotely controlled **[botnets](https://www.ionos.com/digitalguide/server/security/what-is-a-botnet/)** and used to send mass spam emails. Usually, spoofed email sender addresses are used in these waves of spam.

Greylisting is not suitable for combating unsolicited commercial email (UCE). These are individually sent and are often personalized emails from actual companies or professionals. To combat this type of spam, content-based filters and blacklisting are used instead.

## How greylisting works

Greylisting focuses on filtering out potential spam emails during the delivery process. Let us take a look at exactly how this process works.

To transfer an email from a sender to a recipient, the **[Simple Mail Transfer Protocol (SMTP)](https://www.ionos.com/digitalguide/e-mail/technical-matters/smtp/)** is used. Typically, an email sent over the internet will follow the path described below:

1. The sender composes the email with their Mail User Agent (MUA). This can be a locally installed email application or a webmail interface.

2. To send the email, the Mail User Agent establishes an SMTP connection with the sender’s Mail Transfer Agent (MTA). This is software on the SMTP server that receives and forwards emails.

3. The sender’s Mail Transfer Agent forwards the email to the recipient’s Mail Transfer Agent. If the agent accepts the email, it is delivered to the recipient’s inbox.

4. If the recipient synchronizes their local inbox using the IMAP or POP3 protocol, the email will be displayed as a new message.

Greylisting takes place in the third step when the recipient’s Mail Transfer Agent receives the email. The receiving MTA needs three pieces of data before the full email will be accepted:

- The IP address of the sending mail server
- The sender’s email address via the SMTP command “MAIL FROM”
- The recipient’s email address via the SMTP command “RCPT TO”

Since this data is available to the Mail Transfer Agent before the actual message is, it is also referred to as “envelope data”. The Mail Transfer Agent records the envelope data for each incoming email in a list (i.e. the greylist). Here is an example of what a greylist entry may look like:

| IP address | Sender           | Recipient        |
|------------|------------------|------------------|
| 192.0.2.3  | <anne@example.com> | <fred@example.net> |

When a set of envelope data is encountered for the first time, the Mail Transfer Agent will initially reject the email. An error code is then returned indicating that a technical problem has occurred. The sending Mail Transfer Agent will be prompted to retry sending the email after a specific waiting period.

A legitimate standards-compliant Mail Transfer Agent will comply with this request and try to forward the email again later. When attempting to deliver the email again, the envelope data will already be in the greylist and the email will be delivered.

In contrast, an illegitimate sending Mail Transfer Agent usually will not try again. Here we can see the spam protection function of greylisting at work. Since a second attempt at delivering the email is not made, the spam email is never delivered. The recipient being protected by this function will never even notice it happening. It is a very elegant solution for getting rid of annoying spam email.

However, greylisting does have a significant disadvantage. Due to the waiting time required for the second delivery attempt, some emails may only reach the recipient after a noticeable delay. This can sometimes take hours.

You may have encountered this problem when using the password reset function for an online service: You have not received the password reset email you requested. You try requesting the email again multiple times without success. A few hours later, you receive several of these emails almost simultaneously. However, the password reset links contained in them have already expired. The greylisting of your email address is the source of this annoying situation.

![gl](https://www.ionos.com/digitalguide/fileadmin/_processed_/b/0/csm_how-greylisting-works_d4f377d36c.webp)

Greylisting consists of several communication steps between the sender and the recipient.

(a) The Mail User Agent (MUA) transfers an email to the sender’s mail server (P).

(b) The sender’s mail server (P) forwards the email to the recipient’s mail server (Q). It checks the email’s envelope data: the IP address of the sending server and the email addresses of the sender and the recipient. If the set of data containing these three pieces of information cannot yet be found in the recipient’s mail server (Q), the server will initially reject the email indicating that a technical error has occurred. The recipient’s mail server (Q) will record the envelope data in a table, thus greylisting the email.

(c) If it is a legitimately sent email, the sender’s mail server (P) will try to send the email again after the waiting period. Since the envelope data can now be found in the recipient’s mail server (Q), the email will go through. Optionally, the envelope data can be added to the mail server’s whitelist. In this case, any future incoming emails with the same envelope data will be delivered without delay.

(d) If it is an illegitimately sent email, there will generally not be another attempt made to deliver it. In this case, the greylisting has fulfilled its purpose of combating spam since the illegitimate email is never delivered.

Greylisting is usually used in combination with other anti-spam technologies. The Sender Policy Framework (SPF), DomainKeys Identified Mail (DKIM) and Domain-based Message Authentication, Reporting and Conformance (DMARC) are used to secure email communication against common types of abuse.

Greylisting works particularly well when combined with whitelisting and blacklisting, which are similar techniques. As an example, let us take a look at the chronological sequence of delivery attempts made to a receiving mail server:

![st](https://www.ionos.com/digitalguide/fileadmin/_processed_/3/2/csm_greylisting-example-with-whitelist-and-blacklist_088700fa08.webp)

Example with greylist, whitelist and blacklist.
This is a list of email delivery attempts (e1 to e5) arranged in chronological order.

e1) An email is received from a sender who is not yet found on the greylist (“Listed? No.”). The Mail Transfer Agent rejects the email indicating that a technical error has occurred. The envelope data is recorded in the greylist.

e2) Later, another email is delivered from the same sender to the same recipient. Since the envelope data is already in the greylist, the email is delivered. In addition, the envelope data is entered in the whitelist.

e3) As of the last correspondence between Anne and Fred, the IP address of Anne’s SMTP server has changed. Previously, it was 192.0.2.3, and now it is 192.0.2.34. Anne is thus treated as an unknown sender and ends up on the greylist first.

e4) Later, Anne writes to Fred again. This time, the SMTP server is being used under the original IP address 192.0.2.3. Since this envelope data is already on the whitelist, Anne’s email is delivered immediately.

e5) A delivery attempt is made from a server under the IP address 192.0.2.66. Since this server is recorded on the blacklist as a known malicious server, the email’s delivery is rejected. It appears that the sender address <anne@example.com> has been spoofed.
