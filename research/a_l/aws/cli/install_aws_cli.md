# **[Install or update the latest version of the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)***

## Install and update requirements

You must be able to extract or "unzip" the downloaded package. If your operating system doesn't have the built-in unzip command, use an equivalent.

The AWS CLI uses glibc, groff, and less. These are included by default in most major distributions of Linux.

We support the AWS CLI on 64-bit versions of recent distributions of CentOS, Fedora, Ubuntu, Amazon Linux 1, Amazon Linux 2, Amazon Linux 2023, and Linux ARM.

Because AWS doesn't maintain third-party repositories other than snap, we can’t guarantee that they contain the latest version of the AWS CLI.

You can install the AWS CLI by using one of the following methods:

1. The command line installer is good option for version control, as you can specify the version to install. This option does not auto-update and you must download a new installer each time you update to overwrite previous version.

2. The officially supported snap package is a good option to always have the latest version of the AWS CLI as snap packages automatically refresh. There is no built-in support for selecting minor versions of AWS CLI and therefore is not an optimal install method if your team needs to pin versions.

To update your current installation of AWS CLI, download a new installer each time you update to overwrite previous versions. Follow these steps from the command line to install the AWS CLI on Linux.

The following are quick installation steps in a single copy and paste group that provide a basic installation. For guided instructions, see the steps that follow.

Note
(Optional) The following command block downloads and installs the AWS CLI without first verifying the integrity of your download. To verify the integrity of your download, use the below step by step instructions.

To install the AWS CLI, run the following commands.

```bash
pushd .
cd ~/Downloads
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
You can now run: /usr/local/bin/aws --version
aws --version                    
aws-cli/2.22.26 Python/3.12.6 Linux/6.8.0-50-generic exe/x86_64.ubuntu.22
```

## update AWS CLI

To update your current installation of the AWS CLI, add your existing symlink and installer information to construct the install command using the --bin-dir, --install-dir, and --update parameters. The following command block uses an example symlink of /usr/local/bin and example installer location of /usr/local/aws-cli to install the AWS CLI locally for the current user.

```bash
$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
```
