CREATE TABLE [Volvo].[ia_Alert] (
    [id]               INT            IDENTITY (1, 1) NOT NULL,
    [_timestamp]       DATETIME       NULL,
    [Type]             VARCHAR (10)   NULL,
    [controller_name]  VARCHAR (256)  NULL,
    [reference_id]     INT            NULL,
    [description]      VARCHAR (256)  NULL,
    [Accept_user]      VARCHAR (256)  NULL,
    [Accept_timestamp] DATETIME       NULL,
    [Fix_user]         VARCHAR (256)  NULL,
    [Fix_timestamp]    DATETIME       NULL,
    [Detect_timestamp] DATETIME       NULL,
    [Close_user]       VARCHAR (256)  NULL,
    [Close_timestamp]  DATETIME       NULL,
    [User_Comment]     VARCHAR (2000) NULL,
    [controller_id]    INT            NULL,
    [controller_type]  VARCHAR (5)    NULL,
    [AlertStatus]      INT            NULL,
    CONSTRAINT [PK_ia_Alert] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [_dta_index_ia_Alert_23_516105525__K1_14]
    ON [Volvo].[ia_Alert]([id] ASC)
    INCLUDE([User_Comment]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_ia_Alert_23_516105525__K17_K2_K1_K4_K6_14]
    ON [Volvo].[ia_Alert]([AlertStatus] ASC, [_timestamp] ASC, [id] ASC, [controller_name] ASC, [description] ASC)
    INCLUDE([User_Comment]);


GO
CREATE STATISTICS [_dta_stat_516105525_2_17_1_4_6]
    ON [Volvo].[ia_Alert]([_timestamp], [AlertStatus], [id], [controller_name], [description]);


GO
CREATE STATISTICS [_dta_stat_516105525_4_2_6_1]
    ON [Volvo].[ia_Alert]([controller_name], [_timestamp], [description], [id]);


GO
CREATE STATISTICS [_dta_stat_516105525_1_17]
    ON [Volvo].[ia_Alert]([id], [AlertStatus]);


GO
CREATE STATISTICS [_dta_stat_516105525_2_1]
    ON [Volvo].[ia_Alert]([_timestamp], [id]);

