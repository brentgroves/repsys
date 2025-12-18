# **[User and admin consent in Microsoft Entra ID](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/user-admin-consent-overview)**

## User consent

A user can authorize an application to access some data at the protected resource, while acting as that user. The permissions that allow this type of access are called "delegated permissions."

User consent is usually initiated when a user signs in to an application. After the user has provided sign-in credentials, they're checked to determine whether consent has already been granted. If no previous record of user or admin consent for the required permissions exists, the user is directed to the consent prompt window to grant the application the requested permissions.

User consent by non-administrators is possible only in organizations where user consent is allowed for the application and for the set of permissions the application requires. If user consent is disabled, or if users aren't allowed to consent for the requested permissions, they won't be prompted for consent. If users are allowed to consent and they accept the requested permissions, the consent is recorded and they usually don't have to consent again on future sign-ins to the same application.

## User consent settings

Users are in control of their data. A Privileged Administrator can configure whether non-administrator users are allowed to grant user consent to an application. This setting can take into account aspects of the application and the application's publisher, and the permissions being requested.

As an administrator, you can choose whether user consent is allowed. If you choose to allow user consent, you can also choose what conditions must be met before an application can be consented to by a user.

By choosing which application consent policies apply for all users, you can set limits on when users are allowed to grant consent to applications and on when they’ll be required to request administrator review and approval. The Microsoft Entra admin center provides the following built-in options:
