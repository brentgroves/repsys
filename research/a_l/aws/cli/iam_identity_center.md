# **[Enabling AWS IAM Identity Center](https://docs.aws.amazon.com/singlesignon/latest/userguide/get-set-up-for-idc.html)**

Complete the following steps to sign in to the AWS Management Console and enable an organization instance of IAM Identity Center.

1. Do either of the following to sign in to the AWS Management Console.
    - New to AWS (root user) – Sign in as the account owner by choosing Root user and entering your AWS account email address. On the next page, enter your password.
    - Already using AWS (IAM credentials) – Sign in using your IAM credentials with administrative permissions.
2. Open the **[IAM Identity Center console](https://console.aws.amazon.com/singlesignon).

Under Enable IAM Identity Center, choose Enable with AWS Organizations.

Optional Add tags that you want to associate with this organization instance.

Optional Configure delegated administration.

## IAM Identity Center prerequisites and considerations

You can enable a Region for the current accounts in your organization and you must repeat this action for new accounts you might add later. For instructions, see Enable or disable a Region in your organization in the AWS Organizations user guide. To avoid repeating these additional steps, you can choose to deploy your IAM Identity Center in a Region enabled by default. For reference, the following Regions are enabled by default:

- US East (Ohio)
- US East (N. Virginia)
- US West (Oregon)
- US West (N. California)

Using IAM Identity Center for user access to applications only

You can use IAM Identity Center for user access to applications such as Amazon Q Developer, AWS accounts, or both. You can connect your existing identity provider and synchronize users and groups from your directory, or **[create and manage users directly in IAM Identity Center](https://docs.aws.amazon.com/singlesignon/latest/userguide/quick-start-default-idc.html)**. For information about how to connect your existing identity provider to IAM Identity Center, see the IAM Identity Center Identity source tutorials.

## Already using IAM for access to AWS accounts?

You don’t need to make any changes to your current AWS account workflows to use IAM Identity Center for access to AWS managed applications. If you’re using federation with IAM or IAM users for AWS account access, your users can continue to access AWS accounts in the same way they always have, and you can continue to use your existing workflows to manage that access.

## Configure user access with the default IAM Identity Center directory

When you enable IAM Identity Center for the first time, it's automatically configured with an Identity Center directory as your default identity source, so you don't need to choose an identity source. If your organization uses another identity provider such as AWS Directory Service for Microsoft Active Directory, Microsoft Entra ID, or Okta consider integrating that identity source with IAM Identity Center instead of using the default configuration.

## Objective

In this tutorial, you will use the default directory as your identity source and set up and test user access. In this scenario, you manage all users and groups in IAM Identity Center. Users sign in through the AWS access portal. This tutorial is intended for users that are new to AWS or that have been using IAM to manage users and groups. In the next steps, you will create the following:

- An administrative user named Nikki Wolf
- A group named Admin team
- A permission set named AdminAccess

To verify everything was created correctly, you will sign in and set the administrative user's password. After completing this tutorial you can use the administrative user to add more users in IAM Identity Center, create additional permission sets, and set up organizational access to applications.

If you haven't enabled IAM Identity Center yet, see **[Enabling AWS IAM Identity Center](https://docs.aws.amazon.com/singlesignon/latest/userguide/get-set-up-for-idc.html)**.

AWS Organizations is offered at no additional charge. You are charged only for AWS resources that users and roles in your member accounts use. For example, you are charged the standard fees for Amazon EC2 instances that are used by users or roles in your member accounts. For information about the pricing of other AWS services, see AWS Pricing.

Who pays for usage incurred by users under an AWS member account in my organization?

The owner of the management account is responsible for paying for all usage, data, and resources used by the accounts in the organization.

Will my bill reflect the organizational unit structure that I created in my organization?

Your bill will not reflect the structure that you have defined in your organization. You can use cost allocation tags in individual AWS accounts to categorize and track your AWS costs, and this allocation will be visible in the consolidated bill for your organization.

You have successfully created the organization instance of IAM Identity Center 6684a9a228b64fa3.

## Details

Configure your identity source and multi-factor authentication settings for use when managing access to your AWS accounts, resources, and cloud applications.

Instance name

- Edit
-

Instance ID
ssoins-6684a9a228b64fa3
Organization ID
o-v0xk82ug0q

Region
US East (Ohio) | us-east-2
Date created
Thursday, January 2, 2025 at 2:50:54 PM EST

Instance ARN
arn:aws:sso:::instance/ssoins-6684a9a228b64fa3
Delegated administrator
No account registered

Identity-aware sessions

- Enable
Disabled

## Add user

In the IAM Identity Center navigation pane, choose Users, then select Add user.

On the Specify user details page, complete the following information:

- Username - For this tutorial, enter nikkiw.
    When creating users, choose usernames that are easy to remember. Your users must remember the username to sign in to the AWS access portal and you can't change it later.
- Password - Choose Send an email to this user with password setup instructions (Recommended).
    This option sends the user an email addressed from Amazon Web Services, with the subject line Invitation to join IAM Identity Center. The email comes from either <no-reply@signin.aws> or <no-reply@login.awsapps.com>. Add these email addresses to your approved senders list.
- Email address - Enter an email address for the user where you can receive the email. Then, enter it again to confirm it. Each user must have a unique email address.

First name - Enter the first name for the user. For this tutorial, enter Nikki.

Last name - Enter the last name for the user. For this tutorial, enter Wolf.

Display name - The default value is the first and last name of the user. If you want to change the display name, you can enter something different. The display name is visible in the sign-in portal and users list.

Complete the optional information if desired. It isn’t used during this tutorial and you can change it later.

The user "bgroves" was successfully added.
The user will receive an email with a link to set up a password and instructions to connect to the AWS access portal. The link will be valid for up to 7 days. You can grant this user permissions to accounts or applications so that they can access their assigned AWS accounts and cloud applications when they sign in to the AWS access portal.
