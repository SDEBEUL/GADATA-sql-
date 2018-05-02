-- =============================================
-- Author:		Coppejans Jens
-- Create date: 20/04/2018
-- Description:	UltralogDB
-- =============================================
CREATE PROCEDURE [UL].[UltralogDB] @starttime DATETIME = null, 
                                  @endtime   DATETIME = null 
AS 
  BEGIN 
      SET nocount ON; 


---------------------------------------------------------------------------------------

      SELECT dbo.ultraloginspections.inspectiontime, 
             dbo.users.cdsid, 
             dbo.inspectionplan.NAME AS 'Plan Name', 
             dbo.spot.number         AS 'Spot Number', 
             dbo.ultraloginspections.inspectorcomment, 
             dbo.ultraloginspections.bodynbr, 
             dbo.ultraloginspections.ok, 
             dbo.ultraloginspections.loose, 
             dbo.ultraloginspections.smallnugget, 
             dbo.ultraloginspections.stickweld, 
             dbo.ultraloginspections.badtroughweld, 
             dbo.ultraloginspections.measuredthickness, 
             dbo.ultraloginspections.minidentation, 
             dbo.ultraloginspections.totalthickness, 
             PlateType_1.thickness   AS 'Thickness 1', 
             PlateType_2.thickness   AS 'Thickness 2', 
             PlateType_3.thickness   AS 'Thickness 3', 
             PlateType_4.thickness   AS 'Thickness 4', 
             volvo.l_timeline.vyear, 
             volvo.l_timeline.vweek, 
             volvo.l_timeline.vday, 
             volvo.l_timeline.shift 
      FROM   dbo.ultraloginspections 
             INNER JOIN dbo.users 
                     ON dbo.ultraloginspections.inspectorid = dbo.users.id 
             INNER JOIN dbo.spot 
                     ON dbo.ultraloginspections.spotid = dbo.spot.id 
             INNER JOIN dbo.platecombinations 
                     ON dbo.spot.platecombinationtid = dbo.platecombinations.id 
             INNER JOIN dbo.inspectionplan 
                     ON dbo.ultraloginspections.inspectionplanid = 
                        dbo.inspectionplan.id 
             LEFT OUTER JOIN dbo.platetype AS PlateType_1 
                          ON dbo.platecombinations.plate1id = PlateType_1.id 
             LEFT OUTER JOIN dbo.platetype AS PlateType_2 
                          ON dbo.platecombinations.plate2id = PlateType_2.id 
             LEFT OUTER JOIN dbo.platetype AS PlateType_3 
                          ON dbo.platecombinations.plate3id = PlateType_3.id 
             LEFT OUTER JOIN dbo.platetype AS PlateType_4 
                          ON dbo.platecombinations.plate4id = PlateType_4.id 
             LEFT OUTER JOIN volvo.l_timeline 
                          ON dbo.ultraloginspections.inspectiontime BETWEEN 
                             volvo.l_timeline.starttime AND 
                             volvo.l_timeline.endtime 
      WHERE  dbo.ultraloginspections.inspectiontime BETWEEN 
             @starttime AND @endtime 
      ORDER  BY dbo.ultraloginspections.inspectiontime DESC; 
  END