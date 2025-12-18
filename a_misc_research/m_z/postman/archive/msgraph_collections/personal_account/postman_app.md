# Postman App

Cant use to call mail api.

## Register your application

Sign in to the Microsoft Entra admin center.
Expand the Identity menu > select Applications > App registrations > New registration.
Set the Application name to Postman.
Set supported account types as desired.
From the dropdown menu under Redirect URI, select Web.
Set the Redirect URI to <https://oauth.pstmn.io/v1/browser-callback>.
Select Register.

### Get the client ID and secret

On the left menu, select Overview. From here, you can get the application (client) ID and directory (tenant) ID. You'll need these in Step 3: Set up environment variables (next folder).
On the left menu, select Certificates and secrets.
Select New client secret, enter a description, and then select Add. Hover over the new client secret Value and copy it; you'll need this in Step 3: Set up environment variables (next folder).

The application now has two permissions configured. Mail.Read is added as a delegated permission, which is a permission that requires a signed-in user. The application can read mail on behalf of the user. User.Read.All is added as an application permission, which is a permission that does not require a signed-in user. The application can read users in Azure AD.

### Postman App details

```bash
tenant_name: My personal M365 tenant
Principal User: brent.groves@outlook.com/Spirit1$!
Token Name: Delegated Token
Grant Type: Authorization Code
Callback URL: https://oauth.pstmn.io/v1/browser-callback
Auth URL: https://login.microsoftonline.com/{{TenantID}}/oauth2/v2.0/authorize
Access Token URL: https://login.microsoftonline.com/{{TenantID}}/oauth2/v2.0/token
TenantId: 07476fd3-6a57-4e3f-80ab-a1be2af5d10a
ClientId: 4bf317c1-3185-469f-8f13-8c37ccb2c31c
ClientId: {{ClientID}}
# this is the app secret value not its id
ClientSecret: km78Q~h6peVsoA5aJKWBmH6JXoIItOO2OPBeKbEk
ClientSecret: {{ClientSecret}}
Scope: https://graph.microsoft.com/.default
State: 12345
Client Authentication: Send as basic auth headers
```

## Delegated

### Delegated Permissions

