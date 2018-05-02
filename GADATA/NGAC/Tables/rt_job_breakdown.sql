CREATE TABLE [NGAC].[rt_job_breakdown] (
    [id]                 INT          IDENTITY (1, 1) NOT NULL,
    [rt_job_active_id]   INT          NULL,
    [h_alarm_id]         INT          NULL,
    [ts_breakdownStart]  DATETIME     NULL,
    [ts_breakdownEnd]    DATETIME     NULL,
    [ts_breakdownAck]    DATETIME     NULL,
    [ev_breakdownStart]  INT          NULL,
    [val_breakdownStart] INT          NULL,
    [programPointer]     INT          NULL,
    [motionPointer]      INT          NULL,
    [ev_breakdownAck]    INT          NULL,
    [val_breakdownAck]   INT          NULL,
    [index]              VARCHAR (50) NULL,
    [phase1]             VARCHAR (50) NULL,
    [phase2]             VARCHAR (50) NULL,
    [phase3]             VARCHAR (50) NULL,
    [phase4]             VARCHAR (50) NULL,
    [phase5]             VARCHAR (50) NULL,
    [phase6]             VARCHAR (50) NULL,
    [phase7]             VARCHAR (50) NULL,
    [phase8]             VARCHAR (50) NULL,
    [rt_alarm_id]        INT          NULL,
    CONSTRAINT [PK_rt_job_breakdown] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_job_breakdown_h_alarm] FOREIGN KEY ([h_alarm_id]) REFERENCES [NGAC].[h_alarm] ([id]),
    CONSTRAINT [FK_rt_job_breakdown_rt_alarm] FOREIGN KEY ([rt_alarm_id]) REFERENCES [NGAC].[rt_alarm] ([id]),
    CONSTRAINT [FK_rt_job_breakdown_rt_job] FOREIGN KEY ([rt_job_active_id]) REFERENCES [NGAC].[rt_job] ([id])
);


GO
CREATE NONCLUSTERED INDEX [ngac_rtjb_activeJob]
    ON [NGAC].[rt_job_breakdown]([rt_job_active_id] ASC, [index] ASC)
    INCLUDE([h_alarm_id]);


GO
CREATE NONCLUSTERED INDEX [ngac_rtjb_h_alarm]
    ON [NGAC].[rt_job_breakdown]([index] ASC)
    INCLUDE([rt_job_active_id], [h_alarm_id]);

