CREATE TABLE [dbo].[raw_Ultra_IT16668_ULOGVersion] (
    [Version] INT NULL
);


GO
CREATE NONCLUSTERED INDEX [ULOGVERSION]
    ON [dbo].[raw_Ultra_IT16668_ULOGVersion]([Version] ASC);

