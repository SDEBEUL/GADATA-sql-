CREATE TABLE [WELDING].[TOP10TimerfaultsLast24H] (
    [ID]                   INT           IDENTITY (1, 1) NOT NULL,
    [NPT]                  VARCHAR (50)  NULL,
    [Timer]                VARCHAR (50)  NULL,
    [TimerFault]           VARCHAR (MAX) NULL,
    [Count of Timerfaults] INT           NULL,
    [WeldingMaster Action] VARCHAR (MAX) NULL
);

