CREATE TABLE [dbo].[c_logtekst] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [error_number]   INT           NULL,
    [error_severity] INT           NULL,
    [error_text]     VARCHAR (256) NULL,
    CONSTRAINT [PK_c_logtekst] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IndexTableUniqueRows]
    ON [dbo].[c_logtekst]([error_text] ASC) WITH (IGNORE_DUP_KEY = ON);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'contains all posible logtekst for vcsc', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'c_logtekst';

