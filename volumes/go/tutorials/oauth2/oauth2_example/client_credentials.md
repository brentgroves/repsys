<https://aembit.io/blog/authenticate-to-microsoft-graph-api-using-oauth-2-0-client-credentials/>

# Example

<https://learn.microsoft.com/en-us/graph/auth-v2-user?tabs=http>

<https://login.microsoftonline.com/07476fd3-6a57-4e3f-80ab-a1be2af5d10a/oauth2/v2.0/authorize>?
client_id=4c914e6c-f56e-4a77-a59f-733d6d37942e
&response_type=code
&redirect_uri=http%3A%2F%2Flocalhost%2Fmyapp%2F
&response_mode=query
&scope=offline_access%20user.read%20mail.read

```bash
# wonder account (obsolete)
TENANT_ID="2a7c89a0-abf5-4584-a446-bf6c8d111de5"
CLIENT_ID="3bb4fcf5-bb02-4e23-bd3c-ac55e58b63f9"
secret_id="d6bfdd84-0ad9-48e7-8c74-730320638aef"
secret_value="Yem8Q~qNcX7OUcFFQWXl8b5uMvzab3kvjFQulbk6"
SCOPE='https%3A%2F%2Fgraph.microsoft.com%2F.default'
MSFT="https://login.microsoftonline.com/2a7c89a0-abf5-4584-a446-bf6c8d111de5/oauth2/v2.0/token"

# dev account
CLIENT_ID="b08211fd-0bcf-4700-a70a-e600bc0bcf77"
CLIENT_SECRET="nRH8Q~HGjz4eSmS~~nGPxOdbILLOZfLM62~iScss"
TENANT_ID="5269b021-533e-4702-b9d9-72acbc852c97"
SCOPE='https%3A%2F%2Fgraph.microsoft.com%2F.default'
MSFT="https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/token"

# mobex account
CLIENT_ID="b5615dbe-0af5-49fd-ab09-803e91be7bd9"
CLIENT_SECRET="L9c1qlg8x1CfH8StSyfVtkB23vD-C~-.x."
TENANT_ID="b4b87e8f-df64-41ff-9ba4-a4930ebc804b"
SCOPE='https%3A%2F%2Fgraph.microsoft.com%2F.default'

## Outlook Client Application

CLIENT_ID="4c914e6c-f56e-4a77-a59f-733d6d37942e"
CLIENT_SECRET="Ei88Q~LEIJzqYYsaurhNfCqgG.IqoQPy1.rdgaWj"
secret_id=8a85cfce-b6a3-4da2-a056-c717facfdb47
secret_value=Ei88Q~LEIJzqYYsaurhNfCqgG.IqoQPy1.rdgaWj
TENANT_ID="07476fd3-6a57-4e3f-80ab-a1be2af5d10a"
SCOPE='https%3A%2F%2Fgraph.microsoft.com%2F.default'
https://graph.microsoft.com/.default
Mail.ReadBasic Mail.Read Mail.ReadWrite
redirect uri:<http://localhost:8080/oauth/redirect>
domain: brentgrovesoutlook.onmicrosoft.com
MSFT="https://login.microsoftonline.com/07476fd3-6a57-4e3f-80ab-a1be2af5d10a/oauth2/v2.0/token"
https://graph.microsoft.com/.default


https://login.microsoftonline.com/07476fd3-6a57-4e3f-80ab-a1be2af5d10a/oauth2/v2.0/authorize?
client_id=4c914e6c-f56e-4a77-a59f-733d6d37942e
&response_type=code
&redirect_uri=http%3A%2F%2Flocalhost%2Fmyapp%2F
&response_mode=query
&scope=offline_access%20user.read%20mail.read


curl -X GET "https://login.microsoftonline.com/07476fd3-6a57-4e3f-80ab-a1be2af5d10a/oauth2/v2.0/authorize?client_id=4c914e6c-f56e-4a77-a59f-733d6d37942e&esponse_type=code&redirect_uri=http%3A%2F%2Flocalhost%2Fmyapp%2F&response_mode=query&scope=offline_access%20user.read%20mail.read" | jq .

code=`curl \
    -d response_type=code \
    -d client_id=4c914e6c-f56e-4a77-a59f-733d6d37942e \
    -d response_mode=query \
    -d scope=offline_access%20user.read%20mail.read \
    https://login.microsoftonline.com/07476fd3-6a57-4e3f-80ab-a1be2af5d10a/oauth2/v2.0/authorize \
    | jq . `
    \
    | jq -j .access_token`

