﻿CREATE TABLE [dbo].[raw_Ultra_laptop2_ULOGVersion] (
    [Version] INT NULL
);


GO
CREATE NONCLUSTERED INDEX [ULOGVERSION]
    ON [dbo].[raw_Ultra_laptop2_ULOGVersion]([Version] ASC);

