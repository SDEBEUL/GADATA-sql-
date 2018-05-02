CREATE TABLE [dbo].[raw_Ultra_laptop4_ULOGVersion] (
    [Version] INT NULL
);


GO
CREATE NONCLUSTERED INDEX [ULOGVERSION]
    ON [dbo].[raw_Ultra_laptop4_ULOGVersion]([Version] ASC);

