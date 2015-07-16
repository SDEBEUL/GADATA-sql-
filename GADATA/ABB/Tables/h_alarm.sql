CREATE TABLE [ABB].[h_alarm] (
    [id]             INT          IDENTITY (1, 1) NOT NULL,
    [controller_id]  INT          NULL,
    [_timestamp]     DATETIME     NULL,
    [wi_timestamp]   VARCHAR (50) NULL,
    [wd_timestamp]   DATETIME     NULL,
    [error_is_alarm] BIT          NULL,
    [error_id]       INT          NULL,
    [cause_id]       INT          NULL,
    [remedy_id]      INT          NULL,
    [restart_id]     INT          NULL,
    CONSTRAINT [PK_h_alarm] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_h_alarm_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [ABB].[c_controller] ([id]),
    CONSTRAINT [FK_h_alarm_L_Cause] FOREIGN KEY ([cause_id]) REFERENCES [ABB].[L_Cause] ([id]),
    CONSTRAINT [FK_h_alarm_L_error] FOREIGN KEY ([error_id]) REFERENCES [ABB].[L_error] ([id]),
    CONSTRAINT [FK_h_alarm_L_Remedy] FOREIGN KEY ([remedy_id]) REFERENCES [ABB].[L_Remedy] ([id])
);








GO
CREATE NONCLUSTERED INDEX [NCI_Timestamp]
    ON [ABB].[h_alarm]([_timestamp] ASC, [error_id] ASC, [controller_id] ASC, [wd_timestamp] ASC);

