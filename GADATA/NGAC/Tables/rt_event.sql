CREATE TABLE [NGAC].[rt_event] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [event_enum]      INT           NULL,
    [c_controller_id] INT           NULL,
    [_timestamp]      DATETIME      NULL,
    [abbDateTime]     DATETIME      NULL,
    [description]     VARCHAR (MAX) NULL,
    [isEvent]         BIT           NULL,
    [event_value]     INT           NULL,
    CONSTRAINT [PK_rt_event_1] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_event_c_controller] FOREIGN KEY ([c_controller_id]) REFERENCES [NGAC].[c_controller] ([id])
);



