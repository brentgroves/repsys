# **[Message send](https://learn.microsoft.com/en-us/graph/api/message-send?view=graph-rest-1.0&tabs=http)**

## references

## prerequisites

Namespace: microsoft.graph
Send an existing draft message.
The draft message can be a new message draft, reply draft, reply-all draft, or a forward draft.
This method saves the message in the Sent Items folder.
Alternatively, **[send a new message](https://learn.microsoft.com/en-us/graph/api/user-sendmail?view=graph-rest-1.0)** in a single operation.
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

## **[Message send](https://learn.microsoft.com/en-us/graph/api/message-send?view=graph-rest-1.0&tabs=http)**

```bash

 /users/{id | userPrincipalName}/messages/{id}/send
```
