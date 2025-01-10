# **[Create an IAM user for workloads that can't use IAM roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started-workloads.html)**

As a best practice, we recommend you require your human users to use temporary credentials when accessing AWS.

Alternatively, you can manage your user identities, including your administrative user, with AWS IAM Identity Center. We recommend you use IAM Identity Center to manage access to your accounts and permissions within those accounts. If you are using an external identity provider, you can also configure the access permissions for user identities in IAM Identity Center.

If your use case requires IAM users with programmatic access and long-term credentials, we recommend that you establish procedures to **[update access keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/id-credentials-access-keys-update.html)** when needed. For more information, see Update access keys.

To perform some account and service management tasks, you must sign in using root user credentials. To view the tasks that require you to sign in as the root user, see **[Tasks that require root user credentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html#root-user-tasks)**.

To create an IAM user for workloads that can't use IAM roles

Choose the tab for the method you want to follow to create the IAM user for a workload:

## Minimum permissions

To perform the following steps, you must have at least the following IAM permissions:

iam:AddUserToGroup
iam:AttachGroupPolicy
iam:CreateAccessKey
iam:CreateGroup
iam:CreateServiceSpecificCredential
iam:CreateUser
iam:GetAccessKeyLastUsed
iam:GetAccountPasswordPolicy
iam:GetAccountSummary
iam:GetGroup
iam:GetLoginProfile
iam:GetPolicy
iam:GetRole
iam:GetUser
iam:ListAccessKeys
iam:ListAttachedGroupPolicies
iam:ListAttachedUserPolicies
iam:ListGroupPolicies
iam:ListGroups
iam:ListGroupsForUser
iam:ListInstanceProfilesForRole
iam:ListMFADevices
iam:ListPolicies
iam:ListRoles
iam:ListRoleTags
iam:ListSSHPublicKeys
iam:ListServiceSpecificCredentials
iam:ListSigningCertificates
iam:ListUserPolicies
iam:ListUserTags
iam:ListUsers
iam:UploadSSHPublicKey
iam:UploadSigningCertificate

## IAM Console

Follow the sign-in procedure appropriate to your user type as described in the topic How to sign in to AWS in the AWS Sign-In User Guide.

On the Console Home page, select the IAM service.

In the navigation pane, choose Users and then choose Create users.

On the Specify user details page, do the following:

For User name, type WorkloadName. Replace WorkloadName with the name of the workload that will be using the account.

Choose Next.

(Optional) On the Set Permissions page, do the following:

Choose Add user to group.

Choose Create group.

In the Create user group dialog box, for User group name type a name that represents the use of the workloads in the group. For this example, use the name Automation.

Under Permissions policies select the checkbox for the PowerUserAccess managed policy.

Tip
Enter Power into the Permissions policies search box to quickly find the managed policy.

Choose Create user group.

Back on the page with the list of IAM groups, select the checkbox for your new user group. Choose Refresh if you don't see the new user group in the list.

Choose Next.
