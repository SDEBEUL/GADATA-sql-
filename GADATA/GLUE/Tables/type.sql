CREATE TABLE [GLUE].[type] (
    [ID]            INT           IDENTITY (1, 1) NOT NULL,
    [Controller_id] INT           NOT NULL,
    [Product]       NVARCHAR (30) NOT NULL,
    [Doser_type]    NVARCHAR (30) NOT NULL,
    CONSTRAINT [PK_type] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_type] FOREIGN KEY ([Controller_id]) REFERENCES [GLUE].[Controller] ([ID])
);

