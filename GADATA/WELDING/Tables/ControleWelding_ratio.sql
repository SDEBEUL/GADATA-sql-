CREATE TABLE [WELDING].[ControleWelding_ratio] (
    [id]      INT IDENTITY (1, 1) NOT NULL,
    [TimerID] INT NOT NULL,
    [ration]  INT NULL,
    CONSTRAINT [PK_ControleWelding_ratio] PRIMARY KEY CLUSTERED ([id] ASC)
);

