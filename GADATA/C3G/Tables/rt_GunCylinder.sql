CREATE TABLE [C3G].[rt_GunCylinder] (
    [id]            INT            IDENTITY (1, 1) NOT NULL,
    [controller_id] INT            NULL,
    [_timestamp]    DATETIME       NULL,
    [value]         VARCHAR (2048) NULL,
    [variable_id]   INT            NULL,
    [CloseToSemi]   INT            NULL,
    [SemiToOpen]    INT            NULL,
    [Tool_id]       TINYINT        NULL,
    CONSTRAINT [PK_rt_GunCylinder] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_GunCylinder_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [C3G].[c_controller] ([id])
);


GO
CREATE NONCLUSTERED INDEX [nci_controller_id_variable_id__timestamp]
    ON [C3G].[rt_GunCylinder]([controller_id] ASC, [variable_id] ASC, [_timestamp] ASC)
    INCLUDE([CloseToSemi], [SemiToOpen], [Tool_id], [value]);


GO
CREATE NONCLUSTERED INDEX [NCI_controller_id_value_Tool_id]
    ON [C3G].[rt_GunCylinder]([variable_id] ASC, [_timestamp] ASC)
    INCLUDE([controller_id], [Tool_id], [value]);

