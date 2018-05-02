CREATE TABLE [Alerts].[c_state] (
    [id]          INT          IDENTITY (1, 1) NOT NULL,
    [discription] VARCHAR (50) NULL,
    [state]       VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_c_state] PRIMARY KEY CLUSTERED ([id] ASC)
);

