# **[Application types for the Microsoft identity platform](https://learn.microsoft.com/en-us/entra/identity-platform/v2-app-types)**

The Microsoft identity platform supports authentication for various modern app architectures, all of them based on industry-standard protocols OAuth 2.0 or OpenID Connect. This article describes the types of apps that you can build by using Microsoft identity platform, regardless of your preferred language or platform. The information is designed to help you understand high-level scenarios before you start working with the code in the application scenarios.

## The basics

You must register each app that uses the Microsoft identity platform in the Microsoft Entra admin center App registrations. The app registration process collects and assigns these values for your app:

- An Application (client) ID that uniquely identifies your app
- A Redirect URI that you can use to direct responses back to your app
- A few other scenario-specific values such as supported account types
