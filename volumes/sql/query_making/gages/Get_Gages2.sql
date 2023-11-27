CREATE PROCEDURE [dbo].[Gages_Get2] (
  @Plexus_Customer_No INT, 
  @Gage_ID VARCHAR(25) = '', 
  @Gage_Brand VARCHAR(50) = '', 
  @Gage_Type VARCHAR(50) = '', 
  @Gage_Status VARCHAR(1000) = '', 
  @Location VARCHAR(50) = '', 
  @Calibration_Responsible_PUN INT = 0, 
  @Active BIT = 1, 
  @Range INT = 0, 
  @Days VARCHAR(20) = '', 
  @Sort_Order VARCHAR(20) = '', 
  @Text_Search VARCHAR(500) = '', 
  @Department_No INT = -1, 
  @Owner INT = -1, 
  @User INT = -1, 
  @Part_Key INT = -1, 
  @Calibration_Group INT = -1, 
  @Customer_No INT = 0, 
  @Building_Key INT = -1, 
  @Gage_Drawing_No VARCHAR(100) = '', 
  @Parent_Gage_No INT = NULL
) AS 
SET 
  NOCOUNT ON;
SET 
  TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-- Created: 03/15/05 txio 
-- Purpose: For displaying the grid on the gage list page 
-- Used In: Gage_Control/Gage.asp -- 06/07/05 tmcg: changed variable char param sizes to match table, removed UDFs in order by.  Changed big case in order by to be multiple single when cases. 
-- 06/08/05 tmcg: Changed ORDER BY to be all single line cases 
-- 06/21/05 tmcg: Added comment about @Active param, made param a bit type 
-- 07/19/05 mhat: Added serial no to the parameter list 
-- 05/12/06 bste: Added building key 
-- 06/08/07 txio: Added Serial_No to Sort_Order 
-- 10/15/07 txio: Added Gage_Drawing_No 
-- 02/22/08 txio: Change active parameter to include inactive 
-- 04/02/08 txio: Add TOP 500 
-- 07/09/08 txio: Added Building_Key and Building_Code 
-- 07/09/08 txio: Changed to sort by the G.Gage_ID 
-- 07/14/08 txio: Added Parent_Gage_No 
-- 02/05/09 stang: Add capability of multi-picker for gage_status parameter 
-- 01/31/12 dearly: Performance Tweaks and Standards updates 
-- 09/04/14 bgoulder: Changed @Plexus_User_No to @Calibration_Responsible_PUN. Removed unused @Note paramter. 
-- 04/13/16 cmshell 2209187: Removed PCN from LEFT OUTER JOIN to dbo.Plexus_User 
-- 02/09/23 MOLSON:  MO-6433 do date math in customer timezone to avoid dst problems 
DECLARE @Customer_Date DATETIME, 
@Now DATETIME, 
@Customer_Now DATETIME;
SET 
  @Now = GETDATE();
EXEC sp_AdjustDate @Plexus_Customer_No, 
@Now, 
1, 
NULL, 
@Customer_Now OUT;
SELECT 
  @Customer_Date = CAST(
    CONVERT(
      VARCHAR(10), 
      @Customer_Now, 
      101
    ) AS DATETIME
  );
DECLARE @Gage_Status_Temp TABLE (
  Gage_Status VARCHAR(50)
);
INSERT @Gage_Status_Temp (Gage_Status) EXEC [master].dbo.sp_split @Gage_Status;
SELECT 
  TOP (500) G.Gage_No, 
  G.Gage_ID, 
  G.Gage_Brand, 
  G.Gage_Type, 
  G.Gage_Status, 
  G.[Description], 
  G.Location, 
  G.Note, 
  G.Last_Calibration_Date, 
  G.Next_Calibration_Date, 
  G.Calibration_Frequency, 
  PU.First_Name + ' ' + PU.Last_Name AS Gage_User_Name, 
  D.Department_Code, 
  G.Department_No, 
  G.Replacement_Cost, 
  G.Plexus_User_No, 
  G.Serial_No, 
  GD.Gage_Drawing_No, 
  G.Gage_Drawing_Key, 
  COUNT(*) OVER (PARTITION BY GD.Gage_Drawing_No) AS Gage_Drawing_Count, 
  G.Active, 
  G.Building_Key, 
  B.Building_Code, 
  G.Parent_Gage_No, 
  GG.Gage_ID AS Parent_Gage_ID 
FROM 
  dbo.Gage AS G 
  LEFT OUTER JOIN Plexus_Control.dbo.Plexus_User AS PU ON PU.Plexus_User_No = G.Gage_User 
  LEFT JOIN Common.dbo.Department AS D ON D.Plexus_Customer_No = G.Plexus_Customer_No 
  AND D.Department_No = G.Department_No 
  LEFT OUTER JOIN dbo.Gage_Drawing AS GD ON GD.PCN = G.Plexus_Customer_No 
  AND GD.Gage_Drawing_Key = G.Gage_Drawing_Key 
  LEFT OUTER JOIN Common.dbo.Building AS B ON B.Plexus_Customer_No = G.Plexus_Customer_No 
  AND B.Building_Key = G.Building_Key 
  LEFT OUTER JOIN dbo.Gage AS GG ON GG.Plexus_Customer_No = G.Plexus_Customer_No 
  AND GG.Gage_No = G.Parent_Gage_No 
  LEFT OUTER JOIN @Gage_Status_Temp AS GST ON GST.Gage_Status = G.Gage_Status OUTER APPLY Plexus_Control.dbo.Date_To_Customer_Adjust(
    @Plexus_Customer_No, G.Next_Calibration_Date
  ) AS NCD 
