# RITM0193059

Project: Avilla Structures Kubernetes Cluster

Request: Please update the Avilla Structures "Kubernetes" policy.

## Issue

1. Canonical Hypervisor failing to get configuration data stored at <https://codeload.github.com>
2. Unable to install the linuxbrew package manager which needs access to <https://github.com>

Affected Application: Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Avilla Structures Kubernetes Cluster will be used run Structures Information System software such as the Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Requested Policy Change

## Key points about the firewall rule

- Protocol: TCP
- Port: 80/443
- Action: Allow
- Destination: "github.com" and "codeland.github.com"

## Details

```bash
multipass launch --network br0 --network br1 --name k8sn211 --cpus 2 --memory 32G --disk 250G 

# hypervisor failing to get configuration data stored at https://codeload.github.com

[2025-03-05T20:29:05.138] [error] [url downloader] Failed to get https://codeload.github.com/canonical/multipass-blueprints/zip/refs/heads/main: Error opening https://codeload.github.com/canonical/multipass-blueprints/zip/refs/heads/main
[2025-03-05T20:29:05.139] [error] [blueprint provider] Error fetching Blueprints: failed to download from 'https://codeload.github.com/canonical/multipass-blueprints/zip/refs/heads/main': Error opening https://codeload.github.com/canonical/multipass-blueprints/zip/refs/heads/main

# Unable to install the linuxbrew package manager which needs access to https://github.com.

==> /usr/bin/sudo /bin/chown -R ubuntu:ubuntu /home/linuxbrew/.linuxbrew/Homebrew
==> Downloading and installing Homebrew...
fatal: unable to access 'https://github.com/Homebrew/brew/': Failed to connect to github.com port 443 after 133862 ms: Couldn't connect to server
Warning: Trying again in 2 seconds: /usr/bin/git fetch --quiet --progress --force origin
```

## Software and Configuration file access

github.com:443
codeland.github.com:443
