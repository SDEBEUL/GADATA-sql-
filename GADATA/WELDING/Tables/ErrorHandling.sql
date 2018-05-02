CREATE TABLE [WELDING].[ErrorHandling] (
    [procedure]     NCHAR (50)  NULL,
    [ErrorNumber]   INT         NULL,
    [ErrorSeverity] INT         NULL,
    [ErrorState]    INT         NULL,
    [ErrorLine]     INT         NULL,
    [ErrorMessage]  NCHAR (400) NULL,
    [timestamp]     DATETIME    NULL
);

