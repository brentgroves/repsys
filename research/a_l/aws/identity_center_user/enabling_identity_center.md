# **[Enabling AWS IAM Identity Center](https://docs.aws.amazon.com/singlesignon/latest/userguide/get-set-up-for-idc.html)**

Complete the following steps to sign in to the AWS Management Console and enable an organization instance of IAM Identity Center.

1. Do either of the following to sign in to the AWS Management Console.
    - New to AWS (root user) – Sign in as the account owner by choosing Root user and entering your AWS account email address. On the next page, enter your password.
    - Already using AWS (IAM credentials) – Sign in using your IAM credentials with administrative permissions.

2. Open the IAM **[Identity Center console](https://console.aws.amazon.com/singlesignon)**.
3. Under Enable IAM Identity Center, choose Enable with AWS Organizations.
4. Optional Add tags that you want to associate with this organization instance.
5. Optional Configure delegated administration.

If you are using a multi-account environment, we recommend that you configure delegated administration. With delegated administration, you can limit the number of people who require access to the management account in AWS Organizations. For more information, see **[Delegated administration](https://docs.aws.amazon.com/singlesignon/latest/userguide/delegated-admin.html)**.

The ability to **[create account instances of IAM Identity Center](https://docs.aws.amazon.com/singlesignon/latest/userguide/account-instances-identity-center.html)** is enabled by default. Account instances of IAM Identity Center include a subset of features available to an organization instance. You can control whether users can access this feature by using a **[Service Control Policy](https://docs.aws.amazon.com/singlesignon/latest/userguide/control-account-instance.html)**.

Do you need to update firewalls and gateways?
If you filter access to specific AWS domains or URL endpoints by using a web content filtering solution such as next-generation firewalls (NGFW) or Secure Web Gateways (SWG), you must add the following domains or URL endpoints to your web-content filtering solution allowlists. Doing so enables you to access your AWS access portal.

[Directory ID or alias].awsapps.com

*.aws.dev

*.awsstatic.com

*.console.aws.a2z.com

oidc.[Region].amazonaws.com

*.sso.amazonaws.com

*.sso.[Region].amazonaws.com

*.sso-portal.[Region].amazonaws.com

[Region].signin.aws

[Region].signin.aws.amazon.com

signin.aws.amazon.com

*.cloudfront.net

opfcaptcha-prod.s3.amazonaws.com

Considerations for allowlisting domains and URL endpoints
Understand the impact of allowlisting domains beyond AWS access portal.

To access AWS accounts, the AWS Management Console, and the IAM Identity Center console from your AWS access portal, you must allowlist additional domains. Refer to Troubleshooting in the AWS Management Console Getting Started Guide for a list of AWS Management Console domains.

To access AWS managed applications from your AWS access portal, you must allowlist their respective domains. Refer to the respective service documentation for guidance.

These allowlists cover AWS services. If you use external software, such as external IdPs (for example, Okta and Microsoft Entra ID), you'll need to include their domains in your allowlists.

You are now ready to configure IAM Identity Center. When you enable IAM Identity Center it's automatically configured with an Identity Center directory as your default identity source, which is the fastest way to get started using IAM Identity Center. For instructions, see Configure user access with the default IAM Identity Center directory.

If you want to learn more about how IAM Identity Center works with Organizations, identity sources, and IAM roles, see the following topics.
