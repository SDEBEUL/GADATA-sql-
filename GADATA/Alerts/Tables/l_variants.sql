CREATE TABLE [Alerts].[l_variants] (
    [id]           INT           IDENTITY (1, 1) NOT NULL,
    [variantGroup] VARCHAR (25)  NOT NULL,
    [c_trigger_id] INT           NOT NULL,
    [Comment]      VARCHAR (MAX) NULL,
    [CreateUser]   INT           NOT NULL,
    [CreateDate]   DATETIME      NOT NULL,
    CONSTRAINT [PK_l_variants] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_l_variants_c_triggers] FOREIGN KEY ([c_trigger_id]) REFERENCES [Alerts].[c_triggers] ([id]),
    CONSTRAINT [FK_l_variants_L_users] FOREIGN KEY ([CreateUser]) REFERENCES [Volvo].[L_users] ([id])
);

