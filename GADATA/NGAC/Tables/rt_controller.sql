CREATE TABLE [NGAC].[rt_controller] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [c_controller_id] INT           NOT NULL,
    [Availability]    VARCHAR (128) NULL,
    [BaseDirectory]   VARCHAR (128) NULL,
    [ControllerName]  VARCHAR (30)  NULL,
    [HostName]        VARCHAR (230) NULL,
    [Controller_Id]   VARCHAR (30)  NULL,
    [IPaddress]       VARCHAR (30)  NULL,
    [IsVirtual]       INT           NULL,
    [MacAddress]      VARCHAR (50)  NULL,
    [Name]            VARCHAR (50)  NULL,
    [RunLevel]        VARCHAR (50)  NULL,
    [SystemId]        VARCHAR (60)  NULL,
    [SystemName]      VARCHAR (50)  NULL,
    [Version]         VARCHAR (50)  NULL,
    [VersionName]     VARCHAR (50)  NULL,
    [WebServicesPort] INT           NULL,
    [_timestamp]      DATETIME      NULL,
    CONSTRAINT [FK_rt_controller_c_controller] FOREIGN KEY ([c_controller_id]) REFERENCES [NGAC].[c_controller] ([id])
);

