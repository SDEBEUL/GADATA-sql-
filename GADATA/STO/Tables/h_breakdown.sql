CREATE TABLE [STO].[h_breakdown] (
    [id]              INT      IDENTITY (1, 1) NOT NULL,
    [ALARMTIMESTAMP]  DATETIME NULL,
    [_timestamp]      DATETIME NULL,
    [c_controller_id] INT      NOT NULL,
    [l_error_id]      INT      NOT NULL,
    [RESETTIMESTAMP]  DATETIME NULL,
    CONSTRAINT [PK_h_breakdown] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_h_breakdown_c_controller] FOREIGN KEY ([c_controller_id]) REFERENCES [STO].[c_controller] ([id]),
    CONSTRAINT [FK_h_breakdown_l_error] FOREIGN KEY ([l_error_id]) REFERENCES [STO].[l_error] ([id])
);


GO
CREATE NONCLUSTERED INDEX [NCI STO h_breakdown]
    ON [STO].[h_breakdown]([c_controller_id] ASC, [ALARMTIMESTAMP] ASC)
    INCLUDE([id], [l_error_id]);


GO
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
    ON [STO].[h_breakdown]([ALARMTIMESTAMP] ASC)
    INCLUDE([id], [c_controller_id], [l_error_id]);

