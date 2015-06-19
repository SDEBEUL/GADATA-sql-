CREATE TABLE [Volvo].[Ploeg] (
    [ID]         INT       IDENTITY (1, 1) NOT NULL,
    [Ploeg]      NCHAR (1) NULL,
    [ActiveYear] SMALLINT  NULL,
    [EvenWeek]   BIT       NULL,
    CONSTRAINT [PK_Shift] PRIMARY KEY CLUSTERED ([ID] ASC)
);

