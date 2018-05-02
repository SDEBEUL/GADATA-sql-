CREATE TABLE [NGAC].[c_error] (
    [id]                  INT           IDENTITY (1, 1) NOT NULL,
    [enable_bit]          INT           NOT NULL,
    [ordinal]             INT           NULL,
    [error_number]        INT           NOT NULL,
    [error_category]      INT           NOT NULL,
    [error_number_mask]   INT           NOT NULL,
    [error_category_mask] INT           NOT NULL,
    [_operator]           INT           NOT NULL,
    [flags]               INT           NOT NULL,
    [Ignore]              VARCHAR (50)  NULL,
    [UserComment]         VARCHAR (256) NULL,
    CONSTRAINT [PK_c_error] PRIMARY KEY CLUSTERED ([id] ASC)
);

