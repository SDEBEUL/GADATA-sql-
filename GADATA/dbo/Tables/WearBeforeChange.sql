CREATE TABLE [dbo].[WearBeforeChange] (
    [ID]           INT           IDENTITY (1, 1) NOT NULL,
    [DateTime]     SMALLDATETIME NULL,
    [TimerID]      INT           NOT NULL,
    [ElectrodeNbr] TINYINT       NOT NULL,
    [wear]         FLOAT (53)    NOT NULL,
    CONSTRAINT [PK_WearBeforeChange] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_WearBeforeChange_Timer] FOREIGN KEY ([TimerID]) REFERENCES [dbo].[Timer] ([ID])
);


GO
CREATE NONCLUSTERED INDEX [nci_wearbeforrechange]
    ON [dbo].[WearBeforeChange]([DateTime] ASC)
    INCLUDE([ElectrodeNbr], [TimerID], [wear]);


GO
CREATE NONCLUSTERED INDEX [nci_timerid_electroNbr]
    ON [dbo].[WearBeforeChange]([TimerID] ASC, [ElectrodeNbr] ASC, [DateTime] ASC);

