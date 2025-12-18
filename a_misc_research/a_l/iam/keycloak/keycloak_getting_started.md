# **[Keycloak getting started](https://www.keycloak.org/getting-started/getting-started-docker)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../README.md)**

## references

- **[guides](https://www.keycloak.org/guides)**
- **[quarkus](https://www.mastertheboss.com/keycloak/getting-started-with-keycloak-powered-by-quarkus/)**
- **[k8s without operator](https://www.keycloak.org/getting-started/getting-started-kube)**

## Before you start

Make sure your machine or container platform can provide sufficient memory and CPU for your desired usage of Keycloak. See Concepts for sizing **[CPU and memory resources](./cpu_and_memory_resources.md)** for more on how to get started with production sizing.

Make sure you have Docker installed.

## Start Keycloak

From a terminal, enter the following command to start Keycloak:

```bash
docker run -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak:25.0.6 start-dev
```

This command starts Keycloak exposed on the local port 8080 and creates an initial admin user with the username admin and password admin.

## Log in to the Admin Console

1. Go to the **[Keycloak Admin Console](http://localhost:8080/admin)**.
2. Log in with the username and password you created earlier.

## Create a realm

A realm in Keycloak is equivalent to a tenant. Each realm allows an administrator to create isolated groups of applications and users. Initially, Keycloak includes a single realm, called master. Use this realm only for managing Keycloak and not for managing any applications.

Use these steps to create the first realm.

1. Open the **[Keycloak Admin Console](http://localhost:8080/admin)**.
2. Click Keycloak next to master realm, then click Create Realm.
3. Enter myrealm in the Realm name field.
4. Click Create.

![realm](https://www.keycloak.org/resources/images/guides/add-realm.png)

## Create a user

Initially, the realm has no users. Use these steps to create a user:

1. Verify that you are still in the myrealm realm, which is shown above the word Manage.
2. Click Users in the left-hand menu.
3. Click Add user.
4. Fill in the form with the following values:
    - Username: myuser
    - First name: any first name
    - Last name: any last name
5. Click Create.

![user](https://www.keycloak.org/resources/images/guides/add-user.png)

This user needs a password to log in. To set the initial password:

- Click **Credentials** at the top of the page.
- Fill in the **Set password** form with a password.
- Toggle Temporary to Off so that the user does not need to update this password at the first login.

## Log in to the Account Console

You can now log in to the Account Console to verify this user is configured correctly.

1. Open the **[Keycloak Account Console](http://localhost:8080/realms/myrealm/account)**.
2. Log in with myuser and the password you created earlier.

As a user in the Account Console, you can manage your account including modifying your profile, adding two-factor authentication, and including identity provider accounts.

![account](https://www.keycloak.org/resources/images/guides/account-console.png)**

## Secure the first application

To secure the first application, you start by registering the application with your Keycloak instance:

1. Open the **[Keycloak Admin Console](http://localhost:8080/admin)**.
2. Click the word master in the top-left corner, then click myrealm.
3. Click Clients.
4. Click Create client
5. Fill in the form with the following values:
    - Client type: OpenID Connect
    - Client ID: myclient

![client](https://www.keycloak.org/resources/images/guides/add-client-1.png)**
6. Click Next
7. Confirm that Standard flow is enabled.
8. Click Next.
9. Make these changes under Login settings.
    - Set Valid redirect URIs to <https://www.keycloak.org/app/>*
    - Set Web origins to <https://www.keycloak.org>
10. Click Save.

![add client](https://www.keycloak.org/resources/images/guides/add-client-2.png)

To confirm the client was created successfully, you can use the SPA testing application on the Keycloak website.

1. Open <https://www.keycloak.org/app/>.
2. Click Save to use the default configuration.
3. Click Sign in to authenticate to this application using the Keycloak server you started earlier.

## Taking the next step

Before you run Keycloak in production, consider the following actions:

- Switch to a production ready database such as PostgreSQL.
- Configure SSL with your own certificates.
- Switch the admin password to a more secure password.

For more information, see the **[server guides](https://www.keycloak.org/guides#server)**.
