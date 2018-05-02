CREATE TABLE [Alerts].[c_triggers] (
    [id]                   INT           IDENTITY (1, 1) NOT NULL,
    [enabled]              BIT           NOT NULL,
    [discription]          VARCHAR (MAX) NOT NULL,
    [RunAgainst]           INT           NOT NULL,
    [sqlStqStatement]      VARCHAR (MAX) NULL,
    [smsSystem]            INT           NULL,
    [initial_state]        INT           NOT NULL,
    [Cron]                 VARCHAR (50)  NOT NULL,
    [alertType]            VARCHAR (50)  NOT NULL,
    [AutoSetStateTechComp] BIT           NOT NULL,
    [smsOnRetrigger]       BIT           NOT NULL,
    [enableSMS]            BIT           NOT NULL,
    [isDowntime]           BIT           NOT NULL,
    [isInReport]           BIT           NOT NULL,
    CONSTRAINT [PK_c_triggers] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_c_triggers_c_smsSystem] FOREIGN KEY ([smsSystem]) REFERENCES [Alerts].[c_smsSystem] ([id]),
    CONSTRAINT [FK_c_triggers_c_state] FOREIGN KEY ([initial_state]) REFERENCES [Alerts].[c_state] ([id])
);

