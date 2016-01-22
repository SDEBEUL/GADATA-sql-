CREATE TABLE [GLUE].[h_alarm] (
    [ID]            INT       IDENTITY (1, 1) NOT NULL,
    [Controller_id] INT       NOT NULL,
    [c_status]      CHAR (10) NOT NULL,
    [c_timestamp]   DATETIME  NOT NULL,
    [FaultText_id]  INT       NOT NULL,
    [Signal_id]     INT       NOT NULL,
    CONSTRAINT [PK_AlarmData] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_AlarmData_Controller] FOREIGN KEY ([Controller_id]) REFERENCES [GLUE].[Controller] ([ID]),
    CONSTRAINT [FK_AlarmData_FaultInfo] FOREIGN KEY ([FaultText_id]) REFERENCES [GLUE].[FaultInfo] ([ID]),
    CONSTRAINT [FK_AlarmData_Signal] FOREIGN KEY ([Signal_id]) REFERENCES [GLUE].[Signal] ([ID])
);

