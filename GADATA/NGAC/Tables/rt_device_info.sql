CREATE TABLE [NGAC].[rt_device_info] (
    [id]               INT           IDENTITY (1, 1) NOT NULL,
    [c_controller_id]  INT           NULL,
    [c_device_info_id] INT           NULL,
    [_timestamp]       DATETIME      NULL,
    [value]            VARCHAR (MAX) NULL,
    CONSTRAINT [PK_rt_device_info] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_device_info_c_controller] FOREIGN KEY ([c_controller_id]) REFERENCES [NGAC].[c_controller] ([id]),
    CONSTRAINT [FK_rt_device_info_c_device_info] FOREIGN KEY ([c_device_info_id]) REFERENCES [NGAC].[c_device_info] ([id])
);




GO
CREATE NONCLUSTERED INDEX [_dta_index_rt_device_info_23_387441100__K3_K4_K2_K1_5]
    ON [NGAC].[rt_device_info]([c_device_info_id] ASC, [_timestamp] ASC, [c_controller_id] ASC, [id] ASC)
    INCLUDE([value]);


GO
CREATE STATISTICS [_dta_stat_387441100_2_3_4_1]
    ON [NGAC].[rt_device_info]([c_controller_id], [c_device_info_id], [_timestamp], [id]);


GO
CREATE STATISTICS [_dta_stat_387441100_4_1_2]
    ON [NGAC].[rt_device_info]([_timestamp], [id], [c_controller_id]);


GO
CREATE STATISTICS [_dta_stat_387441100_2_4]
    ON [NGAC].[rt_device_info]([c_controller_id], [_timestamp]);


GO
CREATE STATISTICS [_dta_stat_387441100_4_3]
    ON [NGAC].[rt_device_info]([_timestamp], [c_device_info_id]);

