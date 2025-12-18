# **[How to access ZITADEL APIs](https://zitadel.com/docs/guides/integrate/zitadel-apis/access-zitadel-apis)**

## references

**[secrets](../../../../secrets/zitadel.md)**

Accessing ZITADEL APIs, except for the Auth API and the System API, requires these basic steps:

- **Create a service user:** A service user is a special type of account used to grant programmatic access to ZITADEL's functionalities. Unlike regular users who log in with a username and password, service users rely on a more secure mechanism involving digital keys and tokens.
- **Give permission to access ZITADEL APIs:** Assign a Manager role to the service user, giving it permission to make changes to certain resources in ZITADEL.
- **Authenticate the service user:** Like human users, service users must authenticate and request an OAuth token with the scope urn:zitadel:iam:org:project:id:zitadel:aud to access ZITADEL APIs. Service users can be authenticated using private key JWT, client credentials, or personal access tokens.
- **Access ZITADEL APIs with the token:** The OAuth token must be included in the Authorization Header of calls to ZITADEL APIs.

## Accessing Auth API

The Auth API can be used for all operations on the requesting user, meaning the user id in the sub claim of the used token. Using this API doesn't require a service user to be authenticated. Instead, you call the Auth API with the token of the user.

**[Reference documentation for authentication API](https://zitadel.com/docs/apis/introduction#authentication)**

## Accessing System API

With the System API developers can manage different ZITADEL instances. The System API can't be accessed by service users and requires a special configuration and authentication that can be found in our guide to access ZITADEL's System API.

**[Reference documentation for system API](https://zitadel.com/docs/apis/introduction#system)**

1. Create a service user

First, you need to create a new service user through the console or ZITADEL APIs.

Via Console:

- In an organization, navigate to Users > Service Users
- Click on New
- Enter a username and a display name
- Click on Create

Via APIs:

**[Create User (Machine)](https://zitadel.com/docs/apis/resources/mgmt/management-service-add-machine-user)**

2. Grant a Manager role to the service user

ZITADEL Managers are Users who have permission to manage ZITADEL itself. There are some different levels for managers.

- **IAM Managers:** This is the highest level. Users with IAM Manager roles are able to manage the whole instance.
- **Org Managers:** Managers in the Organization Level are able to manage everything within the granted Organization.
- **Project Managers:** At this level, the user is able to manage a project.
- **Project Grant Manager:** The project grant manager is for projects, which are granted of another organization.

On each level, we have some different Roles. Here you can find more about the different roles: **[ZITADEL Manager Roles](https://zitadel.com/docs/guides/manage/console/managers#roles)**

To be able to access the ZITADEL APIs your service user needs permissions to ZITADEL.

1. Go to the detail page of your organization
2. Click in the top right corner the "+" button
3. Search for your service user
4. Give the user the role you need, for the example we choose Org Owner (More about **[ZITADEL Permissions](https://zitadel.com/docs/guides/manage/console/managers)**)

![](https://zitadel.com/docs/assets/images/console_org_manager_add-13fd351c4a76941483e8a1b929a28e9f.gif)**

3. Authenticate service user and request token
Service users can be authenticated using private key JWT, client credentials, or personal access tokens. The **[service user authentication](https://zitadel.com/docs/guides/integrate/service-users/authenticate-service-users)** can be used to make machine-to-machine requests to any Resource Server (eg, a backend service / API) by requesting a token from the Authorization Server (ZITADEL) and sending the short-lived token (access token) in the Header of requests.

This guide covers a specific case of service user authentication when requesting access to the **[ZITADEL APIs](https://zitadel.com/docs/apis/introduction)**. While PAT can be used directly to access the ZITADEL APIS, the more secure authentication methods private key JWT and client credentials must include the **[reserved scope](https://zitadel.com/docs/apis/openidoauth/scopes)** urn:zitadel:iam:org:project:id:zitadel:aud when requesting an access from the token endpoint. This scope will add the ZITADEL APIs to the audience of the access token. ZITADEL APIs will check if they are in the audience of the access token, and reject the token in case they are not in the audience.

The following sections will explain the more specific authentication to access the ZITADEL APIs.

## Authenticate with private key JWT

Follow the steps in this guide to **[generate an key file](https://zitadel.com/docs/guides/integrate/service-users/private-key-jwt#2-generate-a-private-key-file)** and **[create a JWT and sign with private key](https://zitadel.com/docs/guides/integrate/service-users/private-key-jwt#3-create-a-jwt-and-sign-with-private-key)**.

With the encoded JWT (assertion) from the prior step, you will need to craft a POST request to ZITADEL's token endpoint.

To access the ZITADEL APIs you need the ZITADEL Project ID in the audience of your token. This is possible by sending a reserved scope for the audience. Use the scope urn:zitadel:iam:org:project:id:zitadel:aud to include the ZITADEL project id in your audience

## **[Next](https://zitadel.com/docs/guides/integrate/zitadel-apis/access-zitadel-apis#authenticate-with-private-key-jwt)**
