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
                    "address": "brent.groves@gmail.com" 
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

https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=de8bc8b5-d9f9-48b1-a8ad-b748da725064&scope=openid%20profile%20User.Read%20offline_access&redirect_uri=https%3A%2F%2Fdeveloper.microsoft.com%2Fen-us%2Fgraph%2Fgraph-explorer&client-request-id=018e567e-5f60-74a9-bde9-e3e31ab2bcf0&response_mode=fragment&response_type=code&x-client-SKU=msal.js.browser&x-client-VER=3.10.0&client_info=1&code_challenge=KBliSBFOUywSVbsDNclcp-ODCU8YwcGEr0hNrxWcRY0&code_challenge_method=S256&prompt=select_account&nonce=018e567e-5f72-7230-9cfd-da1cea73a26b&state=eyJpZCI6IjAxOGU1NjdlLTVmNzItNzQwNi04MjMxLWQyZTE5NzI0NTYxZCIsIm1ldGEiOnsiaW50ZXJhY3Rpb25UeXBlIjoicG9wdXAifX0%3D&claims=%7B%22access_token%22%3A%7B%22xms_cc%22%3A%7B%22values%22%3A%5B%22CP1%22%5D%7D%7D%7D&mkt=en-US

https://learn.microsoft.com/en-us/entra/identity-platform/tutorial-v2-nodejs-console
```