token=`curl \
    -d grant_type=client_credentials \
    -d client_id=$CLIENT_ID \
    -d client_secret=$CLIENT_SECRET \
    -d scope=https://graph.microsoft.com/.default \
    -d resource=https://graph.microsoft.com \
    https://login.microsoftonline.com/$TENANT_ID/oauth2/token \
    | jq -j .access_token`

# dev_account
# <brentgroves@1hkt5t.onmicrosoft.com>
curl -X GET \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    https://graph.microsoft.com/v1.0/users/9accfa89-9872-4b66-9d70-b75f2342f3ba \
    | jq .


# mobex:
curl -X GET \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    https://graph.microsoft.com/v1.0/users/a69026f5-9ff3-459a-a9e9-1ffb1bd43207 \
    | jq .

# outlook
# https://graph.microsoft.com/v1.0/users/brent.groves@outlook.com/sendMail
# https://graph.microsoft.com/v1.0/users/4e3f82ca-1024-486f-8f4d-30671be7754c

curl -X GET \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    https://graph.microsoft.com/v1.0/users/4e3f82ca-1024-486f-8f4d-30671be7754c \
    | jq .

curl -X GET \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    https://graph.microsoft.com/v1.0/me/messages \
    | jq .

    https://dzone.com/articles/getting-access-token-for-microsoft-graph-using-oau
https://learn.microsoft.com/en-us/archive/blogs/wushuai/resource-owner-password-credentials-grant-in-azure-ad-oauth
Spirit1$!

# https://graph.microsoft.com/v1.0/me/sendMail
# https://graph.microsoft.com/v1.0/users/bgroves@mobexglobal.com/sendMail
# https://graph.microsoft.com/v1.0/users/brent.groves@outlook.com/sendMail


curl -X POST \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    -d '{ 
    "message": { 
        "subject": "Test", 
        "body": { 
            "contentType": "Text", 
            "content": "Test message." 
        }, 
        "toRecipients": [ 
            { 
                "emailAddress": { 
                    "address": "bgroves@mobexglobal.com" 
                } 
            } 
        ] 
    } 
}' \
https://graph.microsoft.com/v1.0/users/bgroves@mobexglobal.com/sendMail 

curl -X POST \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    -d '{ 
    "message": { 
        "subject": "Test", 
        "body": { 
            "contentType": "Text", 
            "content": "Test message." 
        }, 
        "toRecipients": [ 
            { 
                "emailAddress": { 
                    "address": "brent.groves@outlook.com" 
                } 
            } 
        ] 
    } 
}' \
"https://graph.microsoft.com/v1.0/users/brent.groves_outlook.com#EXT#@brentgrovesoutlook.onmicrosoft.com/sendMail"

https://graph.microsoft.com/v1.0/users/brent.groves@outlook.com/sendMail
# above worked with graph explorer token but not client credential token

# with client_credentials token              
"https://graph.microsoft.com/v1.0/users/steven.groves@brentgrovesoutlook.onmicrosoft.com/sendMail"
{"error":{"code":"MailboxNotEnabledForRESTAPI","message":"The mailbox is either inactive, soft-deleted, or is hosted on-premise."}}%                                                                       
# with client_credentials token              
https://graph.microsoft.com/v1.0/users/brent.groves@outlook.com/sendMail
{"error":{"code":"ErrorInvalidUser","message":"The requested user 'brent.groves@outlook.com' is invalid."}}%                                                                                                             
https://graph.microsoft.com/v1.0/users/4e3f82ca-1024-486f-8f4d-30671be7754c/sendMail
{"error":{"code":"MailboxNotEnabledForRESTAPI","message":"The mailbox is either inactive, soft-deleted, or is hosted on-premise."}}% 


mobex 'a69026f5-9ff3-459a-a9e9-1ffb1bd43207'

curl -X GET \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    <https://graph.microsoft.com/v1.0/me> \
    | jq .

/users/{userId}

<https://graph.microsoft.com/v1.0/users/>
<brentgroves@1hkt5t.onmicrosoft.com>

token=`curl \
    -d grant_type=client_credentials \
    -d client_id=$CLIENT_ID \
    -d client_secret=$CLIENT_SECRET \
    -d scope=<https://graph.microsoft.com/.default> \
    -d resource=<https://graph.microsoft.com> \
    <https://login.microsoftonline.com/[tenant_id]/oauth2/token> \
    | jq -j .access_token

curl -X GET \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    https://graph.microsoft.com/v1.0/groups \
    | jq .
```
