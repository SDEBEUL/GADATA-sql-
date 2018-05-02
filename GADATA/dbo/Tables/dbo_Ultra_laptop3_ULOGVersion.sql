CREATE TABLE [dbo].[dbo_Ultra_laptop3_ULOGVersion] (
    [Version] INT NULL
);


GO
CREATE NONCLUSTERED INDEX [ULOGVERSION]
    ON [dbo].[dbo_Ultra_laptop3_ULOGVersion]([Version] ASC);

