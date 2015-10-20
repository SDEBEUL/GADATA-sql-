CREATE PROCEDURE [dbo].[sp_VCSC_C4G_Update_L_breakdown_A1]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @RobotFilterWild as varchar(10) = '%',
   @RobotFilterMaskStart as varchar(10) = '%',
   @RobotFilterMaskEnd as varchar(10) = '99999R99%',
   @OrderbyRobot as bit = null,
   @CalcBreakDowntags as bit = 0
AS
BEGIN




---------------------------------------------------------------------------------------
print 'Running: [dbo].[sp_VCSC_C4G_Update_L_breakdown_A1]'
---------------------------------------------------------------------------------------
EXEC GADATA.volvo.sp_Alog  @rowcount = 0, @Request = '[dbo].[sp_VCSC_C4G_Update_L_breakdown_A1]'
END