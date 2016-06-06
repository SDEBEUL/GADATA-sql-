CREATE TABLE [dbo].[rt_Danfloss_currentlog] (
    [ID]         INT          IDENTITY (1, 1) NOT NULL,
    [_timestamp] DATETIME     NULL,
    [_equipment] VARCHAR (50) NULL,
    [_current]   FLOAT (53)   NULL
);

