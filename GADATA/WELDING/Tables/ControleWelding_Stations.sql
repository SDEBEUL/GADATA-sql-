CREATE TABLE [WELDING].[ControleWelding_Stations] (
    [TimerID]          INT        NOT NULL,
    [timelineID]       INT        NOT NULL,
    [Vyear]            INT        NOT NULL,
    [Vweek]            INT        NOT NULL,
    [Vday]             INT        NOT NULL,
    [shift]            INT        NOT NULL,
    [countjobs]        INT        NULL,
    [SUMWelds]         INT        NULL,
    [ratio]            INT        NULL,
    [Checkweldprocess] NCHAR (25) NOT NULL
);

