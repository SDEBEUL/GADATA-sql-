CREATE TABLE [dbo].[rt_message_ABB_S4] (
    [id]           INT            IDENTITY (1, 1) NOT NULL,
    [_timestamp]   DATETIME       NULL,
    [_message]     VARCHAR (2000) NULL,
    [sqltimestamp] DATETIME       CONSTRAINT [DF_rt_message_ABB_S4_sqltimestamp] DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);






































GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'timestamp of SQL server on insert. (is passed null and takes default )', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'rt_message_ABB_S4', @level2type = N'COLUMN', @level2name = N'sqltimestamp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'timestamp from OPC server (pc time)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'rt_message_ABB_S4', @level2type = N'COLUMN', @level2name = N'_timestamp';


GO
