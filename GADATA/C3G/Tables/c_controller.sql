﻿CREATE TABLE [C3G].[c_controller] (
    [id]                    INT           IDENTITY (1, 1) NOT NULL,
    [controller_name]       VARCHAR (50)  NULL,
    [sys_id]                VARCHAR (20)  NULL,
    [location]              VARCHAR (256) NULL,
    [ipaddress]             VARCHAR (32)  NULL,
    [username]              VARCHAR (32)  NULL,
    [password]              VARCHAR (32)  NULL,
    [reconnect]             BIT           NULL,
    [log_flag]              INT           NULL,
    [enable_bit]            INT           NULL,
    [variable_mask]         INT           NULL,
    [statement_mask]        INT           NULL,
    [error_no_log_mask]     INT           NULL,
    [alarm_monitor]         BIT           NULL,
    [state_monitor]         INT           NULL,
    [state_filter]          INT           NULL,
    [poll_rate]             INT           NULL,
    [poll_not_saved]        BIT           NULL,
    [poll_error_file_list]  BIT           NULL,
    [poll_action_file_list] BIT           NULL,
    [read_sys]              INT           NULL,
    [generation]            INT           NULL,
    [ownership]             VARCHAR (256) NULL,
    CONSTRAINT [PK_c_controller] PRIMARY KEY CLUSTERED ([id] ASC)
);



