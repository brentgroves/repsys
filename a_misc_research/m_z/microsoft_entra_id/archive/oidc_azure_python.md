# Tutorial

This article uses a sample Python web application to illustrate how to add Azure Active Directory B2C (Azure AD B2C) authentication to your web applications.

## references

<https://learn.microsoft.com/en-us/azure/active-directory-b2c/configure-authentication-sample-python-web-app?tabs=linux>

## Configure authentication in a sample Python web app by using Azure AD B2C

## Overview

OpenID Connect (OIDC) is an authentication protocol that's built on OAuth 2.0. You can use OIDC to securely sign users in to an application. This web app sample uses the identity package for Python to simplify adding authentication and authorization support to Python web apps.

The sign-in flow involves the following steps:

1. Users go to the web app and select Sign-in.
2. The app initiates an authentication request and redirects users to Azure AD B2C.
3. Users sign up or sign in, reset the password, or sign in with a social account.
4. After users sign in successfully, Azure AD B2C returns an ID token to the app.
5. The app exchanges the authorization code with an ID token, validates the ID token, reads the claims, and then returns a secure page to users.

## Prerequisites

An Azure account with an active subscription. Create an account for free.
If you don't have one already, create an Azure AD B2C tenant that is linked to your Azure subscription.
Python 3.7+

## Step 1: Configure your user flow

When users try to sign in to your app, the app starts an authentication request to the authorization endpoint via a user flow. The user flow defines and controls the user experience. After users complete the user flow, Azure AD B2C generates a token and then redirects users back to your application.

If you haven't done so already, create a user flow or a custom policy. Repeat the steps to create three separate user flows as follows:

- A combined Sign in and sign up user flow, such as susi. This user flow also supports the Forgot your password experience.
- A Profile editing user flow, such as edit_profile.
- A Password reset user flow, such as reset_password.

- ### Sign-up and sign-in flow

<https://learn.microsoft.com/en-us/azure/active-directory-b2c/add-sign-up-and-sign-in-policy?pivots=b2c-user-flow>

Sign-up and sign-in policy lets users:

- Sign-up with local account
- Sign-in with local account
- Sign-up or sign-in with a social account
- Password reset

b2c_1_sign_in
