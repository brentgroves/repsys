# Firewall

## references

- **[Docker allow list](https://docs.docker.com/desktop/setup/allow-list/)**
- **[Docker hub for firewalls](https://support.sonatype.com/hc/en-us/articles/115015442847-Whitelisting-Docker-Hub-Hosts-for-Firewalls-and-HTTP-Proxy-Servers)**
- **[Ubuntu updates](https://askubuntu.com/questions/187291/what-domains-do-i-need-to-whitelist-for-updates)

Hi,

I have been tasked with setting up a Kubernetes cluster for the Structures department's use. This cluster will be secured with mTLS using Istio when running in production but during its initial setup, we ask for 1 week of unrestricted internet access. Justin Langille requested that I complete a list of all domains needed when the cluster is operational, so I added that as an attachment to this request. This project will take more than 1 week to set up so we will ask for more time with unrestricted access at a future date. Thank you.

Used for live or long running reports, Excel, or Power BI dashboards for the Plex ERP. Later, the cluster will be used to run a tool management system and tool tracking software for the Indiana MRP and engineering departments.

Met with Justin Langille and Jared Davis 
Need:
- 4 IP addresses, 10.188.220.[200-203]
- Unrestricted internet access for 1 week to install software for all IP addresses.


| Domains                                             | Description          |
|-----------------------------------------------------|----------------------|
| https://api.segment.io                              | Analytics            |
| https://cdn.segment.com                             | Analytics            |
| https://experiments.docker.com                      | A/B testing          |
| https://notify.bugsnag.com                          | Error reports        |
| https://sessions.bugsnag.com                        | Error reports        |
| https://auth.docker.io                              | Authentication       |
| https://cdn.auth0.com                               | Authentication       |
| https://login.docker.com                            | Authentication       |
| https://desktop.docker.com                          | Update               |
| https://hub.docker.com                              | Docker Pull/Push     |
| https://registry-1.docker.io                        | Docker Pull/Push     |
| https://production.cloudflare.docker.com            | Docker Pull/Push     |
| https://docker-images-prod.r2.cloudflarestorage.com | Docker Pull/Push     |
| https://docker-pinata-support.s3.amazonaws.com      | Troubleshooting      |
| https://api.dso.docker.com                          | Docker Scout service |


odbc.plex.com
test.odbc.plex.com
repsys1.database.windows.net