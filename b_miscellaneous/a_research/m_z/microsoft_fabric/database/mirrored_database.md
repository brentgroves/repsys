# **[Direct Lake with your mirrored database data](https://learn.microsoft.com/en-us/fabric/database/mirrored-database/overview#direct-lake-with-your-mirrored-database-data)**

**[Current Status](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

**[Direct Lake](https://learn.microsoft.com/en-us/fabric/fundamentals/direct-lake-overview)** mode can be used with mirrored databases in Microsoft Fabric to enable high-performance querying over mirrored data without the need for data movement or duplication. When a mirrored database is created, its data is stored in Delta Lake format within OneLake. This native format allows Power BI and other analytics tools to connect via Direct Lake mode, offering near real-time insights by directly accessing the underlying files. This integration combines the simplicity of mirroring with the speed and scalability of Direct Lake, enabling fast, up-to-date reporting on operational data.

## Retention for mirrored data

Mirroring in Fabric continuously replicates your existing data estate into OneLake in Delta Lake table format. To keep the mirrored data efficiently stored and always ready for analytics, mirroring automatically runs vacuum to remove old files no longer referenced by a Delta log.

You can customize the retention setting according to your requirements. For instance, you may choose a shorter retention period to reduce mirroring storage consumption or extend the retention period to utilize Delta’s time travel capabilities for analytics.

For mirrored databases created from the Fabric portal after mid-June 2025, the default retention is one day. For old mirrored databases, the default is seven days. To check or update the retention setting, in the Fabric portal, navigate to your mirrored database -> Settings -> Maintenance tab, and specify the retention threshold. You can also configure it via public API by specifying the retentionInDays property.

## SQL database in Fabric

You can also directly create and manage a **[SQL database in Microsoft Fabric (Preview)](https://learn.microsoft.com/en-us/fabric/database/sql/overview)** inside the Fabric portal. Based on Azure SQL Database, SQL database in Fabric is automatically mirrored for analytics purposes and allows you to easily create your operational database in Fabric. SQL database is the home in Fabric for OLTP workloads, and can integrate with Fabric's source control integration.

**[Mirroring Fabric SQL database in Microsoft Fabric (preview)](https://learn.microsoft.com/en-us/fabric/database/sql/mirroring-overview?source=recommendations)**
