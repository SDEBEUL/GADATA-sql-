CREATE TABLE [WELDING].[FactoryActualSpotList] (
    [ID]          INT        IDENTITY (1, 1) NOT NULL,
    [TimerName]   NCHAR (15) NULL,
    [SpotName]    INT        NULL,
    [WeldProgram] INT        NULL,
    CONSTRAINT [PK_FactoryActualSpotList] PRIMARY KEY CLUSTERED ([ID] ASC)
);

