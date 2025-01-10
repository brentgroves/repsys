# **[Configure user access with the default IAM Identity Center directory](https://docs.aws.amazon.com/singlesignon/latest/userguide/quick-start-default-idc.html)**

When you enable IAM Identity Center for the first time, it's automatically configured with an Identity Center directory as your default identity source, so you don't need to choose an identity source. If your organization uses another identity provider such as AWS Directory Service for Microsoft Active Directory, Microsoft Entra ID, or Okta consider integrating that identity source with IAM Identity Center instead of using the default configuration.

Objective

In this tutorial, you will use the default directory as your identity source and set up and test user access. In this scenario, you manage all users and groups in IAM Identity Center. Users sign in through the AWS access portal. This tutorial is intended for users that are new to AWS or that have been using IAM to manage users and groups. In the next steps, you will create the following:

- An administrative user named Nikki Wolf
- A group named Admin team
- A permission set named AdminAccess

To verify everything was created correctly, you will sign in and set the administrative user's password. After completing this tutorial you can use the administrative user to add more users in IAM Identity Center, create additional permission sets, and set up organizational access to applications.

If you haven't enabled IAM Identity Center yet, see Enabling AWS IAM Identity Center.
