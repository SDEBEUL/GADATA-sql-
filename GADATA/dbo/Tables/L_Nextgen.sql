CREATE TABLE [dbo].[L_Nextgen] (
    [shift]           INT              NULL,
    [day]             INT              NULL,
    [week]            INT              NULL,
    [Year]            INT              NULL,
    [subgroup]        NCHAR (10)       NULL,
    [appl]            NCHAR (10)       NULL,
    [controller_name] VARCHAR (50)     NULL,
    [cnBD]            INT              NULL,
    [tDT]             INT              NOT NULL,
    [GTotalDT]        INT              NULL,
    [GTotalnDB]       INT              NULL,
    [GTotalnShift]    INT              NULL,
    [AVG]             NUMERIC (28, 15) NULL
);

