# **[Different types of email bounces or delivery status notification (DSN)](https://help.createsend.com/s/article/cs-bounced-email-types#:~:text=DNS%20failure,destination%20domain%20doesn't%20exist.)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[mailtrap bounces](https://mailtrap.io/sending/suppressions)**
- **[DNS Provider Lookup](https://mxtoolbox.com/DnsLookup.aspx)**
- **[nslookup](https://www.nslookup.io/)**
- **[dns record types](https://www.nslookup.io/learning/dns-record-types/)**
- **[DNS Lookup](https://www.whoisfreaks.com/)**
- **[TXT lookup tool](https://www.nslookup.io/txt-lookup/)**
- **[MX lookup tool](https://www.nslookup.io/mx-lookup/)**
- **[NS lookup tool](https://www.nslookup.io/ns-lookup/)**
- **[SOA lookup tool](https://www.nslookup.io/soa-lookup/)**

There are multiple bounce types that you could see in the report for a sent email. All of the bounce messages we receive are sorted into soft bounce categories or, if it's a permanent delivery failure, it's classified as a hard bounce.

Below, we'll explain how our system deals with the thousands of different bounce messages we receive, and how we categorize them.

## Bounce message categorization

Email messages are sent between mail servers using a procedure called Simple Mail Transfer Protocol (SMTP). If there's an error during the transmission a **delivery status notification (DSN)**, otherwise known as a "bounce message", is returned to the sending server — that's us — to explain why the message wasn't delivered.

There is a standard set of SMTP error codes that everyone uses, numbers like 421, 551 and 554, however mailbox providers and mail server administrators can customize the messages that accompany the codes, meaning there is no standard explanation for any particular bounce reason.

For example, the following are all hard bounce error messages:

- Unknown or illegal alias
- Address rejected
- No such user here
- Bad destination mailbox address
- Rule imposed mailbox access for [email] refused: user invalid

To save you trying to interpret thousands of different bounce message explanations, our bounce processing tool sorts them into the categories listed below.

## Bounce category definitions

The following categories will not apply to every bounce type out there. We take a simplified approach to bounce message interpretation based on best practices.

If you need to know more about a specific bounce in your report, please contact us. We can check our bounce logs for the exact error message that was returned, and investigate further.

If you're seeing bounce rates above 2% it's worth investigating the cause. Learn about **[high bounce rates](https://help.createsend.com/s/article/cs-high-bounce-rates)**, and what you can do to prevent them.

## Bounce — but no email address returned

The recipient mail server bounced your email, but did not indicate which address it was bouncing on behalf of. We've determined the recipient based on the content of the bounce.

## Challenge response

The recipient has installed software as an anti-spam measure, that only accepts email from previously authorised senders. If the software doesn't know the sender, a challenge email is returned, requiring a specific action before the original email will be sent to the user.

Since the requested response could be anything, we treat these as a soft bounce.

## DNS failure

The recipient's email server is currently unable to deliver your email due to DNS issues on their end. This may or may not be a temporary problem. The error could be due to the mail server being down, or there was a typo when it was set up, or maybe the destination domain doesn't exist.

All we know is that the DNS host is unreachable, therefore we treat this as a soft bounce to allow some time for the problem to be rectified.

## General bounce

This is treated as a soft bounce because we cannot determine the exact reason for delivery failure. Typically this bounce type is associated with a technical issue such as, "Connection timed out", but we will also classify a bounce as "general" if the response from the recipient server is open to more than one interpretation. It could be a non-standard error message, or too vague to be useful.

## Hard bounce

Your email is permanently undeliverable to this email address. The address is either fake, was entered incorrectly, or the user mailbox or domain is no longer active.

We've removed the address from your mailing list and added it to your suppression list which prevents any further emails being sent to the address. This protects your sender reputation and ensures you do not pay to send to dead addresses.

If the list unsubscribe settings are set to "Only remove them from this list", the subscriber will not be added to your suppression list.

## Mailbox full

The email server cannot deliver your email because the recipient's inbox is full. Most email applications have a set amount of storage an individual user can use for email. If this quota is exceeded the server will not let any more mail through, but it will also usually alert the mailbox owner so they can do something about it.

So while it may be the case that your recipient hasn't put aside time to make some space, it could also be a sign of an abandoned mailbox. For example, someone sets up a free webmail account just for shopping-related emails, then stops signing in when they start saving for a house.

We treat these as a soft bounce in case it's temporary, but if the issue continues we'll convert it to a hard bounce for you.

## Mail block — general

The recipient's email server is blocking inbound mail from our server, which may be due to a blocklisting. A mail block is recorded when the receiving server blocks an email completely; rejecting the message without any attempt to deliver it to the inbox.

The most likely reasons for this block are:

- Your reply-to address is blocklisted.
- One of our sending IPs is temporarily blocked.
- One of our sending domains is temporarily blocklisted.
- The receiving server only accepts allowlisted senders.

You should only try resending this email if the bounce is due to our IP or sending domain being blocked or blocklisted. Please contact us to find out.

## Mail block — known spammer

The recipient's email server has blocked your email on the basis of poor sending reputation. The most likely reasons you would see this block are:

- The email you have sent over time to the mail server has consistently resembled spam, and it has stopped delivering email from you to its users.
- One of our sending IPs is temporarily blocked.
- One of our sending domains is temporarily blocklisted.
- You should only try resending to this mail server if the bounce is due to our IP or sending domain being blocked or blocklisted. Please contact us to find out.

## Mail block — relay denied

Your email has bounced due to a temporary error, which could be on the sending or receiving side. "Relay" simply refers to the transmission of your email from our server to the receiving server, which has most likely been denied due to user error. This type of bounce usually occurs when the sender's message is not authenticated, but it can also be due to a misconfigured server on the recipient side.

Technically speaking this is a hard bounce, but we treat it as a soft bounce because it's often a result of user error, which can therefore be resolved.

## Mail block — spam detected

The recipient's email server has blocked your email on the basis that the content resembles spam. This mail block is often triggered by something detected in your email content, but can also be your reply-to address or brand name that has a poor reputation.

We treat this as a soft bounce due to the fact that some mail servers and email providers respond with false or incorrect error codes.

## Message too large

The size of your email — including all headers, text and images — is larger than the maximum size the recipient's mailbox allows. The bounce message returned doesn't include information on what the size limit is, but we advise you do not send messages bigger than 500Kb.

## Transient bounce

The recipient mail server can't deliver your email, but will keep trying for a limited period of time. We treat this as a soft bounce, as when the recipient mail server retries the message could be delivered.
