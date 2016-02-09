CREATE TABLE [PLC].[c_workstations] (
    [ID]              INT          IDENTITY (1, 1) NOT NULL,
    [controller_name] VARCHAR (20) NOT NULL,
    [location]        VARCHAR (50) NULL,
    [username]        VARCHAR (20) CONSTRAINT [DF_c_workstations_username] DEFAULT ('WinCCConnect') NULL,
    [password]        VARCHAR (20) CONSTRAINT [DF_c_workstations_password] DEFAULT ('2WSXcder') NULL,
    [ipaddress]       VARCHAR (20) NULL,
    CONSTRAINT [PK_c_workstations] PRIMARY KEY CLUSTERED ([ID] ASC)
);

