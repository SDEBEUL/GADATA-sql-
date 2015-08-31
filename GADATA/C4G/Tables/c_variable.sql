CREATE TABLE [C4G].[c_variable] (
    [id]           INT           IDENTITY (1, 1) NOT NULL,
    [bit_id]       INT           NULL,
    [name]         VARCHAR (256) NULL,
    [update_rate]  INT           NULL,
    [in_sys_state] INT           NOT NULL,
    CONSTRAINT [PK_c_variable] PRIMARY KEY CLUSTERED ([id] ASC)
);

