<https://aembit.io/blog/authenticate-to-microsoft-graph-api-using-oauth-2-0-client-credentials/>

# Example

```bash
# wonder account
TENANT_ID="2a7c89a0-abf5-4584-a446-bf6c8d111de5"
CLIENT_ID="3bb4fcf5-bb02-4e23-bd3c-ac55e58b63f9"
secret_id="d6bfdd84-0ad9-48e7-8c74-730320638aef"
secret_value="Yem8Q~qNcX7OUcFFQWXl8b5uMvzab3kvjFQulbk6"
SCOPE='https%3A%2F%2Fgraph.microsoft.com%2F.default'
MSFT="https://login.microsoftonline.com/2a7c89a0-abf5-4584-a446-bf6c8d111de5/oauth2/v2.0/token"

https://login.microsoftonline.com/2a7c89a0-abf5-4584-a446-bf6c8d111de5/oauth2/v2.0/authorize

CLIENT_SECRET="nRH8Q~HGjz4eSmS~~nGPxOdbILLOZfLM62~iScss"
TENANT_ID="5269b021-533e-4702-b9d9-72acbc852c97"
MSFT="https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/token"

# dev account
CLIENT_ID="b08211fd-0bcf-4700-a70a-e600bc0bcf77"
CLIENT_SECRET="nRH8Q~HGjz4eSmS~~nGPxOdbILLOZfLM62~iScss"
TENANT_ID="5269b021-533e-4702-b9d9-72acbc852c97"
SCOPE='https%3A%2F%2Fgraph.microsoft.com%2F.default'
MSFT="https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/token"

# work account
CLIENT_ID="b5615dbe-0af5-49fd-ab09-803e91be7bd9"
CLIENT_SECRET="L9c1qlg8x1CfH8StSyfVtkB23vD-C~-.x."
TENANT_ID="b4b87e8f-df64-41ff-9ba4-a4930ebc804b"
SCOPE='https%3A%2F%2Fgraph.microsoft.com%2F.default'

const TOKEN_ENDPOINT =
  "https://login.microsoftonline.com/b4b87e8f-df64-41ff-9ba4-a4930ebc804b/oauth2/v2.0/token";
const MS_GRAPH_SCOPE = "https://graph.microsoft.com/.default";
https://learn.microsoft.com/en-us/answers/questions/1342882/microsoft-graph-apis-access-for-free-trial-account
Or better yet, get a free DEV subscription that you can reuse: https://developer.microsoft.com/en-us/microsoft-365/dev-program
https://www.youtube.com/watch?v=M22WNJwOxHY
curl \ -d "client_id=$CLIENT_ID" \ -d "client_secret=$CLIENT_SECRET" \ -d "grant_type=client_credentials" \ -d "scope=$SCOPE" \ -X POST $MSFT If everything is configured properly, you should receive a response like this…
{
    "token_type":"Bearer",
    "expires_in":3599,
    "ext_expires_in":3599,
    "access_token":"eyJ0eXAiOiJKV1..."
}

curl -d "client_id=$CLIENT_ID" -d "client_secret=$CLIENT_SECRET" -d "grant_type=client_credentials" -d "scope=$SCOPE" -X POST $MSFT
{"token_type":"Bearer","expires_in":3599,"ext_expires_in":3599,"access_token":"eyJ0eXAiOiJKV1QiLCJub25jZSI6ImwtTFM1VGxGdGpPVnllZTdSeHhfLTRRODV0Wk1FbzNHYWdFdW9fV0d2aVkiLCJhbGciOiJSUzI1NiIsIng1dCI6IlhSdmtvOFA3QTNVYVdTblU3Yk05blQwTWpoQSIsImtpZCI6IlhSdmtvOFA3QTNVYVdTblU3Yk05blQwTWpoQSJ9.eyJhdWQiOiJodHRwczovL2dyYXBoLm1pY3Jvc29mdC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC81MjY5YjAyMS01MzNlLTQ3MDItYjlkOS03MmFjYmM4NTJjOTcvIiwiaWF0IjoxNzEwMzY0ODY5LCJuYmYiOjE3MTAzNjQ4NjksImV4cCI6MTcxMDM2ODc2OSwiYWlvIjoiRTJOZ1lQaDFKV08yZUpMbnRRdjVGa2N6bHRuTEF3QT0iLCJhcHBfZGlzcGxheW5hbWUiOiJEZXYgQWNjb3VudCBDbGllbnQgQXBwbGljYXRpb24iLCJhcHBpZCI6ImIwODIxMWZkLTBiY2YtNDcwMC1hNzBhLWU2MDBiYzBiY2Y3NyIsImFwcGlkYWNyIjoiMSIsImlkcCI6Imh0dHBzOi8vc3RzLndpbmRvd3MubmV0LzUyNjliMDIxLTUzM2UtNDcwMi1iOWQ5LTcyYWNiYzg1MmM5Ny8iLCJpZHR5cCI6ImFwcCIsIm9pZCI6Ijg3MWE3ZTE4LWIzOGItNDhlMy04MmY3LWYwNmMwZWJkZmUzNiIsInJoIjoiMC5BWHdBSWJCcFVqNVRBa2U1MlhLc3ZJVXNsd01BQUFBQUFBQUF3QUFBQUFBQUFBRE1BQUEuIiwic3ViIjoiODcxYTdlMTgtYjM4Yi00OGUzLTgyZjctZjA2YzBlYmRmZTM2IiwidGVuYW50X3JlZ2lvbl9zY29wZSI6Ik5BIiwidGlkIjoiNTI2OWIwMjEtNTMzZS00NzAyLWI5ZDktNzJhY2JjODUyYzk3IiwidXRpIjoiNWg4NHNmSm1Qa0d2cUMxYlp5b0hBUSIsInZlciI6IjEuMCIsIndpZHMiOlsiMDk5N2ExZDAtMGQxZC00YWNiLWI0MDgtZDVjYTczMTIxZTkwIl0sInhtc190Y2R0IjoxNjY5ODA2MTIxfQ.dh1i5l-PbUs3jqun-2We2aQob_7HaU4d9Yg3_gi0tA8eh5ywx46_4ndfHwwNAa38FJWRFJmL8j5DH9EvM7Ozl_6IeyZ9_XYrdXPHsH6hTtvKQ8W6qZr9f_M-GrhnfS1Vggnk2mJgqbBe4jcZeoT_Ybsiu2u7VJ230mxrQxAAb_tRKLkGeuMSITLHgxLmfKAHbvej2XKQD3qh8U8Cvtqcpb4kzMoCcG6yMErUkqH2ylxYeIKTlfnoUKDvThUPrDHiiUxiR6j9lnFTWpStvnN8eivMuDzXYfAiOx3Pl0PMOwTV3XVAmrxwoSDYXd-lh8pbSgW_JsbL9Xca39JLIpEAhg"}%  

GET <https://graph.microsoft.com/v1.0/users/87d349ed-44d7-43e1-9a83-5f2406dee5bd>

<https://mauridb.medium.com/calling-azure-rest-api-via-curl-eb10a06127>

curl -X GET -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJub25jZSI6ImwtTFM1VGxGdGpPVnllZTdSeHhfLTRRODV0Wk1FbzNHYWdFdW9fV0d2aVkiLCJhbGciOiJSUzI1NiIsIng1dCI6IlhSdmtvOFA3QTNVYVdTblU3Yk05blQwTWpoQSIsImtpZCI6IlhSdmtvOFA3QTNVYVdTblU3Yk05blQwTWpoQSJ9.eyJhdWQiOiJodHRwczovL2dyYXBoLm1pY3Jvc29mdC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC81MjY5YjAyMS01MzNlLTQ3MDItYjlkOS03MmFjYmM4NTJjOTcvIiwiaWF0IjoxNzEwMzY0ODY5LCJuYmYiOjE3MTAzNjQ4NjksImV4cCI6MTcxMDM2ODc2OSwiYWlvIjoiRTJOZ1lQaDFKV08yZUpMbnRRdjVGa2N6bHRuTEF3QT0iLCJhcHBfZGlzcGxheW5hbWUiOiJEZXYgQWNjb3VudCBDbGllbnQgQXBwbGljYXRpb24iLCJhcHBpZCI6ImIwODIxMWZkLTBiY2YtNDcwMC1hNzBhLWU2MDBiYzBiY2Y3NyIsImFwcGlkYWNyIjoiMSIsImlkcCI6Imh0dHBzOi8vc3RzLndpbmRvd3MubmV0LzUyNjliMDIxLTUzM2UtNDcwMi1iOWQ5LTcyYWNiYzg1MmM5Ny8iLCJpZHR5cCI6ImFwcCIsIm9pZCI6Ijg3MWE3ZTE4LWIzOGItNDhlMy04MmY3LWYwNmMwZWJkZmUzNiIsInJoIjoiMC5BWHdBSWJCcFVqNVRBa2U1MlhLc3ZJVXNsd01BQUFBQUFBQUF3QUFBQUFBQUFBRE1BQUEuIiwic3ViIjoiODcxYTdlMTgtYjM4Yi00OGUzLTgyZjctZjA2YzBlYmRmZTM2IiwidGVuYW50X3JlZ2lvbl9zY29wZSI6Ik5BIiwidGlkIjoiNTI2OWIwMjEtNTMzZS00NzAyLWI5ZDktNzJhY2JjODUyYzk3IiwidXRpIjoiNWg4NHNmSm1Qa0d2cUMxYlp5b0hBUSIsInZlciI6IjEuMCIsIndpZHMiOlsiMDk5N2ExZDAtMGQxZC00YWNiLWI0MDgtZDVjYTczMTIxZTkwIl0sInhtc190Y2R0IjoxNjY5ODA2MTIxfQ.dh1i5l-PbUs3jqun-2We2aQob_7HaU4d9Yg3_gi0tA8eh5ywx46_4ndfHwwNAa38FJWRFJmL8j5DH9EvM7Ozl_6IeyZ9_XYrdXPHsH6hTtvKQ8W6qZr9f_M-GrhnfS1Vggnk2mJgqbBe4jcZeoT_Ybsiu2u7VJ230mxrQxAAb_tRKLkGeuMSITLHgxLmfKAHbvej2XKQD3qh8U8Cvtqcpb4kzMoCcG6yMErUkqH2ylxYeIKTlfnoUKDvThUPrDHiiUxiR6j9lnFTWpStvnN8eivMuDzXYfAiOx3Pl0PMOwTV3XVAmrxwoSDYXd-lh8pbSgW_JsbL9Xca39JLIpEAhg" -H "Content-Type: application/json" <https://management.azure.com/subscriptions/[SUBSCRIPTION_ID]/providers/Microsoft.Web/sites?api-version=2016-08-01>

curl -X GET -H "Authorization: Bearer [TOKEN]" -H "Content-Type: application/json" <https://management.azure.com/subscriptions/[SUBSCRIPTION_ID]/providers/Microsoft.Web/sites?api-version=2016-08-01>

token=`curl \
    -d grant_type=client_credentials \
    -d client_id=$CLIENT_ID \
    -d client_secret=$CLIENT_SECRET \
    -d scope=https://graph.microsoft.com/.default \
    -d resource=https://graph.microsoft.com \
    https://login.microsoftonline.com/$TENANT_ID/oauth2/token \
    | jq -j .access_token`

curl -X GET \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    <https://graph.microsoft.com/v1.0/users/9accfa89-9872-4b66-9d70-b75f2342f3ba> \
    | jq .

dev_account
<https://graph.microsoft.com/v1.0/users/9accfa89-9872-4b66-9d70-b75f2342f3ba>

mobex:
https://graph.microsoft.com/v1.0/users/a69026f5-9ff3-459a-a9e9-1ffb1bd43207

curl -X GET \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    https://graph.microsoft.com/v1.0/users/a69026f5-9ff3-459a-a9e9-1ffb1bd43207 \
    | jq .

curl -X GET \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    https://graph.microsoft.com/v1.0/users/a69026f5-9ff3-459a-a9e9-1ffb1bd43207 \
    | jq .

https://graph.microsoft.com/v1.0/me/sendMail
https://graph.microsoft.com/v1.0/users/bgroves@mobexglobal.com/sendMail
https://graph.microsoft.com/v1.0/users/brent.groves@outlook.com/sendMail
curl -X POST \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    -d '{"message": {"subject": "Meet for lunch?","body": {"contentType": "Text","content": "The new cafeteria is open."},"toRecipients": [{"emailAddress": {"address":"bgroves@mobexglobal.com"}}]}' https://graph.microsoft.com/v1.0/users/bgroves@mobexglobal.com/sendMail 
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
                    "address": "bgroves@mobexglobal.com" 
                } 
            } 
        ] 
    } 
}' \
https://graph.microsoft.com/v1.0/users/bgroves@mobexglobal.com/sendMail 

curl -d '{"key1":"value1", "key2":"value2"}' -H "Content-Type: application/json" -X POST http://localhost:3000/data

curl -d '{
    "message": {
        "subject": "Meet for lunch?",
        "body": {
            "contentType": "Text",
            "content": "The new cafeteria is open."
        },
        "toRecipients": [
            {
                "emailAddress": {
                    "address": "bgroves@mobexglobal.com"
                }
            }
        ]
    }
}' -H "Content-Type: application/json" -X POST http://localhost:3000/data

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
                    "address": "bgroves@mobexglobal.com"
                }
            }
        ]
    }
}

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
    <https://graph.microsoft.com/v1.0/groups> \
    | jq .
```