WHERE 
  G.Plexus_Customer_No = @Plexus_Customer_No 
  AND G.Gage_ID LIKE @Gage_ID + '%' 
  AND G.Gage_Brand LIKE @Gage_Brand + '%' 
  AND (
    @Gage_Type = '' 
    OR G.Gage_Type = @Gage_Type
  ) 
  AND (
    @Gage_Status = '' 
    OR G.Gage_Status = GST.Gage_Status
  ) 
  AND G.Location LIKE @Location + '%' 
  AND (
    @Calibration_Responsible_PUN = 0 
    OR G.Calibration_Responsibility = @Calibration_Responsible_PUN
  ) 
  AND (
    @Owner = -1 
    OR G.Plexus_User_No = @Owner
  ) 
  AND (
    @User = -1 
    OR G.Gage_user = @User
  ) 
  AND (
    @Building_Key = -1 
    OR G.Building_Key = @Building_Key
  ) 
  AND (
    @Part_Key = -1 
    OR EXISTS (
      SELECT 
        * 
      FROM 
        dbo.Gage_Part 
      WHERE 
        Gage_Part.PCN = G.Plexus_Customer_No 
        AND Gage_Part.Gage_No = G.Gage_No 
        AND Gage_Part.Part_Key = @Part_Key
    )
  ) 
  AND (
    @Customer_No = 0 
    OR EXISTS (
      SELECT 
        * 
      FROM 
        dbo.Gage_Part AS GP 
        JOIN Part.dbo.Customer_Part AS CP ON CP.Plexus_Customer_No = GP.PCN 
        AND CP.Part_Key = GP.Part_Key 
      WHERE 
        GP.PCN = G.Plexus_Customer_No 
        AND GP.Gage_No = G.Gage_No 
        AND CP.Customer_No = @Customer_No
    )
  ) 
  AND (
    @Gage_Drawing_No = '' 
    OR GD.Gage_Drawing_No LIKE @Gage_Drawing_No + '%'
  ) 
  AND (
    @Department_No = -1 
    OR G.Department_No = @Department_No
  ) 
  AND (
    @Active = 1 
    OR G.Active != @Active
  ) 
  AND (
    @Text_Search = '' 
    OR (
      CONVERT(
        VARCHAR(20), 
        ISNULL(G.Gage_ID, '')
      ) LIKE '%' + @Text_Search + '%' 
      OR G.Location LIKE '%' + @Text_Search + '%' 
      OR G.Note LIKE '%' + @Text_Search + '%' 
      OR G.[Description] LIKE '%' + @Text_Search + '%' 
      OR G.Model LIKE '%' + @Text_Search + '%'
    )
  ) 
  AND (
    (
      @Range = 1 
      AND (
        @Days = '' 
        OR DATEDIFF(
          D, 
          CAST(
            CONVERT(
              VARCHAR(10), 
              NCD.Adjusted_Date, 
              101
            ) AS DATETIME
          ), 
          @Customer_Date
        ) >= @Days
      )
    ) 
    OR (
      @Range = -1 
      AND (
        @Days = '' 
        OR DATEDIFF(
          D, 
          @Customer_Date, 
          ISNULL(
            NCD.Adjusted_Date, @Customer_Now
          )
        ) <= @Days
      ) 
      AND DATEDIFF(
        D, 
        @Customer_Date, 
        ISNULL(
          NCD.Adjusted_Date, @Customer_Now
        )
      ) >= 0
    ) 
    OR (
      @Range = -2 
      AND (
        @Days = '' 
        OR DATEDIFF(
          D, 
          @Customer_Date, 
          ISNULL(
            NCD.Adjusted_Date, @Customer_Now
          )
        ) <= @Days
      )
    ) 
    OR (@Range = 0)
  ) 
  AND (
    @Calibration_Group = -1 
    OR G.Calibration_Group = @Calibration_Group
  ) 
  AND (
    @Parent_Gage_No IS NULL 
    OR G.Parent_Gage_No = @Parent_Gage_No
  ) 
ORDER BY 
  CASE @Sort_Order WHEN 'Gage_Drawing_No' THEN GD.Gage_Drawing_No END ASC, 
  CASE @Sort_Order WHEN 'Gage_ID' THEN G.Gage_ID END ASC, 
  CASE @Sort_Order WHEN 'Gage_Type' THEN G.Gage_Type END ASC, 
  CASE @Sort_Order WHEN 'Location_NextCal' THEN G.Location END ASC, 
  CASE @Sort_Order WHEN 'User_NextCal' THEN PU.First_Name + ' ' + PU.Last_Name END ASC, 
  CASE @Sort_Order WHEN 'Gage_User' THEN PU.Last_Name END ASC, 
  CASE @Sort_Order WHEN 'Days_Overdue' THEN DATEDIFF(
    D, 
    CAST(
      CONVERT(
        VARCHAR(10), 
        NCD.Adjusted_Date, 
        101
      ) AS DATETIME
    ), 
    @Customer_Date
  ) END DESC, 
  CASE @Sort_Order WHEN 'Next_Calibration' THEN G.Next_Calibration_Date END ASC, 
  CASE @Sort_Order WHEN '' THEN GD.Gage_Drawing_No END ASC, 
  CASE @Sort_Order WHEN '' THEN G.Gage_ID END ASC, 
  CASE @Sort_Order WHEN '' THEN G.Next_Calibration_Date END ASC, 
  CASE @Sort_Order WHEN 'Serial_No' THEN G.Serial_No END ASC;
RETURN;