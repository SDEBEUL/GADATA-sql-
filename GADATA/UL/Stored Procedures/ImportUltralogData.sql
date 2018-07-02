
-- ============================================= 
-- Author:     Coppejans Jens
-- Create date:  
-- Description:   
-- ============================================= 
CREATE PROCEDURE [UL].[ImportUltralogData] 
AS 
  BEGIN 
      SET nocount ON; 

	

if (OBJECT_ID('tempdb..#temptable999 ') is not null) drop table #temptable999 

      --Create temp table all UL logs from laptops 
      CREATE TABLE #temptable999 
        ( 
           [stationid]                    [VARCHAR](21) NOT NULL, 
           [spotname]                     [CHAR](50) NULL, 
           [inspectionresultname]         [CHAR](255) NULL, 
           [evaluationclass]              [CHAR](50) NULL, 
           [autocomment]                  [CHAR](30) NULL, 
           [inspectorcomment]             [CHAR](50) NULL, 
           [resultcomment]                [CHAR](50) NULL, 
           [resultcommentoperator]        [CHAR](50) NULL, 
           [nuggetdiameter]               [FLOAT] NULL, 
           [nuggetdiameter2]              [FLOAT] NULL, 
           [inspectionmethod]             [CHAR](10) NULL, 
           [partname]                     [CHAR](50) NULL, 
           [inspectionplanname]           [CHAR](50) NULL, 
           [groupofspots]                 [CHAR](255) NULL, 
           [weldstation]                  [CHAR](50) NULL, 
           [measuredthickness]            [FLOAT] NULL, 
           [nameplate1]                   [CHAR](50) NULL, 
           [materialplate1]               [CHAR](50) NULL, 
           [thicknessplate1]              [FLOAT] NULL, 
           [nameplate2]                   [CHAR](50) NULL, 
           [materialplate2]               [CHAR](50) NULL, 
           [thicknessplate2]              [FLOAT] NULL, 
           [nameplate3]                   [CHAR](50) NULL, 
           [materialplate3]               [CHAR](50) NULL, 
           [thicknessplate3]              [FLOAT] NULL, 
           [inspector]                    [CHAR](50) NULL, 
           [nominalnuggetdiameter]        [VARCHAR](255) NULL, 
           [inspectiondate]               [VARCHAR](255) NULL, 
           [inspectiontime]               [VARCHAR](255) NULL, 
           [numberofspots]                [INT] NULL, 
           [numberofokspots]              [INT] NULL, 
           [numberofnokspots]             [INT] NULL, 
           [indexofevaluationclass]       [INT] NULL, 
           [indexofinspectionmethod]      [INT] NULL, 
           [correctprobeused]             [INT] NULL, 
           [usedprobename]                [CHAR](30) NULL, 
           [usedprobenumber]              [CHAR](30) NULL, 
           [usedprobediameter]            [FLOAT] NULL, 
           [usedprobefrequency]           [FLOAT] NULL, 
           [probecontrol]                 [INT] NULL, 
           [backwallechocnt]              [INT] NULL, 
           [flawechocnt]                  [INT] NULL, 
           [gasporeechocnt]               [INT] NULL, 
           [backwallamplitudedifference1] [FLOAT] NULL, 
           [backwallamplitudedifference2] [FLOAT] NULL, 
           [gain]                         [FLOAT] NULL, 
           [displaydelay]                 [FLOAT] NULL, 
           [displaywidth]                 [FLOAT] NULL, 
           [soundvelocity]                [FLOAT] NULL, 
           [probedelay]                   [FLOAT] NULL, 
           [utinstrumentsetting]          [CHAR](255) NULL, 
           [utevaluationassistance]       [INT] NULL, 
           [utevaluationassistancename]   [CHAR](10) NULL, 
           [autofreeze]                   [INT] NULL, 
           [definedprobename]             [CHAR](30) NULL, 
           [definedprobenumber]           [CHAR](30) NULL, 
           [definedprobediameter]         [FLOAT] NULL, 
           [definedprobefrequency]        [FLOAT] NULL, 
           [evaluationthreshold]          [INT] NULL, 
           [evaluationthresholdfe]        [INT] NULL, 
           [evaluationthresholdgp]        [INT] NULL, 
           [toleranceofelectrodemark]     [FLOAT] NULL, 
           [toleranceofelectrodemarkmm]   [FLOAT] NULL, 
           [toleranceofgaspore]           [FLOAT] NULL, 
           [gasporeechos]                 [FLOAT] NULL, 
           [minimumindentation]           [FLOAT] NULL, 
           [minimumindentationmm]         [FLOAT] NULL, 
           [indexoftestsequence]          [INT] NULL, 
           [indexofpointsequence]         [INT] NULL, 
           [teststation]                  [CHAR](50) NULL, 
           [storeokresult]                [INT] NULL, 
           [storeascanresult]             [INT] NULL, 
           [objectplanprogrammer]         [CHAR](50) NULL, 
           [objectplandate]               [VARCHAR](255) NULL, 
           [objectplantime]               [VARCHAR](255) NULL, 
           [objectplanname]               [CHAR](50) NULL, 
           [objectplanpath]               [VARCHAR](max) NULL, 
           [method]                       [INT] NULL, 
           [spotweldtype]                 [INT] NULL, 
           [inspectionplanprogrammer]     [CHAR](50) NULL, 
           [inspectionplandate]           [VARCHAR](255) NULL, 
           [inspectionplantime]           [VARCHAR](255) NULL, 
           [inspectionresult]             [INT] NULL, 
           [idinspection]                 [INT] NULL, 
           [planid]                       [INT] NULL, 
           [partid]                       [INT] NULL, 
           [jointid]                      [INT] NULL, 
           [partidentification]           [INT] NULL, 
           [jointcomment]                 [CHAR](255) NULL, 
           [resultframenumber]            [INT] NULL, 
           [feevaluationafterie]          [INT] NULL, 
           [usboxserialno]                [CHAR](255) NULL, 
           [exporttocentraldatastore]     [INT] NULL, 
           [evaluationparameter]          [CHAR](255) NULL, 
           [partnameconvert]              [INT] NULL, 
           [ultime]                       [CHAR] (50), 
           convertultime                  DATETIME, 
           [inspectorcommentleft]         [CHAR](30) 
        ) 
      ON [PRIMARY] 
      textimage_on [PRIMARY] 

      --insert all data from UL laptops 
      INSERT INTO #temptable999 
      SELECT *, 
             CONVERT (DATETIME, tbl.ultime, 103) AS ConvertULtime, 
             LEFT(inspectorcomment, 30)          AS inspectorcommentLEFT 
      FROM   (SELECT 'raw_Ultra_IT16659'                         AS StationID, 
                     *, 
                     CASE 
                       WHEN partname = 'null' or ISNUMERIC(partname) = 0 THEN 0 
                       ELSE partname 
                     END                                         AS 
                     PartnameConvert, 
                     Concat(inspectiondate, ' ', inspectiontime) AS ULtime 
              FROM   raw_ultra_it16659)tbl 
      UNION 
      SELECT *, 
             CONVERT (DATETIME, tbl.ultime, 103) AS ConvertULtime, 
             LEFT(inspectorcomment, 30)          AS inspectorcommentLEFT 
      FROM   (SELECT 'dbo_raw_Ultra_IT16660'                     AS StationID, 
                     *, 
                     CASE 
                       WHEN partname = 'null' or ISNUMERIC(partname) = 0 THEN 0 
                       ELSE partname 
                     END                                         AS 
                     PartnameConvert, 
                     Concat(inspectiondate, ' ', inspectiontime) AS ULtime 
              FROM   [dbo].[raw_ultra_it16660])tbl 
      UNION 
      SELECT *, 
             CONVERT (DATETIME, tbl.ultime, 103) AS ConvertULtime, 
             LEFT(inspectorcomment, 30)          AS inspectorcommentLEFT 
      FROM   (SELECT 'dbo_raw_Ultra_IT16668'                     AS StationID, 
                     *, 
                     CASE 
                       WHEN partname = 'null' or ISNUMERIC(partname) = 0 THEN 0 
                       ELSE partname 
                     END                                         AS 
                     PartnameConvert, 
                     Concat(inspectiondate, ' ', inspectiontime) AS ULtime 
              FROM   [dbo].[raw_ultra_it16668])tbl 
      UNION 
      SELECT *, 
             CONVERT (DATETIME, tbl.ultime, 103) AS ConvertULtime, 
             LEFT(inspectorcomment, 30)          AS inspectorcommentLEFT 
      FROM   (SELECT 'dbo_raw_Ultra_IT18161'                     AS StationID, 
                     *, 
                     CASE 
                      WHEN partname = 'null' or ISNUMERIC(partname) = 0 THEN 0 
                       ELSE partname 
                     END                                         AS 
                     PartnameConvert, 
                     Concat(inspectiondate, ' ', inspectiontime) AS ULtime 
              FROM   [dbo].[raw_ultra_it18161])tbl 
      UNION 
      SELECT *, 
             CONVERT (DATETIME, tbl.ultime, 103) AS ConvertULtime, 
             LEFT(inspectorcomment, 30)          AS inspectorcommentLEFT 
      FROM   (SELECT 'dbo_raw_Ultra_laptop2'                     AS StationID, 
                     *, 
                     CASE 
                       WHEN partname = 'null' or ISNUMERIC(partname) = 0 THEN 0 
                       ELSE partname 
                     END                                         AS 
                     PartnameConvert, 
                     Concat(inspectiondate, ' ', inspectiontime) AS ULtime 
              FROM   [dbo].[raw_ultra_laptop2])tbl 
      UNION 
      SELECT *, 
             CONVERT (DATETIME, tbl.ultime, 103) AS ConvertULtime, 
             LEFT(inspectorcomment, 30)          AS inspectorcommentLEFT 
      FROM   (SELECT 'dbo_raw_Ultra_laptop3'                     AS StationID, 
                     *, 
                     CASE 
                       WHEN partname = 'null' or ISNUMERIC(partname) = 0 THEN 0  
                       ELSE partname 
                     END                                         AS 
                     PartnameConvert, 
                     Concat(inspectiondate, ' ', inspectiontime) AS ULtime 
              FROM   [dbo].[raw_ultra_laptop3])tbl 
      UNION 
      SELECT *, 
             CONVERT (DATETIME, tbl.ultime, 103) AS ConvertULtime, 
             LEFT(inspectorcomment, 30)          AS inspectorcommentLEFT 
      FROM   (SELECT 'dbo_raw_Ultra_laptop4'                     AS StationID, 
                     *, 
                     CASE 
                       WHEN partname = 'null' or ISNUMERIC(partname) = 0 THEN 0 
                       ELSE partname 
                     END                                         AS 
                     PartnameConvert, 
                     Concat(inspectiondate, ' ', inspectiontime) AS ULtime 
              FROM   [dbo].[raw_ultra_laptop4])tbl 
      UNION 
      SELECT *, 
             CONVERT (DATETIME, tbl.ultime, 103) AS ConvertULtime, 
             LEFT(inspectorcomment, 30)          AS inspectorcommentLEFT 
      FROM   (SELECT 'dbo_raw_Ultra_laptop5'                     AS StationID, 
                     *, 
                     CASE 
                       WHEN partname = 'null' or ISNUMERIC(partname) = 0 THEN 0  
                       ELSE partname 
                     END                                         AS 
                     PartnameConvert, 
                     Concat(inspectiondate, ' ', inspectiontime) AS ULtime 
              FROM   [dbo].[raw_ultra_laptop5])tbl 
      UNION 
      SELECT *, 
             CONVERT (DATETIME, tbl.ultime, 103) AS ConvertULtime, 
             LEFT(inspectorcomment, 30)          AS inspectorcommentLEFT 
      FROM   (SELECT 'dbo_raw_Ultra771'                          AS StationID, 
                     *, 
                     CASE 
                       WHEN partname = 'null' or ISNUMERIC(partname) = 0 THEN 0 
                       ELSE partname 
                     END                                         AS 
                     PartnameConvert, 
                     Concat(inspectiondate, ' ', inspectiontime) AS ULtime 
              FROM   [dbo].[raw_ultra771])tbl 
      UNION 
      SELECT *, 
             CONVERT (DATETIME, tbl.ultime, 103) AS ConvertULtime, 
             LEFT(inspectorcomment, 30)          AS inspectorcommentLEFT 
      FROM   (SELECT 'dbo_raw_Ultra_laptop1'                     AS StationID, 
                     *, 
                     CASE 
                       WHEN partname = 'null' or ISNUMERIC(partname) = 0 THEN 0 
                       ELSE partname 
                     END                                         AS 
                     PartnameConvert, 
                     Concat(inspectiondate, ' ', inspectiontime) AS ULtime 
              FROM   [dbo].[raw_ultra_laptop1])tbl
	  UNION 
      SELECT *, 
             CONVERT (DATETIME, tbl.ultime, 103) AS ConvertULtime, 
             LEFT(inspectorcomment, 30)          AS inspectorcommentLEFT 
      FROM   (SELECT 'dbo_raw_Ultra_laptop6'                     AS StationID, 
                     *, 
                     CASE 
                      WHEN partname = 'null' or ISNUMERIC(partname) = 0 THEN 0 
                       ELSE partname 
                     END                                         AS 
                     PartnameConvert, 
                     Concat(inspectiondate, ' ', inspectiontime) AS ULtime 
              FROM   [dbo].[raw_ultra_laptop6])tbl 	
			  UNION 
      SELECT *, 
             CONVERT (DATETIME, tbl.ultime, 103) AS ConvertULtime, 
             LEFT(inspectorcomment, 30)          AS inspectorcommentLEFT 
      FROM   (SELECT 'dbo_raw_Ultra_laptop7'                     AS StationID, 
                     *, 
                     CASE 
                       WHEN partname = 'null' or ISNUMERIC(partname) = 0 THEN 0 
                       ELSE partname 
                     END                                         AS 
                     PartnameConvert, 
                     Concat(inspectiondate, ' ', inspectiontime) AS ULtime 
              FROM   [dbo].[raw_ultra_laptop7])tbl 		  	   

      INSERT INTO dbo.raw_tempuldata 
      SELECT distinct  * 
      FROM   #temptable999 

      ---insert new inspectionplan if found in laptops---- 
      INSERT INTO dbo.inspectionplan 
                  ([creatorid], 
                   [lenght], 
                   [name], 
                   [date]) 
      SELECT t.creatorid, 
             t.lenght, 
             t.inspectionplanname, 
             CONVERT (DATETIME, t.plandate, 103) AS ConvertULtime 
      FROM   (SELECT DISTINCT dbo.users.id 
                              AS 
                                     creatorID, 
                              Isnull(dbo.raw_tempuldata.numberofspots, 0) 
                              AS 
                              Lenght, 
                              dbo.raw_tempuldata.inspectionplanname, 
                              Concat(inspectionplandate, ' ', inspectionplantime 
                              ) 
                              AS 
                              plandate 
              FROM   dbo.users 
                     INNER JOIN dbo.raw_tempuldata 
                             ON dbo.users.cdsid = 
                                dbo.raw_tempuldata.inspectionplanprogrammer 
                     LEFT OUTER JOIN dbo.inspectionplan 
                                  ON dbo.raw_tempuldata.inspectionplanname = 
                                     dbo.inspectionplan.NAME 
              WHERE  ( dbo.inspectionplan.NAME IS NULL ))t 

      --SELECT * from #TEMPTable999 
      --ALTER TABLE dbo.tempultraloginspections 
      --ALTER Column BodyNbr int null  --- allow temp null values 
      --Convert and insert all data from temp table to dbo.ultraloginspections 
      INSERT INTO dbo.ultraloginspections 
      SELECT  distinct dbo.inspectionplan.id                        AS InspectionplanID, 
             dbo.spot.id                                  AS SpotID, 
             #temptable999.inspectorcommentleft           AS inspectorcomment, 
             #temptable999.partnameconvert                AS bodynr, 
             dbo.users.id                                 AS InspectorID, 
             --CONCAT(#TEMPTable999.InspectionDateconvert,' ', #TEMPTable999.InspectionTimeconvert) AS ULtime, 
             #temptable999.convertultime                  AS inspectiontime, 
             Isnull(#temptable999.indexoftestsequence, 0) AS TestSqz, 
             CASE 
               WHEN evaluationclass = 
                    'Loose                                             ' 
             THEN 1 
               ELSE 0 
             END                                          AS Loose, 
             CASE 
               WHEN evaluationclass = 
                    'OK                                                ' 
             THEN 1 
               ELSE 0 
             END                                          AS OK, 
             CASE 
               WHEN evaluationclass = 
                    'Small nugget                                      ' 
             THEN 1 
               ELSE 0 
             END                                          AS SmallNugget, 
             CASE 
               WHEN evaluationclass = 
                    'stick weld                                        ' 
             THEN 1 
               ELSE 0 
             END                                          AS StickWeld, 
             CASE 
               WHEN evaluationclass = 
                    'bad through weld                                  ' 
             THEN 1 
               ELSE 0 
             END                                          AS BadTroughtWeld, 
             dbo.ultralogstations.id                      AS stationID, 
             Isnull(#temptable999.measuredthickness, 0)   AS meas_thickness, 
             Isnull(#temptable999.minimumindentation, 0)  AS MinIdentation, 
             Isnull(#temptable999.thicknessplate1, 0) 
             + Isnull(#temptable999.thicknessplate2, 0) 
             + Isnull(#temptable999.thicknessplate3, 0)   AS TotalThickness, 
             Isnull(#temptable999.numberofspots, 0)       AS PlanLenght 
      FROM   dbo.spot 
             INNER JOIN #temptable999 
                     ON dbo.spot.number = #temptable999.spotname 
             INNER JOIN dbo.inspectionplan 
                     ON #temptable999.inspectionplanname = 
                        dbo.inspectionplan.NAME 
             INNER JOIN dbo.users 
                     ON #temptable999.inspector = dbo.users.cdsid 
             INNER JOIN dbo.ultralogstations 
                     ON #temptable999.stationid = dbo.ultralogstations.NAME 

      --delete all data from laptops--- 
      DELETE FROM dbo.raw_ultra_it16659 

      DELETE FROM dbo.raw_ultra_it16660 

      DELETE FROM [dbo].[raw_ultra_it16668] 

      DELETE FROM [dbo].[raw_ultra_it18161] 

      DELETE FROM [dbo].[raw_ultra_laptop2] 

      DELETE FROM [dbo].[raw_ultra_laptop3] 

      DELETE FROM [dbo].[raw_ultra_laptop4] 

      DELETE FROM [dbo].[raw_ultra_laptop5] 

      DELETE FROM [dbo].[raw_ultra771] 

      DELETE FROM [dbo].[raw_ultra_laptop1] 

	  DELETE FROM [dbo].[raw_ultra_laptop6] 

	  DELETE FROM [dbo].[raw_ultra_laptop7] 

      --drop temp table 
      DROP TABLE #temptable999 


---Update the plan laatst uitgevoerd lijst --- simuleren situaties uit het verleden-- every 5 minute trigger
insert into [UL].[PlanLastComplete_history]
SELECT GETDATE()
      ,[LastInspectionTime]
      ,[UL plan]
      ,[BuildBody's]
      ,[WorkGroup]
      ,[WorkLocation]
  FROM [GADATA].[UL].[AutomaticWorkFlowULPlans]
  ORDER BY [BuildBody's] DESC

---DELETE records older than 6 months---
      DELETE FROM welding.expulsiondata 
      WHERE  datetime < Dateadd(MONTH, -6, Getdate()) 




 END