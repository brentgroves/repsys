# Register a client application using CLI and REST API

## references

<https://learn.microsoft.com/en-us/azure/healthcare-apis/register-application-cli-rest>

## Sign in to your Azure subscription

Before signing in to Azure, check the az version you've installed in your environment, and upgrade it to the latest version if necessary. Also, ensure that you have the account and Azure Health Data Services extensions installed.

You can sign in to Azure using the CLI login command, and list the Azure subscription and tenant you are in by default. For more information, see change the default subscription. For more information about how to sign in to a specific tenant, see Azure login.

**[login](az_login.md)**

## Create a client application

You can use the CLI command to create a confidential client application registration. You'll need to change the display name "myappregtest1" in your scripts.

```bash
az ad app create --display-name
                 [--app-roles]
                 [--enable-access-token-issuance {false, true}]
                 [--enable-id-token-issuance {false, true}]
                 [--end-date]
                 [--identifier-uris]
                 [--is-fallback-public-client {false, true}]
                 [--key-display-name]
                 [--key-type {AsymmetricX509Cert, Password, Symmetric}]
                 [--key-usage {Sign, Verify}]
                 [--key-value]
                 [--optional-claims]
                 [--public-client-redirect-uris]
                 [--required-resource-accesses]
                 [--sign-in-audience {AzureADMultipleOrgs, AzureADMyOrg, AzureADandPersonalMicrosoftAccount, PersonalMicrosoftAccount}]
                 [--start-date]
                 [--web-home-page-url]
                 [--web-redirect-uris]


az ad app create --display-name myappregtest3 \
                 --enable-access-token-issuance true \
                 --enable-id-token-issuance true \
                 --sign-in-audience AzureADMyOrg \
                 --web-redirect-uris "http://localhost:8080/oauth/redirect"
{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications/$entity",
  "addIns": [],
  "api": {
    "acceptMappedClaims": null,
    "knownClientApplications": [],
    "oauth2PermissionScopes": [],
    "preAuthorizedApplications": [],
    "requestedAccessTokenVersion": null
  },
  "appId": "73d44612-31c3-4060-a785-319a3fc5ae9a",
  "appRoles": [],
  "applicationTemplateId": null,
  "certification": null,
  "createdDateTime": "2024-03-20T23:07:18.4283253Z",
  "defaultRedirectUri": null,
  "deletedDateTime": null,
  "description": null,
  "disabledByMicrosoftStatus": null,
  "displayName": "myappregtest3",
  "groupMembershipClaims": null,
  "id": "480e7ce1-3698-4749-a0f8-31702f74f069",
  "identifierUris": [],
  "info": {
    "logoUrl": null,
    "marketingUrl": null,
    "privacyStatementUrl": null,
    "supportUrl": null,
    "termsOfServiceUrl": null
  },
  "isDeviceOnlyAuthSupported": null,
  "isFallbackPublicClient": null,
  "keyCredentials": [],
  "notes": null,
  "optionalClaims": null,
  "parentalControlSettings": {
    "countriesBlockedForMinors": [],
    "legalAgeGroupRule": "Allow"
  },
  "passwordCredentials": [],
  "publicClient": {
    "redirectUris": []
  },
  "publisherDomain": "LinamarCorporation.onmicrosoft.com",
  "requestSignatureVerification": null,
  "requiredResourceAccess": [],
  "samlMetadataUrl": null,
  "serviceManagementReference": null,
  "servicePrincipalLockConfiguration": null,
  "signInAudience": "AzureADMyOrg",
  "spa": {
    "redirectUris": []
  },
  "tags": [],
  "tokenEncryptionKeyId": null,
  "uniqueName": null,
  "verifiedPublisher": {
    "addedDateTime": null,
    "displayName": null,
    "verifiedPublisherId": null
  },
  "web": {
    "homePageUrl": null,
    "implicitGrantSettings": {
      "enableAccessTokenIssuance": true,
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
  }
}

az ad app list --display-name "myappregtest3"

az ad app create --display-name myappregtest3 \
                 --enable-access-token-issuance true \
                 --enable-id-token-issuance true \
                 --sign-in-audience AzureADMyOrg \
                 --web-redirect-uris "http://localhost:8080/oauth/redirect"
{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications/$entity",
  "addIns": [],
  "api": {
    "acceptMappedClaims": null,
    "knownClientApplications": [],
    "oauth2PermissionScopes": [],
    "preAuthorizedApplications": [],
    "requestedAccessTokenVersion": null
  },
  "appId": "013fba19-8b1b-4a16-b043-a27652e56b00",
  "appRoles": [],
  "applicationTemplateId": null,
  "certification": null,
  "createdDateTime": "2024-03-20T23:02:07.9947665Z",
  "defaultRedirectUri": null,
  "deletedDateTime": null,
  "description": null,
  "disabledByMicrosoftStatus": null,
  "displayName": "myappregtest3",
  "groupMembershipClaims": null,
  "id": "0844b2e7-d040-4c36-8e76-9500bf9f5662",
  "identifierUris": [],
  "info": {
    "logoUrl": null,
    "marketingUrl": null,
    "privacyStatementUrl": null,
    "supportUrl": null,
    "termsOfServiceUrl": null
  },
  "isDeviceOnlyAuthSupported": null,
  "isFallbackPublicClient": null,
  "keyCredentials": [],
  "notes": null,
  "optionalClaims": null,
  "parentalControlSettings": {
    "countriesBlockedForMinors": [],
    "legalAgeGroupRule": "Allow"
  },
  "passwordCredentials": [],
  "publicClient": {
    "redirectUris": []
  },
  "publisherDomain": "1hkt5t.onmicrosoft.com",
  "requestSignatureVerification": null,
  "requiredResourceAccess": [],
  "samlMetadataUrl": null,
  "serviceManagementReference": null,
  "servicePrincipalLockConfiguration": null,
  "signInAudience": "AzureADMyOrg",
  "spa": {
    "redirectUris": []
  },
  "tags": [],
  "tokenEncryptionKeyId": null,
  "uniqueName": null,
  "verifiedPublisher": {
    "addedDateTime": null,
    "displayName": null,
    "verifiedPublisherId": null
  },
  "web": {
    "homePageUrl": null,
    "implicitGrantSettings": {
      "enableAccessTokenIssuance": true,
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
  }
}                 
az ad app create --display-name myappregtest1

{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications/$entity",
  "addIns": [],
  "api": {
    "acceptMappedClaims": null,
    "knownClientApplications": [],
    "oauth2PermissionScopes": [],
    "preAuthorizedApplications": [],
    "requestedAccessTokenVersion": null
  },
  "appId": "c687b01b-465f-4fc9-8dc0-295eb0826743",
  "appRoles": [],
  "applicationTemplateId": null,
  "certification": null,
  "createdDateTime": "2024-03-20T21:54:08.0205597Z",
  "defaultRedirectUri": null,
  "deletedDateTime": null,
  "description": null,
  "disabledByMicrosoftStatus": null,
  "displayName": "myappregtest1",
  "groupMembershipClaims": null,
  "id": "f61bee51-bc6f-4eed-8b58-4a4cea22e0c6",
  "identifierUris": [],
  "info": {
    "logoUrl": null,
    "marketingUrl": null,
    "privacyStatementUrl": null,
    "supportUrl": null,
    "termsOfServiceUrl": null
  },
  "isDeviceOnlyAuthSupported": null,
  "isFallbackPublicClient": null,
  "keyCredentials": [],
  "notes": null,
  "optionalClaims": null,
  "parentalControlSettings": {
    "countriesBlockedForMinors": [],
    "legalAgeGroupRule": "Allow"
  },
  "passwordCredentials": [],
  "publicClient": {
    "redirectUris": []
  },
  "publisherDomain": "1hkt5t.onmicrosoft.com",
  "requestSignatureVerification": null,
  "requiredResourceAccess": [],
  "samlMetadataUrl": null,
  "serviceManagementReference": null,
  "servicePrincipalLockConfiguration": null,
  "signInAudience": "AzureADMyOrg",
  "spa": {
    "redirectUris": []
  },
  "tags": [],
  "tokenEncryptionKeyId": null,
  "uniqueName": null,
  "verifiedPublisher": {
    "addedDateTime": null,
    "displayName": null,
    "verifiedPublisherId": null
  },
  "web": {
    "homePageUrl": null,
    "implicitGrantSettings": {
      "enableAccessTokenIssuance": false,
      "enableIdTokenIssuance": false
    },
    "logoutUrl": null,
    "redirectUriSettings": [],
    "redirectUris": []
  }
}

az ad app list --display-name "myappregtest1"
```

