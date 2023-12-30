# b2c tenant

Can't do this on my development account.

Customers must own a paid license to create Microsoft Entra Workforce tenant.

## references

<https://learn.microsoft.com/en-us/azure/active-directory-b2c/tenant-management-check-tenant-creation-permission>

Anyone who creates an Azure Active Directory B2C (Azure AD B2C) becomes the Global Administrator of the tenant. It's a security risk if a non-admin user is allowed to create a tenant. In this article, you learn how, as an admin, you can restrict tenant creation for non-admins. Also, you'll learn how, as a non-admin user, you can check if you've permission to create a tenant.

## Prerequisites

If you haven't already created your own Azure AD B2C Tenant, create one now. You can use an existing Azure AD B2C tenant.

## Restrict non-admin users from creating Azure AD B2C tenants

As a Global Administrator in an Azure AD B2C tenant, you can restrict non-admin users from creating tenants. To do so, use the following steps:

1. Sign in to the Azure portal.
2. If you have access to multiple tenants, select the Settings icon in the top menu to switch to your Azure AD B2C tenant from the Directories + subscriptions menu.
3. In the Azure portal, search for and select Microsoft Entra ID.
4. Under Manage, select User Settings.
5. Under Tenant creation, select Yes.
6. At the top of the User Settings page, select Save.
