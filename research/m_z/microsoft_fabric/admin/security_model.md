# **[](https://learn.microsoft.com/en-us/training/modules/secure-data-access-in-fabric/2-understand-fabric-security-model)**

## Understand the Fabric security model

Completed
100 XP
5 minutes
Data access in organizations is often restricted by users' responsibilities, and roles and by an organization's Fabric deployment patterns, and data architecture. Fabric has a flexible, multi-layer security model that allows you to configure security to accommodate different data access requirements. Having the ability to control permissions at different layers means you can adhere to the principle of least privilege, restricting user permissions to only what's needed to perform job tasks.

## Fabric has three security levels and they're evaluated sequentially to determine whether a user has data access. The order of evaluation for access is

**Microsoft Entra ID authentication:** checks if the user can authenticate to the Azure identity and access management service, Microsoft Entra ID.
**Fabric access:** checks if the user can access Fabric.
**Data security:** checks if the user can perform the action they've requested on a table or file.

The third level, data security, has several building blocks that can be configured individually or together to align with different access requirements. The primary access controls in Fabric are:

- Workspace roles
- Item permissions
- Compute or granular permissions
- OneLake data access controls (preview)

It's helpful to envision these building blocks in a hierarchy to understand how access controls can be applied individually or together.

![i1](https://learn.microsoft.com/en-us/training/wwl-data-ai/secure-data-access-in-fabric/media/data-access-controls.png)

A workspace in Fabric enables you to distribute ownership and access policies using workspace roles. Within a workspace, you can create Fabric data items like lakehouses, data warehouses, and semantic models. Item permissions can be inherited from a workspace role or set individually by sharing an item. When workspace roles provide too much access, items can be shared using item permissions to ensure proper security.

Within each data item, granular engine permissions such as Read, ReadData, or ReadAll can be applied.

Compute or granular permissions can be applied within a specific compute engine in Fabric, like the SQL Endpoint or semantic model.

Fabric data items store their data in OneLake. Access to data in the lakehouse can be restricted to specific files or folders using the role-based-access control (RBAC) feature called OneLake data access controls (preview).

## Configure workspace and item permissions

Completed
100 XP
6 minutes
Workspaces are environments where users can collaborate to create groups of items. Items are the resources you can work with in Fabric such as lakehouses, warehouses, and reports. Workspace roles are preconfigured sets of permissions that let you manage what users can do and access in a Fabric workspace.

Item permissions control access to individual Fabric items within a workspace. Item permissions let you either adjust the permissions set by a workspace role or give a user access to one or more items within a workspace without adding the user to a workspace role.

Let's consider some scenarios where you would need to configure data access using workspace roles and item permissions.

## Understand workspace roles

Suppose you work at a health care company as the Fabric security admin. You need to set up access for a new data engineer. The data engineer needs the ability to:

- Create Fabric items in an existing workspace
- Read all data in an existing lakehouse that's in the same workspace where they can create Fabric items

Workspace roles control what users can do and access within a Fabric workspace. There are four workspace roles and they apply to all items within a workspace. Workspace roles can be assigned to individuals, security groups, Microsoft 365 groups, and distribution lists. Users can be assigned to the following roles:

- Admin - Can view, modify, share, and manage all content and data in the workspace, and manage permissions.
- Member - Can view, modify, and share all content and data in the workspace.
- Contributor - Can view and modify all content and data in the workspace.
- Viewer - Can view all content and data in the workspace, but can't modify it.

 Tip

For a full list of the permissions associated with workspace roles, see: **[Roles in workspaces](https://learn.microsoft.com/en-us/fabric/get-started/roles-workspaces)**

To meet the access requirements for the new data engineer, you can assign them the workspace Contributor role. This gives them access to modify content in the workspace, including creating Fabric items like lakehouses. The contributor role would also allow them to read data in the existing lakehouse.

## Assign workspace roles

Users can be added to workspace roles from the Manage access button from within a workspace. Add a user by entering the user's name and selecting the workspace role to assign them in the Add people dialogue.

![i2](https://learn.microsoft.com/en-us/training/wwl-data-ai/secure-data-access-in-fabric/media/manage-access.png)

## Configure item permissions

Item permissions control access to individual Fabric items within a workspace. Item permission can be used to give a user access to one or more items within a workspace without adding the user to a workspace role or can be used with workspace roles.

Suppose that after a few months of having Contributor access on a workspace, a data engineer no longer needs to create Fabric items and now only needs to view a single lakehouse and read data in it.

Since the engineer no longer needs to view all items in the workspace, the Contributor workspace role can be removed and item permissions on the lakehouse can be configured so the engineer will only be able to see the lakehouse metadata and data and nothing else in the workspace. This item access configuration helps you adhere to the principle of least privilege, where the engineer only has access to what's needed to perform their job duties.

An item can be shared and item permissions can be configured by selecting on the ellipsis (...) next to a Fabric item in a workspace and then selecting Manage permissions.
