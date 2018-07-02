CREATE TABLE [EqUi].[c_datasource] (
    [Id]               INT           IDENTITY (1, 1) NOT NULL,
    [Name]             VARCHAR (50)  NOT NULL,
    [Description]      VARCHAR (MAX) NULL,
    [Type]             INT           NOT NULL,
    [ConnectionString] VARCHAR (MAX) NOT NULL,
    [isAlertSource]    BIT           NOT NULL,
    CONSTRAINT [PK_c_Databases] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'1 = SQL |  2 = ORACLE', @level0type = N'SCHEMA', @level0name = N'EqUi', @level1type = N'TABLE', @level1name = N'c_datasource', @level2type = N'COLUMN', @level2name = N'Type';

