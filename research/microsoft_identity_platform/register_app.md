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

New app registrations are hidden to users by default. When you are ready for users to see the app on their My Apps page you can enable it. To enable the app, in the Microsoft Entra admin center navigate to Identity > Applications > Enterprise applications and select the app. Then on the Properties page toggle Visible to users? to Yes.

![alt](https://learn.microsoft.com/en-us/entra/identity-platform/media/quickstart-register-app/portal-03-app-reg-02.png#lightbox)
