CREATE TABLE [Volvo].[L_timeline] (
    [starttime]    DATETIME    NULL,
    [endtime]      DATETIME    NULL,
    [shiftlength]  DATETIME    NULL,
    [Vyear]        INT         NULL,
    [Vweek]        INT         NULL,
    [Vday]         INT         NULL,
    [shift]        VARCHAR (2) NULL,
    [Noproduction] BIT         NULL,
    [PLOEG]        VARCHAR (2) NOT NULL,
    [id]           INT         IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_L_timeline] PRIMARY KEY CLUSTERED ([id] ASC)
);








GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_Time2]
    ON [Volvo].[L_timeline]([starttime] ASC, [endtime] ASC, [Vyear] ASC, [Vweek] ASC, [Vday] ASC, [PLOEG] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_Time]
    ON [Volvo].[L_timeline]([starttime] ASC, [endtime] ASC, [Vyear] ASC, [Vweek] ASC, [Vday] ASC, [shift] ASC);

