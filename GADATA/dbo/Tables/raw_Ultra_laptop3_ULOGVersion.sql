CREATE TABLE [dbo].[raw_Ultra_laptop3_ULOGVersion] (
    [Version] INT NULL
);


GO
CREATE NONCLUSTERED INDEX [ULOGVERSION]
    ON [dbo].[raw_Ultra_laptop3_ULOGVersion]([Version] ASC);

