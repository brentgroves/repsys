# write data from excel file into fabric lakehouse

To write data from an Excel file into a Microsoft Fabric Lakehouse, you can use a Dataflow Gen2, a Data Pipeline, or a Spark notebook. Each method offers a different level of flexibility and control, but a Dataflow Gen2 is often the most straightforward for users familiar with Power Query.

## Method 1: Use a Dataflow Gen2

This method uses the Power Query experience to connect to your Excel file, transform the data, and load it into a lakehouse table.
Create a new Dataflow Gen2. In your Fabric workspace, select New > Dataflow Gen2.
Connect to your Excel file. Select the Import from Excel option. You will be prompted to provide the location of your file. For a local file, you can upload it directly. For a file stored on a cloud service like SharePoint, provide the URL.
Transform the data. Once connected, the Power Query editor will appear. This allows you to apply transformations, such as changing data types, removing columns, or filtering rows.
Define the Lakehouse destination. In the Query Settings pane, click Add to Destination and choose Lakehouse.
Configure the load settings. Choose the destination lakehouse and specify a new or existing table. You can select the Append or Overwrite method for loading data.
Publish and run. Click Publish to save and run the dataflow. It will automatically load the data into the specified table in your lakehouse.
