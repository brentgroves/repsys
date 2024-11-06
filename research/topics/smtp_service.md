# **[SMTP Service](https://mailtrap.io/smtp-service/)**

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Research Summary](./research_summary.md)**\
**[Back Main](../../README.md)**

## references

- **[Send emails using SMTP provider](https://mailtrap.io/blog/golang-send-email/)**

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
