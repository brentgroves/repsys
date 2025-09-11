# **[Using OneLake for Excel Files in Microsoft Fabric](https://www.sqlservercentral.com/blogs/using-onelake-for-excel-files-in-microsoft-fabric)**

This tool will allow you to navigate through the files in Lakehouses in a OneDrive-like experience. From here, you can open and edit the Excel file locally and without having to redownload and upload the file from the online portal.

![i1](https://dataonwheels.wordpress.com/wp-content/uploads/2025/01/image-6.png)

![i2](https://dataonwheels.wordpress.com/wp-content/uploads/2025/01/image-7.png)

Unfortunately, OneLake does not sync your local copy of the file when you have the file open. I highly recommend frequently saving the file and closing it so that your changes get pushed to the cloud and you can pull any edits that have been made to the file. To make sure you are working off the latest file, check that the Date Modified in your file explorer matches the cloud Date Modified. You should also ensure that these match each other after saving and closing the file.

![i3](https://dataonwheels.wordpress.com/wp-content/uploads/2025/01/image-8.png)

This explorer is still in Preview, so I’m looking forward to things getting better from here, but it did resolve our situation. In general, definitely recommend going with OneDrive or SharePoint if those are available since those sources have better version history and visibility to concurrent updates.
