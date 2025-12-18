# Quickstart: **[Configure an application to expose a web API](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-configure-app-expose-web-apis)**

In this quickstart, you'll register a web API with the Microsoft identity platform and expose it to client apps by adding a scope. By registering your web API and exposing it through scopes, assigning an owner and app role, you can provide permissions-based access to its resources to authorized users and client apps that access your API.

## Register the web API

Access to APIs require configuration of access scopes and roles. If you want to expose your resource application web APIs to client applications, configure access scopes and roles for the API. If you want a client application to access a web API, configure permissions to access the API in the app registration.

To provide scoped access to the resources in your web API, you first need to register the API with the Microsoft identity platform.

Perform the steps in the Register an application section of **[Quickstart: Register an app with the Microsoft identity platform](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app)**.

Skip the Redirect URI (optional) section. You don't need to configure a redirect URI for a web API since no user is logged in interactively.
