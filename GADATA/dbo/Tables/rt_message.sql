CREATE TABLE [dbo].[rt_message] (
    [id]           INT            IDENTITY (1, 1) NOT NULL,
    [_timestamp]   DATETIME       NULL,
    [_message]     VARCHAR (2000) NULL,
    [SQLtimestamp] DATETIME       CONSTRAINT [DF_rt_message_SQLtimestamp] DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);








































GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'time stamp from OPC server (pc time)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'rt_message', @level2type = N'COLUMN', @level2name = N'_timestamp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'time stamp of the sql server the moment the message was receved  (get pushed null and take default)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'rt_message', @level2type = N'COLUMN', @level2name = N'SQLtimestamp';


GO
CREATE TRIGGER [dbo].[ABB_IRC5_message_trigger] ON [GADATA].[dbo].[rt_message] AFTER INSERT 
AS
IF ((SELECT TRIGGER_NESTLEVEL()) < 2)
BEGIN
 EXEC GADATA.abb.sp_Decode_AE_IRC5
 EXEC GADATA.abb.sp_update_L_IRC5
END