# **[Authentication Flow](https://learn.microsoft.com/en-us/graph/auth-v2-user?tabs=curl)**

## Get access on behalf of a user

To call Microsoft Graph, an app must obtain an access token from the Microsoft identity platform. This access token includes information about whether the app is authorized to access Microsoft Graph on behalf of a signed-in user or with its own identity. This article provides guidance on how an app can access Microsoft Graph on behalf of a user, also called delegated access.

This article details the raw HTTP requests involved for an app to get access on behalf of a user using a popular flow called the OAuth 2.0 authorization code grant flow. Alternatively, you can avoid writing raw HTTP requests and use a Microsoft-built or supported authentication library that handles many of these details for you and helps you to get access tokens and call Microsoft Graph. For more information, see Use the Microsoft Authentication Library (MSAL).

Prerequisites
Before proceeding with the steps in this article:

Understand the authentication and authorization concepts in the Microsoft identity platform. For more information, see Authentication and authorization basics.
Register the app with Microsoft Entra ID. For more information, see Register an application with the Microsoft identity platform.

## Authentication and authorization steps

For an app to get authorization and access to Microsoft Graph using the authorization code flow, you must follow these five steps:

Register the app with Microsoft Entra ID.
Request authorization.
Request an access token.
Use the access token to call Microsoft Graph.
[Optional] Use the refresh token to renew an expired access token.

## 1. Register the app

Before the app can call the Microsoft identity platform endpoints or Microsoft Graph, it must be properly registered. Follow the steps to register your app on the Microsoft Entra admin center.

From the app registration, save the following values:

The application ID (referred to as Object ID on the Microsoft Entra admin center) assigned by the app registration portal.
A redirect URI (or reply URL) for the app to receive responses from Microsoft Entra ID.
A client secret (application password), a certificate, or a federated identity credential. This property isn't needed for public clients like native, mobile and single page applications.

## 2. Request authorization

The first step in the authorization code flow is for the user to authorize the app to act on their behalf.

In the flow, the app redirects the user to the Microsoft identity platform /authorize endpoint. Through this endpoint, Microsoft Entra ID signs the user in and requests their consent for the permissions that the app requests. After consent is obtained, Microsoft Entra ID will return an authorization code to the app. The app can then redeem this code at the Microsoft identity platform /token endpoint for an access token.

Authorization request
The following example shows a request to the /authorize endpoint.

In the request URL, you call the /authorize endpoint and specify the required and recommended properties as query parameters.

In the following example, the app requests the User.Read and Mail.Read Microsoft Graph permissions, which allow the app to read the profile and mail of the signed-in user respectively. The offline_access permission is a standard OIDC scope that's requested so that the app can get a refresh token. The app can use the refresh token to get a new access token when the current one expires.

```curl
curl --location --request GET 'https://login.microsoftonline.com/{tenant}/oauth2/v2.0/authorize?client_id=11111111-1111-1111-1111-111111111111&response_type=code&redirect_uri=https%3A%2F%2Flocalhost%2Fmyapp%2F&response_mode=query&scope=offline_access%20User.Read%20Mail.Read&state=12345'
```
