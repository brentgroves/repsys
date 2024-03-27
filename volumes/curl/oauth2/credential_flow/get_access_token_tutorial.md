# **[Getting Access Token for Microsoft Graph Using OAuth REST API](https://dzone.com/articles/getting-access-token-for-microsoft-graph-using-oau)**

## references

<https://learn.microsoft.com/en-us/entra/identity-platform/v2-oauth2-client-creds-grant-flow>

The value passed for the scope parameter in this request should be the resource identifier (application ID URI) of the resource you want, affixed with the .default suffix. All scopes included must be for a single resource. Including scopes for multiple resources will result in an error.
For the Microsoft Graph example, the value is <https://graph.microsoft.com/.default>. This value tells the Microsoft identity platform that of all the direct application permissions you have configured for your app, the endpoint should issue a token for the ones associated with the resource you want to use. To learn more about the /.default scope, see the consent documentation.

Microsoft Graph is here to unite Azure and Office 365 data under a single roof. It is a simple REST API and Microsoft provided many examples of how to use it, including an interactive Graph Explorer which allows us to discover the different methods.

Using the API is as simple as sending an HTTP request - for example, calling this method will return the details about the users in the directory:

```bash
curl https://graph.microsoft.com/v1.0/users
```

## Access Token for Microsoft Graph

