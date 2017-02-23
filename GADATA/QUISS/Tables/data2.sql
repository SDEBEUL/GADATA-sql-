CREATE TABLE [QUISS].[data2] (
    [DateTime]      DATETIME      NOT NULL,
    [Controller]    VARCHAR (250) NULL,
    [Stuk]          VARCHAR (250) NULL,
    [foutdirectory] VARCHAR (250) NULL,
    [fouttoestand]  INT           NULL,
    [bodynummer]    INT           NULL,
    [ID]            INT           IDENTITY (1, 1) NOT NULL
);

