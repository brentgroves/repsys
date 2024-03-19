# App Registration

## references

<https://learn.microsoft.com/en-us/azure/healthcare-apis/register-application-cli-rest>

## Sign in to your Azure subscription

Before signing in to Azure, check the az version you've installed in your environment, and upgrade it to the latest version if necessary. Also, ensure that you have the account and Azure Health Data Services extensions installed.

You can sign in to Azure using the CLI login command, and list the Azure subscription and tenant you are in by default. For more information, see change the default subscription. For more information about how to sign in to a specific tenant, see Azure login.

```bash
az login
# login in as bgroves@mobexglobal.com
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
az account show --output table
EnvironmentName    HomeTenantId                          IsDefault    Name                   State    TenantId
-----------------  ------------------------------------  -----------  ---------------------  -------  ------------------------------------
AzureCloud         b4b87e8f-df64-41ff-9ba4-a4930ebc804b  True         sub_mgmain_itservices  Enabled  b4b87e8f-df64-41ff-9ba4-a4930ebc804b

az ad app list
# linamar
az login --allow-no-subscriptions
# Add --allow-no-subscriptions param or you get an error
A web browser has been opened at https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize. Please continue the login in the web browser. If no web browser is available or if the web browser fails to open, use device code flow with `az login --use-device-code`.
The following tenants don't contain accessible subscriptions. Use 'az login --allow-no-subscriptions' to have tenant level access.
ceadc058-fad7-4b6b-830b-00ac739654f0 'LinamarCorporation'
[
  {
    "cloudName": "AzureCloud",
    "id": "ceadc058-fad7-4b6b-830b-00ac739654f0",
    "isDefault": true,
    "name": "N/A(tenant level account)",
    "state": "Enabled",
    "tenantId": "ceadc058-fad7-4b6b-830b-00ac739654f0",
    "user": {
      "name": "bGroves@linamar.com",
      "type": "user"
    }
  }
]
az account show --output table
EnvironmentName    IsDefault    Name                       State    TenantId
-----------------  -----------  -------------------------  -------  ------------------------------------
AzureCloud         True         N/A(tenant level account)  Enabled  ceadc058-fad7-4b6b-830b-00ac739654f0

```

## Register a client application using CLI and REST API
