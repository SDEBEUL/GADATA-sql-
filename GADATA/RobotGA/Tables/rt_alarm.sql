CREATE TABLE [RobotGA].[rt_alarm] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [controller_id]   INT           NULL,
    [error_timestamp] DATETIME      NULL,
    [error_number]    INT           NULL,
    [error_severity]  INT           NULL,
    [error_text_id]   INT           NULL,
    [error_text]      VARCHAR (255) NULL,
    CONSTRAINT [PK_rt_alarm] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IndexTableUniqueRows]
    ON [RobotGA].[rt_alarm]([controller_id] ASC, [error_timestamp] ASC, [error_number] ASC) WITH (IGNORE_DUP_KEY = ON);

