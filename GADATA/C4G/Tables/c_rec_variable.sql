CREATE TABLE [C4G].[c_rec_variable] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [name]        VARCHAR (256) NULL,
    [update_rate] INT           NULL,
    [mon_attr]    INT           NULL,
    [_operator]   INT           NULL,
    [range]       VARCHAR (256) NULL,
    [_group]      INT           NULL,
    [index_mask]  INT           NULL,
    [description] VARCHAR (256) NULL,
    [keycode]     INT           NULL,
    [delta_idle]  REAL          NULL,
    CONSTRAINT [PK_c_rec_variable] PRIMARY KEY CLUSTERED ([id] ASC)
);

