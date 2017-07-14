CREATE TABLE [C4G].[L_operation] (
    [ID]            INT           IDENTITY (1, 1) NOT NULL,
    [_timestamp]    DATETIME      NULL,
    [code]          INT           NULL,
    [Vcsc_name]     VARCHAR (50)  NULL,
    [controller_id] INT           NULL,
    [Description]   VARCHAR (250) NULL,
    CONSTRAINT [PK_L_operation] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [_dta_index_L_operation_23_164768240__K5_K3_4]
    ON [C4G].[L_operation]([controller_id] ASC, [code] ASC)
    INCLUDE([Vcsc_name]);


GO
CREATE NONCLUSTERED INDEX [nci_lop1]
    ON [C4G].[L_operation]([code] ASC)
    INCLUDE([controller_id], [Vcsc_name]);

