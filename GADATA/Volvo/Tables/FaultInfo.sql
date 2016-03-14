CREATE TABLE [Volvo].[FaultInfo] (
    [ID]            INT            NOT NULL,
    [RobotTypeId]   INT            NOT NULL,
    [ErrorNbr]      INT            NOT NULL,
    [ErrorSeverity] TINYINT        NOT NULL,
    [Info]          VARCHAR (2500) NOT NULL,
    [Cause]         VARCHAR (2500) NOT NULL,
    [Remedy]        VARCHAR (2500) NOT NULL
);

