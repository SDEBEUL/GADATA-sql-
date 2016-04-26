CREATE TABLE [C4G].[c_prog_info_ign] (
    [id]      INT           IDENTITY (1, 1) NOT NULL,
    [program] VARCHAR (32)  NULL,
    [comment] VARCHAR (256) NULL,
    [bit_id]  INT           NULL,
    [keycode] INT           NULL,
    CONSTRAINT [PK_c_prog_info_ignore] PRIMARY KEY CLUSTERED ([id] ASC)
);

