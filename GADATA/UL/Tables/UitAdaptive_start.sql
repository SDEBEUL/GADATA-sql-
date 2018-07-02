CREATE TABLE [UL].[UitAdaptive_start] (
    [id]             INT        IDENTITY (1, 1) NOT NULL,
    [SpotID]         INT        NOT NULL,
    [TimerID]        INT        NOT NULL,
    [StatusAdaptive] NCHAR (20) NOT NULL,
    [DurationOFF]    TIME (7)   NULL,
    [starttime]      DATETIME   NULL,
    CONSTRAINT [PK_UitAdaptive_start] PRIMARY KEY CLUSTERED ([id] ASC)
);

