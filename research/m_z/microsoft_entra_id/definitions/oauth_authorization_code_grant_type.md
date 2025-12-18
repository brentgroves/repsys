# OAuth authorization code grant type

## refereneces

<https://developer.okta.com/blog/2018/04/10/oauth-authorization-code-grant-type>

## What is the OAuth 2.0 Authorization Code Grant Type?

The Authorization Code Grant Type is probably the most common of the OAuth 2.0 grant types that you’ll encounter. It is used by both web apps and native apps to get an access token after a user authorizes an app.

This post is the first part of a series where we explore frequently used OAuth 2.0 grant types. If you want to back up a bit and learn more about OAuth 2.0 before we dive in, check out What the Heck is OAuth?, also on the Okta developer blog.

## What is an OAuth 2.0 Grant Type?

In OAuth 2.0, the term “grant type” refers to the way an application gets an access token. OAuth 2.0 defines several grant types, including the authorization code flow. OAuth 2.0 extensions can also define new grant types.

Each grant type is optimized for a particular use case, whether that’s a web app, a native app, a device without the ability to launch a web browser, or server-to-server applications.
