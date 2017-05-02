
-- =============================================
-- Author:		<Coppejans,,jens>
-- Create date: <7/03/2017,,>
-- Description:	<OptimalisationTool,,>
-- =============================================
CREATE PROCEDURE [dbo].[WeldingTool] 

    @DateTime as DATETIME = null,
    @spot as varchar(25) = '26185',
	@Zone  as  varchar(25) = '27',
	@Timer as varchar(25) = '34090WT01'

AS

BEGIN
	
	SET NOCOUNT ON;




	SELECT           [Date], [Name] AS Timer, dbo.spot.Number As Spotnr, dbo.spot.Program,Null As TimerFault,Null As ProductionLoss,
	
	                 Zone,
	                 CONVERT(DECIMAL(5, 1), 100 * CAST(dbo.WeldMeasurements.NbrSplash AS decimal(10, 5))/ CAST(dbo.WeldMeasurements.NbrWeld AS decimal(10, 5))) AS [Spatters%], CONVERT(DECIMAL(5, 1), 100 * CAST(dbo.WeldMeasurements.NbrReweld AS decimal(10,  5)) / CAST(dbo.WeldMeasurements.NbrWeld AS decimal(10, 5))) AS PsfReweld, [NbrWeld], [AvgEnergy], [AvgPSF],
					 [StdPSF] As [%AfwijkingPSF], [AvgWeldTIme], NULL AS UltralogTime, NULL AS [Losse spot?], NULL AS [OK spot?], 
					 NULL AS [SmallNugget?], NULL AS [StickWeld?], NULL AS [BadTroughWeld?], NULL  AS [MeasuredThickness], NULL AS [TotalThickness],
					 NULL AS [InspectorComment], NULL AS bodynummer, NULL AS ParameterChange, NULL AS before, NULL AS after,
					 NULL AS CDSID, NULL AS NPT,

			               NULL AS [Pressure], NULL Squeeze, NULL AS [KA_1], NULL AS [WELD1], NULL AS [COOL_1],
		                   NULL AS [KA_2], NULL AS [WELD2], NULL AS [COOL_2], NULL AS [KA_3], NULL AS [WELD3],
		                   NULL AS [HOLD], NULL AS [PRprofile ON ?], NULL AS [thickness1], NULL AS [Material1], NULL AS [Coating1],
		                   NULL AS [Thickness2], NULL AS [Material2], NULL AS [Coating2], NULL AS [thickness3], NULL AS [Material3],
		                   NULL AS [Coating3]

FROM            [GADATA].[dbo].[WeldMeasurements] INNER JOIN
                         dbo.Spot ON dbo.WeldMeasurements.SpotId = dbo.spot.id INNER JOIN
                         [GADATA].[dbo].[Timer] ON [GADATA].[dbo].[Spot].TimerID = [GADATA].[dbo].[Timer].ID
WHERE        [Date] >= GETDATE() - 31  AND dbo.spot.Number LIKE '3%' OR dbo.spot.Number LIKE '4%' OR  dbo.spot.Number LIKE '5%' 

UNION

SELECT             [InspectionTime], NULL AS Name, dbo.spot.Number, dbo.spot.Program,Null As TimerFault,Null As ProductionLoss,

                         NULL AS [Loose], 
						 null as spot,null as spot,null as spot,null as spot,null as spot,
						 null as spot,null as spot, [InspectionTime], [Loose], [OK],
						 [SmallNugget], [StickWeld], [BadTroughWeld],[MeasuredThickness], [TotalThickness],
						 [InspectorComment], [BodyNbr], NULL AS spot, NULL AS spot, NULL AS ParameterChange,
						 NULL AS before, NULL AS NPT,

					
			               NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		                   NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		                   NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		                   NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		                   NULL AS Spot

FROM            [GADATA].[dbo].[UltralogInspections] INNER JOIN
                         dbo.spot ON [GADATA].[dbo].[UltralogInspections].spotID = dbo.spot.id
WHERE        [InspectionTime] >= GETDATE() - 31  

UNION

