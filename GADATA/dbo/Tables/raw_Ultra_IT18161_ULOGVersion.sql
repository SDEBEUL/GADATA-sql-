CREATE TABLE [dbo].[raw_Ultra_IT18161_ULOGVersion] (
    [Version] INT NULL
);


GO
CREATE NONCLUSTERED INDEX [ULOGVERSION]
    ON [dbo].[raw_Ultra_IT18161_ULOGVersion]([Version] ASC);

