# **[Configuring settings for the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)**

This section explains how to configure the settings that the AWS Command Line Interface (AWS CLI) uses to interact with AWS. These include the following:

- Credentials identify who is calling the API. Access credentials are used to encrypt the request to the AWS servers to confirm your identity and retrieve associated permissions policies. These permissions determine the actions you can perform. For information on setting up your credentials, see **[Authentication and access credentials for the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-authentication.html)**.

- Other configuration details to tell the AWS CLI how to process requests, such as the default output format and the default AWS Region.

## Configure your profile with the aws configure sso wizard

To configure an IAM Identity Center profile for your AWS CLI:
In your preferred terminal, run the aws configure sso command.

```bash
$ aws configure sso
SSO session name (Recommended): my-sso
SSO start URL [None]: https://d-9a677e0071.awsapps.com/start/#
The only AWS account available to you is: 051826715128
Using the account ID 051826715128
The only role available to you is: AdministratorAccess
Using the role name "AdministratorAccess"
SSO region [None]: us-east-2
SSO registration scopes [None]: sso:account:access
CLI default client Region [None]: us-east-2
CLI default output format [None]:
CLI profile name [AdministratorAccess-051826715128]: my-dev-profile

To use this profile, specify the profile name using --profile, as shown:

aws s3 ls --profile my-dev-profile
```

```yaml
userName: bgroves
email: brent.groves@outlook.com
M2F: AWS SSO - bgroves
access portal: <https://d-9a677e0071.awsapps.com/start/>
SSO Start URL: https://d-9a677e0071.awsapps.com/start/#
SSO Region: us-east-2
```


## Note 1

AWS requires that all incoming requests are cryptographically signed. The AWS CLI does this for you. The "signature" includes a date/time stamp. Therefore, you must ensure that your computer's date and time are set correctly. If you don't, and the date/time in the signature is too far off of the date/time recognized by the AWS service, AWS rejects the request.

## Configuration and credentials precedence

Credentials and configuration settings are located in multiple places, such as the system or user environment variables, local AWS configuration files, or explicitly declared on the command line as a parameter. Certain locations take precedence over others. The AWS CLI credentials and configuration settings take precedence in the following order:

- Command line options – Overrides settings in any other location, such as the --region, --output, and --profile parameters.

- Environment variables – You can store values in your system's environment variables.

- Assume role – Assume the permissions of an IAM role through configuration or the assume-role command.

- Assume role with web identity – Assume the permissions of an IAM role using web identity through configuration or the assume-role-with-web-identity command.

- AWS IAM Identity Center – The IAM Identity Center configuration settings stored in the config file are updated when you run the aws configure sso command. Credentials are then authenticated when you run the aws sso login command. The config file is located at `~/.aws/config` on Linux or macOS, or at C:\Users\USERNAME\.aws\config on Windows.

- Credentials file – The credentials and config file are updated when you run the command aws configure. The credentials file is located at `~/.aws/credentials` on Linux or macOS, or at C:\Users\USERNAME\.aws\credentials on Windows.

- Custom process – Get your credentials from an external source.

- Configuration file – The credentials and config file are updated when you run the command aws configure. The config file is located at `~/.aws/config` on Linux or macOS, or at C:\Users\USERNAME\.aws\config on Windows.

- Container credentials – You can associate an IAM role with each of your Amazon Elastic Container Service (Amazon ECS) task definitions. Temporary credentials for that role are then available to that task's containers. For more information, see IAM Roles for Tasks in the Amazon Elastic Container Service Developer Guide.

- Amazon EC2 instance profile credentials – You can associate an IAM role with each of your Amazon Elastic Compute Cloud (Amazon EC2) instances. Temporary credentials for that role are then available to code running in the instance. The credentials are delivered through the Amazon EC2 metadata service. For more information, see IAM Roles for Amazon EC2 in the Amazon EC2 User Guide and Using Instance Profiles in the IAM User Guide.

## What's the difference between ECS and EKS?

AWS ECS vs. EKS: What's the Difference and How to Choose ...
ECS: Utilizes AWS's robust security features, including IAM roles, security groups, and VPC network isolation. EKS: Leverages Kubernetes' native security features like RBAC, Network Policies, and Secret Management, which require in-depth Kubernetes knowledge.Dec 20, 2024
