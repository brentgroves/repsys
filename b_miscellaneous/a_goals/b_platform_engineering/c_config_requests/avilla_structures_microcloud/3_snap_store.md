# RITM0192217, 2nd try at getting snap to work

 Request: Please update the Avilla Structures "Kubernetes to untrust" policy.

Goal: To get MicroK8s Kubernetes to install from the Canonical Snap Store.  I have since found the network requirements URL, <https://snapcraft.io/docs/network-requirements>, which shows that I did not ask for all required in my last config request, RITM0192002.  Sorry about that.  

## Policy Change

1. Please change the IP range of this policy from 10.188.50.[200-203] to 10.188.50.[200-212]
Reason: To create 1 backup and 1 development Kubernetes Cluster in addition to the production cluster.

2. Please grant Snap Store access.

Can't install/update the Ubuntu MicroK8s software without accessing the **[Canonical's Snap Store](https://microk8s.io/docs/getting-started)**, which has the following **[network requirements](https://snapcraft.io/docs/network-requirements)**.

## not required but blueprint access

<https://codeload.github.com>

```bash[2025-03-04T15:45:23.136] [error] [url downloader] Failed to get https://codeload.github.com/canonical/multipass-blueprints/zip/refs/heads/main: Error opening https://codeload.github.com/canonical/multipass-blueprints/zip/refs/heads/main
[2025-03-04T15:45:23.137] [error] [blueprint provider] Error fetching Blueprints: failed to download from 'https://codeload.github.com/canonical/multipass-blueprints/zip/refs/heads/main': Error opening https://codeload.github.com/canonical/multipass-blueprints/zip/refs/heads/main
[2025-03-04T15:45:33.136] [error] [url downloader] Failed to get https://codeload.github.com/canonical/multipass-blueprints/zip/refs/heads/main: Error opening https://codeload.github.com/canonical/multipass-blueprints/zip/refs/heads/main
[2025-03-04T15:45:33.137] [error] [blueprint provider] Error fetching Blueprints: failed to download from 'https://codeload.github.com/canonical/multipass-blueprints/zip/refs/heads/main': Error opening https://codeload.github.com/canonical/multipass-blueprints/zip/refs/heads/main
```

## API access

api.snapcraft.io:443
store.canonical.com:443
dashboard.snapcraft.io:443
login.ubuntu.com:443

## Download CDNs

*.snapcraftcontent.com:443
*.cdn.snapcraft.io:443
public.apps.ubuntu.com:443

Project: Avilla Structures Kubernetes Cluster

Affected Application: Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Avilla Structures Kubernetes Cluster will be used run Structures Information System software such as the Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.
