CREATE TABLE [WELDING].[QisControlParameters] (
    [id]               INT        IDENTITY (1, 1) NOT NULL,
    [Parameter_ID]     INT        NULL,
    [Value]            INT        NULL,
    [minValue]         INT        NULL,
    [MaxValue]         INT        NULL,
    [parameterName]    NCHAR (50) NULL,
    [MidairMinRange]   INT        NULL,
    [MidairMaxRange]   INT        NULL,
    [MidairParameter]  BIT        NULL,
    [GeneralParameter] BIT        NULL
);

