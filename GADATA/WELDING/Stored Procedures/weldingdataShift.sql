-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [WELDING].[weldingdataShift]

AS
BEGIN

	SET NOCOUNT ON;

	exec GADATA.WELDING.midairs
	exec GADATA.WELDING.TimerErrorLog

END