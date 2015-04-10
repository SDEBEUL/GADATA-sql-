CREATE TABLE [RobotGA].[FaultInfoVolvo] (
    [ID]          INT            IDENTITY (1, 1) NOT NULL,
    [FaultInfoId] INT            NOT NULL,
    [VolvoInfo]   VARCHAR (2500) NOT NULL,
    CONSTRAINT [PK_FaultInfoVolvo] PRIMARY KEY CLUSTERED ([ID] ASC)
);

