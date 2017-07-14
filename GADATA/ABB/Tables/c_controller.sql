CREATE TABLE [ABB].[c_controller] (
    [id]                INT           IDENTITY (1, 1) NOT NULL,
    [controller_name]   VARCHAR (50)  NULL,
    [sys_id]            VARCHAR (20)  NULL,
    [location]          VARCHAR (256) NULL,
    [ipaddress]         VARCHAR (32)  NULL,
    [Type]              VARCHAR (32)  NULL,
    [password]          VARCHAR (32)  NULL,
    [reconnect]         BIT           NULL,
    [log_flag]          INT           NULL,
    [enable_bit]        INT           NULL,
    [variable_mask]     INT           NULL,
    [error_no_log_mask] INT           NULL,
    [A_Fronius]         BIT           NULL,
    [A_Arictiec]        BIT           NULL,
    [A_Nutrunner]       BIT           NULL,
    [A_Hand]            BIT           NULL,
    [A_Laser]           BIT           NULL,
    [A_Brazing]         BIT           NULL,
    [A_Hemming]         BIT           NULL,
    [A_Preceptron]      BIT           NULL,
    [A_Visdelta]        BIT           NULL,
    [A_Edixia]          BIT           NULL,
    [ownership]         VARCHAR (256) NULL,
    CONSTRAINT [PK_c_controller] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_Type]
    ON [ABB].[c_controller]([id] ASC, [Type] ASC, [controller_name] ASC, [location] ASC);

