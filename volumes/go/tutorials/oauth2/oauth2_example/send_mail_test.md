# work account

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
redirect uri:<http://localhost:8080/oauth/redirect>
domain: brentgrovesoutlook.onmicrosoft.com


https://graph.microsoft.com/v1.0/users/brent.groves@outlook.com

```bash
token=`curl \
    -d grant_type=client_credentials \
    -d client_id=$CLIENT_ID \
    -d client_secret=$CLIENT_SECRET \
    -d scope=https://graph.microsoft.com/.default \
    -d resource=https://graph.microsoft.com \
    https://login.microsoftonline.com/$TENANT_ID/oauth2/token \
    | jq -j .access_token`

https://graph.microsoft.com/v1.0/users/brent.groves@outlook.com/sendMail

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
https://graph.microsoft.com/v1.0/users/4e3f82ca-1024-486f-8f4d-30671be7754c/sendMail

https://graph.microsoft.com/v1.0/users/brent.groves@outlook.com/sendMail


https://graph.microsoft.com/v1.0/users/brent.groves@outlook.com/sendMail 

curl -X GET \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    https://graph.microsoft.com/v1.0/users 

{"@odata.context":"https://graph.microsoft.com/v1.0/$metadata#users","value":[{"businessPhones":[],"displayName":"Brent Groves","givenName":"Brent","jobTitle":null,"mail":null,"mobilePhone":null,"officeLocation":null,"preferredLanguage":"en","surname":"Groves","userPrincipalName":"brent.groves_outlook.com#EXT#@brentgrovesoutlook.onmicrosoft.com","id":"4e3f82ca-1024-486f-8f4d-30671be7754c"},{"businessPhones":["2605644868"],"displayName":"Steven Groves","givenName":"Steven","jobTitle":"marketing","mail":"brent.groves@gmail.com","mobilePhone":null,"officeLocation":null,"preferredLanguage":null,"surname":"Groves","userPrincipalName":"steven.groves@brentgrovesoutlook.onmicrosoft.com","id":"7e865adc-0be2-4cc3-be36-6b04108d1c63"}]}%  

curl -X GET \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    "https://graph.microsoft.com/v1.0/users/4e3f82ca-1024-486f-8f4d-30671be7754c"

curl -X GET \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    "https://graph.microsoft.com/v1.0/users/steven.groves@brentgrovesoutlook.onmicrosoft.com"

curl -X GET \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    https://graph.microsoft.com/v1.0/users/bgroves@mobexglobal.com \
    | jq .

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
"https://graph.microsoft.com/v1.0/users/brent.groves@outlook.com/sendMail"

"https://graph.microsoft.com/v1.0/users/steven.groves@brentgrovesoutlook.onmicrosoft.com/sendMail"
{"error":{"code":"MailboxNotEnabledForRESTAPI","message":"The mailbox is either inactive, soft-deleted, or is hosted on-premise."}}% 

"steven.groves@brentgrovesoutlook.onmicrosoft.com"

"https://graph.microsoft.com/v1.0/users/brent.groves@outlook.com/sendMail"
{"error":{"code":"ErrorInvalidUser","message":"The requested user 'brent.groves@outlook.com' is invalid."}}% 

"https://graph.microsoft.com/v1.0/users/4e3f82ca-1024-486f-8f4d-30671be7754c/sendMail"

{"error":{"code":"MailboxNotEnabledForRESTAPI","message":"The mailbox is either inactive, soft-deleted, or is hosted on-premise."}}%  

https://graph.microsoft.com/v1.0/users/4e3f82ca-1024-486f-8f4d-30671be7754c/sendMail

```

