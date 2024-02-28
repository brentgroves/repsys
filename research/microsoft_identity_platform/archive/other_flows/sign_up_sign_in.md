# Create sign-up and sign-in User Flow

## references

<https://learn.microsoft.com/en-us/azure/active-directory-b2c/add-sign-up-and-sign-in-policy?pivots=b2c-user-flow>

## Set up a sign-up and sign-in flow in Azure Active Directory B2C

Before you begin, use the Choose a policy type selector at the top of this page to choose the type of policy you’re setting up. Azure Active Directory B2C offers two methods to define how users interact with your applications: through predefined user flows or through fully configurable custom policies. The steps required in this article are different for each method.

## Sign-up and sign-in flow

Sign-up and sign-in policy lets users:

- Sign-up with local account
- Sign-in with local account
- Sign-up or sign-in with a social account
- Password reset

![](https://learn.microsoft.com/en-us/azure/active-directory-b2c/media/add-sign-up-and-sign-in-policy/add-sign-up-and-sign-in-flow.png)

## Prerequisites

An Azure account with an active subscription. Create an account for free.
If you don't have one already, create an Azure AD B2C tenant that is linked to your Azure subscription.

## Create a sign-up and sign-in user flow

The sign-up and sign-in user flow handles both sign-up and sign-in experiences with a single configuration. Users of your application are led down the right path depending on the context.

Sign in to the Azure portal.

- If you have access to multiple tenants, select the Settings icon in the top menu to switch to your Azure AD B2C tenant from the Directories + subscriptions menu.
- In the Azure portal, search for and select Azure AD B2C.
- Under Policies, select User flows, and then select New user flow.

An Azure account that's been assigned at least the Contributor role within the subscription or a resource group within the subscription is required.

Can't create an Azure AD B2C tenant with my developers account.

<https://learn.microsoft.com/en-us/azure/governance/policy/tutorials/create-custom-policy-definition>
