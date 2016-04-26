CREATE TABLE [C4G].[c_error_text] (
    [code]     INT           NULL,
    [severity] INT           NULL,
    [args]     INT           NULL,
    [lang]     INT           NULL,
    [text]     VARCHAR (512) NULL,
    [cause]    VARCHAR (768) NULL,
    [remedy]   VARCHAR (512) NULL
);

