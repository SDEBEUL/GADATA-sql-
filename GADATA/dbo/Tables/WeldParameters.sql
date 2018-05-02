CREATE TABLE [dbo].[WeldParameters] (
    [ID]              INT  IDENTITY (1, 1) NOT NULL,
    [ParameterNameID] INT  NOT NULL,
    [SpotID]          INT  NOT NULL,
    [Value]           REAL NOT NULL,
    CONSTRAINT [PK_WeldParameters] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_WeldParameters_Spot] FOREIGN KEY ([SpotID]) REFERENCES [dbo].[Spot] ([ID]),
    CONSTRAINT [FK_WeldParameters_TimerParameterName] FOREIGN KEY ([ParameterNameID]) REFERENCES [dbo].[TimerParameterName] ([ID])
);




GO
CREATE NONCLUSTERED INDEX [idx_WeldParameters_2]
    ON [dbo].[WeldParameters]([SpotID] ASC, [ParameterNameID] ASC, [Value] ASC);

