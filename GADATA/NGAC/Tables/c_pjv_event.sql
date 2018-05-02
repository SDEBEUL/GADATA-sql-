CREATE TABLE [NGAC].[c_pjv_event] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [enable_bit]     INT           NULL,
    [event_enum]     INT           NULL,
    [event_mask]     INT           NULL,
    [event_value]    INT           NULL,
    [event_operator] INT           NULL,
    [action_mask]    INT           NULL,
    [comment]        VARCHAR (250) NULL,
    CONSTRAINT [PK_c_pjv_event] PRIMARY KEY CLUSTERED ([id] ASC)
);

