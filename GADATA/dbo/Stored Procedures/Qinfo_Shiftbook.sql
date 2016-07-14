


CREATE PROCEDURE [dbo].[Qinfo_Shiftbook]
    @Robot as varchar(16) = null
   ,@BreakdownID as int = null
   ,@ShiftbookID as int = null
   ,@user as varchar(16) = 'server'
   ,@WO as int = null
   ,@CI as int = null
   ,@STATE as varchar(16) = null
   ,@userDescription as varchar(1000) = null
   ,@userComment as varchar(8000) = null
   ,@Runmode as int = 0 
   --1= edit mode. (shiftbook form) 2= view mode 3= independant add  5 delete @shiftbookid 6 accept
AS
BEGIN
DECLARE @Redirect as bit 
Set @Redirect = 0
--get controller type and id for references
DECLARE @conttroller_id as int 
DECLARE @controller_type as varchar(10)
SET @conttroller_id = (SELECT TOP 1 r.id FROM GADATA.volvo.Robots as r where r.controller_name like @robot)
SET @controller_type = (SELECT TOP 1 r.controller_type FROM GADATA.volvo.Robots as r where r.controller_name like @robot)


--linked add mode 
--if in edit mode 
if @Runmode = 2
	BEGIN
	--check if existing item is open. (based on location) item is open if status not COMP or TECHCOMP (and not current item)
	if 0 <> (select count(id) from GADATA.Volvo.hShiftbook as sb where sb.controller_id = @conttroller_id AND sb.controller_type = @controller_type AND sb.[State] not like '%COMP%')
		BEGIN 
		  --get shiftbook id from existing item
		  SET @ShiftbookID = (SELECT TOP 1 sb.id FROM GADATA.Volvo.hShiftbook as sb where sb.controller_id = @conttroller_id AND sb.controller_type = @controller_type AND sb.[State] not like '%COMP%')
		  SET @Redirect = 1 --way of communicating that is was a redirect
		END
	--if no item existing item create new one on this breakdown 
	ELSE 
	IF 0 = (select count(id) from GADATA.Volvo.hShiftbook as sb where sb.Breakdown_id = @BreakdownID AND sb.controller_id = @conttroller_id AND sb.controller_type = @controller_type )
		BEGIN
		   --create new 'linked' shiftbook record
			INSERT INTO GADATA.volvo.hShiftbook (controller_type,controller_id,Breakdown_id,Report_timestamp,ReportUser)
			VALUES(@controller_type,@conttroller_id,@BreakdownID,getdate(),@user)
		END
END

--independed add mode 
if @Runmode = 3 
BEGIN
  --kijk of er nog iets open staat op deze locatie 
  SET @ShiftbookID = (SELECT TOP 1 sb.id FROM GADATA.Volvo.hShiftbook as sb where sb.controller_id = @conttroller_id AND sb.controller_type = @controller_type AND sb.[State] not like '%COMP%')
  if @ShiftbookID is null 
    BEGIN
	  --maak nieuw record 
	  DECLARE @independatTS as datetime
	  SET @independatTS = getdate()
	  INSERT INTO GADATA.volvo.hShiftbook (controller_type,controller_id,Report_timestamp,ReportUser,IndependantLocation,userDescription)
	  VALUES(ISNULL(@controller_type,'User'),@conttroller_id,@independatTS,@user,@Robot,@userDescription)
	  SET @ShiftbookID = (SELECT sb.id FROM GADATA.VOLVO.hShiftbook as sb where sb.Report_timestamp = @independatTS)
    END
  ELSE
    BEGIN
		Set @Redirect = 1
    END
  SET @Runmode = 2 --set view mode 
END

 --view mode 
if @Runmode in(2,4)
BEGIN
	SELECT 
		 ISNULL(r.controller_name,isnull(sb.IndependantLocation,'ERROR')) as 'Robot'
		,ISNULL(sb.controller_id,'') as 'Controller_id'
		,ISNULL(sb.controller_type,'') as 'controller_type'
		,ISNULL(b.timestamp,sb.Report_timestamp) as 'Timestamp'
		,ISNULL(b.idx,0) as 'Breakdownreference'
	    ,ISNULL(sb.id,0) as 'ShiftbookID'
		,@Redirect as 'Redirect'
		,'*****************************************' 
		,ISNULL(ISNULL(sb.userDescription,'BREAKDOWN: ' + b.Logtekst),'') as 'Omschrijving'
	    ,ISNULL(b.DOWNTIME,0) as 'Downtime'
		,ISNULL(sb.State,'N/A') as 'Status'		
		,ISNULL(sb.ci,'') as 'CI'
		,ISNULL(sb.wo,'') as 'WO'
		,ISNULL(sb.Report_timestamp,'') as 'ReportTime'
		,ISNULL(sb.ReportUser,'') as 'ReportUser'
		,ISNULL(sb.AcceptUser,'Nobody') as 'AcceptUser'
		,'*****************************************' 
		,ISNULL(sb.userComment,'') as 'Commentaar'
		,ISNULL(sb.State_history,'') as 'StateHistory'
		,'*************************************************************************' 

	FROM GADATA.Volvo.hShiftbook as sb
	left join GADATA.volvo.Robots as r on (r.controller_type = sb.controller_type) and (r.id = sb.controller_id)
	left join
	(
	select * from GADATA.C3G.Breakdown as c3gb where  c3gb.idx = @breakdownid
	UNION
	select * from GADATA.C4G.Breakdown as c4gb where  c4gb.Idx = @breakdownid
	) as B on B.robotname = @Robot
	WHERE
	--called from a breakdown
	(sb.Breakdown_id = @BreakdownID AND sb.controller_id = @conttroller_id AND sb.controller_type = @controller_type)
	--direct call from shiftbook
	OR
	(sb.id = @ShiftbookID)
END

--edit mode (write to db)
if @Runmode = 1 
BEGIN
UPDATE GADATA.volvo.hShiftbook
	SET 
	 ci = @CI
	,wo = @WO
	,[state] = @state
	,State_history = ISNULL(State_history,'N/A') + ' | ' + CONVERT(char(19),getdate(), 120) + '=>' + @user + '=>' + @STATE + CHAR(13)+CHAR(10) 
	,userDescription = @userDescription
	,userComment = @usercomment
	,updateTimestamp = getdate()
FROM GADATA.volvo.hShiftbook as sb 
WHERE
--called from a breakdown
(sb.Breakdown_id = @BreakdownID AND sb.controller_id = @conttroller_id AND sb.controller_type = @controller_type)
--direct call from shiftbook
OR
(sb.id = @ShiftbookID)
END

if @runmode = 5
BEGIN
DELETE gadata.volvo.hShiftbook FROM gadata.volvo.hShiftbook where id = @shiftbookID
END

if @runmode = 6 
BEGIN
UPDATE gadata.volvo.hShiftbook 
SET 
 AcceptUser = @USER
,State_history = ISNULL(State_history,'N/A') + ' | ' + CONVERT(char(19),getdate(), 120) + '=>' + @user + '=>' + 'ASSINGED'  + CHAR(13)+CHAR(10) 
, State = 'ASSINGED'
FROM gadata.volvo.hShiftbook where id = @shiftbookID
END

END