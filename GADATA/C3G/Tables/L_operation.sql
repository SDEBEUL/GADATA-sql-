﻿CREATE TABLE [C3G].[L_operation] (
    [ID]            INT           IDENTITY (1, 1) NOT NULL,
    [_timestamp]    DATETIME      NULL,
    [code]          INT           NULL,
    [Vcsc_name]     VARCHAR (50)  NULL,
    [controller_id] INT           NULL,
    [Description]   VARCHAR (250) NULL,
    CONSTRAINT [PK_L_operation] PRIMARY KEY CLUSTERED ([ID] ASC)
);

