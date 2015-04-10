CREATE PROCEDURE [dbo].[sp_VCSC_C4G_Rt_alarm_logCleanup]
AS
BEGIN

--create table c_logtekst.
/*
USE [GADATA]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[c_logtekst](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[error_number] [int] NULL,
	[error_severity] [int] NULL,
	[error_text] [varchar](256) NULL,
 CONSTRAINT [PK_c_logtekst] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'contains all posible logtekst for vcsc' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'c_logtekst'
GO
*/
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--constraint on c_logteskt table (block double input)
/*
CREATE UNIQUE NONCLUSTERED INDEX [IndexTableUniqueRows] ON gadata.dbo.c_logtekst
(
    error_tekst ASC

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = ON, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
*/
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--fill up the logtekst table

insert into gadata.dbo.[c_logtekst]
SELECT DISTINCT 
      [error_number]
      ,[error_severity]
      ,[error_text]

FROM [GADATA].[dbo].[rt_alarm]
--this clause is only for update mode 
WHERE rt_alarm.error_id is null 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--look if the id binding worked 
/*
SELECT TOP 1000 
	   rt_alarm.[id]
      ,rt_alarm.[controller_id]
      ,rt_alarm.[_timestamp]
      ,rt_alarm.[error_timestamp]
      ,rt_alarm.[error_number]
      ,rt_alarm.[error_count]
      ,rt_alarm.[error_severity]
      ,rt_alarm.[error_text]
      ,rt_alarm.[error_is_alarm]
	  ,c_logtekst.id as 'logtekstid'
  FROM [GADATA].[dbo].[rt_alarm]
  join gadata.dbo.c_logtekst on (rt_alarm.error_text = c_logtekst.error_text)
*/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--links the generated logtekst id to the rt_alarm table
UPDATE GADATA.dbo.rt_alarm
SET rt_alarm.[error_id] = c_logtekst.id
FROM rt_alarm,c_logtekst
WHERE 
(rt_alarm.error_text = c_logtekst.error_text)
--this clause only for update mode 
AND 
(rt_alarm.error_id is null)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--now I need to adjust ALL stored procs and data handelers to take the data from c_logtekst if its is there and go back to rt_alarm if not... (hold on this wil take a long time)
--Main systems are rebuild ...
--BUT do not null replace the rt_alarm.error_severity ! tis will generate a big issue for L_breakdown 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--clean up the rt_alarm table replace logtext and error_number with null if the error_id is joined 
UPDATE GADATA.dbo.rt_alarm
SET rt_alarm.error_text = null
FROM rt_alarm
WHERE 
(rt_alarm.error_id is not null)


END