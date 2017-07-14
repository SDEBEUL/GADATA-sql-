CREATE TABLE [dbo].[TimerParameterName] (
    [ID]              INT         IDENTITY (1, 1) NOT NULL,
    [Name]            NCHAR (64)  NOT NULL,
    [LocalDbID]       INT         NULL,
    [Description]     NCHAR (150) NULL,
    [IsElectrodeData] BIT         NULL,
    CONSTRAINT [PK_TimerParameterName] PRIMARY KEY CLUSTERED ([ID] ASC)
);

