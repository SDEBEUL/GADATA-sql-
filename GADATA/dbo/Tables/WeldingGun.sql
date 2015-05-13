CREATE TABLE [dbo].[WeldingGun] (
    [ID]           INT        IDENTITY (1, 1) NOT NULL,
    [Name]         NCHAR (10) NULL,
    [ElectrodeNbr] TINYINT    NULL,
    [VariantID]    INT        NULL,
    [TimerID]      INT        NULL,
    CONSTRAINT [PK_WeldingGun] PRIMARY KEY CLUSTERED ([ID] ASC)
);

