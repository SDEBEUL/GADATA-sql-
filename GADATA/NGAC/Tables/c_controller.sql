CREATE TABLE [NGAC].[c_controller] (
    [id]              INT          IDENTITY (1, 1) NOT NULL,
    [controller_name] VARCHAR (30) NOT NULL,
    [assetnum]        VARCHAR (30) NULL,
    [enable_bit]      INT          NULL,
    [systemId]        VARCHAR (50) NULL,
    [ip]              VARCHAR (50) NULL,
    [class_id]        INT          NULL,
    CONSTRAINT [PK_c_controller_1] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_c_controller_c_controller_class] FOREIGN KEY ([class_id]) REFERENCES [NGAC].[c_controller_class] ([id])
);



