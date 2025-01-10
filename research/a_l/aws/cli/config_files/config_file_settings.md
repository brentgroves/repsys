# **[Configuration and credential file settings in the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)**

You can save your frequently used configuration settings and credentials in files that are maintained by the AWS CLI.

The files are divided into profiles. By default, the AWS CLI uses the settings found in the profile named default. To use alternate settings, you can create and reference additional profiles.

You can override an individual setting by either setting one of the supported environment variables, or by using a command line parameter. For more information on configuration setting precedence, see **[Configuring settings for the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)**.

For information on setting up your credentials, see **[Authentication and access credentials for the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-authentication.html)**.

## Format of the configuration and credential files

The config and credentials files are organized into sections. Sections include profiles, sso-sessions, and services. A section is a named collection of settings, and continues until another section definition line is encountered. Multiple profiles and sections can be stored in the config and credentials files.

These files are plaintext files that use the following format:

- Section names are enclosed in brackets [ ] such as [default], [profile user1], and [sso-session].
- All entries in a section take the general form of setting_name=value.
- Lines can be commented out by starting the line with a hash character (#).

The config and credentials files contain the following section types:

- profile
- sso-session
- services

## Section type: profile

The AWS CLI stores

Depending on the file, profile section names use the following format:

- Config file: [default] [profile user1]
- Credentials file: [default] [user1]

Do not use the word profile when creating an entry in the credentials file.

Each profile can specify different credentials and can also specify different AWS Regions and output formats. When naming the profile in a config file, include the prefix word "profile", but do not include it in the credentials file.

The following examples show a credentials and config file with two profiles, region, and output specified. The first [default] is used when you run a AWS CLI command with no profile specified. The second is used when you run a AWS CLI command with the --profile user1 parameter.

## IAM Identity Center

This example is for AWS IAM Identity Center. For more information, see **[Configuring IAM Identity Center authentication with the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html)**.

Credentials file

The credentials file is not used for this authentication method.

Config file
