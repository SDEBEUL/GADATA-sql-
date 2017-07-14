CREATE TABLE [Volvo].[hShiftbook] (
    [id]                  BIGINT         IDENTITY (1, 1) NOT NULL,
    [controller_type]     VARCHAR (5)    NULL,
    [controller_id]       INT            NULL,
    [Breakdown_id]        INT            NULL,
    [ci]                  INT            NULL,
    [wo]                  INT            NULL,
    [State]               VARCHAR (15)   NULL,
    [userDescription]     VARCHAR (400)  NULL,
    [userComment]         VARCHAR (MAX)  NULL,
    [ReportUser]          VARCHAR (100)  NULL,
    [Report_timestamp]    DATETIME       NULL,
    [State_history]       VARCHAR (4000) NULL,
    [updateTimestamp]     DATETIME       NULL,
    [IndependantLocation] VARCHAR (50)   NULL,
    [AcceptUser]          VARCHAR (100)  NULL,
    CONSTRAINT [PK_Shiftbook2] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [_dta_index_hShiftbook_23_1156823829__K1_K2_K7_K13_K3_6_8_9_10_14_15]
    ON [Volvo].[hShiftbook]([id] ASC, [controller_type] ASC, [State] ASC, [updateTimestamp] ASC, [controller_id] ASC)
    INCLUDE([AcceptUser], [IndependantLocation], [ReportUser], [userComment], [userDescription], [wo]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_hShiftbook_23_1156823829__K7_K3_K2_K13_K1_8_10_14_15]
    ON [Volvo].[hShiftbook]([State] ASC, [controller_id] ASC, [controller_type] ASC, [updateTimestamp] ASC, [id] ASC)
    INCLUDE([AcceptUser], [userDescription], [IndependantLocation], [ReportUser]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_hShiftbook_23_1156823829__K13_K3_K2_K7_K1_8_10_14_15]
    ON [Volvo].[hShiftbook]([updateTimestamp] ASC, [controller_id] ASC, [controller_type] ASC, [State] ASC, [id] ASC)
    INCLUDE([AcceptUser], [IndependantLocation], [ReportUser], [userDescription]);


GO
CREATE STATISTICS [_dta_stat_1156823829_3_2_1_7]
    ON [Volvo].[hShiftbook]([controller_id], [controller_type], [id], [State]);


GO
CREATE STATISTICS [_dta_stat_1156823829_1_2_7_13]
    ON [Volvo].[hShiftbook]([id], [controller_type], [State], [updateTimestamp]);


GO
CREATE STATISTICS [_dta_stat_1156823829_7_13_3]
    ON [Volvo].[hShiftbook]([State], [updateTimestamp], [controller_id]);


GO
CREATE STATISTICS [_dta_stat_1156823829_2_7_13]
    ON [Volvo].[hShiftbook]([controller_type], [State], [updateTimestamp]);


GO
CREATE STATISTICS [_dta_stat_1156823829_3_13_2_7_1]
    ON [Volvo].[hShiftbook]([controller_id], [updateTimestamp], [controller_type], [State], [id]);


GO
CREATE STATISTICS [_dta_stat_1156823829_13_2_3_1]
    ON [Volvo].[hShiftbook]([updateTimestamp], [controller_type], [controller_id], [id]);


GO
CREATE STATISTICS [_dta_stat_1156823829_1_13_2]
    ON [Volvo].[hShiftbook]([id], [updateTimestamp], [controller_type]);


GO
CREATE STATISTICS [_dta_stat_1156823829_3_2]
    ON [Volvo].[hShiftbook]([controller_id], [controller_type]);

