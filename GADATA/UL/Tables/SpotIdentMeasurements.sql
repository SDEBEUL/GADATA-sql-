CREATE TABLE [UL].[SpotIdentMeasurements] (
    [timestamp] DATETIME NOT NULL,
    [SpotID]    INT      NOT NULL
);




GO
CREATE NONCLUSTERED INDEX [IX_NPTtime]
    ON [UL].[SpotIdentMeasurements]([timestamp] ASC);

