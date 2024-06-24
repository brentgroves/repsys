# **[Access Token](https://docs.progress.com/bundle/datadirect-aha-odbc-80/page/Access-Token.html)**

Specifies the access token used to authenticate to Aha! with OAuth 2.0 enabled. Typically, this option is configured by the application; however, in some scenarios, you may need to secure a token using external processes. In those instances, you can also use this option to set the access token manually.

is an access token you have obtained from the authentication service.

Notes
Access tokens are temporary and must be replaced to maintain the session without interruption. The life of an access token is typically one hour.

See "OAuth 2.0 authentication" for examples and more information.

## **[Aha! Oauth2](https://www.aha.io/api/oauth2)**

## OAuth2 Authentication

OAuth2 is the preferred method of authenticating access to the API. OAuth2 allows authorization without the external application getting the user's email address or password. Instead, the external application gets a token that authorizes access to the user's account. The user can revoke the token for one application without affecting access by any other application.

## Authentication options

All Aha! API keys are tied to a specific user and account in accordance with security best practices. This ensures that every action taken inside Aha! is traceable to a specific user. We do not currently offer authentication outside the context of specific users.

Application authentication can be achieved in multiple ways depending on your architecture:

- Option 1: Use an existing Aha! user account API key. All actions taken by your application will be attributed to this user.
- Option 2: Create an Aha! user specifically for your application API access and assign it appropriate permissions and manage its API keys. This would just be another user in your Aha! account but you can use it like a "service account."
- Option 3: Create an OAuth2 application in your Aha! account and then implement the OAuth2 flow in your application. Each user of your application would have to be a valid Aha! user and they would be required to authorize the application. Each user that uses/authorizes the application would get redirected to your application with an OAuth2 token for each individual user that could be used to call the Aha! API on behalf of that user.
