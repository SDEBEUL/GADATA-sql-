CREATE TABLE [dbo].[Shift] (
    [ID]         INT       IDENTITY (1, 1) NOT NULL,
    [Regime]     TINYINT   NULL,
    [Name]       NCHAR (1) NULL,
    [ActiveYear] SMALLINT  NULL,
    [EvenWeek]   BIT       NULL,
    CONSTRAINT [PK_Shift] PRIMARY KEY CLUSTERED ([ID] ASC)
);

