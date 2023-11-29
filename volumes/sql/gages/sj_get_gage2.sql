DECLARE
  @Plexus_Customer_No INT = 306766,
  @Gage_ID VARCHAR(25) = '', 
  @Gage_Brand VARCHAR(50) = 'BAT', 
  @Gage_Type VARCHAR(50) = '', 
  @Gage_Status VARCHAR(1000) = 'IN,DI', 
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
  @Parent_Gage_No INT = NULL,
  @Now DATETIME

SET 
  @Now = GETDATE()

CREATE TABLE #Temp
(
  String VARCHAR(500) 
)
INSERT INTO #Temp
( String ) SELECT @Gage_Status;

CREATE TABLE #TG
(
  Gage_Status VARCHAR(100),
  String VARCHAR(100)
)
INSERT INTO #TG
(
  Gage_Status,
  String
)
SELECT
  LEFT(String, CHARINDEX(',', String + ',') -1),
  STUFF(String, 1, CHARINDEX(',', String + ','), '')
FROM #Temp

UNION ALL

SELECT
  LEFT(String, CHARINDEX(',', String + ',') - 1),
  STUFF(String, 1, CHARINDEX(',', String + ','), '')
FROM #TG
WHERE
  String > '';

DECLARE @Gage_Status_Temp TABLE
(
  Gage_Status VARCHAR(50)
)
INSERT INTO @Gage_Status_Temp
(
  Gage_Status
)
SELECT
  Gage_Status
FROM #TG

SELECT 
  G.Gage_No, 
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
  Quality_v_Gage AS G 
  LEFT OUTER JOIN Plexus_Control_v_Plexus_User AS PU
    ON PU.Plexus_User_No = G.Gage_User 
  LEFT JOIN Common_v_Department AS D
    ON D.Plexus_Customer_No = G.Plexus_Customer_No 
    AND D.Department_No = G.Department_No 
  LEFT OUTER JOIN Quality_v_Gage_Drawing AS GD
    ON GD.PCN = G.Plexus_Customer_No 
    AND GD.Gage_Drawing_Key = G.Gage_Drawing_Key 
  LEFT OUTER JOIN Common_v_Building AS B
    ON B.Plexus_Customer_No = G.Plexus_Customer_No 
    AND B.Building_Key = G.Building_Key 
  LEFT OUTER JOIN Quality_v_Gage AS GG
    ON GG.Plexus_Customer_No = G.Plexus_Customer_No 
    AND GG.Gage_No = G.Parent_Gage_No 
  LEFT OUTER JOIN @Gage_Status_Temp AS GST
    ON GST.Gage_Status = G.Gage_Status 
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
        Quality_v_Gage_Part 
      WHERE 
        Quality_v_Gage_Part.PCN = G.Plexus_Customer_No 
        AND Quality_v_Gage_Part.Gage_No = G.Gage_No 
        AND Quality_v_Gage_Part.Part_Key = @Part_Key
    )
  ) 
  AND (
    @Customer_No = 0 
    OR EXISTS (
      SELECT 
        * 
      FROM 
        Quality_v_Gage_Part AS GP 
        JOIN Part_v_Customer_Part AS CP ON CP.Plexus_Customer_No = GP.PCN 
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
              G.Next_Calibration_Date, 
              101
            ) AS DATETIME
          ), 
          @Now
        ) >= @Days
      )
    ) 
    OR (
      @Range = -1 
      AND (
        @Days = '' 
        OR DATEDIFF(
          D, 
          @now, 
          ISNULL(
            G.Next_Calibration_Date, @Now
          )
        ) <= @Days
      ) 
      AND DATEDIFF(
        D, 
        @Now, 
        ISNULL(
          G.Next_Calibration_Date, @Now
        )
      ) >= 0
    ) 
    OR (
      @Range = -2 
      AND (
        @Days = '' 
        OR DATEDIFF(
          D, 
          @Now, 
          ISNULL(
            G.Next_Calibration_Date, @Now
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
        G.Next_Calibration_Date, 
        101
      ) AS DATETIME
    ), 
    @Now
  ) END DESC, 
  CASE @Sort_Order WHEN 'Next_Calibration' THEN G.Next_Calibration_Date END ASC, 
  CASE @Sort_Order WHEN '' THEN GD.Gage_Drawing_No END ASC, 
  CASE @Sort_Order WHEN '' THEN G.Gage_ID END ASC, 
  CASE @Sort_Order WHEN '' THEN G.Next_Calibration_Date END ASC, 
  CASE @Sort_Order WHEN 'Serial_No' THEN G.Serial_No END ASC;