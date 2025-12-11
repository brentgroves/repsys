# **[](https://learn.microsoft.com/en-us/power-bi/connect-data/service-gateway-sql-tutorial#:~:text=In%20production%20environments%2C%20you%20typically,or%20contact%20your%20database%20administrator.)**

**[](https://learn.microsoft.com/en-us/power-bi/connect-data/service-gateway-enterprise-manage-sql#:~:text=On%20the%20New%20connection%20screen,credentials%20to%20execute%20the%20queries.)**

When publishing a Power BI report to the service, you use **a dedicated service account or Windows/Basic authentication credentials for the Data Gateway**, not your personal login; this service account (often managed by an admin) has permissions to refresh data in the Power BI Service, enabling automated updates, with Windows (Integrated) Authentication preferred for on-prem SQL for SSO, while Basic (SQL Login) works but requires managing passwords.

## Key Credential Types

For On-Premises SQL (via Data Gateway):
Windows Authentication (Recommended): Uses your Active Directory/Windows account; ideal for Single Sign-On (SSO) where users' own credentials access the data, requiring Kerberos setup.
Basic (Username/Password): Uses a specific SQL Server login; requires managing passwords but is straightforward for SQL logins.
For Azure SQL/Cloud Sources:
OAuth2/Microsoft Entra ID: For Azure SQL, this uses stored Microsoft Entra tokens or even the user's own credentials (SSO).

How it Works When Publishing
In Desktop: You connect using your personal credentials (Windows or Basic) to author the report.
Publish to Service: The .pbix file uploads, but credentials are not embedded.
In Power BI Service: You configure the data source in the gateway/dataset settings.
The Gateway Takes Over: The Data Gateway uses the configured service credentials (Windows or Basic) to connect and refresh data, independent of your desktop login.

## Best Practice

Use a dedicated service account with the minimum required permissions (like db_datareader).
For on-prem, configure Windows Authentication on the gateway for seamless SSO.
Avoid using your personal admin account for scheduled refreshes; this separates report authoring from data refresh operations.
