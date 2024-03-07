# Review Plex Views

## references

```sql
-- container_cur_prev_loc_review_plex_views2
--container_cur_prev_loc_review_plex_views.sql
-- fruitport 295932
-- albion 300758
--select top 10 * from part_v_container_change2
;with container_change2
as
(
--SELECT top 10 
  select
  cc2.change_key,
  cc2.Plexus_Customer_No pcn,
  CC2.Serial_No,
  cc2.part_key,
  cc2.part_operation_key,
  cc2.change_date,
--  CC2.Change_Date AS [Change Date/Time],
--  CC2.Quantity AS Quantity,
  CC2.Location,
  CC2.Last_Action
--  CC2.Gross_Weight,
--  CC2.Change_Key
FROM part_v_Container_Change2_e AS CC2
--FROM part_v_Container_Change2_e AS CC2 WITH (INDEX = IX_History2)
WHERE CC2.Plexus_Customer_No = @PCN
aND CC2.Change_Date >= @From_Date
aND CC2.Change_Date < @To_Date
and cc2.serial_no = 'FD4353548'
--  AND (@Location = '' OR CC2.Location LIKE @Location + '%')
--  AND (@Last_Action = '' OR CC2.Last_Action LIKE @Last_Action + '%')
  
),
--@PCN int = 295932,
--@from_Date datetime = '20240306',
--@to_Date datetime = '20240307',
--select count(*) cnt from container_change2 cc2k -- 13,884
--select top 10 * from container_change2 cc2k
part
as
(
  select
  cc2k.change_key
  ,cc2k.change_date
  ,cc2k.pcn
  ,CC2k.Serial_No
--    ,cc2k.part_key
  ,cc2k.part_operation_key
  ,cc2k.location
  ,CC2k.Last_Action
  

--  p.plexus_customer_no pcn
--  ,p.part_key
  ,p.part_no
  ,p.revision
  
  from container_change2 cc2k
  join part_v_part_e AS P
  on cc2k.pcn=p.plexus_customer_no
  and cc2k.part_key=p.part_key

),
-- select count(*) cnt from part -- 13,884
--select top 10 * from part
part_operation
as
( 
  select
  p.change_key
  ,p.change_date
  ,p.pcn
  ,p.Serial_No
  ,p.part_no
  ,p.revision
  ,p.location
  ,p.Last_Action

--  ,p.part_operation_key
  ,po.operation_no
  ,po.operation_key

--  p.plexus_customer_no pcn
--  ,p.part_key
  from part p
--  ,po.part_operation_no
  join part_v_part_operation_e AS po
  on p.pcn=po.plexus_customer_no
  and p.part_operation_key=po.part_operation_key

),
-- select count(*) cnt from part_operation -- 13,884
-- select top 10 * from part_operation
operation
as
(
  select
  po.change_key
  ,po.change_date
  ,po.pcn
  ,po.Serial_No
  ,po.part_no
  ,po.revision
  ,po.location
  ,po.last_action
--  ,p.part_operation_key
  ,po.operation_no
  ,o.operation_code
  from part_operation po
  join part_v_operation_e AS o
  on po.pcn=o.plexus_customer_no 
  and po.operation_key=o.operation_key

)
--select count(*) cnt from operation -- 13,884
 select top 1000 * from operation
 order by change_key desc
--SELECT top 10 
--  cc2k.pcn,
--  cc2k.Change_Date,
--  cc2k.Serial_No
--  U.Last_Name + ', ' + U.First_Name AS Change_By,
--  P.Part_No,
--  P.Revision,
--  PO.Operation_No AS [Op No],
--  O.Operation_Code AS Operation,
--  CC2.Quantity AS Quantity,
--  CC2.Location,
--  CC2.Last_Action,
----  CC2.Gross_Weight,
--  CC2.Change_Key
--FROM container_change2 AS cc2k 
----join part_v_Container_Change2_e AS cc2
----on cc2k.change_key=cc2.change_key
----and cc2k.pcn=cc2.plexus_customer_no
----and cc2k.serial_no=cc2.serial_no
--JOIN part AS P -- added lots of time
--  ON cc2k.pcn = p.pcn
--  AND cc2k.Part_Key = p.Part_Key
--JOIN part_operation po
--  ON cc2k.pcn = po.pcn
--  AND cc2k.Part_Key = po.Part_Key
--  AND cc2k.Part_Operation_Key = po.Part_Operation_Key
--JOIN operation AS O
--  ON po.pcn = o.pcn
--  AND po.operation_Key = o.Operation_Key

--JOIN part_v_Operation_e AS O
--  ON O.Plexus_Customer_No = PO.Plexus_Customer_No
--  AND O.Operation_Key = PO.Operation_Key
--LEFT OUTER JOIN Plexus_Control_v_Plexus_User AS U
--  ON U.Plexus_User_No = CC2.Update_By
--ORDER BY 
--  CC2.Location, 
--  CC2.Serial_No, 
--  CC2.Change_Date
--

--SELECT top 10 
--  cc2.Plexus_Customer_No pcn,
--  CC2.Change_Date AS [Change Date/Time],
--  CC2.Serial_No,
--  U.Last_Name + ', ' + U.First_Name AS Change_By,
--  P.Part_No AS Part_No,
--  P.Revision AS Revision,
--  PO.Operation_No AS [Op No],
--  O.Operation_Code AS Operation,
--  CC2.Quantity AS Quantity,
--  CC2.Location,
--  CC2.Last_Action,
--  CC2.Gross_Weight,
--  CC2.Change_Key
--FROM part_v_Container_Change2_e AS CC2 WITH (INDEX = IX_History2)
--  JOIN part_v_part_e AS P
--  ON P.Plexus_Customer_No = CC2.Plexus_Customer_No
--    AND P.Part_Key = CC2.Part_Key
--  JOIN part_v_Part_Operation_e AS PO
--  ON PO.Plexus_Customer_No = CC2.Plexus_Customer_No
--    AND PO.Part_Key = CC2.Part_Key
--    AND PO.Part_Operation_Key = CC2.Part_Operation_Key
--  JOIN part_v_Operation_e AS O
--  ON O.Plexus_Customer_No = PO.Plexus_Customer_No
--    AND O.Operation_Key = PO.Operation_Key
--  LEFT OUTER JOIN Plexus_Control_v_Plexus_User AS U
--  ON U.Plexus_User_No = CC2.Update_By
--WHERE CC2.Plexus_Customer_No = @PCN
--  AND CC2.Change_Date >= @From_Date
--  AND CC2.Change_Date < @To_Date
--  AND (@Location = '' OR CC2.Location LIKE @Location + '%')
--  AND (@Last_Action = '' OR CC2.Last_Action LIKE @Last_Action + '%')
--ORDER BY 
--  CC2.Location, 
--  CC2.Serial_No, 
--  CC2.Change_Date
```

