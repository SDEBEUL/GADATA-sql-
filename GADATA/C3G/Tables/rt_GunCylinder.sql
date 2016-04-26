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





