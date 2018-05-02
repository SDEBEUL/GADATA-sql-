CREATE TABLE [NGAC].[c_job] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [jobNumber]  INT           NOT NULL,
    [enable_bit] INT           NOT NULL,
    [flags]      INT           NOT NULL,
    [comment]    VARCHAR (MAX) NULL,
    CONSTRAINT [PK_c_job] PRIMARY KEY CLUSTERED ([id] ASC)
);

