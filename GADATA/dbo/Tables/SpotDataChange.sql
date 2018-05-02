CREATE TABLE [dbo].[SpotDataChange] (
    [ID]          INT        IDENTITY (1, 1) NOT NULL,
    [SpotID]      INT        NOT NULL,
    [DateTime]    DATETIME   NOT NULL,
    [ParameterID] INT        NOT NULL,
    [OldValue]    NCHAR (50) NOT NULL,
    [NewValue]    NCHAR (50) NOT NULL,
    [UserID]      INT        NOT NULL,
    CONSTRAINT [PK_SpotDataChangeTEMP] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_SpotDataChange_Spot1] FOREIGN KEY ([SpotID]) REFERENCES [dbo].[Spot] ([ID]),
    CONSTRAINT [FK_SpotDataChange_TimerParameterName1] FOREIGN KEY ([ParameterID]) REFERENCES [dbo].[TimerParameterName] ([ID]),
    CONSTRAINT [FK_SpotDataChange_Users1] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([ID])
);




GO
CREATE NONCLUSTERED INDEX [timestamp]
    ON [dbo].[SpotDataChange]([DateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_indexdate]
    ON [dbo].[SpotDataChange]([DateTime] ASC);