Before the Microsoft identity platform can authorize your app to access data through Microsoft Graph, the app must be granted the privileges that it needs.
One way to grant an app the privileges it needs to access and work with your data through Microsoft Graph is by assigning it Microsoft Graph permissions.
This folder contains the APIs that require **[delegated](https://learn.microsoft.com/en-us/graph/permissions-overview?tabs=http#delegated-permissions)** permissions. They're permissions that allow the application to act on behalf of a signed-in user.

### To Get Started

You will need to set up delegated authorization for this folder. Go to the folder Delegated > Set up delegated authentication to follow the step-by-step guide to run your first delegated request.
After your application is authenticated, you can decide which Microsoft Graph **[permissions](https://learn.microsoft.com/en-us/graph/permissions-overview?tabs=http)** to add to your Azure Active Directory application based on the access scenario and the operations you want to perform.
To find the right permissions, check the Permissions section of the relevant **[API reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true)**  page and look for the delegated permission type.

### Set up delegated authentication

This folder describes how you can use delegated authentication with Postman for Microsoft Graph to run requests on behalf of the signed-in user.

### Prerequisite

Complete the setup instructions in the Get started folder, before you can continue with this tutorial.

### Step 1: Get a delegated access token

The first time you run a request as a delegated authentication flow, you need to get an access token:

1. Select the Delegated folder.
2. Select the Authorization tab.
3. In the Configure New Token section, make sure the callback URL matches with what you provided when you created the application registration, for example, <https://oauth.pstmn.io/v1/browser-callback>. Leave all the fields as preconfigured, including the Grant type that is set to Authorization Code.

For personal account which uses Delegated permission (you have tried in Microsoft Graph Explorer), the authority endpoint is <https://login.microsoftonline.com/commonm/oauth2/v2.0/authorize> or <https://login.microsoftonline.com/consumers/oauth2/v2.0/authorize>.

4. Scroll down on the right and select Get New Access Token.
5. Sign in with your developer tenant administrator account.
6. Select Proceed, and then select the Use Token button.

You have now a valid access token to use for delegated requests.

### Step 2: Run your first delegated request

The Delegated folder contains many requests for Microsoft Graph workloads that you can consume:

1. Expand the Delegated folder, and then expand the Mail folder.
2. Double-click Get my messages to open the request.
3. On the top right, select Send.

{
    "error": {
        "code": "MailboxNotEnabledForRESTAPI",
        "message": "The mailbox is either inactive, soft-deleted, or is hosted on-premise."
    }
}

## question

MailboxNotEnabledForRESTAPI postman graph explorer
<https://stackoverflow.com/questions/65426179/microsoft-graph-to-send-mail-with-client-credential-flow-application-permission>

"MailboxNotEnabledForRESTAPI - REST API is not yet supported for this mailbox" This error message means that the email account you are using to send email doesn't have an Exchange Online license.

For a personal account, you should use Delegated permission, which you have tried in Microsoft Graph Explorer. See Permissions here.

If we add the personal account to your tenant as a guest user, although we can Assign a license to a guest user (I assume we can assign EXO license to the guest user), the mailbox hosted in EXO is different from the mailbox of the personal account. They are totally 2 separated mailboxes. And in fact I failed to assign EXO license to the guest.

So in this case Client Credential Flow applies to the AAD users, not the personal account.

UPDATE:

For personal account which uses Delegated permission (you have tried in Microsoft Graph Explorer), the authority endpoint is <https://login.microsoftonline.com/commonm/oauth2/v2.0/authorize> or <https://login.microsoftonline.com/consumers/oauth2/v2.0/authorize>.

But when you use client credential flow with Application permission, you have to specify the tenant id in the request <https://login.microsoftonline.com/{tenant> id}/oauth2/v2.0/authorize.

Although your personal account is added into the tenant as a guest user, it doesn't have EXO license (based on test we are unable to assign EXO license to it), so it won't be hosted in O365.

That is why we can't use client credential flow with personal account.

Can access emails of m365 personal account using the Microsoft graph explorer by calling "<https://graph.microsoft.com/v1.0/me/messages> " but cannot access emails using the postman microsoft graph api collection,<https://www.postman.com/microsoftgraph/workspace/microsoft-graph/overview>, and get this error "MailboxNotEnabledForRESTAPI"

Are you sure the account you use to sign into Graph Explorer are the same as the one used in UsernamePasswordProvider? Is it a work account (O365 or AAD account) or personal account (MSA)?

**[Use the Outlook mail REST API](https://learn.microsoft.com/en-us/graph/api/resources/mail-api-overview?view=graph-rest-1.0)**

<https://learn.microsoft.com/en-us/exchange/troubleshoot/user-and-shared-mailboxes/rest-api-is-not-yet-supported-for-this-mailbox-error>

### Cause

This error can occur if the mailbox is on a dedicated Microsoft Exchange Server and is not a valid Microsoft 365 mailbox.

### Resolution

To get a valid Microsoft 365 mailbox, submit a request to your Exchange or Global administrator to migrate the mailbox account. Users who don't have administrator permissions can't migrate accounts. For information on how to migrate the mailbox account, see How to migrate mailbox data by using the Exchange Admin Center in Microsoft 365.

Microsoft Graph lets your app get authorized access to a user's Outlook mail data in a personal or organization account. With the appropriate delegated or application mail permissions, your app can access the mail data of the signed-in user or any user in a tenant. For more information on access tokens, app registration, and delegated and application permissions, see Authentication and authorization basics.

The Microsoft Graph API supports accessing data in users' primary mailboxes and in shared mailboxes. The data can be calendar, mail, or personal contacts stored in a mailbox in the cloud on Exchange Online as part of Microsoft 365, or on Exchange on-premises in a hybrid deployment.

The API does not support accessing in-place archive mailboxes, not on Exchange Online nor on Exchange Server.

You have now successfully run a Microsoft Graph request using delegated authentication.
You can repeat these steps to run other requests to Microsoft Graph (ex. requests in the Sample delegated request folder below). Note that you have to add **[permissions](https://learn.microsoft.com/en-us/graph/permissions-reference)** to your Azure Active Directory application for other requests to work; otherwise, you get permission denied errors in your responses. To find the right permissions, check the Permissions section of the relevant API in the **[Microsoft Graph API Reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true)** docs and look for the delegated permission type.

## Next Steps

Now that you have successfully made a Microsoft Graph call using delegated authentication, proceed to the folder: Application > Set up app-only authentication to run your first application request.

## Application

Application Permissions
Before the Microsoft identity platform can authorize your app to access data through Microsoft Graph, the app must be granted the privileges that it needs.

One way to grant an app the privileges it needs to access and work with your data through Microsoft Graph is by assigning it Microsoft Graph permissions.

This folder contains the APIs that require application permissions. They're permissions that allow the application to act with its own identity, without a signed-in user present.

## To Get Started application access

You will need to set up app-only authorization for this folder. Click **[here](https://www.postman.com/microsoftgraph/workspace/microsoft-graph/folder/455214-1db05515-e045-482a-8d70-9eb21b651c0b)**  to follow the step-by-step guide to run your first app-only request.
After your application is authenticated, you can decide which Microsoft Graph permissions to add to your Azure Active Directory application based on the access scenario and the operations you want to perform.
To find the right permissions, check the Permissions section of the relevant API reference page and look for the delegated permission type.

## Set up app-only authentication

This folder describes how you can use app-only (application) authentication with Postman for Microsoft Graph to run requests without a signed-in user.

## app-onlyPrerequisite

Complete the setup instructions in the Get started folder, before you can continue with this tutorial.

## Step 1: Get an application access token

The first time you run a request as an application authentication flow, you need to get an access token:

1. Select the Application folder.
2. Select the Authorization tab.
3. In the Configure New Token section, leave all the fields as preconfigured, including the Grant type that is set to Client Credentials.
4. Scroll down on the right and select Get New Access Token.
5. Select Proceed, and then select the Use Token button.
6. You have now a valid access token to use for application requests.

## Step 2: Run your first application request

The Application folder contains many requests for Microsoft Graph workloads that you can consume:

1. Expand the Application folder, and then expand the User folder.
2. Double-click Get Users to open the request.
3. On the top right, select Send.

You have now successfully run a Microsoft Graph request using application authentication.

You can repeat these steps to run other requests to Microsoft Graph (ex. requests in the Sample app-only requests folder below). Note that you have to add permissions to your Azure Active Directory application for other requests to work; otherwise, you get permission denied errors in your responses. To find the right permissions, check the Permissions section of the relevant API in the Microsoft Graph API Reference docs and look for the delegated permission type.
