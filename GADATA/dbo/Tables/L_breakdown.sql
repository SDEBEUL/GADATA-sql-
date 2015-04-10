CREATE TABLE [dbo].[L_breakdown] (
    [controller_id]    INT           NULL,
    [EndOfBreakdown]   DATETIME      NULL,
    [StartOfBreakdown] DATETIME      NULL,
    [error_number]     INT           NULL,
    [error_text]       VARCHAR (256) NULL,
    [idx]              INT           NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IndexTableUniqueRows]
    ON [dbo].[L_breakdown]([idx] ASC) WITH (IGNORE_DUP_KEY = ON);

