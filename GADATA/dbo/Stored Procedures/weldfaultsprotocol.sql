
CREATE PROCEDURE [dbo].[weldfaultsprotocol] 
	
   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null
	
AS
BEGIN

---------------------------------------------------------------------------------------
--Set default values of start and end date
---------------------------------------------------------------------------------------
if ((@StartDate is null) OR (@StartDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @StartDate = GETDATE()-1
END

if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()
END

	
	SET NOCOUNT ON;

SELECT           dbo.WeldFaultLog.DateTime, dbo.NPT.Name AS NPT, dbo.Timer.Robot, 
                         dbo.Spot.Number AS Spot, dbo.Spot.Program, dbo.WeldFaultName.WeldFaultName AS TimerFault,null as ProductionLoss,
                        
                         dbo.WeldFaultLog.WeldMasterComment, dbo.WeldFaultLog.ID, null as [Description],null as  [OldValue],null as  [NewValue],null as [CDSID]

FROM            dbo.NPT INNER JOIN
                         dbo.WeldFaultLog INNER JOIN
                         dbo.WeldFaultName ON dbo.WeldFaultLog.WeldFaultID = dbo.WeldFaultName.ID AND dbo.WeldFaultLog.WeldFaultID = dbo.WeldFaultName.ID AND 
                         dbo.WeldFaultLog.WeldFaultID = dbo.WeldFaultName.ID AND dbo.WeldFaultLog.WeldFaultID = dbo.WeldFaultName.ID AND 
                         dbo.WeldFaultLog.WeldFaultID = dbo.WeldFaultName.ID AND dbo.WeldFaultLog.WeldFaultID = dbo.WeldFaultName.ID AND 
                         dbo.WeldFaultLog.WeldFaultID = dbo.WeldFaultName.ID AND dbo.WeldFaultLog.WeldFaultID = dbo.WeldFaultName.ID AND 
                         dbo.WeldFaultLog.WeldFaultID = dbo.WeldFaultName.ID AND dbo.WeldFaultLog.WeldFaultID = dbo.WeldFaultName.ID INNER JOIN
                         dbo.Spot ON dbo.WeldFaultLog.SpotID = dbo.Spot.ID AND dbo.WeldFaultLog.SpotID = dbo.Spot.ID AND dbo.WeldFaultLog.SpotID = dbo.Spot.ID AND 
                         dbo.WeldFaultLog.SpotID = dbo.Spot.ID AND dbo.WeldFaultLog.SpotID = dbo.Spot.ID AND dbo.WeldFaultLog.SpotID = dbo.Spot.ID AND 
                         dbo.WeldFaultLog.SpotID = dbo.Spot.ID AND dbo.WeldFaultLog.SpotID = dbo.Spot.ID AND dbo.WeldFaultLog.SpotID = dbo.Spot.ID AND 
                         dbo.WeldFaultLog.SpotID = dbo.Spot.ID INNER JOIN
                         dbo.Timer ON dbo.Spot.TimerID = dbo.Timer.ID AND dbo.Spot.TimerID = dbo.Timer.ID AND dbo.Spot.TimerID = dbo.Timer.ID AND dbo.Spot.TimerID = dbo.Timer.ID AND
                          dbo.Spot.TimerID = dbo.Timer.ID AND dbo.Spot.TimerID = dbo.Timer.ID AND dbo.Spot.TimerID = dbo.Timer.ID ON dbo.NPT.ID = dbo.Timer.NptId AND 
                         dbo.NPT.ID = dbo.Timer.NptId AND dbo.NPT.ID = dbo.Timer.NptId AND dbo.NPT.ID = dbo.Timer.NptId AND dbo.NPT.ID = dbo.Timer.NptId AND 
                         dbo.NPT.ID = dbo.Timer.NptId AND dbo.NPT.ID = dbo.Timer.NptId                        

WHERE        DateTime between @startdate and @EndDate 

UNION

SELECT        [DateTime], [Name] AS NPT,[Robot], [Number],  [Program],null as [Description],null as ProductionLoss ,
		     null as Weldmastercomment, null as ID,	
             [Description], [OldValue], [NewValue], [CDSID]
FROM            [GADATA].[dbo].[Weldfault_WM_change]
WHERE			DateTime between   @startdate and @EndDate 

UNION

SELECT       [Timestamp],NULL AS [Location], [Robotname], NULL AS [Type], NULL AS [Errortype], [Logtekst],
             [DOWNTIME] AS ProductionLoss, NULL AS [Shift], NULL AS [Shift], NULL AS [Shift], NULL AS [Shift], NULL AS [Shift], NULL AS [Shift]
FROM            C3G.old_old_breakdown
WHERE        (Object = 'Spot')    AND Timestamp between   @startdate and @EndDate 

UNION

SELECT        [Timestamp], NULL AS [Location], [Robotname] AS ROBOT, NULL AS [Type], NULL AS [ErrorType], [Logtekst], 
                         [DOWNTIME] As proctionLoss, NULL AS [Year], NULL AS [Week], NULL AS [day],  NULL AS [Subgroup], NULL AS [idx], null as spot
                        
FROM            [GADATA].[C4G].[old_old_breakdown]
WHERE        object = 'Spot' AND Timestamp between   @startdate and @EndDate 

UNION

SELECT        dbo.TimerErrorLog.DateTime, NULL AS NPT, dbo.Timer.Robot, NULL AS spot, NULL AS program, dbo.TimerErrorText.ErrorText, NULL AS weldfault, NULL 
                         AS productionLoss, NULL AS WMcomment, NULL AS ID, NULL AS Expr1, NULL AS Expr2, NULL AS Expr3
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.TimerErrorLog ON dbo.Timer.ID = dbo.TimerErrorLog.TimerID INNER JOIN
                         dbo.TimerErrorText ON dbo.TimerErrorLog.ErrorID = dbo.TimerErrorText.ID
WHERE                    dbo.TimerErrorLog.DateTime between   @startdate and @EndDate  AND dbo.TimerErrorText.ID = '5' OR
                         dbo.TimerErrorLog.DateTime between   @startdate and @EndDate  AND dbo.TimerErrorText.ID = '17' OR
                         dbo.TimerErrorLog.DateTime between   @startdate and @EndDate  AND dbo.TimerErrorText.ID = '20' OR
                         dbo.TimerErrorLog.DateTime between   @startdate and @EndDate  AND dbo.TimerErrorText.ID = '21' OR
                         dbo.TimerErrorLog.DateTime between   @startdate and @EndDate  AND dbo.TimerErrorText.ID = '22' OR
                         dbo.TimerErrorLog.DateTime between   @startdate and @EndDate  AND dbo.TimerErrorText.ID = '24' OR
                         dbo.TimerErrorLog.DateTime between   @startdate and @EndDate  AND dbo.TimerErrorText.ID = '30' OR
                         dbo.TimerErrorLog.DateTime between   @startdate and @EndDate  AND dbo.TimerErrorText.ID = '36' OR
                         dbo.TimerErrorLog.DateTime between   @startdate and @EndDate  AND dbo.TimerErrorText.ID = '37' OR
                         dbo.TimerErrorLog.DateTime between   @startdate and @EndDate  AND dbo.TimerErrorText.ID = '38' OR
                         dbo.TimerErrorLog.DateTime between   @startdate and @EndDate  AND dbo.TimerErrorText.ID = '39' OR
                         dbo.TimerErrorLog.DateTime between   @startdate and @EndDate  AND  dbo.TimerErrorText.ID = '40' OR
                         dbo.TimerErrorLog.DateTime between   @startdate and @EndDate AND dbo.TimerErrorText.ID = '42' OR
						  dbo.TimerErrorLog.DateTime between   @startdate and @EndDate AND dbo.TimerErrorText.ID = '10' OR
						   dbo.TimerErrorLog.DateTime between   @startdate and @EndDate AND dbo.TimerErrorText.ID = '11' 


UNION 

SELECT       dbo.TimerDataChange.DateTime, dbo.NPT.Name AS NPT, dbo.Timer.Robot AS robot, NULL AS spot, NULL AS Expr1, NULL AS weldfault, NULL 
                         AS productionLoss, NULL AS WMcomment, NULL AS ID, dbo.TimerParameterName.Description, dbo.TimerDataChange.OldValue, dbo.TimerDataChange.NewValue, 
                         dbo.Users.CDSID
FROM            dbo.NPT INNER JOIN
                         dbo.Timer ON dbo.NPT.ID = dbo.Timer.NptId INNER JOIN
                         dbo.TimerDataChange ON dbo.Timer.ID = dbo.TimerDataChange.TimerID INNER JOIN
                         dbo.TimerParameterName ON dbo.TimerDataChange.ParameterID = dbo.TimerParameterName.ID INNER JOIN
                         dbo.Users ON dbo.TimerDataChange.UserID = dbo.Users.ID
WHERE       dbo.TimerDataChange.DateTime between @startdate and @EndDate 

UNION 


  SELECT [Timestamp], null as [Location],[Robotname], null as spot, NULL AS [Errortype], [Logtekst],[DOWNTIME]
      ,[Errortype],null as [Logcode],null as [Severity],null as [Year],null as [Week],null as [day]
 
  FROM [GADATA].[C3G].[Live]
  WHERE Object = 'spot'  AND [Timestamp] between @startdate and @EndDate OR Logtekst LIKE '%maint mode%' AND [Timestamp] between @startdate and @EndDate 

  UNION

  SELECT       [Timestamp],NULL AS [Location], [Robotname], NULL AS [Type], NULL AS [Errortype], [Logtekst],
             [DOWNTIME] AS ProductionLoss, NULL AS [Shift], NULL AS [Shift], NULL AS [Shift], NULL AS [Shift], NULL AS [Shift], NULL AS [Shift]
FROM            C3G.old_breakdown
WHERE        Logtekst LIKE '%water%'  AND Timestamp between   @startdate and @EndDate 

UNION

SELECT        [Timestamp], NULL AS [Location], [Robotname] AS ROBOT, NULL AS [Type], NULL AS [ErrorType], [Logtekst], 
                         [DOWNTIME] As proctionLoss, NULL AS [Year], NULL AS [Week], NULL AS [day],  NULL AS [Subgroup], NULL AS [idx], null as spot
                        
FROM            [GADATA].[C4G].[old_breakdown]
WHERE       Logtekst LIKE '%water%'  AND Timestamp between   @startdate and @EndDate 





END