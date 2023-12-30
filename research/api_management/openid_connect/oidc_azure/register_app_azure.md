# Register an app in Azure AD

## references

<https://learn.microsoft.com/en-us/azure/active-directory-b2c/tutorial-register-applications>

## Developer

<https://developer.microsoft.com/>
this is a moch company setup with many users.
brentgroves
<brentgroves@1hkt5t.onmicrosoft.com>
<AlexW@1hkt5t.onmicrosoft.com>
EAxejwisiakJip3
domain:1hkt5t.onmicrosoft.com

don't remember what <brent.groves@outlook.com> is for
but it has an Azure data factory and SQL server it also had a 1 node aks but I deleted it because it was a couple hundred dollars per month.

Used AzureTokenTest most recently for web app testing.

## Tutorial: Register a web application in Azure Active Directory B2C

Before your applications can interact with Azure Active Directory B2C (Azure AD B2C), they must be registered in a tenant that you manage. This tutorial shows you how to register a web application using the Azure portal.

A "web application" refers to a traditional web application that performs most of the application logic on the server. They may be built using frameworks like ASP.NET Core, Spring (Java), Flask (Python), or Express (Node.js).

If you're using a single-page application ("SPA") instead (such as using Angular, Vue, or React), learn how to register a single-page application.

If you're using a native app instead (such as iOS, Android, mobile & desktop), learn how to register a native client application.

## Prerequisites

If you don't have an Azure subscription, create a free account before you begin.

If you haven't already created your own Azure AD B2C Tenant, create one now. You can use an existing Azure AD B2C tenant.

## Register a web application

To register a web application in your Azure AD B2C tenant, you can use our new unified App registrations. Learn more about the new experience.

## App registrations

1. Sign in to the Azure portal.

2. If you have access to multiple tenants, select the Settings icon in the top menu to switch to your Azure AD B2C tenant from the Directories + subscriptions menu.

3. In the Azure portal, search for, then select Azure AD B2C.

4. Select App registrations, and then select New registration.

5. Enter a Name for the application. For example, webapp1.

6. Under Supported account types, select Accounts in any identity provider or organizational directory (for authenticating users with user flows).

7. Under Redirect URI, select Web, and then enter <https://jwt.ms> in the URL text box.

The redirect URI is the endpoint to which the user is sent by the authorization server (Azure AD B2C, in this case) after completing its interaction with the user, and to which an access token or authorization code is sent upon successful authorization. In a production application, it's typically a publicly accessible endpoint where your app is running, like <https://contoso.com/auth-response>. For testing purposes like this tutorial, you can set it to <https://jwt.ms>, a Microsoft-owned web application that displays the decoded contents of a token (the contents of the token never leave your browser). During app development, you might add the endpoint where your application listens locally, like <https://localhost:5000>. You can add and modify redirect URIs in your registered applications at any time.
