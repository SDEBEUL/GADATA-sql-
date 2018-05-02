CREATE TABLE [Volvo].[h_usersPermisions] (
    [id]        INT          IDENTITY (1, 1) NOT NULL,
    [user_id]   INT          NOT NULL,
    [Role]      VARCHAR (50) NOT NULL,
    [GrantedBy] INT          NOT NULL,
    [GrantedAt] DATETIME     CONSTRAINT [DF_h_usersPermisions_GrantedAt] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_h_usersPermisions] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_h_usersPermisions_c_userRoles] FOREIGN KEY ([Role]) REFERENCES [Volvo].[c_userRoles] ([Role]),
    CONSTRAINT [FK_h_usersPermisions_L_users] FOREIGN KEY ([user_id]) REFERENCES [Volvo].[L_users] ([id]),
    CONSTRAINT [FK_h_usersPermisions_L_users1] FOREIGN KEY ([GrantedBy]) REFERENCES [Volvo].[L_users] ([id])
);

