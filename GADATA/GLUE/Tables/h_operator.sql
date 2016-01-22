CREATE TABLE [GLUE].[h_operator] (
    [ID]                    INT          IDENTITY (1, 1) NOT NULL,
    [Controller_id]         INT          NOT NULL,
    [c_timestamp]           DATETIME     NOT NULL,
    [User_id]               INT          NOT NULL,
    [OperatorActionInfo_id] INT          NOT NULL,
    [NewValue]              VARCHAR (50) NULL,
    [OldValue]              VARCHAR (50) NULL,
    [Signal_id]             INT          NOT NULL,
    CONSTRAINT [PK_h_operator] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_h_operator_Controller] FOREIGN KEY ([Controller_id]) REFERENCES [GLUE].[Controller] ([ID]),
    CONSTRAINT [FK_h_operator_OperatorActionInfo] FOREIGN KEY ([OperatorActionInfo_id]) REFERENCES [GLUE].[OperatorActionInfo] ([ID]),
    CONSTRAINT [FK_h_operator_Signal] FOREIGN KEY ([Signal_id]) REFERENCES [GLUE].[Signal] ([ID]),
    CONSTRAINT [FK_h_operator_Users] FOREIGN KEY ([User_id]) REFERENCES [GLUE].[Users] ([ID])
);

