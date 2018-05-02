CREATE TABLE [dbo].[raw_Ultra_laptop5_ULOGVersion] (
    [Version] INT NULL
);


GO
CREATE NONCLUSTERED INDEX [ULOGVERSION]
    ON [dbo].[raw_Ultra_laptop5_ULOGVersion]([Version] ASC);

