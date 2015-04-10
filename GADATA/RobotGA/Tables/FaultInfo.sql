CREATE TABLE [RobotGA].[FaultInfo] (
    [ID]            INT            IDENTITY (1, 1) NOT NULL,
    [RobotTypeId]   INT            NOT NULL,
    [ErrorNbr]      INT            NOT NULL,
    [ErrorSeverity] TINYINT        NOT NULL,
    [Info]          VARCHAR (2500) NOT NULL,
    [Cause]         VARCHAR (2500) NOT NULL,
    [Remedy]        VARCHAR (2500) NOT NULL,
    CONSTRAINT [PK_FaultInfo] PRIMARY KEY CLUSTERED ([ID] ASC)
);

