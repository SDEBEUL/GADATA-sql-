CREATE TABLE [dbo].[raw_Ultra_IT16660_ULOGVersion] (
    [Version] INT NULL
);


GO
CREATE NONCLUSTERED INDEX [ULOGVERSION]
    ON [dbo].[raw_Ultra_IT16660_ULOGVersion]([Version] ASC);

