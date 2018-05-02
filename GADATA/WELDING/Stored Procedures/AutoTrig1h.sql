
-------------------------------------------------------------------------------
CREATE PROCEDURE [WELDING].[AutoTrig1h]
AS
BEGIN
exec GADATA.WELDING.HousekeepingSpotTimer --take controle over spotlist and timerlist -- see changes
exec GADATA.WELDING.Datachange -- timerPC datachange
exec GADATA.WELDING.TimerFaults -- all timerfaults
---exec GADATA.WELDING.SpatterDATA
exec GADATA.WELDING.QControlSystem -- adaptive controle check
exec GADATA.WELDING.WeldingMeasurements ---import all nut/bolt data greenfield
exec GADATA.UL.SpotIdentImport -- to calculate bodys between ultralogplans



END