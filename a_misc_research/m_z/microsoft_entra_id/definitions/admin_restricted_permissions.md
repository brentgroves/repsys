# **[Admin-restricted permissions](https://learn.microsoft.com/en-us/entra/identity-platform/scopes-oidc#admin-restricted-permissions)**

Permissions in the Microsoft identity platform can be set to admin restricted. For example, many higher-privilege Microsoft Graph permissions require admin approval. If your app requires admin-restricted permissions, an organization's administrator must consent to those scopes on behalf of the organization's users. The following section gives examples of these kinds of permissions:

## references

<https://learn.microsoft.com/en-us/entra/identity-platform/scopes-oidc#admin-restricted-permissions>

## Admin restricted permissions Examples

- User.Read.All: Read all user's full profiles
- Directory.ReadWrite.All: Write data to an organization's directory
- Groups.Read.All: Read all groups in an organization's directory

In requests to the authorization, token or consent endpoints for the Microsoft identity platform, if the resource identifier is omitted in the scope parameter, the resource is assumed to be Microsoft Graph. For example, scope=User.Read is equivalent to <https://graph.microsoft.com/User.Read>.

Although a consumer user might grant an application access to this kind of data, organizational users can't grant access to the same set of sensitive company data. If your application requests access to one of these permissions from an organizational user, the user receives an error message that says they're not authorized to consent to your app's permissions.

If the application requests application permissions and an administrator grants these permissions this grant isn't done on behalf of any specific user. Instead, the client application is granted permissions directly. These types of permissions should only be used by daemon services and other non-interactive applications that run in the background. For more information on the direct access scenario, see Access scenarios in the Microsoft identity platform.

For a step by step guide on how to expose scopes in a web API, see **[Configure an application to expose a web API](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-configure-app-expose-web-apis)**.
