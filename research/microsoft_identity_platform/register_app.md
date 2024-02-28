# **[Quickstart: Register an app with the Microsoft identity platform](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app)**

Get started with the Microsoft identity platform by registering an application in the Azure portal.

The Microsoft identity platform performs identity and access management (IAM) only for registered applications. Whether it's a client application like a web or mobile app, or it's a web API that backs a client app, registering it establishes a trust relationship between your application and the identity provider, the Microsoft identity platform.

To register an application for Azure AD B2C, follow the steps in **[Tutorial: Register a web application in Azure AD B2C](https://learn.microsoft.com/en-us/azure/active-directory-b2c/tutorial-register-applications)**.

## Register an application

Steps in this article might vary slightly based on the portal you start from.

Registering your application establishes a trust relationship between your app and the Microsoft identity platform. The trust is unidirectional: your app trusts the Microsoft identity platform, and not the other way around. Once created, the application object cannot be moved between different tenants.

Follow these steps to create the app registration:

1. Sign in to the Microsoft Entra admin center as at least a Cloud Application Administrator.
2. f you have access to multiple tenants, use the Settings icon  in the top menu to switch to the tenant in which you want to register the application from the Directories + subscriptions menu.
3. Browse to Identity > Applications > App registrations and select New registration.

4. Enter a display Name for your application. Users of your application might see the display name when they use the app, for example during sign-in. You can change the display name at any time and multiple app registrations can share the same name. The app registration's automatically generated Application (client) ID, not its display name, uniquely identifies your app within the identity platform.
5. Specify who can use the application, sometimes called its sign-in audience.

| Supported account types                                                  | Description                                                                                                                                                                                                                                                                                                                                                     |
|--------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Accounts in this organizational directory only                           | Select this option if you're building an application for use only by users (or guests) in your tenant.  Often called a line-of-business (LOB) application, this app is a single-tenant application in the Microsoft identity platform.                                                                                                                          |
| Accounts in any organizational directory                                 | Select this option if you want users in any Microsoft Entra tenant to be able to use your application. This option is appropriate if, for example, you're building a software-as-a-service (SaaS) application that you intend to provide to multiple organizations.  This type of app is known as a multitenant application in the Microsoft identity platform. |
| Accounts in any organizational directory and personal Microsoft accounts | Select this option to target the widest set of customers.  By selecting this option, you're registering a multitenant application that can also support users who have personal Microsoft accounts. Personal Microsoft accounts include Skype, Xbox, Live, and Hotmail accounts.                                                                                |
| Personal Microsoft accounts                                              | Select this option if you're building an application only for users who have personal Microsoft accounts. Personal Microsoft accounts include Skype, Xbox, Live, and Hotmail accounts.                                                                                                                                                                          |

6. Don't enter anything for Redirect URI (optional). You'll configure a redirect URI in the next section.

7. Select Register to complete the initial app registration.

![](https://learn.microsoft.com/en-us/entra/identity-platform/media/quickstart-register-app/portal-02-app-reg-01.png#lightbox)

When registration finishes, the Microsoft Entra admin center displays the app registration's Overview pane. You see the Application (client) ID. Also called the client ID, this value uniquely identifies your application in the Microsoft identity platform.

New app registrations are hidden to users by default. When you are ready for users to see the app on their My Apps page you can enable it. To enable the app, in the Microsoft Entra admin center navigate to Identity > Applications > Enterprise applications and select the app. Then on the Properties page toggle Visible to users? to Yes.

Your application's code, or more typically an authentication library used in your application, also uses the client ID. The ID is used as part of validating the security tokens it receives from the identity platform.

![alt](https://learn.microsoft.com/en-us/entra/identity-platform/media/quickstart-register-app/portal-03-app-reg-02.png#lightbox)

## Add a redirect URI

A redirect URI is the location where the Microsoft identity platform redirects a user's client and sends security tokens after authentication.

In a production web application, for example, the redirect URI is often a public endpoint where your app is running, like <https://contoso.com/auth-response>. During development, it's common to also add the endpoint where you run your app locally, like <https://127.0.0.1/auth-response> or <http://localhost/auth-response>. Be sure that any unnecessary development environments/redirect URIs are not exposed in the production app. This can be done by having separate app registrations for development and production.

You add and modify redirect URIs for your registered applications by configuring their **[platform settings](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app#configure-platform-settings)**.

## Configure platform settings

Settings for each application type, including redirect URIs, are configured in Platform configurations in the Azure portal. Some platforms, like Web and Single-page applications, require you to manually specify a redirect URI. For other platforms, like mobile and desktop, you can select from redirect URIs generated for you when you configure their other settings.

To configure application settings based on the platform or device you're targeting, follow these steps:

1. In the Microsoft Entra admin center, in App registrations, select your application.
2. Under Manage, select Authentication.
3. Under Platform configurations, select Add a platform.
4. Under Configure platforms, select the tile for your application type (platform) to configure its settings.

![alt](https://learn.microsoft.com/en-us/azure/active-directory/develop/media/quickstart-register-app/portal-04-app-reg-03-platform-config.png)

| Platform                        | Configuration settings                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
|---------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Web                             | Enter a Redirect URI for your app. This URI is the location where the Microsoft identity platform redirects a user's client and sends security tokens after authentication.  Front-channel logout URL and implicit and hybrid flow properties can also be configured.  Select this platform for standard web applications that run on a server.                                                                                                                                                   |
| Single-page application         | Enter a Redirect URI for your app. This URI is the location where the Microsoft identity platform redirects a user's client and sends security tokens after authentication.  Front-channel logout URL and implicit and hybrid flow properties can also be configured.  Select this platform if you're building a client-side web app by using JavaScript or a framework like Angular, Vue.js, React.js, or Blazor WebAssembly.                                                                    |
| iOS / macOS                     | Enter the app Bundle ID. Find it in Build Settings or in Xcode in Info.plist.  A redirect URI is generated for you when you specify a Bundle ID.                                                                                                                                                                                                                                                                                                                                                  |
| Android                         | Enter the app Package name. Find it in the AndroidManifest.xml file. Also generate and enter the Signature hash.  A redirect URI is generated for you when you specify these settings.                                                                                                                                                                                                                                                                                                            |
| Mobile and desktop applications | Select one of the suggested Redirect URIs. Or specify on or more Custom redirect URIs.  For desktop applications using embedded browser, we recommend <https://login.microsoftonline.com/common/oauth2/nativeclient>  For desktop applications using system browser, we recommend <http://localhost>  Select this platform for mobile applications that aren't using the latest Microsoft Authentication Library (MSAL) or aren't using a broker. Also select this platform for desktop applications. |

5.Select Configure to complete the platform configuration.

## Redirect URI restrictions

There are some restrictions on the format of the redirect URIs you add to an app registration. For details about these restrictions, see **[Redirect URI (reply URL) restrictions and limitations](https://learn.microsoft.com/en-us/entra/identity-platform/reply-url)**.

## Redirect URI (reply URL) restrictions and limitations

A redirect URI, or reply URL, is the location where the authorization server sends the user once the app has been successfully authorized and granted an authorization code or access token. The authorization server sends the code or token to the redirect URI, so it's important you register the correct location as part of the app registration process.

The Microsoft Entra application model specifies these restrictions to redirect URIs:

- Redirect URIs must begin with the scheme https. There are some exceptions for localhost redirect URIs.
- Redirect URIs are case-sensitive and must match the case of the URL path of your running application. For example, if your application includes as part of its path .../abc/response-oidc, do not specify .../ABC/response-oidc in the redirect URI. Because the web browser treats paths as case-sensitive, cookies associated with .../abc/response-oidc may be excluded if redirected to the case-mismatched .../ABC/response-oidc URL.
- Redirect URIs not configured with a path segment are returned with a trailing slash ('/') in the response. This applies only when the response mode is query or fragment.

Examples:

- <https://contoso.com> is returned as <https://contoso.com/>
- <http://localhost:7071> is returned as <http://localhost:7071/>

Redirect URIs that contain a path segment are not appended with a trailing slash in the response.
Examples:

- <https://contoso.com/abc> is returned as <https://contoso.com/abc>
- <https://contoso.com/abc/response-oidc> is returned as <https://contoso.com/abc/response-oidc>

- Redirect URIs do not support special characters - ! $ ' ( ) , ;

## Query parameter support in redirect URIs

Query parameters are allowed in redirect URIs for applications that only sign in users with work or school accounts.

Query parameters are not allowed in redirect URIs for any app registration configured to sign in users with personal Microsoft accounts like Outlook.com (Hotmail), Messenger, OneDrive, MSN, Xbox Live, or Microsoft 365.

## Supported schemes

HTTPS: The HTTPS scheme (https://) is supported for all HTTP-based redirect URIs.

HTTP: The HTTP scheme (http://) is supported only for localhost URIs and should be used only during active local application development and testing.

## Localhost exceptions

Per RFC 8252 sections 8.3 and 7.3, "loopback" or "localhost" redirect URIs come with two special considerations:

http URI schemes are acceptable because the redirect never leaves the device. As such, both of these URIs are acceptable:

- <http://localhost/myApp>
- <https://localhost/myApp>

Due to ephemeral port ranges often required by native applications, the port component (for example, :5001 or :443) is ignored for the purposes of matching a redirect URI. As a result, all of these URIs are considered equivalent:

- <http://localhost/MyApp>
- <http://localhost:1234/MyApp>
- <http://localhost:5000/MyApp>
- <http://localhost:8080/MyApp>

## From a development standpoint, this means a few things

- Do not register multiple redirect URIs where only the port differs. The login server will pick one arbitrarily and use the behavior associated with that redirect URI (for example, whether it's a web-, native-, or spa-type redirect).

    This is especially important when you want to use different authentication flows in the same application registration, for example both the authorization code grant and implicit flow. To associate the correct response behavior with each redirect URI, the login server must be able to distinguish between the redirect URIs and cannot do so when only the port differs.
- To register multiple redirect URIs on localhost to test different flows during development, differentiate them using the path component of the URI. For example, <http://localhost/MyWebApp> doesn't match <http://localhost/MyNativeApp>.
- The IPv6 loopback address ([::1]) is not currently supported.

## Prefer 127.0.0.1 over localhost

To prevent your app from being broken by misconfigured firewalls or renamed network interfaces, use the IP literal loopback address 127.0.0.1 in your redirect URI instead of localhost. For example, <https://127.0.0.1>.

You cannot, however, use the Redirect URIs text box in the Azure portal to add a loopback-based redirect URI that uses the http scheme:

![](https://learn.microsoft.com/en-us/entra/identity-platform/media/reply-url/portal-01-no-http-loopback-redirect-uri.png)

To add a redirect URI that uses the http scheme with the 127.0.0.1 loopback address, you must currently modify the replyUrlsWithType attribute in the application manifest.

## Restrictions on wildcards in redirect URIs

Wildcard URIs like https://*.contoso.com may seem convenient, but should be avoided due to security implications. According to the OAuth 2.0 specification (section 3.1.2 of RFC 6749), a redirection endpoint URI must be an absolute URI. As such, when a configured wildcard URI matches a redirect URI, query strings and fragments in the redirect URI are stripped.

Wildcard URIs are currently unsupported in app registrations configured to sign in personal Microsoft accounts and work or school accounts. Wildcard URIs are allowed, however, for apps that are configured to sign in only work or school accounts in an organization's Microsoft Entra tenant.

To add redirect URIs with wildcards to app registrations that sign in work or school accounts, use the application manifest editor in App registrations in the Azure portal. Though it's possible to set a redirect URI with a wildcard by using the manifest editor, we strongly recommend you adhere to section 3.1.2 of RFC 6749. and use only absolute URIs.

If your scenario requires more redirect URIs than the maximum limit allowed, consider the following state parameter approach instead of adding a wildcard redirect URI

## Use a state parameter

If you have several subdomains and your scenario requires that, upon successful authentication, you redirect users to the same page from which they started, using a state parameter might be helpful.
