﻿CREATE TABLE [C4G].[h_toollog] (
    [controller_id] INT          NULL,
    [Tool_name]     VARCHAR (50) NULL,
    [_timestamp]    DATETIME     NULL,
    [X]             REAL         NULL,
    [Y]             REAL         NULL,
    [Z]             REAL         NULL,
    [id]            INT          IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_h_toollog] PRIMARY KEY CLUSTERED ([id] ASC)
);