| change_key | change_date          | pcn    | Serial_No | part_no | revision | location     | last_action                             | operation_no | operation_code |
| ---------- | -------------------- | ------ | --------- | ------- | -------- | ------------ | --------------------------------------- | ------------ | -------------- |
| 5302202473 | 3/7/2024 2:38:15 AM  | 295932 | FD4353548 | 5169    |          | X RAY SHARED | Retired at X RAY 6                      | 105          | Gate Removal   |
| 5302202472 | 3/7/2024 2:38:15 AM  | 295932 | FD4353548 | 5169    |          | X RAY SHARED | Depleted at X RAY 6                     | 105          | Gate Removal   |
| 5302039457 | 3/7/2024 1:14:39 AM  | 295932 | FD4353548 | 5169    |          | X RAY SHARED | Container Full                          | 105          | Gate Removal   |
| 5301948535 | 3/7/2024 12:43:04 AM | 295932 | FD4353548 | 5169    |          | CASTER 01A   | Production Update                       | 105          | Gate Removal   |
| 5301948533 | 3/7/2024 12:43:04 AM | 295932 | FD4353548 | 5169    |          | CASTER 01A   | Production Recorded at Control Panel V3 | 105          | Gate Removal   |
| 5301853456 | 3/6/2024 11:59:20 PM | 295932 | FD4353548 | 5169    |          | CASTER 01A   | Production Update                       | 105          | Gate Removal   |
| 5301853451 | 3/6/2024 11:59:20 PM | 295932 | FD4353548 | 5169    |          | CASTER 01A   | Production Recorded at Control Panel V3 | 105          | Gate Removal   |
| 5301853210 | 3/6/2024 11:59:09 PM | 295932 | FD4353548 | 5169    |          | CASTER 01A   | Created at Control Panel                | 105          | Gate Removal   |
