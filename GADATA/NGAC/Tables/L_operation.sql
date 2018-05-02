CREATE TABLE [NGAC].[L_operation] (
    [ID]            INT           IDENTITY (1, 1) NOT NULL,
    [_timestamp]    DATETIME      NULL,
    [code]          INT           NULL,
    [Vasc_name]     VARCHAR (50)  NULL,
    [controller_id] INT           NULL,
    [Description]   VARCHAR (250) NULL,
    CONSTRAINT [PK_L_operation] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_L_operation_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [NGAC].[c_controller] ([id])
);



