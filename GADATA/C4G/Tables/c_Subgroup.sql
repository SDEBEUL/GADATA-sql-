CREATE TABLE [C4G].[c_Subgroup] (
    [id]       INT        IDENTITY (1, 1) NOT NULL,
    [Subgroup] NCHAR (10) NULL,
    CONSTRAINT [PK_C_Subgroup] PRIMARY KEY CLUSTERED ([id] ASC)
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_C4G_c_Subgroup]
    ON [C4G].[c_Subgroup]([Subgroup] ASC, [id] ASC);

