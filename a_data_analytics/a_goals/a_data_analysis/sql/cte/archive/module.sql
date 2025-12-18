/*
--https://en.wikipedia.org/wiki/Mean_time_between_failures
--https://en.wikipedia.org/wiki/Mean_time_between_failures
	PCN
	310507/Avilla
	300758/Albion
	295933/Franklin
	300757/Alabama
	306766/Edon
	312055/ BPG WorkHolding
	1	123681 / Southfield
2	295932 FruitPort
3	295933
4	300757
5	300758
6	306766
7	310507
8	312055

--Plexus_Control_v_Module AS M -- 1150
PK_Module	Module_Key
IX_Module_Key_Name	Module_Key
Name
Internal_Only
IX_Champion	Champion
IX_FK_Module_Module_Multilingual	Module_Multilingual_Key

- Plexus_Control_v_Module_Revision_e
PK_Module_Revision	PCN
Application_Key
Identity_Key
Revision_Key

Customer_Group_Member
PK_Customer_Group_Member	Customer_Group_No
Plexus_Customer_No
Plexus_Customer_No	Plexus_Customer_No
Customer_Group_No
IX_Unique_Customer_Group_Member	Plexus_Customer_No
;with module_revision
as
(
select
MR.PCN, -- PK
MR.Application_Key, -- PK
MR.Identity_Key, -- PK
MR.revision_Key, -- PK
MR.Module_Key, -- FK
MR.Revision_Date, -- IX
MR.Revision_By,
MR.Original_Text,
MR.Revision_Text
--CAST(MR.Original_Text AS VARCHAR(5)) AS Original_Text
--SUBSTRING(MR.Original_Text, 1, 5) AS TruncatedText
--STUFF(MR.Original_Text, 101, LEN(YourTextColumn) - 100, '') AS TruncatedText
FROM Plexus_Control_v_Module_Revision_e AS MR
where MR.PCN = @PCN -- 2801630
and MR.Revision_Date between 
)
select count(*) cnt from module_revision MR -- 2801724
@End_Ship_Date datetime = '20200228',
@PCNList varchar(max) = '123681,300758'
@Plexus_Customer_No INT = 123681,
@Account_No VARCHAR(20) = '',  
@Account_Name VARCHAR(50) = '',
@Sort_By VARCHAR(15) = '' ,
@Purchasing SMALLINT = -1,
@Sub_Category_No INT=0,
@Work_Log SMALLINT = -1,
@Format_Type_No INT = 0, 
@Active TINYINT = 2,
@Limit INT = 0
*/


-- Created: 11/21/11 JHAP
-- Purpose: Find all revision records by user/date
-- Used In: VP Report

-- 07/25/18 swoodruff: Removed the adjustment on @Revision_Date2 when comparing with MR.Revision_Date
--,module
--as
--(
--select 
--M.module_key,
--M.name
--FROM Plexus_Control_v_Module AS M -- 1150
--)
--select count(*) cnt from module -- 1150
--,plexus_user
--as
--(
--select 
--pu.plexus_user_no
--from Plexus_Control_v_Plexus_User_e AS PU
--)
--select count(*) cnt from plexus_user -- 14414
--  ON PU.Plexus_User_No = MR.Revision_By
--  AND MR.PCN = PU.Plexus_Customer_No

--JOIN Plexus_Control_v_Module AS M
SELECT
--  MR.PCN,
  cgm.Plexus_Customer_Code,
  M.Name AS Module_Name,
  app.Path_Filename,
  MR.Revision_Date,  
--  A.Path_Filename,
  MR.Identity_Key,  
--  PU.[User_ID] AS Revision_User_ID,
  PU.Last_Name,
  PU.First_Name,
--  MR.Revision_By,
  MR.Original_Text,
  MR.Revision_Text
FROM Plexus_Control_v_Module_Revision_e AS MR -- 15,473,273, pk module_key
JOIN Plexus_Control_v_Module AS M --15,473,273
  ON M.Module_Key = MR.Module_Key
--JOIN Plexus_Control_v_[Application] AS A
--  ON A.Application_Key = MR.Application_Key
JOIN Plexus_Control_v_Plexus_User_e AS PU
  ON PU.Plexus_User_No = MR.Revision_By
  AND MR.PCN = PU.Plexus_Customer_No

JOIN Plexus_Control_v_Customer_Group_Member as cgm
  ON PU.Plexus_Customer_No = cgm.Plexus_Customer_No

JOIN Plexus_Control_v_Application as app
  ON MR.Application_Key = app.Application_Key
WHERE MR.Revision_Date >= '2025-07-01'
  AND MR.Revision_Date < '2025-08-01'
--  AND MR.Module_Key = ISNULL(@Module_Key, MR.Module_Key)
  AND MR.PCN = '123681'
ORDER BY
  M.Name,
  MR.Revision_Date
--  A.Path_Filename

RETURN
