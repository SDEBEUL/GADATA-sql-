CREATE TABLE [C3G].[rt_pjv_file] (
    [id]                INT           IDENTITY (1, 1) NOT NULL,
    [_timestamp]        DATETIME      NULL,
    [c_controller_id]   INT           NULL,
    [c_pjv_action_id]   INT           NULL,
    [fileNamePC]        VARCHAR (250) NULL,
    [fileNameRobot]     VARCHAR (250) NULL,
    [fileDateTime]      DATETIME      NULL,
    [fileDateTimeRobot] VARCHAR (50)  NULL,
    [fileSize]          INT           NULL,
    [state]             INT           NULL,
    [MD5]               VARCHAR (250) NULL,
    CONSTRAINT [PK_rt_pjv_file] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_pjv_file_c_controller] FOREIGN KEY ([c_controller_id]) REFERENCES [C3G].[c_controller] ([id]),
    CONSTRAINT [FK_rt_pjv_file_c_pjv_action] FOREIGN KEY ([c_pjv_action_id]) REFERENCES [C3G].[c_pjv_action] ([id])
);

