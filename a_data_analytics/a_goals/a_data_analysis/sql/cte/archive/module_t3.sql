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
M.module_key,
M.name
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
M.module_key
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
select count(*) cnt from key_set