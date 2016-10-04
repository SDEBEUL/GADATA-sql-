CREATE TABLE [C3G].[L_error] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [error_number]   INT           NULL,
    [error_severity] INT           NULL,
    [error_text]     VARCHAR (255) NULL,
    [Appl_id]        INT           NULL,
    [Subgroup_id]    INT           NULL,
    CONSTRAINT [PK_L_alarm] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_L_error_c_Appl] FOREIGN KEY ([Appl_id]) REFERENCES [C3G].[c_Appl] ([id]),
    CONSTRAINT [FK_L_error_c_Subgroup] FOREIGN KEY ([Subgroup_id]) REFERENCES [C3G].[c_Subgroup] ([id])
);

