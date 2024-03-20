# **[Overview of admin consent workflow](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/admin-consent-workflow-overview)**

**[grant admin consent](https://learn.microsoft.com/en-us/cli/azure/ad/app/permission?view=azure-cli-latest)**

There may be situations where your end-users need to consent to permissions for applications that they're creating or using with their work accounts. However, non-admin users aren't allowed to consent to permissions that require admin consent. Also, users can’t consent to applications when user consent is disabled in the user’s tenant.

In such situations where user consent is disabled, an admin can grant users the ability to make requests for gaining access to applications by enabling the admin consent workflow. In this article, you’ll learn about the user and admin experience when the admin consent workflow is disabled vs when it's enabled.

When an administrator responds to a request, the user receives an email alert informing them that the request has been processed.

When the user submits a consent request, the request shows up in the admin consent request page in the Microsoft Entra admin center. Administrators and designated reviewers sign in to view and act on the new requests. Reviewers only see consent requests that were created after they were designated as reviewers. Requests show up in the following two tabs in the admin consent requests blade:

My pending: This shows any active requests that have the signed-in user designated as a reviewer. Although reviewers can block or deny requests, only people with the correct RBAC permissions to consent to the requested permissions can do so.
All(Preview): All requests, active or expired, that exist in the tenant. Each request includes information about the application and the user(s) requesting the application.
Email notifications
If configured, all reviewers will receive email notifications when:

A new request has been created
A request has expired
A request is nearing the expiration date.
Requestors will receive email notifications when:

They submit a new request for access
Their request has expired
Their request has been denied or blocked
Their request has been approved
