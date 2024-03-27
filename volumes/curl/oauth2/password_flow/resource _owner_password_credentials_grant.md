# **[Resource Owner Password Credentials Grant in Azure AD OAuth](https://learn.microsoft.com/en-us/archive/blogs/wushuai/resource-owner-password-credentials-grant-in-azure-ad-oauth)**

## **[THIS FLOW WONT WORK UNLESS YOU DISABLE MFA](https://stackoverflow.com/questions/76460724/aad-outh-generate-token-failure-aadsts50076)**

## references

<https://learn.microsoft.com/en-us/archive/blogs/wushuai/resource-owner-password-credentials-grant-in-azure-ad-oauth>

<https://dzone.com/articles/getting-access-token-for-microsoft-graph-using-oau>

**[How to include environment variable in bash line CURL?](https://superuser.com/questions/835587/how-to-include-environment-variable-in-bash-line-curl)**

## Resource Owner Password Credentials Grant

Azure AD supports varies grant flows for different scenarios, such as Authorization Code Grant for Web server application, Implicit Grant for native application, and Client Credentials Grant for service application. Furthermore, the Resource Owner Password Credentials Grant is also supported for the case that the resource owner has a trust to the target application, such as an in-house windows service.

As the Resource Owner Password Credentials Grant is totally based on http request without URL redirection, it not only can apply to WPF, Winform application but also C++, MFC, also no matter there is user interact or not. For more official description regarding to this flow, you may refer to RFC6749. This flow has given us much flexibility to gain a token easily, while, as this flow will expose the user name and password directly in a http request, it brings potential attack risk as well. Your credential will be lost easily if the request is sent to an unexpected endpoint, and definitely we should always avoid  handling the user credential directly. Furthermore, notice that resource owner password grant doesn't provide consent and doesn't support MFA either. So, try to use Authorization Code flow if possible and do not abuse the resource owner password grant.

The following are the parameters needed in Azure AD OAuth for resource owner password grant.

| Name       | Description                                                                                       |
|------------|---------------------------------------------------------------------------------------------------|
| grant_type | The OAuth 2 grant type: password                                                                  |
| resource   | The app to consume the token, such as Microsoft Graph, Azure AD Graph or your own Restful service |
| client_id  | The Client Id of a registered application in Azure AD                                             |
| username   | The user account in Azure AD                                                                      |
| password   | The password of the user account                                                                  |
| scope      | optional, such as openid to get Id Token                                                          |

## **[Flow 2: Get Access Token From Client and User Credentials](https://dzone.com/articles/getting-access-token-for-microsoft-graph-using-oau)** (Resource Owner Password Credential Grant)

The first option, while it is the simplest of all (since it only requires the Application ID and Secret), doesn't always work. There are several Graph Methods for which just using the client credentials is not enough - they require user authorization as well. For example, in order to retrieve **[Group Events](https://developer.microsoft.com/en-us/graph/docs/api-reference/v1.0/api/group_list_events)**, we can see permission ApplicationNot supported, meaning getting access to that resource with just Client Credentials will not work. However, the first line is, Delegated (work or school account): Group.Read.All meaning, if we can get a "delegated permission" we can make this work.

So what does "delegated permission" mean, you ask? Well in simple terms, we need to show the API that not only have we come with an approved Client, we also have to carry a valid User authorization as well. Meaning that our access token needs to contain both a valid Client and User claims.

So how can we do that? There are a couple of ways to achieve that, in this option, we will look at the simplest way - the Resource Owner Credentials Grant.

For this flow, we need to send the following POST message:

```bash
POST https://login.microsoftonline.com/{{AAD_name}}/oauth2/token

```

- grant_type: The grant flow we want to use, password in this case.
- client_id: The Client ID (Application ID) of the application we created in the previous step.
- client_secret: The Client Secret we created in the previous step.
- resource: The name of the resource to which we would like to get access, <https://graph.microsoft.com> in this case.
- username: Full username of the user, including the domain, for example, <john@contoso.onmicrosoft.com>
- password: User's plain-text password.

Note:
none of the microsoft examples contain resource property and when I tried to add it got the following error.
-d "resource=https%3A%2F%2Fgraph.microsoft.com" \
{"error":"invalid_request","error_description":"AADSTS901002: The 'resource' request parameter is not supported.}

Sample at **[password flow](../../../../../../../../media/brent/KINGSTON/secrets/azure/tenants/msdev_1hkt5t/apps/MicrosoftGraphClient/curl/resource%20_owner_password_credentials_grant.md)**

## **[I received the following error](https://stackoverflow.com/questions/76460724/aad-outh-generate-token-failure-aadsts50076)**

{"error":"invalid_grant","error_description":"AADSTS50076: Due to a configuration change made by your administrator, or because you moved to a new location, you must use multi-factor authentication to access '00000003-0000-0000-c000-000000000000'. Trace ID: fa3dac0c-f63e-4923-a0a4-c4b0d20b3500 Correlation ID: d5f20575-1407-4f7b-aa55-35716c88972f Timestamp: 2024-03-26 21:48:02Z","error_codes":[50076],"timestamp":"2024-03-26 21:48:02Z","trace_id":"fa3dac0c-f63e-4923-a0a4-c4b0d20b3500","correlation_id":"d5f20575-1407-4f7b-aa55-35716c88972f","error_uri":"<https://login.microsoftonline.com/error?code=50076","suberror":"basic_action"}%>

To resolve the error, you have to either disable MFA for that user or change your authentication flow to authorization code.

We will receive a response with a JSON object containing the following properties:

- token_type: The value Bearer
- expires_on: The token expire timestamp in Unix epoch time.
- access_token: The access token we needed to access the Graph API.
- refresh_token: A refresh token that can be used to acquire a new access token when the original expires.

To learn more about this flow, see: **[Resource Owner Password Credentials Grant in Azure AD OAuth](https://blogs.msdn.microsoft.com/wushuai/2016/09/25/resource-owner-password-credentials-grant-in-azure-ad-oauth/)**.

Besides the access token, we received two additional tokens - Refresh Token and ID Token. They were are not necessary for this flow, but they can be used in other grant flows and this is an example of how to get them. We automatically get the Refresh Token in this flow, and we can get an ID Token by adding to the request scope parameter with the value openid, as seen in the above Postman screenshot.
