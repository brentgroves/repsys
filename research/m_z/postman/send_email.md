# **[send a new message in a single operation](https://learn.microsoft.com/en-us/graph/api/user-sendmail?view=graph-rest-1.0)**

## references

<https://learn.microsoft.com/en-us/graph/api/user-sendmail?view=graph-rest-1.0&tabs=http>

## prerequisites

Namespace: microsoft.graph
Send a new message in a single operation.
This API is available in the following **[national cloud deployments](https://learn.microsoft.com/en-us/graph/deployments)**.

- Global service
- US Government L4
- US Government L5 (DOD)
- China operated by 21Vianet

POST /users/{id | userPrincipalName}/messages/{id}/send

## Microsoft Free Azure Accounts

Maybe this was why I was having problems using postman to send mail. It might not be part of the Global Service.

## Permissions

Choose the permission or permissions marked as least privileged for this API. Use a higher privileged permission or permissions only if your app requires it. For details about delegated and application permissions, see Permission types. To learn more about these permissions, see the permissions reference.

| Permission type                        | Least privileged permissions | Higher privileged permissions |
|----------------------------------------|------------------------------|-------------------------------|
| Delegated (work or school account)     | Mail.Send                    | Not available.                |
| Delegated (personal Microsoft account) | Mail.Send                    | Not available.                |
| Application                            | Mail.Send                    | Not available.                |

## **[Example 1: Send a new email using JSON format](https://learn.microsoft.com/en-us/graph/api/user-sendmail?view=graph-rest-1.0&tabs=http#example-1-send-a-new-email-using-json-format)**

```bash
POST /me/sendMail
https://graph.microsoft.com/v1.0/me/sendMail
POST /users/{id | userPrincipalName}/sendMail
https://graph.microsoft.com/v1.0/users/{{UserId}}/sendMail
# put in body as raw
{
  "message": {
    "subject": "Meet for lunch?",
    "body": {
      "contentType": "Text",
      "content": "The new cafeteria is open."
    },
    "toRecipients": [
      {
        "emailAddress": {
          "address": "{{UserName}}"
        }
      }
    ],
    "ccRecipients": [
      {
        "emailAddress": {
          "address": "{{UserName}}"
        }
      }
    ]
  },
  "saveToSentItems": "false"
}
```

## **[Example 3: Create a message with a file attachment and send the message](https://learn.microsoft.com/en-us/graph/api/user-sendmail?view=graph-rest-1.0&tabs=go#example-3-create-a-message-with-a-file-attachment-and-send-the-message)**
