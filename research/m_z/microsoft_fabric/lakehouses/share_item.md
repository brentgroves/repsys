# **[Share items in Microsoft Fabric](https://learn.microsoft.com/en-us/fabric/fundamentals/share-items)**

Workspaces are the central places where you collaborate with your colleagues in Microsoft Fabric. Besides assigning workspace roles, you can also use item sharing to grant and manage item-level permissions in scenarios where:

- You want to collaborate with colleagues who don't have a role in the workspace.
- You want to grant additional item level-permissions for colleagues who already have a role in the workspace.

This document describes how to share an item and manage its permissions.

## Share an item via link

In the list of items, or in an open item, select the Share button Screenshot of share button. .

1. The Create and send link dialog opens. Select People in your organization can view.

![i1](https://learn.microsoft.com/en-us/fabric/fundamentals/media/share-items/create-send-link.png)

## 2. The Select permissions dialog opens. Choose the audience for the link you're going to share

# [i2](https://learn.microsoft.com/en-us/fabric/fundamentals/media/share-items/select-permission.png)

You have the following options:

- People in your organization This type of link allows people in your organization to access this item. It doesn't work for external users or guest users. Use this link type when:

  - You want to share with someone in your organization.
  - You're comfortable with the link being shared with other people in your organization.
  - You want to ensure that the link doesn't work for external or guest users.

- People with existing access This type of link generates a URL to the item, but it doesn't grant any access to the item. Use this link type if you just want to send a link to somebody who already has access.
- Specific people This type of link allows specific people or groups to access the report. If you select this option, enter the names or email addresses of the people you wish to share with. This link type also lets you share to guest users in your organization's Microsoft Entra ID. You can't share to external users who aren't guests in your organization.

 Note

If your admin has disabled shareable links to People in your organization, you can only copy and share links using the People with existing access and Specific people options.

## Choose the permissions you want to grant via the link

![i2](https://learn.microsoft.com/en-us/fabric/fundamentals/media/share-items/additional-permissions.png)

Links that give access to People in your organization or Specific people always include at least read access. However, you can also specify if you want the link to include additional permissions as well.

 Note

The Additional permissions settings vary for different items. Learn more about the item permission model.

Links for People with existing access don't have additional permission settings because these links don't give access to the item.

Select Apply.

## 5. In the Create and send link dialog, you have the option to copy the sharing link, generate an email with the link, or share it via Teams

![i5](https://learn.microsoft.com/en-us/fabric/fundamentals/media/share-items/create-send-link-options.png)

- Copy link: This option automatically generates a shareable link. Select Copy in the Copy link dialog that appears to copy the link to your clipboard.

![i52](https://learn.microsoft.com/en-us/fabric/fundamentals/media/share-items/copy-link.png)

- by Email: This option opens the default email client app on your computer and creates an email draft with the link in it.

- by Teams: This option opens Teams and creates a new Teams draft message with the link in it.

## 6. You can also choose to send the link directly to Specific people or groups (distribution groups or security groups). Enter their name or email address, optionally type a message, and select Send. An email with the link is sent to your specified recipients

![i61](https://learn.microsoft.com/en-us/fabric/fundamentals/media/share-items/directly-send-link.png)

## Manage item links

1. To manage links that give access to the item, in the upper right of the sharing dialog, select the Manage permissions icon:

![i71](https://learn.microsoft.com/en-us/fabric/fundamentals/media/share-items/manage-permission-entry-1.png)

## 2. The Manage permissions pane opens, where you can copy or modify existing links or grant users direct access. To modify a given link, select Edit

![i72](https://learn.microsoft.com/en-us/fabric/fundamentals/media/share-items/manage-permission-pane.png)

## 3.  In the Edit link pane, you can modify the permissions included in the link, people who can use this link, or delete the link. Select Apply after your modification

This image shows the Edit link pane when the selected audience is People in your organization can view and share.

![i73](https://learn.microsoft.com/en-us/fabric/fundamentals/media/share-items/edit-link-1.png)

## This image shows the Edit link pane when the selected audience is Specific people can view and share. Note that the pane enables you to modify who can use the link

![i74](https://learn.microsoft.com/en-us/fabric/fundamentals/media/share-items/edit-link-2.png)

## 4. For more access management capabilities, select the Advanced option in the footer of the Manage permissions pane. On the management page that opens, you can

- View, manage, and create links.
- View and manage who has direct access and grant people direct access.
- Apply filters or search for specific links or people.

## Grant and manage access directly

In some cases, you need to grant permission directly instead of sharing link, such as granting permission to service account, for example.

Select Manage permission from the context menu.

![i81](https://learn.microsoft.com/en-us/fabric/fundamentals/media/share-items/permission-management-entry.png)

## Item permission model

Depending on the item being shared, you may find a different set of permissions that you can grant to recipients when you share. Read permission is always granted during sharing, so the recipient can discover the shared item in the OneLake catalog and open it.

| Permission granted while sharing     | Effect                                                                                                                                                                                                                                                 |
|--------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Read                                 | Recipient can discover the item in the data hub and open it. Connect to the Warehouse or SQL analytics endpoint of the Lakehouse.                                                                                                                      |
| Edit                                 | Recipient can edit the item or its content.                                                                                                                                                                                                            |
| Share                                | Recipient can share the item and grant permissions up to the permissions that they have. For example, if the original recipient has Share, Edit, and Read permissions, they can at most grant Share, Edit, and Read permissions to the next recipient. |
| Read All with SQL analytics endpoint | Read data from the SQL analytics endpoint of the Lakehouse or Warehouse data through TDS endpoints.                                                                                                                                                    |
| Read all with Apache Spark           | Read Lakehouse or Data warehouse data through OneLake APIs and Spark. Read Lakehouse data through Lakehouse explorer.                                                                                                                                  |
| Subscribe to OneLake events          | Subscribe to OneLake events for lakehouses, data warehouses, mirrored databases, SQL databases, and KQL databases.                                                                                                                                     |
| Build                                | Build new content on the semantic model.                                                                                                                                                                                                               |
| Execute                              | Execute or cancel execution of the item.                                                                                                                                                                                                               |
