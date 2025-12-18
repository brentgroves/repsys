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
MR.Revision_By, -- NOT MARKED AS A FORIEGN KEY SO USER CAN BE DELETED. SCHEMA SHOULD NOT ALLOW DELETION OF USER IF IN MODULE_REVISION.
MR.Original_Text,
MR.Revision_Text
--CAST(MR.Original_Text AS VARCHAR(5)) AS Original_Text
--SUBSTRING(MR.Original_Text, 1, 5) AS TruncatedText
--STUFF(MR.Original_Text, 101, LEN(YourTextColumn) - 100, '') AS TruncatedText
FROM Plexus_Control_v_Module_Revision_e AS MR
where MR.PCN = @PCN -- 2801630
and MR.Revision_Date between @Start_Revision_Date and @End_Revision_Date
)
--select count(*) cnt from module_revision MR -- 290008
,module
as
(
select 
M.module_key, --PK
M.name
FROM Plexus_Control_v_Module AS M -- 1150
)
--select count(*) cnt from module M -- 1150
,plexus_user
as
(
select
PU.Plexus_Customer_No,
PU.plexus_user_no -- PK
from Plexus_Control_v_Plexus_User_e AS PU
where PU.Plexus_Customer_No = @PCN
)
--select count(*) cnt from plexus_user PU -- 1837
,customer_group_member
as
(
select
--cgm.Customer_Group_No, -- PK
CGM.Plexus_Customer_No, -- PK
CGM.Plexus_Customer_Code 
from Plexus_Control_v_Customer_Group_Member AS CGM
)
--select count(*) cnt from customer_group_member CGM
,application
as
(
select
app.application_key,
--app.module_key, -- ONLY 1 MODULE_KEY PER APPLICATION_KEY, 5155 NULL MODULE KEYS
app.Path_Filename
from Plexus_Control_v_Application as app -- view not in classic view list
)
--select count(*) cnt from application app
select
--count(*) cnt
CGM.Plexus_Customer_Code,
M.Name AS Module_Name,
app.Path_Filename,
MR.Revision_Date,
MR.Identity_Key,  
left(PU.Last_Name,10) as last_name, 
left(PU.First_Name,1) as first_initial,
MR.Original_Text, -- text column added much delay to query
MR.Revision_Text

from module_revision MR -- 290008
join customer_group_member AS CGM
on MR.PCN = cgm.Plexus_Customer_No -- 290008
join module AS M
ON MR.Module_Key = M.Module_Key
--join application as app -- 288523 OOPS missing app.Application_keys; NO foriegn key constraint setup.
left outer join application as app -- 290008
ON MR.Application_Key = app.Application_Key
--join plexus_user AS PU -- 234650 OOPS missing plexus users; NO foriegn key constraint setup.
left outer join Plexus_Control_v_Plexus_User_e AS PU
ON MR.PCN = PU.Plexus_Customer_No
AND MR.Revision_By = PU.Plexus_User_No