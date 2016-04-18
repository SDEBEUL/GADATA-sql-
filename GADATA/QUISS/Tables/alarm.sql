CREATE TABLE [QUISS].[alarm] (
    [ID]               INT      IDENTITY (1, 1) NOT NULL,
    [c_timestamp]      DATETIME NOT NULL,
    [Controller_id]    INT      NOT NULL,
    [Stuk_id]          INT      NOT NULL,
    [foutdirectory_id] INT      NOT NULL,
    [fouttoestand]     INT      NOT NULL,
    [bodynummer]       INT      NOT NULL,
    CONSTRAINT [FK_AlarmData_Controller] FOREIGN KEY ([Controller_id]) REFERENCES [QUISS].[Controller] ([ID]),
    CONSTRAINT [FK_AlarmData_foutdirectory] FOREIGN KEY ([foutdirectory_id]) REFERENCES [QUISS].[foutdirectory] ([ID]),
    CONSTRAINT [FK_AlarmData_Stuk] FOREIGN KEY ([Stuk_id]) REFERENCES [QUISS].[Stuk] ([ID])
);

