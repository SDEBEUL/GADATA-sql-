CREATE TABLE [ABB].[L_Cause] (
    [id]         INT            IDENTITY (1, 1) NOT NULL,
    [cause_text] VARCHAR (2000) NULL,
    CONSTRAINT [PK_L_Cause] PRIMARY KEY CLUSTERED ([id] ASC)
);

