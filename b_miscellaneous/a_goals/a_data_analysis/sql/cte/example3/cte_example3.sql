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
