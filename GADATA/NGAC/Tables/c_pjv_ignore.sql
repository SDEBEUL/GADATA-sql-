CREATE TABLE [NGAC].[c_pjv_ignore] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [enable_bit] INT           NULL,
    [filename]   VARCHAR (250) NULL,
    [comment]    VARCHAR (250) NULL,
    CONSTRAINT [PK_c_pjv_ignore] PRIMARY KEY CLUSTERED ([id] ASC)
);

