CREATE TABLE [C4G].[h_NoGateStop] (
    [id]           INT IDENTITY (1, 1) NOT NULL,
    [Breakdown_id] INT NULL
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_Rs_Breakdown]
    ON [C4G].[h_NoGateStop]([Breakdown_id] ASC, [id] ASC);

