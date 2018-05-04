-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [EqUi].[EQpluginNutsCellstest]



    -- Insert statements for procedure here
--default parameters
--timeparameters
	   @StartDate as DATETIME = null,
	   @EndDate as DATETIME = null,
	   @daysBack as int = null,
	--Filterparameters.
	   @assets as varchar(10) = '%',
	   @locations as varchar(20) = '%',
	   @lochierarchy as varchar(20) = '%', 
	--non default parms
   @ErrorDispLog as bit = 1,
   @TestBool2 as bit = 0,
   @TestDate1 as datetime = null,
   @TestDate2 as datetime  = null,
   @TestVarchar1 as varchar(100) = null,
   @TestVarchar2 as varchar(100) = null

AS
BEGIN

---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--Set default values of start and end date
---------------------------------------------------------------------------------------
if ((@StartDate is null) OR (@StartDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @StartDate = GETDATE()-'1900-01-01 12:00:00'
END

if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()
END
--for days back mode
if (@daysBack is not null)
BEGIN
SET @StartDate = GETDATE() - @daysBack
END 
---------------------------------------------------------------------------------------

SELECT        'Location' AS Expr1, 'AssetID' AS Expr2, 'Logtype' AS Expr3, 'timestamp' AS Expr4, 'Logcode' AS Expr5, 'Severity' AS Expr6, 'Logtext' AS Expr7, 
                         'FullLogtext' AS Expr8, tblrobot.[Txt 1], tblrobot.[Txt 2], tblrobot.[Txt 3], tblrobot.[Txt 4], tblrobot.[Txt 5], tblrobot.[Txt 6], tblrobot.[Txt 7], tblrobot.[Txt 8], tblrobot.[Txt 9], 
                         tblrobot.[Txt 10], tblrobot.[Txt 11], 'Classification' AS Expr9, 'Subgroup' AS Expr10, 'Category' AS Expr11, 'refId' AS Expr12, tblrobot.LocationTree, 
                         'ClassTree' AS Expr13, tblrobot.controller_name, 'controller_type' AS Expr14, tblrobot.TRimSpotID, WELDING.tbl_NutBoltWelding.RobotSpot_id, 
                         WELDING.tbl_NutBoltWelding.NutID_BoltID_BOS6000, WELDING.tbl_NutBoltWelding.NutID_BoltID_PII, WELDING.tbl_NutBoltWelding.TimerName, 
                         WELDING.tbl_NutBoltWelding.MachineNumber
FROM            (SELECT        TOP (100) PERCENT c.controller_name AS 'Location', c.CLassificationId AS 'AssetID', 'ErrDispLog' AS 'Logtype', rt.[Date Time] AS 'timestamp', 
                                                    rt.AlarmNo AS 'Logcode', NGAC.fn_GetSeverity(rt.[Txt 1]) AS 'Severity', rt.[Txt 2] AS 'Logtext', NGAC.AddifSomething(rt.[Txt 2]) 
                                                    + NGAC.AddifSomething(rt.[Txt 3]) + NGAC.AddifSomething(rt.[Txt 4]) + NGAC.AddifSomething(rt.[Txt 5]) + NGAC.AddifSomething(rt.[Txt 6]) 
                                                    + NGAC.AddifSomething(rt.[Txt 7]) + NGAC.AddifSomething(rt.[Txt 8]) + NGAC.AddifSomething(rt.[Txt 9]) + NGAC.AddifSomething(rt.[Txt 10]) 
                                                    + NGAC.AddifSomething(rt.[Txt 11]) + + 'Response: ' + rt.Action AS 'FullLogtext', rt.[Txt 1], rt.[Txt 2], rt.[Txt 3], rt.[Txt 4], rt.[Txt 5], rt.[Txt 6], rt.[Txt 7], 
                                                    rt.[Txt 8], rt.[Txt 9], rt.[Txt 10], rt.[Txt 11], RTRIM(ISNULL(NULL, 'Undefined*')) AS 'Classification', ISNULL(NULL, 'Undefined*') AS 'Subgroup', 
                                                    REPLACE(rt.[Txt 1], '-', '') AS 'Category', rt.id AS 'refId', c.LocationTree, c.ClassificationTree AS 'ClassTree', c.controller_name, 
                                                    'NGAC' AS 'controller_type', LEFT(rt.[Txt 10], 10) AS TRimSpotID
                          FROM            NGAC.rt_ErrDispLog AS rt LEFT OUTER JOIN
                                                    NGAC.rt_csv_file AS rt_csv ON rt.rt_csv_file_id = rt_csv.id LEFT OUTER JOIN
                                                    NGAC.c_controller AS c WITH (NOLOCK) ON c.id = rt_csv.c_controller_id
                          WHERE        (c.CLassificationId LIKE 'UAWN+UAWB%') AND (rt.[Date Time] BETWEEN @startdate AND @enddate) AND (@ErrorDispLog = 1)) 
                         AS tblrobot LEFT OUTER JOIN
                         WELDING.tbl_NutBoltWelding ON tblrobot.TRimSpotID = WELDING.tbl_NutBoltWelding.RobotSpot_id

END