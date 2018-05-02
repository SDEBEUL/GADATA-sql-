CREATE TABLE [NGAC].[rt_active_info] (
    [id]                    INT          IDENTITY (1, 1) NOT NULL,
    [c_controller_id]       INT          NULL,
    [h_alarm_id]            INT          NULL,
    [rt_alarm_id]           INT          NULL,
    [rt_job_id]             INT          NULL,
    [_timestamp]            DATETIME     NULL,
    [program_number]        INT          NULL,
    [body_number]           INT          NULL,
    [application_error]     INT          NULL,
    [operating_mode]        INT          NULL,
    [execution_status]      INT          NULL,
    [controller_state]      INT          NULL,
    [master_state]          INT          NULL,
    [at_home]               INT          NULL,
    [vasc_state]            INT          NULL,
    [vasc_session]          VARCHAR (20) NULL,
    [task_execution_status] INT          NULL,
    [ts_breakDownAck]       DATETIME     NULL,
    [ts_breakDownStart]     DATETIME     NULL,
    CONSTRAINT [PK_rt_active_info] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_active_info_c_controller] FOREIGN KEY ([c_controller_id]) REFERENCES [NGAC].[c_controller] ([id])
);

