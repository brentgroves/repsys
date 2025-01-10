# **[How to export a hosted zone in AWS Route 53](https://www.linkedin.com/pulse/how-export-hosted-zone-aws-route-53-mubashar-saeed-cno4f/)**

Amazon Route 53 stands out as a dependable and efficient DNS service, connecting Internet traffic to the relevant servers hosting the requested web applications. Globally acknowledged for its high availability, reliability, and scalability, Amazon Route 53 serves as a cloud-based Domain Name System (DNS) that ensures seamless routing for developers and businesses. Its primary objective is to offer developers and businesses a remarkably reliable and cost-effective solution for effectively directing end users to Internet applications.

## Prerequisite

- AWS CLI
- CLI53
- IAM Credentials

## 1 AWS CLI

Download and configure AWS CLI using following link

**[Install or update the latest version of the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)**

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

## script

```bash
#!/bin/bash

zonename=$1
hostedzoneid=$(aws route53 list-hosted-zones --profile my-dev-profile | jq -r ".HostedZones[] | select(.Name == \"$zonename.\") | .Id" | cut -d'/' -f3)
aws route53 list-resource-record-sets --hosted-zone-id $hostedzoneid --output json | jq -jr '.ResourceRecordSets[] | "\(.Name) \t\(.TTL) \t\(.Type) \t\(.ResourceRecords[].Value)\n"'
```

## bash

```bash
#!/bin/bash

zonename="repsys.dev"
hostedzoneid=$(aws route53 list-hosted-zones --profile my-dev-profile | jq -r ".HostedZones[] | select(.Name == \"$zonename.\") | .Id" | cut -d'/' -f3)
aws route53 list-resource-record-sets --profile my-dev-profile --hosted-zone-id $hostedzoneid --output json | jq -jr '.ResourceRecordSets[] | "\(.Name) \t\(.TTL) \t\(.Type) \t\(.ResourceRecords[].Value)\n"'
```

## AWS CLI53

cli53 provides import and export from BIND format and simple command line management of Route 53 domains.

Features:

- import and export BIND format
- create, delete and list hosted zones
- create, delete and update individual records
- create AWS extensions: failover, geolocation, latency, weighted and ALIAS records
- create, delete and use reusable delegation sets

## Installation

Installation is easy, just download the binary from the GitHub releases page (builds are available for Linux, Mac and Windows)

Download and Installation of CLI53

```bash
cd ~/Downloads
curl -OL https://github.com/barnybug/cli53/releases/download/0.8.23/cli53-linux-amd64 
sudo install -m 555 cli53-linux-amd64 /usr/bin/cli53
# or
sudo mv cli53-linux-amd64 /usr/local/bin/cli53
sudo chmod +x /usr/local/bin/cli53
```

## list zones

```bash
cd ~/src/secrets/aws
source ./set_vars.sh
cli53 list --profile my-dev-profile