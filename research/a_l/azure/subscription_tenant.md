# **[Tenants and subscriptions](https://www.reddit.com/r/AZURE/comments/bwuzmp/confused_about_tenants_subscriptions_directories/)**

## **[Associate or add an Azure subscription to your Microsoft Entra tenant](https://learn.microsoft.com/en-us/entra/fundamentals/how-subscriptions-associated-directory)**

![](https://learn.microsoft.com/en-us/entra/fundamentals/media/how-subscriptions-associated-directory/trust-relationship.png)

All Azure subscriptions have a trust relationship with a Microsoft Entra tenant. Subscriptions rely on this tenant (directory) to authenticate and authorize security principals and devices. When a subscription expires, the trusted instance remains, but the security principals lose access to Azure resources. Subscriptions can only trust a single directory while one Microsoft Entra tenant may be trusted by multiple subscriptions.

When a user signs up for a Microsoft cloud service, a new Microsoft Entra tenant is created and the user is made a Global Administrator. However, when an owner of a subscription joins their subscription to an existing tenant, the owner isn't assigned to the Global Administrator role.

While users may only have a single authentication home directory, users may participate as guests in multiple directories. You can see both the home and guest directories for each user in Microsoft Entra ID.

## **[Tenant and subscriptions](https://www.reddit.com/r/AZURE/comments/bwuzmp/confused_about_tenants_subscriptions_directories/)**

Confused about tenants, subscriptions, directories, and transferring subscriptions
Can someone explain what happens in the following scenario?

Company A has an azure tenant with a subscription and a directory.

Company B has an azure tenant with a subscription and a directory.

Company B moves their subscription to Company A for billing/ownership.

What happens to company B's subscription resources and directory?

What access/control does company A have over company B's resources and directory?

What happens to company B's tenant once the subscription is transferred to company A?

I think I can answer most of this, and don't worry, it took me a long time to wrap my head around these concepts, and even still sometimes I have to stop and question myself. So here is my understanding:

If you have an Enterprise Agreement things are a little different than if you don't. In the EA portal you can invite the owner account into your EA, which basically just moves billing into the EA, everything else pretty much stays the same. Otherwise you would probably use the Azure Account portal (or whatever it is called today) to handle your billing, and the Account portal will show you billing for whatever subscriptions are owned by that account.

With or without an EA, when you move subscriptions you are actually changing the owner account of the subscription. The account that owns the subscription determines the Azure AD tenant (directory) that the subscription uses for authentication. If you change the owner to an account from a different tenant all of your RBAC roles are lost and you must re-apply them using users in the new tenant. The resources are not lost, but the roles assigned on them to users from the old AAD tenant are lost.

So in your scenario above, assuming company B transferred ownership of their subscriptions to company A's "owner" account, company A's owner account would now have the owner role in the subscriptions and all other roles previously assigned on resources in company B's subscriptions will need to be re-assigned with users from company A's Azure AD tenant. Company B's Azure AD tenant will still exist, and whatever accounts exist in it can still log in to the Azure portal and look at users and groups, but they won't have any subscriptions available to manage under that tenant.

I was always under the impression that a tenant and the Azure AD have a 1 to 1 relationship. So if i have company b setup with a custom dns name of test.com and company a setup with a custom dns name of test2.com these two tenants and Azure AD directories will remain in tact after the subscription move just with different ownership under the enterprise agreement. Is that correct?

## My understanding of the terminology is that an Azure AD directory is the tenant

But yes, I don't think there is any way to destroy an Azure AD tenant. Even after you transfer all the subscriptions to another account owner the AAD tenant still exists, and you could always create more subscriptions associated to it later.

As for the EA, my understanding is that it really just acts as a collection of accounts under a common billing contract. You can invite new accounts into it without changing anything related to their Azure AD tenant or subscriptions, only the billing changes. Once those accounts are added to the EA portal it does make it easier to transfer ownership of subscriptions to a different account though, as there is a nice little "transfer" button in the subscriptions list in the EA portal.

My understanding of the terminology is that an Azure AD directory is the tenant.

## Correct, Azure AD, tenant, Office 365 tenant... Many names, but all the same

Azure AD is like an on-premises Active Directory. You maintain all users here, and have trust relationships with applications (Exchange Online, SharePoint Online, Dynamics 365, Azure, ServiceNow, etc) that use it as their Identity Provider.

I would clarify for anyone reading, Azure AD is not an exact replacement for on-prem AD, but more an extension for your on-prem AD or a limited feature alternative if you just need to authenticate to Azure, Office 365, etc. There is no group policy and you can't extend the schema, so you can't expect to do the same things you could on-prem with just an Azure AD tenant. The most common usage scenario for business of any size is to use "Azure AD Connect" to replicate an on-prem AD to Azure AD.

## I worked in Azure directly in this area. Just wanted to chime in to endorse this answer

One clarification I want to add is that the "owner role" you referred to here is actually called the "Account Administrator" role. The Account Admin is the identity that initially signed up for the Azure subscription and is the only identity that can manage billing (like updating billing address and changing credit cards) for the subscription. the The distinction is important because there's also the RBAC Owner role.

This depends on the type of ownership/transfer.

Source: I work for an Azure CSP, and we bill both direct and indirect Azure CSP Subscriptions.

Firstly a tenancy and directory are more or less the same thing. You can have sub directories like Azure AD B2C but they are treated more like a resource than the high level tenancy.

Subscriptions are a billing construct, they provide a way for cost associated to running Azure resources to be applied to and billed to an entity or entities. The applied to and billed to can be two separate entities.

In the case of CSP subscriptions, a trust relationship is created between the CSP reseller and the end customer, the trust relationship allows to things to happen, firstly the CSP can create subscriptions on behalf of the customer, and delegated authority to preform certain actions against the customers tenency and any CSP subscriptions created. This delegated authority does encompass a lot and in some cases can be too open depending on the organisational requirements. This delegated authority can be paired back to what is needed by manually configuring permissions etc. That's CSP in a nut-shell.

All other subscriptions "generally" bill directly to the tenancy owner, or the business that created the tenancy. For example these subscriptions could be pay as you go (credit card) or Enterprise agreements. I won't go over the nuances of those because it's probably not important for your question.

Now to answer your questions directly, if Company B were to sign up to CSP through Company A, Company B still owns the subscription and all the resources there in, but the billing is handled on behalf of the CSP. The only changes to Company B's tenancy is some delegated authority is applied via Azure AD groups. Existing resources/subscriptions are not affected, but resources would need to be moved to the new CSP sub in order for billing to be done by Company A.

If Company A were to become the Administrator/co-owner of Company B's PAYG subscription, this would mean that they could take over the billing (i.e. update the credit card to be Company A's). Nothing happens to the existing resources, but technically Company A had full control over the subscription. At this point they could do a lot. But again this isn't too different to what would happen with a CSP.

If Company A were to transfer (this is quite an important difference) Company B's subscription to Company A's tenancy, Company B would no longer have any control whatsoever on that subscription, essentially it disappears from Company B's tenancy. The resources are not affected, but all IAM etc would be removed because the AAD groups etc wouldn't exist in Company A's tenancy. At this point Company A has FULL control of the subscription.

Hopefully that covers it, if not, or something needs further clarification let me know.

EDIT: forgot the last question. In any of these scenarios nothing happens to Company B's tenancy. That will carry on working merrily.
