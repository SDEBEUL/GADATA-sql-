CREATE TABLE [dbo].[Raw_Ultra_laptop6_ULOGVersion] (
    [Version] INT NULL
);


GO
CREATE NONCLUSTERED INDEX [ULOGVERSION]
    ON [dbo].[Raw_Ultra_laptop6_ULOGVersion]([Version] ASC);

