;with null_keys
as
(
select
count(*) cnt
--app.application_key,
--app.module_key, -- AN APPLICATION KEY MAY BE FOR MULTIPLE MODULES
--app.Path_Filename
from Plexus_Control_v_Application as app -- view not in classic view list
where app.module_key is NULL
)
--select cnt from null_keys nk -- 5155
,multi_modules
as
(
select
app.application_key,
count(*) cnt
--app.module_key, -- AN APPLICATION KEY MAY BE FOR MULTIPLE MODULES
--app.Path_Filename
from Plexus_Control_v_Application as app -- view not in classic view list
group by app.application_key
having count(*) > 1
)
--select mm.application_key,cnt from multi_modules mm
select count(*) cnt from multi_modules mm