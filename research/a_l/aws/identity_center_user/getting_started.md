# **[Get started with common tasks in IAM Identity Center](https://docs.aws.amazon.com/singlesignon/latest/userguide/getting-started.html)**

If you haven't enabled IAM Identity Center yet, see **[Enabling AWS IAM Identity Center](https://docs.aws.amazon.com/singlesignon/latest/userguide/get-set-up-for-idc.html)**.

If you are a new user of IAM Identity Center, the basic workflow to get started using the service is:

Sign in to the console of your management account if you are using an organization instance of IAM Identity Center or your AWS account if you are using an account instance of IAM Identity Center and navigate to the IAM Identity Center console.

Select your identity source from the IAM Identity Center console. You can connect your existing identity source, such as an external identity provider or Active Directory. IAM Identity Center also provides you a directory by default that you can use to configure user access.

For organization instances, assign user access to AWS accounts by selecting the accounts in your organization, and then selecting users or groups from your directory and the permissions you want to grant them.

Give users access to applications by:

Set up customer managed SAML 2.0 applications by either electing one of the pre-integrated applications from the application catalog or adding your own SAML 2.0 application.

Configure the application properties.

Assign the users access to the application. We recommend that you assign user access through group membership rather than by adding individual user permissions. With groups you can grant or deny permissions to groups of users, instead of applying those permissions to each individual. If a user moves to a different organization, you simply move that user to a different group. The user then automatically receives the permissions that are needed for the new organization.

If you are using the default IAM Identity Center directory, tell your users how to sign in to the AWS access portal. New users in IAM Identity Center must activate their user credentials before they can be used to sign in to the AWS access portal. For more information, see Sign in to the AWS access portal in the AWS Sign-In User Guide
