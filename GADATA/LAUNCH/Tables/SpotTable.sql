CREATE TABLE [LAUNCH].[SpotTable] (
    [ID]          INT      IDENTITY (1, 1) NOT NULL,
    [NptID]       INT      NOT NULL,
    [TimerID]     INT      NOT NULL,
    [SpotName]    INT      NOT NULL,
    [WeldProgram] SMALLINT NOT NULL,
    CONSTRAINT [PK_SpotTable] PRIMARY KEY CLUSTERED ([ID] ASC)
);

