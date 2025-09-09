# **[OneLake file explorer](https://learn.microsoft.com/en-us/fabric/onelake/onelake-file-explorer)**

The OneLake file explorer application seamlessly integrates OneLake with Windows File Explorer. This application automatically syncs all OneLake items that you have access to in Windows File Explorer. "Sync" refers to pulling up-to-date metadata on files and folders, and sending changes made locally to the OneLake service. Syncing doesn’t download the data, it creates placeholders. You must double-click on a file to download the data locally.

![i1](https://learn.microsoft.com/en-us/fabric/onelake/media/onelake-file-explorer/onelake-file-explorer-screen-v-2.png#lightbox)

 Important

This feature is in preview.

When you create, update, or delete a file via Windows File Explorer, it automatically syncs the changes to OneLake service. Updates to your item made outside of your File Explorer aren't automatically synced. To pull these updates, you need to right-click on the item or subfolder in Windows File Explorer and select OneLake > Sync from OneLake.
