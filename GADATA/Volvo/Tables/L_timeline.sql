CREATE TABLE [Volvo].[L_timeline] (
    [starttime]    DATETIME    NULL,
    [endtime]      DATETIME    NULL,
    [shiftlength]  DATETIME    NULL,
    [Vyear]        INT         NULL,
    [Vweek]        INT         NULL,
    [Vday]         INT         NULL,
    [shift]        VARCHAR (2) NULL,
    [Noproduction] BIT         NULL,
    [PLOEG]        VARCHAR (2) NOT NULL
);



