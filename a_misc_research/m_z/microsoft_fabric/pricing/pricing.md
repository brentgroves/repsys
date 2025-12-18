<https://azure.microsoft.com/en-us/pricing/details/microsoft-fabric/>

Mirroring an Azure SQL database to Microsoft Fabric is free up to a certain capacity-based limit. Specifically, the compute used to replicate the data into OneLake is free, and so is the OneLake storage for the replica, up to a limit based on your purchased capacity,

Here's a more detailed breakdown:
Free Compute:
The compute resources used to replicate your Azure SQL Database data into Fabric OneLake are provided at no cost.
Free Storage (up to a limit):
Microsoft Fabric provides free storage for the mirrored data, based on the size of your purchased capacity. For example, if you have an F64 capacity, you get 64 free terabytes of storage exclusively for mirroring, according to a Fabric Blog post.
When charges apply:
You only incur charges when you exceed the free storage limit or when your Fabric capacity is paused.
Fabric Capacity:
The compute used for querying the mirrored data via SQL, Power BI, or Spark is charged based on your Fabric capacity.

In essence, mirroring Azure SQL databases into Fabric offers a cost-effective way to analyze your data, as the initial replication process and storage for the replica are free up to a certain point.
