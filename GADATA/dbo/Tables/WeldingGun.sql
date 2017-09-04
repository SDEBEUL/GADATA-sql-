CREATE TABLE [dbo].[WeldingGun] (
    [ID]           INT        IDENTITY (1, 1) NOT NULL,
    [Name]         NCHAR (15) NULL,
    [ElectrodeNbr] TINYINT    NULL,
    [VariantID]    INT        NULL,
    [TimerID]      INT        NULL,
    CONSTRAINT [PK_WeldingGun] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_WeldingGun_Timer] FOREIGN KEY ([TimerID]) REFERENCES [dbo].[Timer] ([ID]),
    CONSTRAINT [FK_WeldingGun_WeldingGunVariant] FOREIGN KEY ([VariantID]) REFERENCES [dbo].[WeldingGunVariant] ([ID])
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_WeldingGun2]
    ON [dbo].[WeldingGun]([Name] ASC, [ID] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_WedingGun]
    ON [dbo].[WeldingGun]([Name] ASC, [ID] ASC, [ElectrodeNbr] ASC, [VariantID] ASC, [TimerID] ASC);

