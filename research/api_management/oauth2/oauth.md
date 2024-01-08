# OAuth

## references

<https://developer.okta.com/blog/2017/06/21/what-the-heck-is-oauth>

## What the Heck is OAuth?

There’s a lot of confusion around what OAuth actually is.

Some people think OAuth is a login flow (like when you sign into an application with Google Login), and some people think of OAuth as a “security thing”, and don’t really know much more than that.

I’m going to show you what OAuth is, explain how it works, and hopefully leave you with a sense of how and where OAuth can benefit your application.

## What Is OAuth?

To begin at a high level, OAuth is not an API or a service: it’s an open standard for authorization and anyone can implement it.

More specifically, OAuth is a standard that apps can use to provide client applications with “secure delegated access”. OAuth works over HTTPS and authorizes devices, APIs, servers, and applications with access tokens rather than credentials.

There are two versions of OAuth: OAuth 1.0a and OAuth 2.0. These specifications are completely different from one another, and cannot be used together: there is no backwards compatibility between them.

Which one is more popular? Great question! Nowadays, OAuth 2.0 is the most widely used form of OAuth. So from now on, whenever I say “OAuth”, I’m talking about OAuth 2.0 – as it’s most likely what you’ll be using.

## Why OAuth?

OAuth was created as a response to the direct authentication pattern. This pattern was made famous by HTTP Basic Authentication, where the user is prompted for a username and password. Basic Authentication is still used as a primitive form of API authentication for server-side applications: instead of sending a username and password to the server with each request, the user sends an API key ID and secret. Before OAuth, sites would prompt you to enter your username and password directly into a form and they would login to your data (e.g. your Gmail account) as you. This is often called the password anti-pattern.

To create a better system for the web, federated identity was created for single sign-on (SSO). In this scenario, an end user talks to their identity provider, and the identity provider generates a cryptographically signed token which it hands off to the application to authenticate the user. The application trusts the identity provider. As long as that trust relationship works with the signed assertion, you’re good to go. The diagram below shows how this works.

![](https://developer.okta.com/assets-jekyll/browser_spa_implicit_flow-9116158c9299208718b42a75921acd10a60e4c829edee55a8f14a9ce8de40028.png)

Federated identity was made famous by SAML 2.0, an OASIS Standard released on March 15, 2005. It’s a large spec but the main two components are its authentication request protocol (aka Web SSO) and the way it packages identity attributes and signs them, called SAML assertions. Okta does this with its SSO chiclets. We send a message, we sign the assertion, inside the assertion it says who the user is, and that it came from Okta. Slap a digital signature on it and you’re good to go.

## SAML

SAML is basically a session cookie in your browser that gives you access to webapps. It’s limited in the kinds of device profiles and scenarios you might want to do outside of a web browser.

When SAML 2.0 was launched in 2005, it made sense. However, a lot has changed since then. Now we have modern web and native application development platforms. There are Single Page Applications (SPAs) like Gmail/Google Inbox, Facebook, and Twitter. They have different behaviors than your traditional web application, because they make AJAX (background HTTP calls) to APIs. Mobile phones make API calls too, as do TVs, gaming consoles, and IoT devices. SAML SSO isn’t particularly good at any of this.

## OAuth and APIs

A lot has changed with the way we build APIs too. In 2005, people were invested in WS-* for building web services. Now, most developers have moved to REST and stateless APIs. REST is, in a nutshell, HTTP commands pushing JSON packets over the network.

Developers build a lot of APIs. The API Economy is a common buzzword you might hear in boardrooms today. Companies need to protect their REST APIs in a way that allows many devices to access them. In the old days, you’d enter your username/password directory and the app would login directly as you. This gave rise to the delegated authorization problem.

“How can I allow an app to access my data without necessarily giving it my password?”

If you’ve ever seen one of the dialogs below, that’s what we’re talking about. This is an application asking if it can access data on your behalf.

![](https://developer.okta.com/assets-jekyll/blog/oauth/biketoworkday-fb-login-f00e39aabbf3e44bc3570333643cbf5d966fc27367dbffd2623ff4a3694831c3.png)

## This is OAuth

OAuth is a delegated authorization framework for REST/APIs. It enables apps to obtain limited access (scopes) to a user’s data without giving away a user’s password. It decouples authentication from authorization and supports multiple use cases addressing different device capabilities. It supports server-to-server apps, browser-based apps, mobile/native apps, and consoles/TVs.

You can think of this like hotel key cards, but for apps. If you have a hotel key card, you can get access to your room. How do you get a hotel key card? You have to do an authentication process at the front desk to get it. After authenticating and obtaining the key card, you can access resources across the hotel.

To break it down simply, OAuth is where:

- App requests authorization from User
- User authorizes App and delivers proof
- App presents proof of authorization to server to get a Token
- Token is restricted to only access what the User authorized for the specific App

## OAuth Central Components

OAuth is built on the following central components:

- Scopes and Consent
- Actors
- Clients
- Tokens
- Authorization Server
- Flows

## OAuth Scopes

Scopes are what you see on the authorization screens when an app requests permissions. They’re bundles of permissions asked for by the client when requesting a token. These are coded by the application developer when writing the application.

![](https://developer.okta.com/assets-jekyll/blog/oauth/oauth-scopes-7ea53a0efe6c05a8113671297f641baae7486dfb6ab8b8357c74cb6e6f8371ce.png)

## OAuth permissions for OpenStack.org

OpenStack.org website

This app would like to:
Allow access to your profile info.
Allow access to your email info.
Allow access to your address info.
Use Openid Connect Protocol
Allow to emit refresh tokens (offline access without user presence).
** OpenStack.org website Application and OpenInfra Foundation will use this information in accordance with their respective terms of service and privacy policies.

Scopes decouple authorization policy decisions from enforcement. This is the first key aspect of OAuth. The permissions are front and center. They’re not hidden behind the app layer that you have to reverse engineer. They’re often listed in the API docs: here are the scopes that this app requires.

You have to capture this consent. This is called trusting on first use. It’s a pretty significant user experience change on the web. Most people before OAuth were just used to name and password dialog boxes. Now you have this new screen that comes up and you have to train users to use. Retraining the internet population is difficult. There are all kinds of users from the tech-savvy young folk to grandparents that aren’t familiar with this flow. It’s a new concept on the web that’s now front and center. Now you have to authorize and bring consent.

The consent can vary based on the application. It can be a time-sensitive range (day, weeks, months), but not all platforms allow you to choose the duration. One thing to watch for when you consent is that the app can do stuff on your behalf - e.g. LinkedIn spamming everyone in your network.

OAuth is an internet-scale solution because it’s per application. You often have the ability to log in to a dashboard to see what applications you’ve given access to and to revoke consent.

## OAuth Actors

The actors in OAuth flows are as follows:

- Resource Owner: owns the data in the resource server. For example, I’m the Resource Owner of my Facebook profile.
- Resource Server: The API which stores data the application wants to access
- Client: the application that wants to access your data
- Authorization Server: The main engine of OAuth

<https://www.redhat.com/architect/oauth-20-authentication-keycloak>
