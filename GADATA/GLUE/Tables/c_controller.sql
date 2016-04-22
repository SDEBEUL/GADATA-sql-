CREATE TABLE [GLUE].[c_controller] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [controller_name] VARCHAR (50)  NULL,
    [location]        VARCHAR (256) NULL,
    CONSTRAINT [PK_c_controller_GLUE] PRIMARY KEY CLUSTERED ([id] ASC)
);

