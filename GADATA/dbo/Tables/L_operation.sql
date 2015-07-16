CREATE TABLE [dbo].[L_operation] (
    [ID]            INT          IDENTITY (1, 1) NOT NULL,
    [_timestamp]    DATETIME     NULL,
    [code]          INT          NULL,
    [Vcsc_name]     VARCHAR (50) NULL,
    [controller_id] INT          NULL,
    [Description]   VARCHAR (50) NULL,
    CONSTRAINT [PK_L_operation] PRIMARY KEY CLUSTERED ([ID] ASC)
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_L_operation2]
    ON [dbo].[L_operation]([ID] ASC, [controller_id] ASC, [_timestamp] ASC, [code] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_L_operation]
    ON [dbo].[L_operation]([code] ASC, [ID] ASC, [controller_id] ASC, [_timestamp] ASC);