In the **[Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer)** demo page it all works fine, but as soon as we try to use the Graph API from outside the page, from another program or test application like **[Postman](https://www.getpostman.com/apps)**, we receive a "401 Unauthorized" exception.

What's the deal?

## The Access Tokens

As it turns out, in order to use any of the Microsoft Graph API, we need to let it know who we are - who is making the request.

Microsoft Graph API uses **[Bearer Authentication](https://swagger.io/docs/specification/authentication/bearer-authentication/)** in order to validate the request, which means it expects to receive an authorization token (sometimes called a bearer token) together with the request. This token will contain, in a secured way, all the details about the requester.

Sending an authorization token with the request is a simple matter, all we need to do is to add an Authorization header to the request containing the word Bearer and our authorization token:

Authorization: Bearer <access_token>

There are several kinds of authorization tokens – Graph API requires an access token. The token itself is a looks like a random base 64 string, something like:

```base64
eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI3Rlcy5SZWFkLkFsbCBOb3..
QXBwIG9mZmxpbmVfYWNjZXNzIG9wZW5pZCBQZW9wbGUuUmVhZCBQZW9wbGUuUmVh..
ZC5BbGwgcHJvZmlsZSBSZXBvcnRzLlJlYWQuQWxsIFNpdGVzLkZ1bGxDb250cm9s..
LkFsbCBTaXRlcy5NYW5hZ2UuQWxsIFNpdGVzLlJlYWQuQWxsIFNpdGVzLlJlYWRX..
DMrCzi7JrvQ7_jclKHfPrv7jJAgsHfYkal5OalQAWRC6kaj6cgO0c7xyfGQUnhGA
```

It is not important to understand the token format for now, only that once we get a valid access token we can use it to access the information we need.

So how do we get the access token? That's where things get little more complicated.

In order to get a valid token for the Graph API, we need to use another Microsoft API: the Azure Active Directory (AAD) Services.

## Azure Active Directory Services

Azure Active Directory is where all of our organization's users are stored. Since the data we want to retrieve from the Graph API is usually related to specific users, it only makes sense that we need to use Azure Active Directory Services in order to retrieve a valid access token.

Microsoft AAD Services is based on the OAuth 2.0 protocol and act as an Identity Provider, which is an OAuth term for "where the users sit." Using these services, we can issue access tokens for the Graph methods (as well as id tokens and refresh tokens which are not in the scope of this article).

The Azure Active Directory Authorization endpoint has the following URL format:

```bash
https://login.microsoftonline.com/<organization-directory-name>.onmicrosoft.com/oauth2/token
```

Meaning every tenant directory has its own URL. The directory name can be found by hovering over our name in the Azure Portal.

Instead of a name, we can also use the directory ID:

```bash
https://login.microsoftonline.com/256d2b4c-b5c3-758f-55f3-cd8969f04e86/oauth2/token
```

Your Azure Active Directory ID can be found in Azure Portal > AAD Properties blade:

So now that we know what the authorization endpoint URL is, what message do we need to send in order to get an access token?

Well, the answer for that is - it depends. The service supports several OAuth authentication flows, each suited for a different scenario and the kinds of information we have. Regardless of the kind of message we send, the response will always contain the Access Token.

But, before we can look at the different options, we first need to understand another important part of the puzzle. All of the different flows in Graph API have something in common - they all require a Client ID with a Client Secret. In order to get those, we first need to create an OAuth App.

## Understanding OAuth Apps (Clients)

A very important concept in the OAuth world is the separation between users and clients. Users are the actual people who use our system. Clients are the applications they are using to do so. Why is this separation important? It's all about regulating access to resources.

In the past, when applications wanted to access data in another system or database which required authentication it had two options:

- Pass on the current logged in user's authentication.
- Impersonate a strong user.

Many times, the first option was not used - sometimes because it was complicated to perform (SSO is hard to get right), or the current user did not have enough permissions to perform the operation the application required.

This leaves the second option: impersonating a strong user. But which user to impersonate? Since we don't want to use an existing user (which could lead to many issues), a dedicated user for the application needs to be created. Those users are often called System Accounts since they are used by the system and not actual human beings.

However, this pattern of using system accounts had many problems, for example:

- **Password policy:** The System Account had a password just like any other user, which caused problems if the normal password policy were applied to them. For example, the accounts would have locked after a number of failed login attempts (usually by entering the wrong password). Also, the password would expire after some time. In all of those instances, the user was automatically locked, meaning all applications which depended on them would have failed.
- **Managing: Users** are usually managed by the organization's IT department, meaning developers were dependent on them in order to create and manage System Accounts across different environments. This can cause operation delays and unexpected application shut-downs as a result of a random password change.
- **Security:** Since the application runs its code as a power-user, any vulnerability in the code could allow users to gain access to data they were not supposed to be able to access. This can be used for to perform Privilege escalation attacks. Because of that, it is usually considered dangerous to use code impersonation.
- **No refined Access Control:** Since the application is using a single System User for ALL users, it means that System Account has to have full access to ALL of the user's data. This could lead to information leakage where users are accidentally exposed to other users data. Also, the users have no say in what kind of data a specific application can access - it is controlled by the system itself.

Because all of those issues, the OAuth protocol doesn't use System Accounts in order to authenticate a client program. Instead of System Accounts, we now have OAuth Apps (clients).

In OAuth, when a client application wants to access a resource (for example our Graph API), the first thing it needs to do is to authenticate itself (meaning which client application is calling the service, not which user is using it). This is done by sending the Client ID and it's matching Client Secret.

So where do we get that Client ID and Secret? We can get it by registering an OAuth app.

## Registering an OAuth App

We can register an OAuth app for the Graph API from the Azure Portal.

Full instructions on how to do so can be found in the official documentation here.

For our needs, this is the minimum which is required:

1. Create a new app in the target directory (Azure Portal > Azure Active Directory > App Registration > New Application Registration).
2. In the Create screen, enter the following information:
    - Name: Can be any name, for example, "MicrosoftGraphClient."
    - Type: Must be "Web App/API" for our needs. **Note:** I did not configure any platform and the credential grant flow still worked and I was able to send email.
    - Sign-On URL: Not important (since we do not intend users to directly login to the app), for our case, we should put it under the tenant directory. For example,https://<directoryname>.onmicrosoft.com/MicrosoftGraphClient
3. Allow public client flows (This was not needed for the basic credential flow only for the resource owner password credential flow)
    - go to Authentication under Advanced settings
    - check Allow public client flows
    This ennables the following mobile and desktop flows:
    - App collects plaintext password **[Resource Owner Password Credential Flow](https://go.microsoft.com/fwlink/?linkid=2144008)
    - No keyboard (Device Code Flow) Learn more
    - SSO for domain-joined Windows (Windows Integrated Auth Flow) Learn more

4. Get the Client ID: Note the Application ID - It is the Client ID, so we need the following steps.
5. Create a new Client Secret: Navigate to App > Keys > Passwordsand add a new key.
    - Name (description): enter a descriptive name for the key so you later know that the client application is using it (you can have more than one key per app).
    - Expires: Choose "Never Expire," unless you want to change your key every year or two.
    - Click Save - a new Client Secret will be generated for you. This will be the only time you will see the Client Secret, so you better copy it to a secured location otherwise you won't be able to retrieve it again!

Fill out this **[app template](../../../../../../../../media/brent/KINGSTON/secrets/azure/tenants/app_template.md)**

## Configuring App Permission

Now that we have created an app, we have to configure its permissions. In the OAuth world, when apps try to access information, they must have the appropriate permissions to do so. Configuring those permissions is a two-step process - first, we need to declare what kind of permissions the app would like to have. Then we need to make sure the app is granted that permission.

1. Setup app permission: Navigate to App > Required Permission > Add > Select an API > "Microsoft Graph" > Select Permission. We see a list of Graph related permissions. Here we can select the permission our app should have, according to the type of information it needs. If we are not sure about which specific permission is required, we can use the API Documentation to find out. For example, since we wanted to access the /Users method, we can find in the Users documentation page that one the permissions which will allow us to call this method is User.Read.All. There are two permission groups: Application Permission and Delegated Permissions, and many permissions exist in both groups. More on that later, for now, select the required permission in both groups.

    ```text
    // I added more permissions
    - Delegated:Mail.Read // Read user mail
    - Delegated:Mail.Send  // Send mail as a user
    - Delegated:User.Read // Sign in and read user profile
    - Application:User.Read.All // Read all users' full profiles
    - Application.Mail.ReadBasic.All // Read basic mail in all mailboxe
    - Application:Mail.Send // Send mail as any user

    // not needed for resource owner password credential flow grant

    - Delegated:offline_access // Maintain access to data you have given it access to
    - Delegated:openid // Sign users in
    - Delegated:profile // needed for openid
        The offline_access permission is a standard OIDC scope that's requested so that the app can get a refresh token. The app can use the refresh token to get a new access token when the current one expires.
    ```

2. Grant App permissions: Now that we have declared what kind of permission our App requires, it's time to grant them to the App. Usually this is done by the user when the app first attempts to access their information, but, for now, we can just "accept" on behalf of all of our tenant users by doing one  of the following:

    a. Clicking the Grant Permissions button in the App > Required Permission section:
    b. Using the admin consent endpoint:

    ```text
    https://login.microsoftonline.com/{TenantDirectory}.onmicrosoft.com/adminconsent?client_id={ApplicationID} 
    ```

In both cases, we end up granting our app the required permissions for all of the users in the directory.

Note: Consenting on behalf of all users is usually only done in specific scenarios, like a background service which requires full access to all tenant data. In most cases, users should consent themselves.

## Getting the Access Token

After we registered our OAuth App, got its Client ID and Secret, and configured its permissions, we can finally use AAD Services in order to get the Access Token.

In OAuth, there are several different ways to achieve access tokens, each suited for different a scenario. Those ways are called "grant flows," and, according to the desired flow, a different message needs to be sent. Let's review our different flows.

## Flow 1: Get an Access Token From Client Credentials (Client Credentials Grant)

The most basic option is to use our Client ID and Secret in order to get an access token. For this, we need to send a POST message to our Azure Active Directory Authentication endpoint (which we talked about before) with following body parameters:

```bash
POST https://login.microsoftonline.com/<AAD_name>/oauth2/token
```

- grant_type: The flow we want to use, client_credentials in this case.
- client_id: The Client ID (Application ID) of the application we created in the previous step.
- client_secret: The Client Secret we created in the previous step.
- resource: The name of the resource we would like to get access, <https://graph.microsoft.com> in this case.

```bash
token=`curl -d "client_id=$CLIENT_ID" \
-d "client_secret=$CLIENT_SECRET" \
-d "grant_type=client_credentials" \
-d "scope=$SCOPE" \
-X POST "$MSFT" \
| jq -j .access_token`
```

Sample can be found at: **[client_credential_test](../../../../../../../../media/brent/KINGSTON/secrets/azure/tenants/msdev_1hkt5t/apps/MicrosoftGraphClient/curl/client_credential.md)**

We will receive a response with a JSON object containing the following properties:

- token_type: The value Bearer
- expires_on: The token expire timestamp in Unix epoch time.
- access_token: The access token we needed to access the Graph API

This option is called Client Credentials Grant Flow and is suitable for machine-to-machine authentication where a specific user's permission to access data is not required.

To learn more about this flow, see: **[Service to service calls using client credentials](https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-protocols-oauth-service-to-service)** (shared secret or certificate)

## Flow 2 - Get Access Token From Client and User Credentials (Resource Owner Credentials Grant)

The first option, while it is the simplest of all (since it only requires the Application ID and Secret), doesn't always work. There are several Graph Methods for which just using the client credentials is not enough - they require user authorization as well. For example, in order to retrieve Group Events, we can see permission ApplicationNot supported, meaning getting access to that resource with just Client Credentials will not work. However, the first line is, Delegated (work or school account): Group.Read.All meaning, if we can get a "delegated permission" we can make this work.

So what does "delegated permission" mean, you ask? Well in simple terms, we need to show the API that not only have we come with an approved Client, we also have to carry a valid User authorization as well. Meaning that our access token needs to contain both a valid Client and User claims.

So how can we do that? There are a couple of ways to achieve that, in this option, we will look at the simplest way - the Resource Owner Credentials Grant.

For this flow, we need to send the following POST message:

```text
POST https://login.microsoftonline.com/{{AAD_name}}/oauth2/token

grant_type: The grant flow we want to use, password in this case.
client_id: The Client ID (Application ID) of the application we created in the previous step.
client_secret: The Client Secret we created in the previous step.
resource: The name of the resource to which we would like to get access, https://graph.microsoft.com in this case.
username: Full username of the user, including the domain, for example, john@contoso.onmicrosoft.com
password: User's plain-text password.
```

We will receive a response with a JSON object containing the following properties:

- token_type: The value Bearer
- expires_on: The token expire timestamp in Unix epoch time.
- access_token: The access token we needed to access the Graph API.
- refresh_token: A refresh token that can be used to acquire a new access token when the original expires.

To learn more about this flow, see: **[Resource Owner Password Credentials Grant in Azure AD OAuth](https://blogs.msdn.microsoft.com/wushuai/2016/09/25/resource-owner-password-credentials-grant-in-azure-ad-oauth/)**.

Besides the access token, we received two additional tokens - Refresh Token and ID Token. They were are not necessary for this flow, but they can be used in other grant flows and this is an example of how to get them. We automatically get the Refresh Token in this flow, and we can get an ID Token by adding to the request scope parameter with the value openid, as seen in the above Postman screenshot.

```bash
SCOPE='https%3A%2F%2Fgraph.microsoft.com%2F.default openid'
```

Sample can be found at: **[Resource Owner Password Credentials Grant in Azure AD OAuth](../../../../../../../../media/brent/KINGSTON/secrets/azure/tenants/msdev_1hkt5t/apps/MicrosoftGraphClient/curl/resource%20_owner_credentials_grant.md)**
