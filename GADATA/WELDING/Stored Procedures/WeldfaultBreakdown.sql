
-- ============================================= 
-- Author:     Coppejans Jens
-- Create date:  
-- Description:   
-- ============================================= 
CREATE PROCEDURE [WELDING].[WeldfaultBreakdown] 
AS 
 
      SET nocount ON; 

--every 60 sec trigger  
--SELECT * from [WELDING].[LiveTimerErrorsGA]   
--zijn er nieuwe errors create start  
--SELECT * from [WELDING].[LiveTimerErrorsGA]  -- to check the errors  

BEGIN TRY 

INSERT INTO [WELDING].[breakdown_start] 
            (timer, 
             timerfault, 
             starttime, 
             breakdowntime) 
SELECT welding.livetimererrorsga.timername, 
       welding.livetimererrorsga.errortext, 
       welding.livetimererrorsga.timestamp, 
       Cast('00:00' AS TIME) AS breakdownstart 
FROM   welding.livetimererrorsga 
       LEFT OUTER JOIN [WELDING].[breakdown_start] 
                    ON welding.livetimererrorsga.timername = 
                       [WELDING].[breakdown_start].timer 
                       AND welding.livetimererrorsga.errortext = 
                           [WELDING].[breakdown_start].timerfault 
WHERE  [WELDING].[breakdown_start].starttime IS NULL 
        OR ( Datediff(second, welding.livetimererrorsga.timestamp, 
                   welding.livetimererrorsga.timestamp) >= 60 ) 

--zijn de errors nog steeds bezig  =>>>  count 60 seconds trigger
UPDATE [WELDING].[breakdown_start] 
SET    breakdowntime = Dateadd(ss, 60, breakdowntime) 
FROM   (SELECT welding.livetimererrorsga.timername, 
               welding.livetimererrorsga.errortext, 
               [WELDING].[breakdown_start].starttime 
        FROM   welding.livetimererrorsga 
               INNER JOIN [WELDING].[breakdown_start] 
                       ON welding.livetimererrorsga.timername = 
                          [WELDING].[breakdown_start].timer 
                          AND welding.livetimererrorsga.errortext = 
                              [WELDING].[breakdown_start].timerfault)tbl 

--Error is niet meer in vorige Query =>>> insert into [WELDING].[Breakdown]  
INSERT INTO [WELDING].[breakdown] 
SELECT dbo.timer.id, 
       [WELDING].[breakdown_start].timerfault, 
       [WELDING].[breakdown_start].starttime, 
       [WELDING].[breakdown_start].breakdowntime,
	   null as WMcomment 

FROM   dbo.timer 
       INNER JOIN [WELDING].[breakdown_start] 
               ON dbo.timer.NAME = [WELDING].[breakdown_start].timer 
       LEFT OUTER JOIN welding.livetimererrorsga 
                    ON [WELDING].[breakdown_start].timer = 
                       welding.livetimererrorsga.timername 
WHERE  ( welding.livetimererrorsga.timestamp IS NULL ) 

-- delete from startbreakdowns  
DELETE FROM [WELDING].[breakdown_start] 
FROM   welding.breakdown_start 
       LEFT OUTER JOIN welding.livetimererrorsga 
                    ON welding.breakdown_start.timer = 
                       welding.livetimererrorsga.timername 
                       AND welding.breakdown_start.timerfault = 
                           welding.livetimererrorsga.errortext 
WHERE  ( welding.livetimererrorsga.timestamp IS NULL ) 
       AND ( welding.livetimererrorsga.timername IS NULL ) 
       AND ( welding.livetimererrorsga.errortext IS NULL ) 
  END TRY

  BEGIN CATCH

  INSERT INTO [WELDING].[ErrorHandling]([procedure]
      ,[ErrorNumber]
      ,[ErrorSeverity]
      ,[ErrorState]
      ,[ErrorLine]
      ,[ErrorMessage]
	  ,[timestamp])

  SELECT 
    '[WELDING].[WeldfaultBreakdown]_fault_catch'
    ,ERROR_NUMBER() AS ErrorNumber  
    ,ERROR_SEVERITY() AS ErrorSeverity  
    ,ERROR_STATE() AS ErrorState  
    ,ERROR_LINE() AS ErrorLine  
    ,ERROR_MESSAGE() AS ErrorMessage
	,GETDATE();  

 END CATCH