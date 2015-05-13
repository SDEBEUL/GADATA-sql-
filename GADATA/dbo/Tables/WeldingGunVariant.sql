CREATE TABLE [dbo].[WeldingGunVariant] (
    [ID]      INT        IDENTITY (1, 1) NOT NULL,
    [Name]    NCHAR (13) NULL,
    [X]       REAL       NULL,
    [Y]       REAL       NULL,
    [Z]       REAL       NULL,
    [Remark1] NTEXT      NULL,
    [Remark2] NTEXT      NULL,
    CONSTRAINT [PK_WeldingGunVariant] PRIMARY KEY CLUSTERED ([ID] ASC)
);

