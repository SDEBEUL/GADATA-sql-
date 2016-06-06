CREATE TABLE [C3G].[rt_CycleTime] (
    [id]            INT            IDENTITY (1, 1) NOT NULL,
    [controller_id] INT            NULL,
    [_timestamp]    DATETIME       NULL,
    [value]         VARCHAR (2048) NULL,
    [variable_id]   INT            NULL,
    [idx1]          INT            NULL,
    [idx2]          INT            NULL,
    [datatype]      INT            NULL,
    [_timeMS]       INT            NULL,
    [plcOrder]      INT            NULL,
    [segment]       INT            NULL,
    CONSTRAINT [PK_rt_CycleTime] PRIMARY KEY CLUSTERED ([id] ASC)
);

