CREATE TABLE [RobotGA].[RobotOLD] (
    [ID]        INT           IDENTITY (1, 1) NOT NULL,
    [RobotName] NCHAR (10)    NULL,
    [Type]      INT           NULL,
    [location]  VARCHAR (256) NULL,
    CONSTRAINT [PK_Robot] PRIMARY KEY CLUSTERED ([ID] ASC)
);

