CREATE TABLE [Volvo].[L_Screens] (
    [id]               INT           IDENTITY (1, 1) NOT NULL,
    [Screen_num]       INT           NOT NULL,
    [Discription]      VARCHAR (MAX) NULL,
    [User_id]          INT           NOT NULL,
    [ScreenUrl]        VARCHAR (MAX) NOT NULL,
    [StartDisplayTime] DATETIME      NULL,
    [StopDisplayTime]  DATETIME      NULL,
    [ResetRate]        INT           NULL,
    CONSTRAINT [PK_L_Screens] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_L_Screens_L_users] FOREIGN KEY ([User_id]) REFERENCES [Volvo].[L_users] ([id])
);

