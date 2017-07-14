CREATE TABLE [Volvo].[Users] (
    [id]        BIGINT        IDENTITY (1, 1) NOT NULL,
    [CDS]       VARCHAR (255) NULL,
    [nickname]  VARCHAR (255) NULL,
    [Ulevel]    INT           NULL,
    [UserLevel] INT           NULL,
    [UserGroup] NCHAR (10)    NULL,
    CONSTRAINT [PK_Users_2] PRIMARY KEY CLUSTERED ([id] ASC)
);

