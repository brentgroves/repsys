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

*/

;with module_revision
as
(
select
MR.PCN,
MR.Application_Key,
MR.Identity_Key,  
MR.revision_Key,
MR.Module_Key,
MR.Revision_By
FROM Plexus_Control_v_Module_Revision_e AS MR -- 15473273
where MR.PCN = '123681'
)
--select count(*) cnt from module_revision MR -- 2800574
,module
as
(
select 
M.module_key
--M.name
FROM Plexus_Control_v_Module AS M -- 1150
)
--select count(*) cnt from module M -- 1150
,plexus_user
as
(
select
PU.Plexus_Customer_No,
PU.plexus_user_no
from Plexus_Control_v_Plexus_User_e AS PU
)
-- select count(*) cnt from plexus_user PU -- 14414
,customer_group_member
as
(
select
CGM.Plexus_Customer_No,
CGM.Plexus_Customer_Code
from Plexus_Control_v_Customer_Group_Member AS CGM
)
--select count(*) cnt from customer_group_member CGM
,application
as
(
select
app.application_key,
app.Path_Filename
from Plexus_Control_v_Application as app
)
--select count(*) cnt from application app
,key_set
as
(
select 
--count(*) cnt
MR.PCN,
MR.Application_Key,
MR.Identity_Key,  
MR.revision_Key,
MR.Module_Key,
MR.Revision_By
FROM module_revision AS MR -- 2800574
JOIN module AS M 
ON M.Module_Key = MR.Module_Key -- 2800574
JOIN Customer_Group_Member as cgm
ON MR.PCN = cgm.Plexus_Customer_No -- 2800574
left outer JOIN application as app
ON MR.Application_Key = app.Application_Key -- 2789328 oops lost some;
--where app.Application_key is NULL -- 11246 : 2789328 + 11246 = 280574
left outer JOIN Plexus_User AS PU
ON PU.Plexus_User_No = MR.Revision_By
AND MR.PCN = PU.Plexus_Customer_No -- 2197716 OOPs Lost some, no longer in system 
--where PU.Plexus_User_No is NULL -- 602858 : 2197716 + 602858 = 2800574
)
-- select count(*) cnt from key_set ks
select
--count(*) cnt
ks.PCN,
cgm.Plexus_Customer_Code,
M.Name AS Module_Name,
app.Path_Filename,
MR.Revision_Date,
ks.Identity_Key,  
--  PU.[User_ID] AS Revision_User_ID,
left(PU.Last_Name,10) as last_name, 
left(PU.First_Name,1) as first_initial
----  MR.Revision_By,
--CAST(MR.Original_Text AS VARCHAR(5)) AS Original_Text
--SUBSTRING(MR.Original_Text, 1, 5) AS TruncatedText
--STUFF(MR.Original_Text, 101, LEN(YourTextColumn) - 100, '') AS TruncatedText
--left(MR.Original_Text,1)

from key_set ks -- 2800574
join Plexus_Control_v_Customer_Group_Member AS CGM
on ks.PCN = cgm.Plexus_Customer_No
join Plexus_Control_v_Module AS M
ON ks.Module_Key = M.Module_Key 
left outer join Plexus_Control_v_Application as app
ON ks.Application_Key = app.Application_Key
join Plexus_Control_v_Module_Revision_e AS MR
ON ks.PCN=MR.PCN
and ks.application_key=MR.Application_Key
and ks.identity_key=MR.Identity_Key  
and ks.revision_key=MR.revision_Key
and ks.Module_Key = MR.Module_Key
left outer join Plexus_Control_v_Plexus_User_e AS PU
ON ks.PCN = PU.Plexus_Customer_No
AND ks.Revision_By = PU.Plexus_User_No

--where ks.PCN = '123681'