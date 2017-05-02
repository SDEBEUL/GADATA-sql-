CREATE TABLE [Volvo].[L_liveView] (
    [Location]  VARCHAR (256) NULL,
    [Robot]     VARCHAR (50)  NULL,
    [Type]      VARCHAR (32)  NULL,
    [Errortype] VARCHAR (4)   NOT NULL,
    [Timestamp] CHAR (19)     NULL,
    [Logcode]   INT           NULL,
    [Severity]  INT           NOT NULL,
    [Logtekst]  VARCHAR (301) NULL,
    [DT]        INT           NULL,
    [Year]      INT           NULL,
    [Week]      INT           NULL,
    [day]       INT           NULL,
    [Shift]     INT           NULL,
    [Object]    VARCHAR (25)  NULL,
    [Subgroup]  VARCHAR (25)  NULL,
    [id]        INT           NULL
);






GO
CREATE NONCLUSTERED INDEX [_dta_index_L_liveView_23_615581877__K2_K4_K8_K9_K10_K11_K12_K13_K14_K15_5_16]
    ON [Volvo].[L_liveView]([Robot] ASC, [Errortype] ASC, [Logtekst] ASC, [DT] ASC, [Year] ASC, [Week] ASC, [day] ASC, [Shift] ASC, [Object] ASC, [Subgroup] ASC)
    INCLUDE([id], [Timestamp]);


GO
CREATE STATISTICS [_dta_stat_615581877_2_10_11_12_8_15_4_9_13_14]
    ON [Volvo].[L_liveView]([Robot], [Year], [Week], [day], [Logtekst], [Subgroup], [Errortype], [DT], [Shift], [Object]);

