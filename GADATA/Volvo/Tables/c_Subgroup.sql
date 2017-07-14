CREATE TABLE [Volvo].[c_Subgroup] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [Subgroup]    VARCHAR (50)  NOT NULL,
    [Discription] VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_C_Subgroup] PRIMARY KEY CLUSTERED ([id] ASC)
);

