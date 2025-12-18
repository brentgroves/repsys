# SQL CTE Example

Hi Team,

I would like to share SQL CTEs insights.

- Thank you

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>>.

**Goal:** I wanted to prove that CTEs improve query performance but could not.  If you have a SPROC that shows a performance gain using CTEs please share it with the team.

**Query Optimization:** SQL engines can optimize queries that use CTEs more efficiently, improving performance, especially when the **same result set needs to be accessed multiple times**.

**Findings:** If you filter columns and records in CTEs prior to the final select statement no noticable change in run time is noticed.  If you run queries several times a huge performance increase occurs.

## **[CTE in SQL - good intro](https://www.geeksforgeeks.org/sql/cte-in-sql/)**

## Plex ERP select statement

Noticed that Module_Revision has no **[FORIEGN KEY constraint](https://www.w3schools.com/sql/sql_foreignkey.asp)** on Revision_By preventing plexus_user records from being deleted.

```sql
select
--count(*) cnt,
CGM.Plexus_Customer_Code,
M.Name AS Module_Name,
app.Path_Filename,
MR.Revision_Date, 
MR.Identity_Key,
PU.Last_Name, 
PU.First_Name,
MR.Original_Text, -- text column added much delay to query
MR.Revision_Text
FROM Plexus_Control_v_Module_Revision_e AS MR
join Plexus_Control_v_Module AS M
ON MR.Module_Key = M.Module_Key
join Plexus_Control_v_Customer_Group_Member AS CGM
on MR.PCN = cgm.Plexus_Customer_No -- 290008
left outer join Plexus_Control_v_Application as app 
ON MR.Application_Key = app.Application_Key
left outer join Plexus_Control_v_Plexus_User_e AS PU
ON MR.PCN = PU.Plexus_Customer_No
AND MR.Revision_By = PU.Plexus_User_No
where MR.PCN = @PCN -- 2801630
and MR.Revision_Date between @Start_Revision_Date and @End_Revision_Date
```

## Plex ERP select statement using CTE

```sql
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
PU.plexus_user_no, -- PK
PU.Last_Name, 
PU.First_Name
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
app.Path_Filename
from Plexus_Control_v_Application as app 
)
--select count(*) cnt from application app
select
--count(*) cnt
CGM.Plexus_Customer_Code,
M.Name AS Module_Name,
app.Path_Filename,
MR.Revision_Date,
MR.Identity_Key,
PU.Last_Name, 
PU.First_Name,
MR.Original_Text, -- text column added much delay to query
MR.Revision_Text
from module_revision MR -- 290008
join module AS M
ON MR.Module_Key = M.Module_Key
join customer_group_member AS CGM
on MR.PCN = cgm.Plexus_Customer_No -- 290008
--join application as app -- 288523 OOPS missing app.Application_keys; NO foriegn key constraint setup.
left outer join application as app -- 290008
ON MR.Application_Key = app.Application_Key
--join plexus_user AS PU -- 234650 OOPS missing plexus users; NO foriegn key constraint setup.
left outer join plexus_user AS PU
ON MR.PCN = PU.Plexus_Customer_No
AND MR.Revision_By = PU.Plexus_User_No
```

## SQL Team

- Sadiq Basha Sr. Data Engineer, Data & Analytics
- Tarek Mohamed, Data and Analytics IT, Supervisor
- Cody Hudson, Fabric Administrator
- Kevin Young, Information Systems Manager
- Sam Jackson, Information Systems Developer, Southfield
- Brad D. Cook, Quality Engineer, Fruitport
- Jared Eikenberry, Quality Engineer, Fruitport
