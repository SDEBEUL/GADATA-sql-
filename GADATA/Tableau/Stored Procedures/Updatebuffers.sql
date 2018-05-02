




CREATE PROCEDURE [Tableau].[Updatebuffers]
AS
BEGIN


--update NGAC buffer
                --delete old records
                delete GADATA.Tableau.[BT_Last100d_STO-NGAC] from GADATA.Tableau.[BT_Last100d_STO-NGAC] where Logtype = 'ControllerEvent' AND timestamp < GETDATE() - 30 
                --update new records
                insert into GADATA.Tableau.[BT_Last100d_STO-NGAC]
                select rt.* from GADATA.Tableau.[Last100d_NGAC] as rt
                where rt.timestamp > 
				ISNULL(
				(select top 1 h.[timestamp] from GADATA.Tableau.[BT_Last100d_STO-NGAC] as h WHERE  Logtype = 'ControllerEvent' order by h.[timestamp] desc)
				,GETDATE()-30)

--update STO buffer
/*
				declare @timestamp as datetime
				set @timestamp =  ISNULL(
				(select top 1 h.[timestamp] from GADATA.Tableau.[BT_Last100d_STO-NGAC] as h WHERE  Logtype = 'STOerror' order by h.[timestamp] desc)
				,GETDATE()-30)
				--delete old records
                delete GADATA.Tableau.[BT_Last100d_STO-NGAC] from GADATA.Tableau.[BT_Last100d_STO-NGAC] where  Logtype = 'STOerror' AND timestamp < GETDATE() - 30 
                --update new records
                insert into GADATA.Tableau.[BT_Last100d_STO-NGAC]
                select rt.* from GADATA.Tableau.[Last100d_STO] as rt
                where rt.timestamp > @timestamp

				*/


--update STW040 and maximo buffer
                --delete old records
                delete GADATA.Tableau.BT_Last100d_STW040andMAXIMO  from GADATA.Tableau.BT_Last100d_STW040andMAXIMO 
                --update old records
                insert into GADATA.Tableau.BT_Last100d_STW040andMAXIMO SELECT rt.* FROM GADATA.Tableau.[Last100d_STW040andMAXIMO] as rt


END