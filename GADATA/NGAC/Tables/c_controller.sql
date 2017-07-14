CREATE TABLE [NGAC].[c_controller] (
    [id]              INT          IDENTITY (1, 1) NOT NULL,
    [controller_name] VARCHAR (30) NOT NULL,
    [assetnum]        VARCHAR (30) NULL,
    [enable_bit]      INT          NULL,
    CONSTRAINT [PK_c_controller_1] PRIMARY KEY CLUSTERED ([id] ASC)
);

