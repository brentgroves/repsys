# Warehouse Lakehouse Access

This is done in Warehouse SPROC.

```sql
ALTER PROCEDURE [dbo].[SentinelOne_API_Usp_Prepare_Output_Tables]
AS
BEGIN
    SET NOCOUNT ON;
 
    --=====================================
    -- Step 1: Prepare Output Computer Agents
    --=====================================
    BEGIN TRY
        BEGIN TRAN;
 
        TRUNCATE TABLE [SentinelOne_API_Output_Computer_Agents];
 
        -- Insert computers with agents
        INSERT INTO [SentinelOne_API_Output_Computer_Agents] (
            [ComputerName], [ComputerDistinguishedName], [CreatedAt], [UpdatedAt], [LastLogon],
            [HasAgent], [AgentVersion], [OsArch], [OsName], [OsRevision], [OsStartTime], [OsType],
            [SiteId], [SiteName], [ActiveThreats], [DetectionState], [Domain], [GroupName],
            [Infected], [InstallerType], [IsActive], [IsDecommissioned], [IsPendingUninstall],
            [IsUninstalled], [IsUpToDate], [LastActiveDate], [ModelName], [ThreatRebootRequired],
            [Days_Since_Boot], [EncryptedApplications], [FirewallEnabled], [LastLoggedInUserName],
            [MachineType], [Entity_Name], [Entity_Code], [UserActionsNeeded], [IsLMMS], [Agent_Status],
            [IsException], [ActiveComputer], [Record_Entry_Time]
        )
        SELECT
            LEFT(ADC.[ComputerName], 30),
            ADC.[ComputerDistinguishedName],
            CAST(ADC.[CreatedAt] AS DATE),
            CAST(ADC.[UpdatedAt] AS DATE),
            CASE
                WHEN ADCD.[LastLogonTimestamp] IS NOT NULL
                THEN CAST((CONVERT(BIGINT, ADCD.[LastLogonTimestamp]) / 864000000000.0 - 109207) AS DATETIME)
                ELSE NULL
            END AS LastLogon,
            1,
            ADC.[AgentVersion], ADC.[OsArch], ADC.[OsName], ADC.[OsRevision], ADC.[OsStartTime], ADC.[OsType],
            ADC.[SiteId], ADC.[SiteName], ADC.[ActiveThreats], ADC.[DetectionState], ADC.[Domain], ADC.[GroupName],
            ADC.[Infected], ADC.[InstallerType], ADC.[IsActive], ADC.[IsDecommissioned], ADC.[IsPendingUninstall],
            ADC.[IsUninstalled], ADC.[IsUpToDate], ADC.[LastActiveDate], ADC.[ModelName], ADC.[ThreatRebootRequired],
            DATEDIFF(DAY, ADC.[OsStartTime], CAST(GETDATE() AS DATE)),
            ADC.[EncryptedApplications], ADC.[FirewallEnabled], ADC.[LastLoggedInUserName], ADC.[MachineType],
            ADCD.[Entity_Name], ADCD.[Entity_Code], ADC.[UserActionsNeeded],
            CASE WHEN ADC.[ComputerDistinguishedName] LIKE '%OU=LMMS%' THEN 1 ELSE 0 END,
            CASE WHEN ADC.[UserActionsNeeded] IS NULL THEN 'Agent no issues' ELSE 'Agent with issues' END,
            0,
            ADCD.[Active],
            GETDATE()
        FROM [E001_Global_Lakehouse].[dbo].[SentinelOne_API_Agents] ADC
        LEFT JOIN [E001_Global_Lakehouse].[dbo].[Active_Directory_Computer_Data] ADCD
            ON LOWER(LTRIM(RTRIM(LEFT(ADC.[ComputerName], 30)))) = LOWER(LTRIM(RTRIM(ADCD.[Cn])))
 
        -- Insert computers without agents
        INSERT INTO [SentinelOne_API_Output_Computer_Agents] (
            [ComputerName], [ComputerDistinguishedName], [CreatedAt], [UpdatedAt], [LastLogon],
            [HasAgent], [OsName], [OsRevision], [Entity_Name], [Entity_Code], [IsLMMS], [Agent_Status],
            [IsException], [ActiveComputer], [Record_Entry_Time]
        )
        SELECT
            ADC.[Cn],
            ADC.[DistinguishedName],
            CAST(ADC.[WhenCreated] AS DATE),
            CAST(ADC.[WhenChanged] AS DATE),
            CASE
                WHEN ADC.[LastLogonTimestamp] IS NOT NULL
                THEN CAST((CONVERT(BIGINT, ADC.[LastLogonTimestamp]) / 864000000000.0 - 109207) AS DATETIME)
                ELSE NULL
            END,
            0,
            ADC.[OperatingSystem],
            ADC.[OperatingSystemVersion],
            ADC.[Entity_Name],
            ADC.[Entity_Code],
            CASE WHEN ADC.[DistinguishedName] LIKE '%OU=LMMS%' THEN 1 ELSE 0 END,
            'No Agent',
            CASE WHEN SAE.[Title] IS NULL THEN 0 ELSE 1 END,
            ADC.[Active],
            GETDATE()
        FROM [E001_Global_Lakehouse].[dbo].[Active_Directory_Computer_Data] ADC
        LEFT JOIN [E001_Global_Lakehouse].[dbo].[SentinelOne_Sharepoint_Agent_Exceptions] SAE
            ON RTRIM(LTRIM(LOWER(SAE.[Title]))) = RTRIM(LTRIM(LOWER(ADC.[Cn])))
        LEFT JOIN [E001_Global_Lakehouse].[dbo].[SentinelOne_API_Agents] S1AG
            ON RTRIM(LTRIM(LOWER(LEFT(S1AG.ComputerName, 30)))) = RTRIM(LTRIM(LOWER(ADC.[Cn])))
        WHERE S1AG.ComputerName IS NULL;
 
        COMMIT TRAN;
    END TRY
   BEGIN CATCH
    DECLARE @ErrorMessage VARCHAR(4000) = ERROR_MESSAGE();
    DECLARE @ErrorTime DATETIME = GETDATE();
    DECLARE @RecordEntryTime DATETIME = GETDATE();
    DECLARE @ErrorContext VARCHAR(100) = 'Step 1: Output Computer Agents';
 
    INSERT INTO dbo.ErrorLog (ErrorLogId, ErrorMessage, ErrorTime, ErrorContext, Record_Entry_Time)
    VALUES (NEWID(), @ErrorMessage, @ErrorTime, @ErrorContext, @RecordEntryTime);
 
    IF @@TRANCOUNT > 0 ROLLBACK TRAN;
    RAISERROR(@ErrorMessage, 16, 1);
   END CATCH
 
 
    --=====================================
    -- Step 2: Prepare Output Vulnerability
    --=====================================
    BEGIN TRY
        BEGIN TRAN;
 
        TRUNCATE TABLE [E001_Global_Warehouse].[dbo].[SentinelOne_API_Output_Vulnerability];
 
        INSERT INTO [E001_Global_Warehouse].[dbo].[SentinelOne_API_Output_Vulnerability] (
            [Application_Id], [Application_Name], [Vendor], [Cve_Count], [Id], [Site_Name], [Entity_Code],
            [Site_Type], [Account_Id], [Account_Name], [CreatedAt], [UpdateAt], [Highest_Severity],
            [HighestNvdBaseScore], [Estimate], [Endpoint_Count], [Detection_Date],
            [Facility_Name], [Group_Name], [Days_Detected], [Record_Entry_Time]
        )
        SELECT
            [ApplicationId], [Applicationame], [Vendor], [CveCount], [Id], [Site_Name],
            [Description] AS [Entity_Code], [SiteType], [AccountId], [AccountName],
            PARSE([CreatedAt] AS datetime2), PARSE([UpdatedAt] AS datetime2),
            [HighestSeverity], [HighestNvdBaseScore], [Estimate], [EndpointCount],
            PARSE([DetectionDate] AS datetime2),
            CASE
                WHEN CHARINDEX('-', [Site_Name]) > 0 AND CHARINDEX('Skyjack', [Site_Name]) = 0
                    THEN RIGHT([Site_Name], LEN([Site_Name]) - CHARINDEX('-', [Site_Name]))
                ELSE [Site_Name]
            END AS [FacilityName],
            CASE
                WHEN CHARINDEX('-', [Site_Name]) > 0
                    THEN LEFT([Site_Name], CHARINDEX('-', [Site_Name]) - 1)
                ELSE [Site_Name]
            END AS [GroupName],
            [DaysDetected],
            GETDATE()
        FROM [E001_Global_Lakehouse].[dbo].[SentinelOne_API_Vulnerabilities];
 
        COMMIT TRAN;
    END TRY
BEGIN CATCH
    DECLARE @ErrorMessage2 VARCHAR(4000) = ERROR_MESSAGE();
    DECLARE @ErrorTime2 DATETIME = GETDATE();
    DECLARE @RecordEntryTime2 DATETIME = GETDATE();
    DECLARE @ErrorContext2 VARCHAR(100) = 'Step 2: Output Vulnerability';
 
    INSERT INTO dbo.ErrorLog (ErrorLogId, ErrorMessage, ErrorTime, ErrorContext, Record_Entry_Time)
    VALUES (NEWID(), @ErrorMessage2, @ErrorTime2, @ErrorContext2, @RecordEntryTime2);
 
    IF @@TRANCOUNT > 0 ROLLBACK TRAN;
    RAISERROR(@ErrorMessage2, 16, 1);
END CATCH
END
```