SELECT        dbo.SpotDataChange.DateTime AS Date, dbo.Timer.Name AS TIMER, dbo.Spot.Number, dbo.Spot.Program,Null As TimerFault,Null As ProductionLoss,

                         null as spot,
                         NULL AS spot, NULL AS spot, NULL AS spot, NULL AS spot, NULL AS spot,
						 NULL AS spot, NULL AS spot, NULL AS spot, NULL AS spot, NULL AS spot,
						 NULL AS spot, NULL AS spot, NULL AS spot, NULL AS spot, NULL AS spot, 
						 NULL AS ParameterChange, NULL AS spot, dbo.TimerParameterName.Description, dbo.SpotDataChange.OldValue AS [oude parameter], dbo.SpotDataChange.NewValue AS [nieuwe parameter],
                         dbo.Users.CDSID, null as NPT,

			               NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		                   NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		                   NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		                   NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		                   NULL AS Spot

FROM            dbo.Spot INNER JOIN
                         dbo.Timer ON dbo.Spot.TimerID = dbo.Timer.ID AND dbo.Spot.TimerID = dbo.Timer.ID INNER JOIN
                         dbo.NPT ON dbo.Timer.NptId = dbo.NPT.ID INNER JOIN
                         dbo.SpotDataChange ON dbo.Spot.ID = dbo.SpotDataChange.SpotID AND dbo.Spot.ID = dbo.SpotDataChange.SpotID INNER JOIN
                         dbo.TimerParameterName ON dbo.SpotDataChange.ParameterID = dbo.TimerParameterName.ID AND 
                         dbo.SpotDataChange.ParameterID = dbo.TimerParameterName.ID INNER JOIN
                         dbo.Users ON dbo.SpotDataChange.UserID = dbo.Users.ID AND dbo.SpotDataChange.UserID = dbo.Users.ID
WHERE        (dbo.SpotDataChange.DateTime >= GETDATE() - 31) AND dbo.spot.Number LIKE '3%' OR dbo.spot.Number LIKE '4%' OR  dbo.spot.Number LIKE '5%' 

UNION

SELECT        dbo.TimerDataChange.DateTime AS Date, dbo.Timer.Name AS Timer, NULL AS Spot, null as spot,Null As TimerFault,Null As ProductionLoss,

                         
						  null as spot,
						  NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, 
                          NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, 
						  NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
                          NULL AS Spot, NULL AS Spot, dbo.TimerParameterName.Description, dbo.TimerDataChange.OldValue, dbo.TimerDataChange.NewValue,
						  dbo.Users.CDSID,dbo.NPT.Name AS NPT,

						 
						   NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		                   NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		                   NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		                   NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		                   NULL AS Spot

FROM            dbo.TimerParameterName INNER JOIN
                         dbo.TimerDataChange ON dbo.TimerParameterName.ID = dbo.TimerDataChange.ParameterID INNER JOIN
                         dbo.Users ON dbo.TimerDataChange.UserID = dbo.Users.ID INNER JOIN
                         dbo.Timer ON dbo.TimerDataChange.TimerID = dbo.Timer.ID INNER JOIN
                         dbo.NPT ON dbo.Timer.NptId = dbo.NPT.ID


WHERE        datetime >= GETDATE() - 31 

UNION

SELECT        [Date],[Name],[Number],[Program] ,Null As TimerFault,Null As ProductionLoss,
      
	   NULL AS Spot, 
	    NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		 NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		  NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		   NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		   NULL AS Spot, NULL AS Spot
	 
     
                       
		                ,[Pressure],[Squeeze],[KA_1],[WELD1],[COOL_1]
						,[KA_2],[WELD2],[COOL_2],[KA_3],[WELD3]
						,[HOLD] ,[PRprofile ON ?] ,[thickness1],[Material1],[Coating1]
						,[Thickness2],[Material2],[Coating2],[thickness3],[Material3]
						,[Coating3]
						
      
     FROM [GADATA].[LAUNCH].[JoiningParameterPlatesGA]   
    WHERE  Number LIKE '3%' OR Number LIKE '4%' OR  Number LIKE '5%' 
	

	UNION

	SELECT [DateTime],[Name],[Spot],[Program] ,[TimerFault],[ProductionLoss],
      
     	   NULL AS Spot, 
	    NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		 NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		  NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		   NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		   NULL AS Spot, NULL AS Spot,

        NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		                   NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		                   NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		                   NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot, NULL AS Spot,
		                   NULL AS Spot
      
      
    
      FROM [GADATA].[LAUNCH].[WeldFaultProtocol]

	  WHERE datetime >= GETDATE() - 31 AND  Spot LIKE '3%' OR Spot LIKE '4%' OR  Spot LIKE '5%' 


   END