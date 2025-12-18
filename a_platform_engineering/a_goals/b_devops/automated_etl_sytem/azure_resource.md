# Azure Resource Usage and Configuration Summary

The following is in markdown format it can be viewed better from <https://markdownlivepreview.com/> by copying and pasting the contents below.

## Recommend

Recreate or transfer ownership of all resources in the reports-aks resource group.

## Azure resources

We mostly use Free-Tier services or "free and open source software" on our on-prem Kubernetes Cluster.  The following costs are for the cloud-based version of the report system and are only needed for Microsoft Teams tab accessibility.

- A secure **[container registry](https://azure.microsoft.com/en-us/products/container-registry)** to store images of custom and OSS software used by our report system running on our Azure AKS cluster.
  - cost $10/month

- **[Azure AKS Entra ID managed cluster](https://learn.microsoft.com/en-us/azure/aks/enable-authentication-microsoft-entra-id)**
  - mTLS secured gateway
  - cost $350/month
  - Our current cluster uses one **[Standard_D8_v3](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/general-purpose/dv3-series?tabs=sizebasic)** VM which has 8 vCPU and 32 GB ram.

- **[Fully Mangaged Azure SQL Database](https://learn.microsoft.com/en-us/sql/sql-server/sql-docs-navigation-guide?view=sql-server-ver16#applies-to)**
  - **[Secured by Server Level IP Firewall rule](https://learn.microsoft.com/en-us/azure/azure-sql/database/firewall-create-server-level-portal-quickstart?view=azuresql)**
  - cost $50/month
  - Current db was created with the standard S1 service tier and 20 **[DTU](https://learn.microsoft.com/en-us/azure/azure-sql/database/service-tiers-dtu?view=azuresql#database-transaction-units-dtus)** capacity.

- **[Azure Key Vault](https://learn.microsoft.com/en-us/azure/key-vault/general/overview)** for TLS certificates and other secrets.

## Configuration Needs

- **[Register App with Azure Entra](https://auth0.com/docs/authenticate/identity-providers/enterprise-identity-providers/azure-active-directory/v2)**

- **[Create Azure SQL DB firewall rules](https://learn.microsoft.com/en-us/azure/azure-sql/database/firewall-create-server-level-portal-quickstart?view=azuresql)**

- **[Add 5 DNS records to completely secure emails](https://help.mailtrap.io/article/79-dns-records#why)**

  - CNAME domain verification
  - SPF
  - DKIM (2)
  - DMARC

## Other Azure Resource Usages

- **[Azure Blob Storage:](https://azure.microsoft.com/en-us/products/storage/blobs)** Could be used as a replacement for the Minio S3 compatible storage running in our Kubernetes Clusters.

## **[Estimated Cost Summary](https://linamarcorporation-my.sharepoint.com/:x:/r/personal/bgroves_linamar_com/Documents/a_report_system/Mobex_Azure_Costs_Oct2%20-%20Copy.xlsx?d=w6e8da880c5064a35979f4fb52cade75e&csf=1&web=1&e=vLdYyt)**

| Resource                                                                        | ResourceType              | ResourceGroupName                    | ServiceName          | ServiceTier                                         | Cost      |
|---------------------------------------------------------------------------------|---------------------------|--------------------------------------|----------------------|-----------------------------------------------------|-----------|
| mgsqlmi                                                                         | SQL managed instance      | rg-useast-dataservices               | SQL Managed Instance | SQL Managed Instance General Purpose - Compute Gen5 | $453.00   |
| mgsqlmi                                                                         | SQL managed instance      | rg-useast-dataservices               | SQL Managed Instance | SQL Managed Instance General Purpose - SQL License  | $297.50   |
| mgsqlmi                                                                         | SQL managed instance      | rg-useast-dataservices               | SQL Managed Instance | SQL Managed Instance General Purpose - Storage      | $11.04    |
| aks-nodepool1-21371349-vmss                                                     | Virtual machine scale set | mc_reports-aks_repsys1_centralus     | Virtual Machines     | Virtual Machines Dv3 Series                         | $136.00   |
| aks-nodepool1-21371349-vmss                                                     | Virtual machine scale set | mc_reports-aks_repsys1_centralus     | Bandwidth            | Rtn Preference: MGN                                 | $0.00     |
| aks-nodepool1-21371349-vmss                                                     | Virtual machine scale set | mc_reports-aks_repsys1_centralus     | Bandwidth            | Bandwidth Inter-Region                              | $0.00     |
| aks-nodepool1-21371349-vmss                                                     | Virtual machine scale set | mc_reports-aks_repsys1_centralus     | Bandwidth            | Bandwidth Inter-Region                              | $0.00     |
| aks-default-29924714-vmss                                                       | Virtual machine scale set | mc_reports-aks_reports-aks_centralus | Virtual Machines     | Virtual Machines Ev3 Series                         | $126.11   |
| aks-default-29924714-vmss                                                       | Virtual machine scale set | mc_reports-aks_reports-aks_centralus | Bandwidth            | Rtn Preference: MGN                                 | $0.00     |
| aks-default-29924714-vmss                                                       | Virtual machine scale set | mc_reports-aks_reports-aks_centralus | Bandwidth            | Bandwidth Inter-Region                              | $0.00     |
| repsys / rsdw                                                                   | SQL database              | repsys                               | SQL Database         | SQL Database Single Standard                        | $30.00    |
| aks-default-29924714aks-default-29924714-os__1_20d72a6852e440a29f2dc752ab892bec | Disk                      | mc_reports-aks_reports-aks_centralus | Storage              | Premium SSD Managed Disks                           | $18.29    |
| plex-datasources                                                                | Automation account        | rg-useast-dataservices               | Automation           | Process Automation                                  | $16.49    |
| kubernetes                                                                      | Load balancer             | mc_reports-aks_reports-aks_centralus | Load Balancer        | Load Balancer                                       | $10.83    |
| kubernetes                                                                      | Load balancer             | mc_reports-aks_reports-aks_centralus | Load Balancer        | Load Balancer                                       | $0.67     |
| kubernetes                                                                      | Load balancer             | mc_reports-aks_reports-aks_centralus | Load Balancer        | Load Balancer                                       | $0.01     |
| kubernetes                                                                      | Load balancer             | mc_reports-aks_repsys1_centralus     | Load Balancer        | Load Balancer                                       | $7.70     |
| kubernetes                                                                      | Load balancer             | mc_reports-aks_repsys1_centralus     | Load Balancer        | Load Balancer                                       | $0.08     |
| aks-nodepool1-213713aks-nodepool1-2137134os__1_f29e01295206496881e523690e9b02fc | Disk                      | mc_reports-aks_repsys1_centralus     | Storage              | Standard SSD Managed Disks                          | $4.95     |
| aks-nodepool1-213713aks-nodepool1-2137134os__1_f29e01295206496881e523690e9b02fc | Disk                      | mc_reports-aks_repsys1_centralus     | Storage              | Standard SSD Managed Disks                          | $0.45     |
| mobexcr                                                                         | Container registry        | reports-aks                          | Container Registry   | Container Registry                                  | $5.16     |
| aks-default-29924714aks-default-29924714-os__1_f1e04a5c0300401c820f082bade8ac69 | Disk                      | mc_reports-aks_reports-aks_centralus | Storage              | Premium SSD Managed Disks                           | $3.74     |
| aks-nodepool1-213713aks-nodepool1-2137134os__1_2df3e8dce1024b0495acfcd80bac8d45 | Disk                      | mc_reports-aks_repsys1_centralus     | Storage              | Standard SSD Managed Disks                          | $2.99     |
| aks-nodepool1-213713aks-nodepool1-2137134os__1_2df3e8dce1024b0495acfcd80bac8d45 | Disk                      | mc_reports-aks_repsys1_centralus     | Storage              | Standard SSD Managed Disks                          | $0.15     |
| f889f403-ecb2-4b24-9a00-404855445cac                                            | Public IP address         | mc_reports-aks_reports-aks_centralus | Virtual Network      | IP Addresses                                        | $2.17     |
| ingressakspublicip                                                              | Public IP address         | mc_reports-aks_reports-aks_centralus | Virtual Network      | IP Addresses                                        | $2.17     |
| 37faf0b7-a0f4-4931-88d9-fbf9411d6407                                            | Public IP address         | mc_reports-aks_repsys1_centralus     | Virtual Network      | IP Addresses                                        | $1.54     |
| kubernetes-a1c16ff2d13f34794936eab3c401cfa9                                     | Public IP address         | mc_reports-aks_repsys1_centralus     | Virtual Network      | IP Addresses                                        | $1.54     |
| kubernetes-ad434d53123624fdf97377d3e5b9fce9                                     | Public IP address         | mc_reports-aks_reports-aks_centralus | Virtual Network      | IP Addresses                                        | $1.05     |
| kubernetes-a05b822ea09784b329f1c87ca280ba84                                     | Public IP address         | mc_reports-aks_reports-aks_centralus | Virtual Network      | IP Addresses                                        | $0.61     |
| aks-nodepool1-27950551-vmss                                                     | Virtual machine scale set | mc_reports-aks_repsys_centralus      | Virtual Machines     | Virtual Machines Dv2 Series                         | $0.34     |
| aks-nodepool1-27950551-vmss                                                     | Virtual machine scale set | mc_reports-aks_repsys_centralus      | Bandwidth            | Rtn Preference: MGN                                 | $0.00     |
| aks-nodepool1-27950551-vmss                                                     | Virtual machine scale set | mc_reports-aks_repsys_centralus      | Bandwidth            | Bandwidth Inter-Region                              | $0.00     |
| kubernetes-a19b9f26948754733adad6a8290345de                                     | Public IP address         | mc_reports-aks_reports-aks_centralus | Virtual Network      | IP Addresses                                        | $0.24     |
| aks-nodepool1-73064974-vmss                                                     | Virtual machine scale set | mc_reports-aks_repsys_centralus      | Virtual Machines     | Virtual Machines Dv3 Series                         | $0.15     |
| aks-nodepool1-73064974-vmss                                                     | Virtual machine scale set | mc_reports-aks_repsys_centralus      | Bandwidth            | Bandwidth Inter-Region                              | $0.00     |
| kubernetes                                                                      | Load balancer             | mc_reports-aks_repsys_centralus      | Load Balancer        | Load Balancer                                       | $0.09     |
| kubernetes                                                                      | Load balancer             | mc_reports-aks_repsys_centralus      | Load Balancer        | Load Balancer                                       | $0.00     |
| aks-nodepool1-279505aks-nodepool1-2795055disk1_121d7f3d028c4e749179263f0e556de2 | Disk                      | mc_reports-aks_repsys_centralus      | Storage              | Premium SSD Managed Disks                           | $0.06     |
| 549ce6b0-a33a-4448-82b4-5fe1e236ef57                                            | Public IP address         | mc_reports-aks_repsys_centralus      | Virtual Network      | IP Addresses                                        | $0.02     |
| aks-default-29924714aks-default-29924714-os__1_7c051b34228f4a7a872e083a625e093f | Disk                      | mc_reports-aks_reports-aks_centralus | Storage              | Premium SSD Managed Disks                           | $0.02     |
| aks-default-29924714aks-default-29924714-os__1_0f8d166579214947b64ee56eeafbd52b | Disk                      | mc_reports-aks_reports-aks_centralus | Storage              | Premium SSD Managed Disks                           | $0.01     |
| kubernetes-a25320ddedc83468780f40d60bbe20a3                                     | Public IP address         | mc_reports-aks_reports-aks_centralus | Virtual Network      | IP Addresses                                        | $0.01     |
| kubernetes-aaaefc6f55deb4905ba395d29dff40c5                                     | Public IP address         | mc_reports-aks_reports-aks_centralus | Virtual Network      | IP Addresses                                        | $0.01     |
| kubernetes-acfa7e09fdec3424da818b837a4f91ed                                     | Public IP address         | mc_reports-aks_reports-aks_centralus | Virtual Network      | IP Addresses                                        | $0.01     |
| aks-nodepool1-730649aks-nodepool1-7306497os__1_86b12c9ecddf4070920676da2f5780ca | Disk                      | mc_reports-aks_repsys_centralus      | Storage              | Standard SSD Managed Disks                          | $0.01     |
| aks-default-29924714aks-default-29924714-os__1_18381f64aa5c4ba9bfcce259b9049bce | Disk                      | mc_reports-aks_reports-aks_centralus | Storage              | Premium SSD Managed Disks                           | $0.01     |
| kubernetes-a91eeb7148ab640119974d2319d18f1c                                     | Public IP address         | mc_reports-aks_reports-aks_centralus | Virtual Network      | IP Addresses                                        | $0.01     |
| aks-default-29924714aks-default-29924714-os__1_b20f3ad56e7c4ec8bae407260f422049 | Disk                      | mc_reports-aks_reports-aks_centralus | Storage              | Premium SSD Managed Disks                           | $0.01     |
| aks-default-29924714aks-default-29924714-os__1_b0098d258fe8409e804f076e200d9a74 | Disk                      | mc_reports-aks_reports-aks_centralus | Storage              | Premium SSD Managed Disks                           | $0.01     |
| kubernetes-a4a02c0ed53f146ab9be8acf726c73c4                                     | Public IP address         | mc_reports-aks_repsys_centralus      | Virtual Network      | IP Addresses                                        | $0.01     |
| kubernetes-a77ed0af48a22497a9ef8e2c9032e62a                                     | Public IP address         | mc_reports-aks_repsys_centralus      | Virtual Network      | IP Addresses                                        | $0.00     |
| kubernetes-a66c50d765a644aeeb61e70de0bf9287                                     | Public IP address         | mc_reports-aks_repsys_centralus      | Virtual Network      | IP Addresses                                        | $0.00     |
| kubernetes-afb60dc4eebd2443893d283bb2e141df                                     | Public IP address         | mc_reports-aks_repsys_centralus      | Virtual Network      | IP Addresses                                        | $0.00     |
| aks-nodepool1-213713aks-nodepool1-2137134os__1_946a74321a3b46f38092375fd8316748 | Disk                      | mc_reports-aks_repsys1_centralus     | Storage              | Standard SSD Managed Disks                          | $0.00     |
| 03bb8ec6-77dc-4518-a9d4-64b1be645374                                            | Public IP address         | mc_reports-aks_repsys_centralus      | Virtual Network      | IP Addresses                                        | $0.00     |
| mgstore                                                                         | Storage account           | rg-useast-dataservices               | Storage              | Files                                               | $0.00     |
| mgstore                                                                         | Storage account           | rg-useast-dataservices               | Storage              | Tables                                              | $0.00     |
| mgstore                                                                         | Storage account           | rg-useast-dataservices               | Storage              | Blob Storage                                        | $0.00     |
| mgstore                                                                         | Storage account           | rg-useast-dataservices               | Storage              | Storage - Bandwidth                                 | $0.00     |
| pvc-65362d3b-8eff-460c-aefd-bf869e2c95b5                                        | Disk                      | mc_reports-aks_reports-aks_centralus | Storage              | Standard SSD Managed Disks                          | $0.00     |
| pvc-65362d3b-8eff-460c-aefd-bf869e2c95b5                                        | Disk                      | mc_reports-aks_reports-aks_centralus | Storage              | Standard SSD Managed Disks                          | $0.00     |
| aks-default-29924714aks-default-29924714-os__1_58869ccdc57649638a2d438625fc2ca9 | Disk                      | mc_reports-aks_reports-aks_centralus | Storage              | Premium SSD Managed Disks                           | $0.00     |
| aks-nodepool1-213713aks-nodepool1-2137134os__1_82ee4a0f4c584ac29188c8de823ca244 | Disk                      | mc_reports-aks_repsys1_centralus     | Storage              | Standard SSD Managed Disks                          | $0.00     |
| kubernetes-a3e95a897a7bb4ac8b2ce78753a5f67a                                     | Public IP address         | mc_reports-aks_repsys_centralus      | Virtual Network      | IP Addresses                                        | $0.00     |
| pvc-bb9df398-815b-4d62-bd3c-e4c718b08dcc                                        | Disk                      | mc_reports-aks_reports-aks_centralus | Storage              | Standard SSD Managed Disks                          | $0.00     |
| repsys3-kv                                                                      | Key vault                 | reports-aks                          | Key Vault            | Key Vault                                           | $0.00     |
| repsys-kv                                                                       | Key vault                 | reports-aks                          | Key Vault            | Key Vault                                           | $0.00     |
| repsys-aks                                                                      | Key vault                 | reports-aks                          | Key Vault            | Key Vault                                           | $0.00     |
| reports-aks                                                                     | Key vault                 | reports-aks                          | Key Vault            | Key Vault                                           | $0.00     |
| repsys1-ky                                                                      | Key vault                 | reports-aks                          | Key Vault            | Key Vault                                           | $0.00     |
|                                                                                 |                           |                                      |                      | Total                                               | $1,135.23 |
|                                                                                 |                           |                                      |                      | SQL MI                                              | $761.54   |
|                                                                                 |                           |                                      |                      | Revised Total                                       | $373.69   |
