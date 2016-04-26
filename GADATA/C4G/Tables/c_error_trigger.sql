CREATE TABLE [C4G].[c_error_trigger] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [error_code]  INT           NULL,
    [action_code] INT           NULL,
    [comment]     VARCHAR (256) NULL,
    [bit_id]      INT           NULL,
    [keycode]     INT           NULL,
    CONSTRAINT [PK_c_error_trigger] PRIMARY KEY CLUSTERED ([id] ASC)
);

