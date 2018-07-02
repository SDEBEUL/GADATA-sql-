CREATE TABLE [EqUi].[c_ownership] (
    [id]           INT           IDENTITY (1, 1) NOT NULL,
    [Plant]        VARCHAR (50)  NOT NULL,
    [Optgroup]     VARCHAR (50)  NOT NULL,
    [Ownership]    VARCHAR (50)  NOT NULL,
    [LocationTree] VARCHAR (100) NOT NULL,
    [UserComment]  VARCHAR (MAX) NULL,
    CONSTRAINT [PK_c_ownership] PRIMARY KEY CLUSTERED ([id] ASC)
);