In practice, you'll define variables, assign values to them, and set references to client app ID and object ID, which are used in subsequent steps.

## Define app registration name, etc

appregname=myappregtest2
clientid=$(az ad app create --display-name $appregname --query appId --output tsv)
objectid=$(az ad app show --id $clientid --query id --output tsv)

## Add a client secret for confidential client applications

For confidential client applications, you'll need to add a client secret. For public client applications, you can skip this step.

Choose a name for the secret and specify the expiration duration. The default is one year, but you can use the --end-date option to specify the duration. The client secret is saved in the variable and can be displayed with the echo command. Make a note of it as it isn't visible on the portal. In your deployment scripts, you can save and store the value in Azure Key Vault and rotate it periodically.

## Add client secret with expiration. The default is one year

```bash
clientsecretname=mycert2
clientsecretduration=2
clientsecret=$(az ad app credential reset --id $clientid --append --display-name $clientsecretname --years $clientsecretduration --query password --output tsv)
WARNING: The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
echo $clientsecret
```

## Change the flag for public client applications

For public client applications, change the Allow public client flows flag to Yes. For confidential client applications, skip this step.

## Optionally, change the app registration from confidential to public

```bash
az ad app update

az ad app update  --id $clientid  --set allowPublicClient=true 
Resource '' does not exist or one of its queried reference-property objects are not present
Property publicClient in payload has a value that does not match schema.
az ad app update  --id $clientid  --set redirectUris=https://www.getpostman.com/oauth2/callback

```

## Add redirect URLs

Adding redirect URLs is an optional step. You can use the --reply-urls to add one or more reply (or redirect) URLs for web apps. However, you can't specify application or platform type with the parameter.

For single page app, mobile, and desktop applications, use the REST API instead and specify the application or platform type.

```bash
###Update app registration using REST. az ad supports reply-urls only. 
#https://github.com/Azure/azure-cli/issues/9501
#redirecttype=spa | web | publicClient

redirecttype=publicClient
redirecturl=https://www.getpostman.com/oauth2/callback
graphurl=https://graph.microsoft.com/v1.0/applications/$objectid
az rest --method PATCH --uri $graphurl --headers 'Content-Type=application/json' --body '{"'$redirecttype'":{"redirectUris":["'$redirecturl'"]}}'

redirecttype=web
redirecturl=http://localhost:8080/oauth/redirect
graphurl=https://graph.microsoft.com/v1.0/applications/$objectid
az rest --method PATCH --uri $graphurl --headers 'Content-Type=application/json' --body '{"'$redirecttype'":{"redirectUris":["'$redirecturl'"]}}'

```
