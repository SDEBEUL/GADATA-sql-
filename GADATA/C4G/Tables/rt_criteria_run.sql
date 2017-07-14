CREATE TABLE [C4G].[rt_criteria_run] (
    [id]                  INT      IDENTITY (1, 1) NOT NULL,
    [_timestamp]          DATETIME NULL,
    [triggered_status]    INT      NULL,
    [c_criteria_teach_id] INT      NULL,
    [measured_if1]        REAL     NULL,
    [measured_if2]        REAL     NULL,
    [measured_if3]        REAL     NULL,
    [measured_when1]      REAL     NULL,
    [measured_when2]      REAL     NULL,
    [measured_when3]      REAL     NULL,
    [rt_rec_group_id]     INT      NULL,
    [cond_if1]            INT      NULL,
    [cond_if2]            INT      NULL,
    [cond_if3]            INT      NULL,
    [cond_when1]          INT      NULL,
    [cond_when2]          INT      NULL,
    [cond_when3]          INT      NULL,
    [keycode]             INT      NULL,
    CONSTRAINT [PK_rt_criteria_run] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_criteria_run_c_criteria_teach_id] FOREIGN KEY ([c_criteria_teach_id]) REFERENCES [C4G].[c_criteria_teach] ([id]),
    CONSTRAINT [FK_rt_criteria_run_rt_rec_group] FOREIGN KEY ([rt_rec_group_id]) REFERENCES [C4G].[rt_rec_group] ([id])
);

