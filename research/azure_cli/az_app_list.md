# **[az ad app list](https://learn.microsoft.com/en-us/cli/azure/ad/app?view=azure-cli-latest#az-ad-app-list)**

## references

**[example queries](https://github.com/MicrosoftDocs/azure-docs-cli/blob/main/docs-ref-conceptual/includes/query-azure-cli-examples.md)**

```bash
az ad app list --show-mine --query "[].{DisplayName:displayName,AppId:appId,RedirectURI:web.redirectUris}"
az ad app list --query "[].{DisplayName:displayName,AppId:appId,RedirectURI:web.redirectUris}"
az ad app list --query "[].{DisplayName:displayName,AppId:appId,Web:web}"
az ad app list --query "[].{PublisherDomain:publisherDomain,SignInAudience:signInAudience,DisplayName:displayName,AppId:appId,Web:web,oauth:api.oauth2PermissionScopes,identifierUris:identifierUris,PasswordCredentials:passwordCredentials,ServicePrincipalLockConfiguration:servicePrincipalLockConfiguration}"

az ad app list  --query "[].{DisplayName:displayName,AppId:appId,RedirectURI:web.redirectUris}"

az ad app list --display-name "repsys requestor" --query "[].{PublisherDomain:publisherDomain,SignInAudience:signInAudience,DisplayName:displayName,AppId:appId,Web:web,oauth:api.oauth2PermissionScopes,identifierUris:identifierUris,PasswordCredentials:passwordCredentials,ServicePrincipalLockConfiguration:servicePrincipalLockConfiguration}"

az ad app list --display-name "repsys requestor" 

az ad app list --display-name "repsys requestor" --query "[].{PublisherDomain:publisherDomain,SignInAudience:signInAudience,DisplayName:displayName,AppId:appId,Web:web,oauth:api.oauth2PermissionScopes,identifierUris:identifierUris,PasswordCredentials:passwordCredentials,ServicePrincipalLockConfiguration:servicePrincipalLockConfiguration}"

[
  {
    "AppId": "d6b668c7-e181-4415-b6fe-fb7a76d48d4a",
    "DisplayName": "repsys requestor",
    "PasswordCredentials": [
      {
        "customKeyIdentifier": null,
        "displayName": "Use to encode jwt",
        "endDateTime": "2024-08-28T21:32:01.357Z",
        "hint": "DWK",
        "keyId": "b51ee493-22c4-44db-99d5-237a143d8a84",
        "secretText": null,
        "startDateTime": "2024-03-01T22:32:01.357Z"
      }
    ],
    "PublisherDomain": "1hkt5t.onmicrosoft.com",
    "ServicePrincipalLockConfiguration": {
      "allProperties": true,
      "credentialsWithUsageSign": true,
      "credentialsWithUsageVerify": true,
      "identifierUris": false,
      "isEnabled": true,
      "tokenEncryptionKeyId": true
    },
    "SignInAudience": "AzureADMyOrg",
    "Web": {
      "homePageUrl": null,
      "implicitGrantSettings": {
        "enableAccessTokenIssuance": false,
        "enableIdTokenIssuance": true
      },
      "logoutUrl": null,
      "redirectUriSettings": [
        {
          "index": null,
          "uri": "http://localhost:8080/oauth/redirect"
        }
      ],
      "redirectUris": [
        "http://localhost:8080/oauth/redirect"
      ]
    },
    "identifierUris": [
      "api://d6b668c7-e181-4415-b6fe-fb7a76d48d4a"
    ],
    "oauth": [
      {
        "adminConsentDescription": "OpenID connect",
        "adminConsentDisplayName": "OpenID connect",
        "id": "38bf155a-f86d-4a81-9734-f0f6dce183bf",
        "isEnabled": true,
        "type": "User",
        "userConsentDescription": "OpenID connect",
        "userConsentDisplayName": "OpenID connect",
        "value": "OpenID_connect"
      }
    ]
  }
]

```
