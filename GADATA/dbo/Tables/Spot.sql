CREATE TABLE [dbo].[Spot] (
    [ID]                  INT        IDENTITY (1, 1) NOT NULL,
    [Number]              INT        NULL,
    [Zone]                TINYINT    CONSTRAINT [DF_Spot_Zone] DEFAULT ((0)) NULL,
    [Comment1]            NCHAR (25) NULL,
    [Comment2]            NCHAR (25) NULL,
    [Comment3]            NCHAR (25) NULL,
    [PlateCombinationtId] INT        CONSTRAINT [DF_Spot_PlateCombinationtId] DEFAULT ((0)) NOT NULL,
    [Program]             TINYINT    CONSTRAINT [DF_Spot_Program] DEFAULT ((0)) NOT NULL,
    [TimerID]             INT        CONSTRAINT [DF_Spot_TimerID] DEFAULT ((0)) NOT NULL,
    [ElectrodeDia]        TINYINT    CONSTRAINT [DF_Spot_ElectrodeDia] DEFAULT ((0)) NOT NULL,
    [AlternativeNumber]   NCHAR (25) NULL,
    [Model]               NCHAR (10) NULL,
    [Variant]             NCHAR (50) NULL,
    [JobCode]             INT        NULL,
    CONSTRAINT [PK_Spot] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_Spot_PlateCombinations] FOREIGN KEY ([PlateCombinationtId]) REFERENCES [dbo].[PlateCombinations] ([ID]),
    CONSTRAINT [FK_Spot_Timer] FOREIGN KEY ([TimerID]) REFERENCES [dbo].[Timer] ([ID])
);


GO
ALTER TABLE [dbo].[Spot] NOCHECK CONSTRAINT [FK_Spot_PlateCombinations];




GO
ALTER TABLE [dbo].[Spot] NOCHECK CONSTRAINT [FK_Spot_PlateCombinations];




GO
ALTER TABLE [dbo].[Spot] NOCHECK CONSTRAINT [FK_Spot_PlateCombinations];




GO
ALTER TABLE [dbo].[Spot] NOCHECK CONSTRAINT [FK_Spot_PlateCombinations];




GO
CREATE NONCLUSTERED INDEX [IUX_spotid]
    ON [dbo].[Spot]([Number] ASC)
    INCLUDE([ID]);

