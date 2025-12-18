# **[Register app](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app)**

Get started with the Microsoft identity platform by registering an application in the Azure portal.

The Microsoft identity platform performs identity and access management (IAM) only for registered applications. Whether it's a client application like a web or mobile app, or it's a web API that backs a client app, registering it establishes a trust relationship between your application and the identity provider, the Microsoft identity platform.

## Prerequisites

- An Azure account that has an active subscription. Create an account for free.
- The Azure account must be at least a Cloud Application Administrator.
- Completion of the Set up a tenant quickstart.

## Register an application

Steps in this article might vary slightly based on the portal you start from.

Registering your application establishes a trust relationship between your app and the Microsoft identity platform. The trust is unidirectional: your app trusts the Microsoft identity platform, and not the other way around. Once created, the application object cannot be moved between different tenants.

Follow these steps to create the app registration:

1. Sign in to the Microsoft Entra admin center as at least a Cloud Application Administrator. <brentgroves@1hkt5t.onmicrosoft.com>

2. If you have access to multiple tenants, use the Settings icon  in the top menu to switch to the tenant in which you want to register the application from the Directories + subscriptions menu.

3. Browse to Identity > Applications > App registrations and select New registration.
<brent.groves@outlook.com>
Enter a display Name for your application. Users of your application might see the display name when they use the app, for example during sign-in. You can change the display name at any time and multiple app registrations can share the same name. The app registration's automatically generated Application (client) ID, not its display name, uniquely identifies your app within the identity platform.

Note: New app registrations are hidden to users by default. When you are ready for users to see the app on their My Apps page you can enable it. To enable the app, in the Microsoft Entra admin center navigate to Identity > Applications > Enterprise applications and select the app. Then on the Properties page toggle Visible to users? to Yes.
