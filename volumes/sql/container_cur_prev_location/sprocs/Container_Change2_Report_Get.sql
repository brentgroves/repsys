--container_cur_prev_loc_review_plex_views.sql
-- fruitport 295932
-- albion 300758
--select top 10 * from part_v_container_change2

SELECT top 10 
  cc2.Plexus_Customer_No pcn,
  CC2.Change_Date AS [Change Date/Time],
  CC2.Serial_No,
  U.Last_Name + ', ' + U.First_Name AS Change_By,
  P.Part_No AS Part_No,
  P.Revision AS Revision,
  PO.Operation_No AS [Op No],
  O.Operation_Code AS Operation,
  CC2.Quantity AS Quantity,
  CC2.Location,
  CC2.Last_Action,
  CC2.Gross_Weight,
  CC2.Change_Key
FROM part_v_Container_Change2_e AS CC2 WITH (INDEX = IX_History2)
  JOIN part_v_part_e AS P
  ON P.Plexus_Customer_No = CC2.Plexus_Customer_No
    AND P.Part_Key = CC2.Part_Key
  JOIN part_v_Part_Operation_e AS PO
  ON PO.Plexus_Customer_No = CC2.Plexus_Customer_No
    AND PO.Part_Key = CC2.Part_Key
    AND PO.Part_Operation_Key = CC2.Part_Operation_Key
  JOIN part_v_Operation_e AS O
  ON O.Plexus_Customer_No = PO.Plexus_Customer_No
    AND O.Operation_Key = PO.Operation_Key
  LEFT OUTER JOIN Plexus_Control_v_Plexus_User AS U
  ON U.Plexus_User_No = CC2.Update_By
WHERE CC2.Plexus_Customer_No = @PCN
  AND CC2.Change_Date >= @From_Date
  AND CC2.Change_Date < @To_Date
  AND (@Location = '' OR CC2.Location LIKE @Location + '%')
  AND (@Last_Action = '' OR CC2.Last_Action LIKE @Last_Action + '%')
ORDER BY 
  CC2.Location, 
  CC2.Serial_No, 
  CC2.Change_Date
  
CREATE PROCEDURE [dbo].[Container_Change2_Report_Get]
  (
  @PCN INT,
  @From_Date DATETIME,
  @To_Date DATETIME,
  @Location VARCHAR(50) = '',
  @Last_Action VARCHAR(50) = ''
)
AS
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

-- Created: JDAN 10/12/2005
-- Purpose: Return records for the history of a container.
-- Used By: Part/Reports/Container_History_Report.asp
--
-- 06/27/2006 TMCG: Added return column Change_Key, Gross_Weight
-- 04/08/2013 jsearles: added index hint, standards

-- 01/19/16 mahay 2408065: swapped index hint from IX_History1 to IX_History2.
-- 02/17/17 cjersey DR-88: Added recompile option to address issues with the optimize for unknown trace flag.

SELECT
  CC2.Change_Date AS [Change Date/Time],
  CC2.Serial_No,
  U.Last_Name + ', ' + U.First_Name AS Change_By,
  P.Part_No AS Part_No,
  P.Revision AS Revision,
  PO.Operation_No AS [Op No],
  O.Operation_Code AS Operation,
  CC2.Quantity AS Quantity,
  CC2.Location,--container_cur_prev_loc_review_plex_views.sql
-- fruitport 295932
-- albion 300758
--select top 10 * from part_v_container_change2
  cc2.Plexus_Customer_No pcn,
  CC2.Change_Date AS [Change Date/Time],
  CC2.Serial_No,
  U.Last_Name + ', ' + U.First_Name AS Change_By,
  P.Part_No AS Part_No,
  P.Revision AS Revision,
  PO.Operation_No AS [Op No],
  O.Operation_Code AS Operation,
  CC2.Quantity AS Quantity,
  CC2.Location,
  CC2.Last_Action,
  CC2.Gross_Weight,
  CC2.Change_Key
FROM part_v_Container_Change2_e AS CC2 WITH (INDEX = IX_History2)
  JOIN part_v_part_e AS P
  ON P.Plexus_Customer_No = CC2.Plexus_Customer_No
    AND P.Part_Key = CC2.Part_Key
  JOIN part_v_Part_Operation_e AS PO
  ON PO.Plexus_Customer_No = CC2.Plexus_Customer_No
    AND PO.Part_Key = CC2.Part_Key
    AND PO.Part_Operation_Key = CC2.Part_Operation_Key
  JOIN part_v_Operation_e AS O
  ON O.Plexus_Customer_No = PO.Plexus_Customer_No
    AND O.Operation_Key = PO.Operation_Key
  LEFT OUTER JOIN Plexus_Control_v_Plexus_User AS U
  ON U.Plexus_User_No = CC2.Update_By
WHERE CC2.Plexus_Customer_No = @PCN
  AND CC2.Change_Date >= @From_Date
  AND CC2.Change_Date < @To_Date
  AND (@Location = '' OR CC2.Location LIKE @Location + '%')
  AND (@Last_Action = '' OR CC2.Last_Action LIKE @Last_Action + '%')
ORDER BY 
  CC2.Location, 
  CC2.Serial_No, 
  CC2.Change_Datenge2 AS CC2 WITH (INDEX = IX_History2)
  JOIN dbo.Part AS P
  ON P.Plexus_Customer_No = CC2.Plexus_Customer_No
    AND P.Part_Key = CC2.Part_Key
  JOIN dbo.Part_Operation AS PO
  ON PO.Plexus_Customer_No = CC2.Plexus_Customer_No
    AND PO.Part_Key = CC2.Part_Key
    AND PO.Part_Operation_Key = CC2.Part_Operation_Key
  JOIN dbo.Operation AS O
  ON O.Plexus_Customer_No = PO.Plexus_Customer_No
    AND O.Operation_Key = PO.Operation_Key
  LEFT OUTER JOIN Plexus_Control.dbo.Plexus_User AS U
  ON U.Plexus_User_No = CC2.Update_By
WHERE CC2.Plexus_Customer_No = @PCN
  AND CC2.Change_Date >= @From_Date
  AND CC2.Change_Date < @To_Date
  AND (@Location = '' OR CC2.Location LIKE @Location + '%')
  AND (@Last_Action = '' OR CC2.Last_Action LIKE @Last_Action + '%')
ORDER BY 
  CC2.Location, 
  CC2.Serial_No, 
  CC2.Change_Date
OPTION
(RECOMPILE,
MAXDOP
4);

RETURN