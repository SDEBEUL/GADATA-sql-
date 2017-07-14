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
CREATE NONCLUSTERED INDEX [_dta_index_L_timeline_23_2095203110__K1_K2_K10_K4_K5_K6_K7_K9]
    ON [Volvo].[L_timeline]([starttime] ASC, [endtime] ASC, [id] ASC, [Vyear] ASC, [Vweek] ASC, [Vday] ASC, [shift] ASC, [PLOEG] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_Time2]
    ON [Volvo].[L_timeline]([starttime] ASC, [endtime] ASC, [Vyear] ASC, [Vweek] ASC, [Vday] ASC, [PLOEG] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_Time]
    ON [Volvo].[L_timeline]([starttime] ASC, [endtime] ASC, [Vyear] ASC, [Vweek] ASC, [Vday] ASC, [shift] ASC);


GO
CREATE STATISTICS [_dta_stat_2095203110_1_7_4_5]
    ON [Volvo].[L_timeline]([starttime], [shift], [Vyear], [Vweek]);


GO
CREATE STATISTICS [_dta_stat_2095203110_4_5_6_9]
    ON [Volvo].[L_timeline]([Vyear], [Vweek], [Vday], [PLOEG]);


GO
CREATE STATISTICS [_dta_stat_2095203110_10_1_2_4_5_6_7_9]
    ON [Volvo].[L_timeline]([id], [starttime], [endtime], [Vyear], [Vweek], [Vday], [shift], [PLOEG]);


GO
CREATE STATISTICS [_dta_stat_2095203110_1_2_4_5_6_7_9]
    ON [Volvo].[L_timeline]([starttime], [endtime], [Vyear], [Vweek], [Vday], [shift], [PLOEG]);


GO
CREATE STATISTICS [_dta_stat_2095203110_1_4_5_6_7_9]
    ON [Volvo].[L_timeline]([starttime], [Vyear], [Vweek], [Vday], [shift], [PLOEG]);


GO
CREATE STATISTICS [_dta_stat_2095203110_1_10_4_5_6_7]
    ON [Volvo].[L_timeline]([starttime], [id], [Vyear], [Vweek], [Vday], [shift]);

