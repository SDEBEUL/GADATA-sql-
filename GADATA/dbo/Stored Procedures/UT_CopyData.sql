CREATE PROC UT_CopyData AS 
SET IDENTITY_INSERT Robot ON

INSERT INTO Robot (ID, RobotName, Type, Subtype, ControllerVersion, TimeOffset) SELECT * FROM TemporaryUpsizedTable2

SET IDENTITY_INSERT Robot OFF