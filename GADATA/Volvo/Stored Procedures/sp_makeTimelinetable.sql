﻿
CREATE PROCEDURE [Volvo].[sp_makeTimelinetable]


AS
BEGIN


---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1

DECLARE @startdate as datetime
DECLARE @Enddate as datetime
DECLARE @ndays as int 
SET @ndays = 5

DECLARE @Timespan as int 
SET @Timespan = 0

SET @StartDate = getdate()- @ndays 
SET @EndDate = getdate()


SET @startdate = '2018-03-19 13:30:00.000'
SET @Enddate = '2025-03-19 13:30:00.000' 

--set start date to closest shift begin point
SET @StartDate =  gadata.dbo.[fn_volvoCurrentShiftBegin](@StartDate,CAST(@StartDate AS time)) 
SET @EndDate =  gadata.dbo.[fn_volvoCurrentShiftBegin](@EndDate,CAST(@EndDate AS time)) 

------------------------------------------------------------------------------------------------------------------------------------------------
--Make a temp table that generates all the posible week day shifts from the end and startdate 
------------------------------------------------------------------------------------------------------------------------------------------------
Declare @Temp_L_WeekDayShift table(starttime datetime, endtime datetime, shiftlength datetime,Vyear int, Vweek int, Vday int, shift varchar(2), Noproduction bit)

Declare @shiftlength datetime
Declare @Year int
Declare @week int 
Declare @day int 
Declare @shift varchar(2)
Declare @Incdate datetime 
Declare @Endtime datetime

SET @Incdate = @StartDate
While @Incdate <= @enddate

Begin
 --calc end of current shift
 Set @Endtime = @Incdate + GADATA.dbo.fn_volvoshiftlength(@Incdate,CAST(@Incdate AS time)) 
 --calc current shiftlength
 Set @shiftlength = GADATA.dbo.fn_volvoshiftlength(@Incdate,CAST(@Incdate AS time)) 
 --insert current shift in temptable
 Set @Year = datepart(year,@Incdate)
 Set @week = DATEPART(week,@Incdate)
 Set @day = GADATA.dbo.fn_volvoday(@Incdate,CAST(@Incdate AS time))
 Set @Shift = GADATA.dbo.fn_volvoshift1(@Incdate,CAST(@Incdate AS time))
 insert into @Temp_L_WeekDayShift values (@Incdate, @Endtime, @shiftlength, @Year, @week, @day, @shift,0)
 --increment 1 shiftlength
 set @Incdate = @Incdate + @shiftlength	
 --shift counter 
 set @Timespan = @Timespan +1

--drop the temp object in a themp db 
if (OBJECT_ID('GADATA.VOLVO.L_timelineTemp') is not null) drop table GADATA.VOLVO.L_timelineTemp
 SELECT 
 * 
     ,CASE 
	  WHEN (L.[Vweek] %2 = 0) AND (L.[shift] = 1) THEN 'B' --even weken vroege shift 
	  WHEN (L.[Vweek] %2 = 0) AND (L.[shift] = 2) THEN 'A' --even weken late shift
	  WHEN (L.[Vweek] %2 = 1) AND (L.[shift] = 1) THEN 'A' --oneven weken vroegen shift
	  WHEN (L.[Vweek] %2 = 1) AND (L.[shift] = 2) THEN 'B' --oneven weken late shift
	  WHEN L.[shift] = 3 THEN 'N'
	  WHEN L.[shift] = 4 THEN 'WE'
	  ELSE 'na' 
	  END as [PLOEG]
INTO GADATA.VOLVO.L_timelineTemp 
FROM @Temp_L_WeekDayShift AS L
End


end