﻿CREATE TABLE [dbo].[raw_Ultra_laptop7_ULOGVersion] (
    [Version] INT NULL
);


GO
CREATE NONCLUSTERED INDEX [ULOGVERSION]
    ON [dbo].[raw_Ultra_laptop7_ULOGVersion]([Version] ASC);

