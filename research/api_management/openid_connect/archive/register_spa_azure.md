# Register an SPA app in Azure AD

I never did one of these.

## references

<https://learn.microsoft.com/en-us/azure/active-directory-b2c/tutorial-register-spa>

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

## Register a single-page application in Azure Active Directory B2C

Before your applications can interact with Azure Active Directory B2C (Azure AD B2C), they must be registered in a tenant that you manage. This guide shows you how to register a single-page application ("SPA") using the Azure portal.

Overview of authentication options
Many modern web applications are built as client-side single-page applications ("SPAs"). Developers write them by using JavaScript or an SPA framework such as Angular, Vue, and React. These applications run on a web browser and have different authentication characteristics than traditional server-side web applications.

Azure AD B2C provides two options to enable single-page applications to sign in users and get tokens to access back-end services or web APIs:

## Authorization code flow (with PKCE)

OAuth 2.0 Authorization code flow (with PKCE) allows the application to exchange an authorization code for ID tokens to represent the authenticated user and Access tokens needed to call protected APIs. In addition, it returns Refresh tokens that provide long-term access to resources on behalf of users without requiring interaction with those users.

This is the recommended approach. Having limited-lifetime refresh tokens helps your application adapt to modern browser cookie privacy limitations, like Safari ITP.

To take advantage of this flow, your application can use an authentication library that supports it, like MSAL.js.

## Implicit grant flow

Some libraries, like MSAL.js 1.x, only support the implicit grant flow or your applications is implemented to use implicit flow. In these cases, Azure AD B2C supports the OAuth 2.0 implicit flow. The implicit grant flow allows the application to get ID and Access tokens. Unlike the authorization code flow, implicit grant flow doesn't return a Refresh token.

This authentication flow doesn't include application scenarios that use cross-platform JavaScript frameworks such as Electron and React-Native. Those scenarios require further capabilities for interaction with the native platforms.

## Prerequisites

If you don't have an Azure subscription, create a free account before you begin.

If you don't have an Azure AD B2C Tenant, create one now. You can use an existing Azure AD B2C tenant.

## Register the SPA application

1. Sign in to the Azure portal.

2. If you have access to multiple tenants, select the Settings icon in the top menu to switch to your Azure AD B2C tenant from the Directories + subscriptions menu.

3. In the Azure portal, search for and select Azure AD B2C.

4. Select App registrations, and then select New registration.

5. Enter a Name for the application. For example, spaapp1.

6. Under Supported account types, select Accounts in any identity provider or organizational directory (for authenticating users with user flows)

7. Under Redirect URI, select Single-page application (SPA), and then enter <https://jwt.ms> in the URL text box.
