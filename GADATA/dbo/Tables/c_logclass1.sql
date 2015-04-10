CREATE TABLE [dbo].[c_logclass1] (
    [APPL]            NCHAR (10) NULL,
    [Subgroup]        NCHAR (10) NULL,
    [error_codeStart] INT        NULL,
    [error_codeEnd]   INT        NULL,
    [error_tekst]     NCHAR (50) NULL,
    [id]              INT        IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_C_logclass1] PRIMARY KEY CLUSTERED ([id] ASC)
);

