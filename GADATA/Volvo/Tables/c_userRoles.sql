CREATE TABLE [Volvo].[c_userRoles] (
    [Role]        VARCHAR (50)  NOT NULL,
    [Description] VARCHAR (MAX) NULL,
    CONSTRAINT [PK_c_userRoles] PRIMARY KEY CLUSTERED ([Role] ASC)
);

