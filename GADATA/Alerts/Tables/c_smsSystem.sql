CREATE TABLE [Alerts].[c_smsSystem] (
    [id]          INT          IDENTITY (1, 1) NOT NULL,
    [Discription] VARCHAR (50) NULL,
    [system]      VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_c_smsSystem] PRIMARY KEY CLUSTERED ([id] ASC)
);

