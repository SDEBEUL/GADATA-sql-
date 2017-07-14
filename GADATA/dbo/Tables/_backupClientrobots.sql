CREATE TABLE [dbo].[$backupClientrobots] (
    [RobotNaam]       NVARCHAR (MAX) NULL,
    [Type]            NVARCHAR (MAX) NULL,
    [station]         NVARCHAR (MAX) NULL,
    [fabriekzone]     NVARCHAR (MAX) NULL,
    [ftppasswd]       NVARCHAR (MAX) NULL,
    [ftpuser]         NVARCHAR (MAX) NULL,
    [unixpasswd]      NVARCHAR (MAX) NULL,
    [unixuser]        NVARCHAR (MAX) NULL,
    [autobackup]      FLOAT (53)     NULL,
    [checkcrc]        FLOAT (53)     NULL,
    [robotversion]    FLOAT (53)     NULL,
    [last_getlogtime] DATETIME       NULL,
    [pingok]          FLOAT (53)     NULL,
    [ftpok]           FLOAT (53)     NULL,
    [networklocation] NVARCHAR (MAX) NULL,
    [backuplocation]  NVARCHAR (MAX) NULL
);

