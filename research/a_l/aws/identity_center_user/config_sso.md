# **[Configuring IAM Identity Center authentication with the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html)**

This topic provides instructions on how to configure the AWS CLI with AWS IAM Identity Center (IAM Identity Center) to retrieve credentials to run AWS CLI commands. There are primarily two ways to authenticate users with IAM Identity Center to get credentials to run AWS CLI commands through the config file:

- (Recommended) SSO token provider configuration.
- Legacy non-refreshable configuration.

For information on using bearer auth, which uses no account ID and role, see **[Setting up to use the AWS CLI with CodeCatalyst](https://docs.aws.amazon.com/codecatalyst/latest/userguide/set-up-cli.html)** in the Amazon CodeCatalyst User Guide.

For a guided process of using IAM Identity Center with AWS CLI commands, see Tutorial: **[Using IAM Identity Center to run Amazon S3 commands in the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso-tutorial.html)**.
