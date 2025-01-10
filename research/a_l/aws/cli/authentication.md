# **[Authentication and access credentials for the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-authentication.html)**

You must establish how the AWS CLI authenticates with AWS when you develop with AWS services. To configure credentials for programmatic access for the AWS CLI, choose one of the following options. The options are in order of recommendation.

## IAM Identity Center workforce users short-term credentials

(Recommended) Use short-term credentials for an IAM Identity Center workforce user.
Security best practice is to use AWS Organizations with IAM Identity Center. It combines short-term credentials with a user directory, such as the built-in IAM Identity Center directory or Active Directory.

## **[Configuring IAM Identity Center authentication with the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html)**

This topic provides instructions on how to configure the AWS CLI with AWS IAM Identity Center (IAM Identity Center) to retrieve credentials to run AWS CLI commands. There are primarily two ways to authenticate users with IAM Identity Center to get credentials to run AWS CLI commands through the config file:

- (Recommended) SSO token provider configuration.

- Legacy non-refreshable configuration.

For information on using bearer auth, which uses no account ID and role, see **[Setting up to use the AWS CLI with CodeCatalyst in the Amazon CodeCatalyst User Guide](https://docs.aws.amazon.com/codecatalyst/latest/userguide/set-up-cli.html)**.

## Note 1

For a guided process of using IAM Identity Center with AWS CLI commands, see Tutorial: **[Using IAM Identity Center to run Amazon S3 commands in the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso-tutorial.html)**.

## Prerequisites

- Install the AWS CLI. For more information, see Installing or updating to the latest version of the AWS CLI.
- You must first have access to SSO authentication within IAM Identity Center.
- Follow the instructions in **[Getting started](https://docs.aws.amazon.com/singlesignon/latest/userguide/getting-started.html)** in the AWS IAM Identity Center User Guide. This process activates IAM Identity Center, creates an administrative user, and adds an appropriate least-privilege permission set.

Note
Create a permission set that applies least-privilege permissions. We recommend using the predefined PowerUserAccess permission set, unless your employer has created a custom permission set for this purpose.

Exit the portal and sign in again to see your AWS accounts, programmatic access details, and options for Administrator or PowerUserAccess. Select PowerUserAccess when working with the SDK.

Choose one of the following methods to access your AWS credentials.

After gaining access to IAM Identity Center, gather your IAM Identity Center information by performing the following:

1. Gather your SSO Start URL and SSO Region values that you need to run aws configure sso
    - In your AWS access portal, select the permission set you use for development, and select the Access keys link.
    - In the Get credentials dialog box, choose the tab that matches your operating system.
    - Choose the IAM Identity Center credentials method to get the SSO Start URL and SSO Region values.
2. Alternatively, starting with version 2.22.0, you can use the Issuer URL instead of the Start URL. The Issuer URL is located in the AWS IAM Identity Center console in one of the following locations:
    - On the Dashboard page, the Issuer URL is in the settings summary.
    - On the Settings page, the Issuer URL is in the Identity source settings.
3. For information on which scopes value to register, see OAuth 2.0 Access scopes in the IAM Identity Center User Guide.

## Configure your profile with the aws configure sso wizard

To configure an IAM Identity Center profile for your AWS CLI:
In your preferred terminal, run the aws configure sso command.

Create a session name, provide your IAM Identity Center start URL or the issuer URL, the AWS Region that hosts the IAM Identity Center directory, and the registration scope.

```bash
$ aws configure sso --use-device-code

aws configure sso --use-device-code
SSO session name (Recommended): my-sso
SSO start URL [None]: https://d-9a677e0071.awsapps.com/start/#
SSO region [None]: us-east-2
SSO registration scopes [sso:account:access]: sso:account:access
Attempting to automatically open the SSO authorization page in your default browser.
If the browser does not open or you wish to use a different device to authorize this request, open the following URL:

https://device.sso.us-east-2.amazonaws.com/

Then enter the code:

KPHG-FFHV
The only AWS account available to you is: 051826715128
Using the account ID 051826715128
The only role available to you is: AdministratorAccess
Using the role name "AdministratorAccess"
CLI default client Region [None]: us-east-2
CLI default output format [None]: json
CLI profile name [AdministratorAccess-051826715128]: my-dev-profile

To use this profile, specify the profile name using --profile, as shown:

aws s3 ls --profile my-dev-profile
```

A final message describes the completed profile configuration. You can now use this profile to request credentials. Use the aws sso login command to request and retrieve the credentials needed to run commands. For instructions, see **[Sign in to an IAM Identity Center session](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html#cli-configure-sso-login)**.
