CREATE TABLE [C4G].[rt_act_ipcb] (
    [id]             INT          NULL,
    [rt_act_prog_id] INT          NULL,
    [prog_sts]       INT          NULL,
    [exec_line]      INT          NULL,
    [exec_progrqm]   VARCHAR (50) NULL,
    [motion_line]    INT          NULL,
    [motion_program] VARCHAR (50) NULL,
    [_timestamp]     DATETIME     NULL,
    [rt_alarm_id]    INT          NULL
);

