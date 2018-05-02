CREATE TABLE [PJV].[JoiningFile] (
    [id]               INT           IDENTITY (1, 1) NOT NULL,
    [_timestamp]       DATETIME      NULL,
    [_lasttimestamp]   DATETIME      NULL,
    [fullFileName]     VARCHAR (MAX) NULL,
    [filename]         VARCHAR (MAX) NULL,
    [fileDateTime]     DATETIME      NULL,
    [createDateTime]   DATETIME      NULL,
    [modifiedDateTime] DATETIME      NULL,
    [propertyInfo]     VARCHAR (MAX) NULL,
    [isDead]           INT           NULL,
    [rev_created]      INT           NULL,
    [rev_modified]     INT           NULL,
    CONSTRAINT [PK_JoiningFile] PRIMARY KEY CLUSTERED ([id] ASC)
);

