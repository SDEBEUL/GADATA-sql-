CREATE TABLE [EqUi].['Zone - Lijst - Laatste werkdag$'] (
    [Begin storing (JJWWD)]     NVARCHAR (255) NULL,
    [Begin storing]             DATETIME       NULL,
    [Shift + Ploeg]             NVARCHAR (255) NULL,
    [Machines]                  NVARCHAR (255) NULL,
    [#]                         FLOAT (53)     NULL,
    [Storingstijd (min)]        FLOAT (53)     NULL,
    [Verl# T (min)]             FLOAT (53)     NULL,
    [Omschrijving oorzaak]      NVARCHAR (255) NULL,
    [Objectcode + omschrijving] NVARCHAR (255) NULL,
    [Omschrijving aktie]        NVARCHAR (255) NULL,
    [Eig#]                      NVARCHAR (255) NULL,
    [Code manueel (J/N)]        NVARCHAR (255) NULL,
    [id]                        INT            IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_'Zone - Lijst - Laatste werkdag$'] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [_dta_index_'Zone - Lijst - Laatste werkdag$_23_1594397395__K2_K13_4_5_6_7_8_9_10]
    ON [EqUi].['Zone - Lijst - Laatste werkdag$']([Begin storing] ASC, [id] ASC)
    INCLUDE([#], [Machines], [Objectcode + omschrijving], [Omschrijving aktie], [Omschrijving oorzaak], [Storingstijd (min)], [Verl# T (min)]);

