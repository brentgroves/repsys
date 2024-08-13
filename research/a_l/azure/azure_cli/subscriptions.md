# **[How to manage Azure subscriptions with the Azure CLI](https://learn.microsoft.com/en-us/cli/azure/manage-azure-subscriptions-azure-cli?tabs=bash)**

## references

- **[How to manage Azure subscriptions with the Azure CLI](https://learn.microsoft.com/en-us/cli/azure/manage-azure-subscriptions-azure-cli?tabs=bash)**

The Azure CLI helps you manage your Azure subscription, create management groups, and lock subscriptions.You might have multiple subscriptions within Azure. You can be part of more than one organization or your organization might divide access to certain resources across groupings. The Azure CLI supports selecting a subscription both globally and per command.

For detailed information on subscriptions, billing, and cost management, see the billing and cost management documentation.

## mobexglobal.com

```bash
# store the default subscription in a variable
subscriptionId="$(az account list --query "[?isDefault].id" --output tsv)"
echo $subscriptionId

# get the current default subscription using show
az account show --output table
EnvironmentName    HomeTenantId                          IsDefault    Name                   State    TenantId
-----------------  ------------------------------------  -----------  ---------------------  -------  ------------------------------------
AzureCloud         b4b87e8f-df64-41ff-9ba4-a4930ebc804b  True         sub_mgmain_itservices  Enabled  b4b87e8f-df64-41ff-9ba4-a4930ebc804b

# get the current default subscription using list
az account list --query "[?isDefault]"
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b",
    "id": "f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a",
    "isDefault": true,
    "managedByTenants": [],
    "name": "sub_mgmain_itservices",
    "state": "Enabled",
    "tenantId": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b",
    "user": {
      "name": "bgroves@mobexglobal.com",
      "type": "user"
    }
  }
]

# get a subscription that contains search words or phrases
az account list --query "[?contains(name,'search phrase')].{SubscriptionName:name, SubscriptionID:id, TenantID:tenantId}" --output table
```
