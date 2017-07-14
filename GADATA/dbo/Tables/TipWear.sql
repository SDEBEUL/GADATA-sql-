CREATE TABLE [dbo].[TipWear] (
    [WeldingGunId]      INT           NULL,
    [Date_Time]         SMALLDATETIME NULL,
    [BodysPerElectrode] SMALLINT      NULL,
    [BodyRemaining]     SMALLINT      NULL,
    [ID]                INT           IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_TipWear] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_TipWear_WeldingGun] FOREIGN KEY ([WeldingGunId]) REFERENCES [dbo].[WeldingGun] ([ID])
);

