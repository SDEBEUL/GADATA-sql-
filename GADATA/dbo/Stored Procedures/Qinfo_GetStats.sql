CREATE PROCEDURE [dbo].[Qinfo_GetStats]
   @Robot as varchar(16) = null
   ,@ErrCode as int = null
     ,@ErrID as int = null
AS
BEGIN


DECLARE @robType varchar(20)
SET @robType = (select robots.controller_type from GADATA.Volvo.Robots where Robots.controller_name = @robot) 


--case of C4G robot
IF @robType = 'c4g'
BEGIN
SELECT
'Count LastDay:' =
(SELECT count(Error.Logcode) FROM GADATA.C4G.Error WHERE (Robotname = @Robot AND [timestamp] BETWEEN getdate()-1 AND getdate()) AND Error.logcode = @Errcode)

,'Count LastWeek:' =
(SELECT count(Error.Logcode) FROM GADATA.C4G.Error WHERE (Robotname = @Robot AND [timestamp] BETWEEN getdate()-7 AND getdate()) AND Error.logcode = @Errcode)

,'Count LastMonth:' =
(SELECT count(Error.Logcode) FROM GADATA.C4G.Error WHERE (Robotname = @Robot AND [timestamp] BETWEEN getdate()-31 AND getdate()) AND Error.logcode = @Errcode)

,'Count ALL:' =
(SELECT count(Error.Logcode) FROM GADATA.C4G.Error WHERE Robotname = @Robot  AND Error.logcode = @Errcode)

,'First Time:' =
(SELECT top 1 CONVERT(char(19),Error.[timestamp], 120)  FROM GADATA.C4G.Error WHERE (Robotname = @Robot AND Error.logcode = @Errcode) order by Error.[timestamp] ASC)

,'Last Time:' = 
(SELECT top 1 CONVERT(char(19),Error.[timestamp], 120)  FROM GADATA.C4G.Error WHERE (Robotname = @Robot AND Error.logcode = @Errcode) order by Error.[timestamp] DESC)
END

--case of C3G robot
IF @robType = 'c3g'
BEGIN
SELECT
'Count LastDay:' =
(SELECT count(Error.Logcode) FROM GADATA.C3G.Error WHERE (Robotname = @Robot AND [timestamp] BETWEEN getdate()-1 AND getdate()) AND Error.logcode = @Errcode)

,'Count LastWeek:' =
(SELECT count(Error.Logcode) FROM GADATA.C3G.Error WHERE (Robotname = @Robot AND [timestamp] BETWEEN getdate()-7 AND getdate()) AND Error.logcode = @Errcode)

,'Count LastMonth:' =
(SELECT count(Error.Logcode) FROM GADATA.C3G.Error WHERE (Robotname = @Robot AND [timestamp] BETWEEN getdate()-31 AND getdate()) AND Error.logcode = @Errcode)

,'Count ALL:' =
(SELECT count(Error.Logcode) FROM GADATA.C3G.Error WHERE Robotname = @Robot  AND Error.logcode = @Errcode)

,'First Time:' =
(SELECT top 1 CONVERT(char(19),Error.[timestamp], 120)  FROM GADATA.C3G.Error WHERE (Robotname = @Robot AND Error.logcode = @Errcode) order by Error.[timestamp] ASC)

,'Last Time:' = 
(SELECT top 1 CONVERT(char(19),Error.[timestamp], 120)  FROM GADATA.C3G.Error WHERE (Robotname = @Robot AND Error.logcode = @Errcode) order by Error.[timestamp] DESC)
END

--case of irc5 robot
IF @robType = 'IRC5'
BEGIN
SELECT
'Count LastDay:' =
(SELECT count(IRC5error.Logcode) FROM GADATA.ABB.IRC5error WHERE (Robotname = @Robot AND [timestamp] BETWEEN getdate()-1 AND getdate()) AND IRC5error.logcode = @Errcode)

,'Count LastWeek:' =
(SELECT count(IRC5error.Logcode) FROM GADATA.ABB.IRC5error WHERE (Robotname = @Robot AND [timestamp] BETWEEN getdate()-7 AND getdate()) AND IRC5error.logcode = @Errcode)

,'Count LastMonth:' =
(SELECT count(IRC5error.Logcode) FROM GADATA.ABB.IRC5error WHERE (Robotname = @Robot AND [timestamp] BETWEEN getdate()-31 AND getdate()) AND IRC5error.logcode = @Errcode)

,'Count ALL:' =
(SELECT count(IRC5error.Logcode) FROM GADATA.ABB.IRC5error WHERE Robotname = @Robot  AND IRC5error.logcode = @Errcode)

,'First Time:' =
(SELECT top 1 CONVERT(char(19),IRC5error.[timestamp], 120)  FROM GADATA.ABB.IRC5error WHERE (Robotname = @Robot AND IRC5error.logcode = @Errcode) order by IRC5error.[timestamp] ASC)

,'Last Time:' = 
(SELECT top 1 CONVERT(char(19),IRC5error.[timestamp], 120)  FROM GADATA.ABB.IRC5error WHERE (Robotname = @Robot AND IRC5error.logcode = @Errcode) order by IRC5error.[timestamp] DESC)
END

--case of s4 robot
IF (@robType = 'S4C') OR (@robType = 'S4C+')
BEGIN
SELECT
'Count LastDay:' =
(SELECT count(S4error.Logcode) FROM GADATA.ABB.S4error WHERE (Robotname = @Robot AND [timestamp] BETWEEN getdate()-1 AND getdate()) AND S4error.logcode = @Errcode)

,'Count LastWeek:' =
(SELECT count(S4error.Logcode) FROM GADATA.ABB.S4error WHERE (Robotname = @Robot AND [timestamp] BETWEEN getdate()-7 AND getdate()) AND S4error.logcode = @Errcode)

,'Count LastMonth:' =
(SELECT count(S4error.Logcode) FROM GADATA.ABB.S4error WHERE (Robotname = @Robot AND [timestamp] BETWEEN getdate()-31 AND getdate()) AND S4error.logcode = @Errcode)

,'Count ALL:' =
(SELECT count(S4error.Logcode) FROM GADATA.ABB.S4error WHERE Robotname = @Robot  AND S4error.logcode = @Errcode)

,'First Time:' =
(SELECT top 1 CONVERT(char(19),S4error.[timestamp], 120)  FROM GADATA.ABB.S4error WHERE (Robotname = @Robot AND S4error.logcode = @Errcode) order by S4error.[timestamp] ASC)

,'Last Time:' = 
(SELECT top 1 CONVERT(char(19),S4error.[timestamp], 120)  FROM GADATA.ABB.S4error WHERE (Robotname = @Robot AND S4error.logcode = @Errcode) order by S4error.[timestamp] DESC)
END

END