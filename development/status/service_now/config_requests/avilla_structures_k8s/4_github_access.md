# RITM0193059

### **[add certificate to trust store](https://fabianlee.org/2019/01/28/git-client-error-server-certificate-verification-failed/)**

```bash
git clone https://github.com/barnybug/cli53
Cloning into 'cli53'...
fatal: unable to access 'https://github.com/barnybug/cli53/': server certificate verification failed. CAfile: none CRLfile: none

# this reverts back to the original /etc/ssl/certs/ca-certificates.crt
# sudo update-ca-certificates

openssl s_client -showcerts -servername github.com -connect github.com:443 </dev/null 2>/dev/null | sed -n -e '/BEGIN\ CERTIFICATE/,/END\ CERTIFICATE/ p'  > github-com.pem
cat github-com.pem | sudo tee -a /etc/ssl/certs/ca-certificates.crt
```

### bypass ssl verification

Not recommended

```bash
ssh brent@10.188.50.202
git clone https://github.com/barnybug/cli53
git clone https://github.com/w3schools-test/w3schools-test.github.io.git
Cloning into 'w3schools-test.github.io'...
fatal: unable to access 'https://github.com/w3schools-test/w3schools-test.github.io.git/': server certificate verification failed. CAfile: none CRLfile: none

You can also disable SSL verification, (if the project does not require a high level of security other than login/password) by typing :

sudo timedatectl set-timezone America/Indiana/Indianapolis
sudo timedatectl
               Local time: Mon 2025-03-10 18:35:50 EDT
           Universal time: Mon 2025-03-10 22:35:50 UTC
                 RTC time: Mon 2025-03-10 22:35:50
                Time zone: America/Indiana/Indianapolis (EDT, -0400)
System clock synchronized: no
              NTP service: active
          RTC in local TZ: no

git config --global --get http.sslverify 


git config --global http.sslverify false

git config --global --unset http.sslverify 

```

## Test

```bash
ssh brent@10.188.50.202
git clone https://github.com/barnybug/cli53
git clone https://github.com/w3schools-test/w3schools-test.github.io.git
Cloning into 'w3schools-test.github.io'...
fatal: unable to access 'https://github.com/w3schools-test/w3schools-test.github.io.git/': server certificate verification failed. CAfile: none CRLfile: none

You can also disable SSL verification, (if the project does not require a high level of security other than login/password) by typing :

git config --global --get http.sslverify 


git config --global http.sslverify false


```

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
