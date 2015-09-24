
CREATE PROCEDURE [Volvo].[sp_Alog]
   @RowCount as int = null
  ,@Request as varchar(255) = ''
AS
BEGIN


CREATE TABLE #sp_who2 
      (
	   SPID INT
	  ,Status VARCHAR(255)
	  ,Login  VARCHAR(255)
	  ,HostName  VARCHAR(255)
	  ,BlkBy  VARCHAR(255)
	  ,DBName  VARCHAR(255)
	  ,Command VARCHAR(255)
	  ,CPUTime INT
	  ,DiskIO INT
	  ,LastBatch VARCHAR(255)
	  ,ProgramName VARCHAR(255)
	  ,SPID2 INT
	  ,REQUESTID INT
	  )

INSERT INTO #sp_who2 EXEC sp_who2


INSERT INTO GADATA.Volvo.L_ActivityLog
SELECT top 1
    Getdate() as '_timestamp'      
	,#sp_who2.Login
	,#sp_who2.HostName
	,#sp_who2.CPUTime
	,#sp_who2.DiskIO
	,@RowCount as 'rowCount'
	,@Request as 'Request'
FROM        #sp_who2 Where [DBName] LIKE '%GADATA%'
order by Dbname asc
DROP TABLE #sp_who2

END