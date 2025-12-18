# **[SMTP Service](https://mailtrap.io/smtp-service/)**

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Research Summary](./research_summary.md)**\
**[Back Main](../../README.md)**

## references

- **[Send emails using SMTP provider](https://mailtrap.io/blog/golang-send-email/)**

## SMTP Service Setup

- **[SPF Guide](../../research/a_l/dns/txt/spf-a-practical-guide.md)**
- **[TXT records](../../research/a_l/dns/txt/txt_record.md)**
- **[SPF records](../../research/a_l/dns/txt/spf_txt_record.md)**
- **[DKIM records](../../research/a_l/dns/txt/dkim_txt_record.md)**
- **[DMARC records](../../research/a_l/dns/txt/dmarc_txt_record.md)**
- **[DNS Provider Lookup](https://mxtoolbox.com/DnsLookup.aspx)**
- **[nslookup](https://www.nslookup.io/)**

Domains that have not set up SPF, DKIM, and DMARC correctly may find that their emails get quarantined as spam, or are not delivered to their recipients. They are also in danger of having spammers impersonate them.

Will set up a quick meeting to show it sending an excel file to linamar user. Using the free tier, we can send 1000 email per month.

**DomainKeys Identified Mail (DKIM)** is an email security standard that uses public-key cryptography to verify the authenticity of emails. DKIM works by attaching a digital signature to an email, which is then checked by the recipient's mail server to ensure the email is genuine:

- **Signing:** The sender uses their private key to sign the email's header.
- **Storing:** The domain's public key is stored in a DKIM record.
- **Verifying:** The recipient's mail server uses the public key from the DKIM record to verify that the sender's private key was used to sign the email. If the signature verifies, the email is considered authentic and passes DKIM.

Gomail is a community-driven package for Go that truly is, as its creators say, “simple and efficient.”

It supports the following:

- SSL / TLS
- Attachments
- Embedded images
- Text/HTML templates
- Automatic encoding of special characters

Additionally, it’s important to mention that Gomail must be paired with an external SMTP server.

So now I’ll provide you with the code you can use with any SMTP, whether it’s a dedicated provider or your Gmail account even. Later on though, I’ll leverage Gomail with Mailtrap SMTP so you can see it in action.

## **[Best SMTP service providers](https://mailtrap.io/blog/smtp-providers/)**

- Mailtrap Email Delivery Platform: for developers and marketing teams looking for a reliable SMTP that can help them test, send, and control their email infrastructure all in one place.
- SendGrid: for large businesses seeking marketing tools alongside SMTP email delivery.
Mailgun: for businesses looking for a straightforward SMTP service, but also well-documented APIs.
- Mailchimp Transactional Email: for existing Mailchimp users looking to extend Mailchimp’s marketing services to transactional (user-triggered) emails.
- Amazon SES: best for tech-savvy users who prefer a cost-effective service and a completely manual setup process (a lot of coding required).
- Mailjet: for businesses that want to do SMS marketing on top of emails at a scale.
Postmark: for businesses that want a straightforward SMTP service to send user generated or bulk emails.

Here’s a tabular overview of each provider, click on the links to jump to individual reviews.

| SMTP providers                | Great email infrastructure | Affordable pricing | Responsive customer support | Fully featured solution |
|-------------------------------|----------------------------|--------------------|-----------------------------|-------------------------|
| Mailtrap                      | ✅                          | ✅                  | ✅                           | ✅                       |
| SendGrid                      | ✅                          | ⛔                  | ⛔                           | ✅                       |
| Mailgun                       | ✅                          | ⛔                  | ✅                           | ✅                       |
| Mailchimp Transactional Email | ✅                          | ⛔                  | ✅                           | ⛔ (add-on)              |
| Amazon SES                    | ✅                          | ✅                  | ⛔                           | ⛔                       |
| Mailjet                       | ✅                          | ✅                  | ✅                           | ✅                       |
| Postmark                      | ✅                          | ✅                  | ✅                           | ✅                       |
