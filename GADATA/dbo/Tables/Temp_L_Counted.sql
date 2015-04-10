CREATE TABLE [dbo].[Temp_L_Counted] (
    [shift]        INT        NULL,
    [day]          INT        NULL,
    [week]         INT        NULL,
    [subgroup]     NCHAR (10) NULL,
    [appl]         NCHAR (10) NULL,
    [controllerID] INT        NOT NULL,
    [count]        INT        NULL,
    [sum]          INT        NULL
);

